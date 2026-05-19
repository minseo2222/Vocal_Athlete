"""
PROTOTYPE — throwaway. Pure progression state machine (no I/O).

QUESTION being answered:
  Do the locked ADR decisions feel right when they collide in one timeline?
  Specifically: completion-based unlock + 1-lesson/day cap + lenient streak
  (no 0-reset, no freeze) + return-review (7+ day gap → 1 or 2 review days,
  review consumes that day's slot, no new unlock that day) + graduation
  (path complete) → unified transition (celebrate → nonbinding genre pick →
  enter next course if released else maintenance mode → auto-connect on
  release). Maintenance = thin repeat of last course's skills, streak keeps
  going, no new unlock.

This module is the bit worth keeping if validated; the TUI is throwaway.
"""
from dataclasses import dataclass, field, replace
from typing import Optional

# Beginner path ≈ 48 lessons, 5 internal blocks (ADR-0006).
BLOCKS = [(1, 8, "1 토대"), (9, 20, "2 SOVT도입"), (21, 30, "3 SOVT확장"),
          (31, 40, "4 균형·자기청취"), (41, 48, "5 자기모방·시각")]
PATH_LEN = 48
GENRES = ("뮤지컬", "성악", "가요")


def block_of(lesson_no: int) -> str:
    for lo, hi, name in BLOCKS:
        if lo <= lesson_no <= hi:
            return name
    return "-"


@dataclass
class State:
    day: int = 1                 # simulated calendar day
    last_active_day: int = 0     # day of last lesson done (0 = never)
    done: int = 0                # lessons completed in current course (0..PATH_LEN)
    streak: int = 0              # lenient: only ever increments, never resets
    pending_review: int = 0      # review lessons owed on return
    did_today: bool = False      # 1-lesson/day cap
    transition_day: int = 0      # day a course transition happened (for messaging)
    course: str = "초급"         # 초급 | <genre>중급 | (none)
    graduated: bool = False      # finished current course path
    genre: Optional[str] = None  # chosen genre (nonbinding)
    maintenance: bool = False    # in maintenance loop
    released: set = field(default_factory=set)  # genre 중급 courses shipped
    log: list = field(default_factory=list)


def _msg(s: State, text: str) -> tuple:
    s = replace(s, log=(s.log + [f"d{s.day}: {text}"])[-8:])
    return s, text


def new_day(s: State) -> tuple:
    """Advance the calendar by one day (no lesson)."""
    return _msg(replace(s, day=s.day + 1, did_today=False), "▶ 다음 날")


def skip_days(s: State, n: int) -> tuple:
    return _msg(replace(s, day=s.day + n, did_today=False), f"▶ {n}일 건너뜀(공백 생성)")


def _gap(s: State) -> int:
    if s.last_active_day == 0:
        return 0
    return s.day - s.last_active_day - 1  # full missed days between activity


def do_lesson(s: State) -> tuple:
    if s.did_today:
        # Option 1 (messaging-only): graduation/transition boundary is a
        # ceremony screen, NOT a bare cap error. Cap itself unchanged (ADR-0003).
        if s.graduated and s.genre is None:
            return _msg(s, "🎉 경로 완주! 오늘 훈련은 여기까지 — 장르를 고르고(g) 내일부터 다음 코스")
        if s.transition_day == s.day:
            nxt = s.course if not s.maintenance else f"{s.course} 유지"
            return _msg(s, f"🎉 전이 완료 — 오늘 훈련은 끝(졸업 레슨). 내일 {nxt} 1과부터")
        return _msg(s, "✗ 1일 1레슨 캡 — 오늘은 이미 했음")

    gap = _gap(s)
    # Return-review trigger: 7+ day gap, only when re-entering an active course.
    if gap >= 7 and s.pending_review == 0 and not s.graduated:
        owed = 1 if gap <= 14 else 2
        s = replace(s, pending_review=owed)
        s, _ = _msg(s, f"⚠ {gap}일 공백 → 복귀 복습 {owed}일 부여(스트릭 0 리셋 없음)")

    s = replace(s, did_today=True, last_active_day=s.day, streak=s.streak + 1)

    if s.maintenance:
        return _msg(s, f"♻ 유지 모드 레슨({s.course} 스킬 반복) — 신규 해금 없음, 스트릭 {s.streak}")

    if s.pending_review > 0:
        s = replace(s, pending_review=s.pending_review - 1)
        return _msg(s, f"↩ 복귀 복습 소비(남은 {s.pending_review}) — 신규 해금은 다음날, 스트릭 {s.streak}")

    if s.graduated:
        return _msg(s, "✗ 이미 졸업 — 장르 선택 또는 유지 모드")

    s = replace(s, done=s.done + 1)
    if s.done >= PATH_LEN:
        s = replace(s, graduated=True)
        return _msg(s, f"★ 레슨 {s.done}/{PATH_LEN}({block_of(s.done)}) 완료 → 경로 완주! 졸업. 장르 선택하세요(g)")
    return _msg(s, f"✓ 레슨 {s.done}/{PATH_LEN} 완료 (블록 {block_of(s.done)}) — 스트릭 {s.streak}")


def choose_genre(s: State, idx: int) -> tuple:
    if not s.graduated:
        return _msg(s, "✗ 졸업 후에만 장르 선택")
    g = GENRES[idx % len(GENRES)]
    s = replace(s, genre=g)
    if g in s.released:
        # transition straight into that genre's intermediate course
        s = replace(s, course=f"{g}중급", graduated=False, done=0,
                     maintenance=False, pending_review=0, transition_day=s.day)
        return _msg(s, f"→ 장르 '{g}' 선택 — 중급 출시됨 → {g}중급 진입(경로 0/N)")
    s = replace(s, maintenance=True, transition_day=s.day)
    return _msg(s, f"→ 장르 '{g}' 선택(비구속) — 중급 미출시 → 유지 모드 진입(스트릭 유지)")


def toggle_release(s: State, idx: int) -> tuple:
    g = GENRES[idx % len(GENRES)]
    rel = set(s.released)
    if g in rel:
        rel.discard(g)
        s = replace(s, released=rel)
        return _msg(s, f"(테스트) {g}중급 출시 취소")
    rel.add(g)
    s = replace(s, released=rel)
    s, _ = _msg(s, f"(테스트) {g}중급 출시됨")
    # auto-connect: if waiting in maintenance for exactly this genre
    if s.maintenance and s.genre == g:
        s = replace(s, course=f"{g}중급", graduated=False, done=0,
                     maintenance=False, pending_review=0, transition_day=s.day)
        return _msg(s, f"⇒ 자동 연결: 유지 모드 → {g}중급 진입")
    return s, s.log[-1]


def reset(_s: State) -> tuple:
    return _msg(State(), "↺ 초기화")
