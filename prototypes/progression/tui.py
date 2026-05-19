"""
PROTOTYPE TUI — throwaway shell. Drives progression.py by hand.
Run:  python prototypes/progression/tui.py
Line-input (Windows-safe): type a key + Enter.
"""
import os
import sys

for _s in (sys.stdout, sys.stdin):
    try:
        _s.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass

sys.path.insert(0, os.path.dirname(__file__))
import progression as P  # noqa: E402

B = "\x1b[1m"
D = "\x1b[2m"
R = "\x1b[0m"


def render(s: P.State, last: str):
    os.system("cls" if os.name == "nt" else "clear")
    print(f"{B}=== 진행 상태머신 프로토 (throwaway) ==={R}\n")
    course = s.course + ("  " + D + "[졸업·장르 대기]" + R if s.graduated else "")
    print(f"{B}코스{R}        {course}")
    print(f"{B}경로{R}        {s.done}/{P.PATH_LEN}"
          f"  {D}블록 {P.block_of(max(1, s.done))}{R}")
    print(f"{B}달력일{R}      d{s.day}   {D}마지막 활동 d{s.last_active_day or '-'}{R}")
    print(f"{B}스트릭{R}      {s.streak}   {D}(관대: 0 리셋·freeze 없음){R}")
    print(f"{B}오늘 캡{R}     {'소진' if s.did_today else '가능'}   "
          f"{B}복귀복습{R} {s.pending_review}")
    print(f"{B}장르{R}        {s.genre or '-'}   "
          f"{B}유지모드{R} {'ON' if s.maintenance else 'off'}   "
          f"{B}출시중급{R} {sorted(s.released) or '-'}")
    print(f"\n{D}최근:{R}")
    for line in s.log[-6:]:
        print(f"  {D}{line}{R}")
    print(f"\n{B}» {last}{R}")
    print(f"\n{D}[l]레슨  [n]다음날  [s]N일건너뜀  [g]장르선택  "
          f"[r]중급출시토글  [x]초기화  [q]종료{R}")


def main():
    s = P.State()
    last = "시작 — l(레슨)/n(다음날)/s(공백)으로 ADR 충돌 지점을 밀어보세요"
    while True:
        render(s, last)
        try:
            cmd = input("> ").strip().lower()
        except (EOFError, KeyboardInterrupt):
            break
        if cmd == "q":
            break
        elif cmd == "l":
            s, last = P.do_lesson(s)
        elif cmd == "n":
            s, last = P.new_day(s)
        elif cmd == "s":
            try:
                n = int(input("며칠 건너뛸까? ").strip())
            except ValueError:
                last = "숫자 입력 필요"
                continue
            s, last = P.skip_days(s, n)
        elif cmd == "g":
            last = f"장르: {list(enumerate(P.GENRES))}"
            render(s, last)
            try:
                i = int(input("번호: ").strip())
            except ValueError:
                last = "숫자 입력 필요"
                continue
            s, last = P.choose_genre(s, i)
        elif cmd == "r":
            last = f"출시 토글: {list(enumerate(P.GENRES))}"
            render(s, last)
            try:
                i = int(input("번호: ").strip())
            except ValueError:
                last = "숫자 입력 필요"
                continue
            s, last = P.toggle_release(s, i)
        elif cmd == "x":
            s, last = P.reset(s)
        else:
            last = f"알 수 없는 키: {cmd!r}"
    print("\n프로토 종료. 배운 것은 NOTES.md에 적으세요.")


if __name__ == "__main__":
    main()
