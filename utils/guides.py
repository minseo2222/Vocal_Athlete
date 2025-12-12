# utils/guides.py

# CSS 스타일
CUSTOM_CSS = """
<style>
    .big-font { font-size:20px !important; font-weight: bold; }
    .success-box { padding: 10px; background-color: #e6fffa; border-left: 5px solid #00b894; border-radius: 5px; margin-bottom: 10px; }
    .warning-box { padding: 10px; background-color: #fff5f5; border-left: 5px solid #ff7675; border-radius: 5px; margin-bottom: 10px; }
    .info-box { padding: 10px; background-color: #eefcff; border-left: 5px solid #0984e3; border-radius: 5px; margin-bottom: 10px; }
</style>
"""

# 가이드 내용 딕셔너리
CONTENT = {
    "alexander": """
        <div class='success-box'>
        <b>✅ 정답 느낌 (DO)</b><br>
        - 벽에 기대서기: 머리가 척추 위로 풍선처럼 떠오른다.<br>
        - 턱과 혀에 힘을 완전히 뺀다 (바보 표정).<br>
        - 숨이 배꼽 아래로 쑥 '빨려 들어오는' 느낌.
        </div>
        <div class='warning-box'>
        <b>🚨 위험 신호 (DON'T)</b><br>
        - 숨 쉴 때 어깨가 귀랑 가까워진다 (승모근 긴장).<br>
        - 턱이 앞으로 튀어 나간다 (거북목).
        </div>
    """,
    "estill": """
        <div class='info-box'>
        <b>💡 훈련법</b>: 마녀 웃음소리 "이히히!" 혹은 오리 소리 "꽥꽥" 흉내내기
        </div>
        <div class='success-box'>
        <b>✅ 정답 느낌 (DO)</b><br>
        - 귀가 쟁쟁거릴 정도로 소리가 날카롭다.<br>
        - 목 자체는 하나도 안 아프고 가볍다.
        </div>
        <div class='warning-box'>
        <b>🚨 위험 신호 (DON'T)</b><br>
        - 목이 따갑거나 기침이 나온다 (가성대 개입 - 즉시 중단!).<br>
        - 소리가 답답하고 먹먹하다.
        </div>
    """,
    "physical": """
        <div class='success-box'>
        <b>💪 데드버그 (Dead Bug)</b><br>
        - 누워서 팔다리를 교차로 내릴 때 <b>허리가 절대 바닥에서 뜨면 안 됨.</b><br>
        - 배꼽을 바닥으로 누르는 그 힘이 노래할 때의 '서포트(Support)'임.
        </div>
        <div class='success-box'>
        <b>🏃‍♂️ 인터벌 러닝</b><br>
        - [1분 전력질주 + 2분 가볍게] x 5세트.<br>
        - 심장이 터질 것 같은 상태에서 호흡을 고르는 능력이 무대 체력임.
        </div>
    """
}