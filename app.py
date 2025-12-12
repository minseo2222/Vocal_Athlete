import streamlit as st
import pandas as pd
from datetime import datetime, date
import time
import os
# 분리해둔 가이드 파일 불러오기
from utils.guides import CUSTOM_CSS, CONTENT

# --- 페이지 설정 ---
st.set_page_config(page_title="Vocal Athlete Manager", page_icon="🎤", layout="wide")
st.markdown(CUSTOM_CSS, unsafe_allow_html=True)

# --- 데이터 저장소 (경로 변경: data/ 폴더) ---
# data 폴더가 없으면 생성
if not os.path.exists('data'):
    os.makedirs('data')
CSV_FILE = 'data/vocal_training_log.csv'

def load_data():
    if not os.path.exists(CSV_FILE):
        return pd.DataFrame(columns=["날짜", "훈련시간", "훈련내용", "상태/메모"])
    return pd.read_csv(CSV_FILE)

def save_data(date_val, duration, content, memo):
    df = load_data()
    new_data = pd.DataFrame({
        "날짜": [date_val],
        "훈련시간": [duration],
        "훈련내용": [content],
        "상태/메모": [memo]
    })
    df = pd.concat([df, new_data], ignore_index=True)
    df.to_csv(CSV_FILE, index=False)
    return df

# --- 사이드바 ---
st.sidebar.title("🎤 Vocal Athlete")
st.sidebar.markdown("---")
start_date = st.sidebar.date_input("훈련 시작일", value=date(2024, 1, 1))
today = date.today()
days_passed = (today - start_date).days
total_days = 365 * 2
progress = min(days_passed / total_days, 1.0)
st.sidebar.metric(label="D-Day 카운터", value=f"Day {days_passed}", delta=f"남은 기간 {total_days - days_passed}일")
st.sidebar.progress(progress)

# --- 메인 화면 ---
st.title("🏃‍♂️ 뮤지컬 배우 2년 트레이닝 센터")
tab1, tab2, tab3, tab4 = st.tabs(["📅 오늘의 루틴", "📚 트레이닝 가이드북", "📈 2년 마스터 플랜", "📝 연습 일지"])

# --- TAB 1: 오늘의 루틴 (동일) ---
with tab1:
    st.header(f"{today.strftime('%Y년 %m월 %d일')} 훈련 체크리스트")
    col1, col2 = st.columns([1.5, 1])
    with col1:
        st.subheader("🎤 보컬 트레이닝")
        st.checkbox("💧 기상 직후 물 한 잔 & 침묵")
        st.checkbox("🧘 오전: 호흡 & SOVT 워밍업 (20분)")
        st.checkbox("🎹 오후: 스케일 & 발성 테크닉 (40분)")
        st.checkbox("🎭 저녁: 레퍼토리 & 액팅 (50분)")
        st.checkbox("🧊 취침 전 쿨다운 (10분)")
        st.markdown("---")
        st.subheader("💪 피지컬 트레이닝")
        st.checkbox("🔥 [코어] 데드버그 / 플랭크 (10분)")
        st.checkbox("🏃‍♂️ [유산소] 인터벌 러닝 (20분)")
    with col2:
        st.subheader("⏱️ 훈련 타이머")
        timer_type = st.selectbox("모드 선택", ["누워서 호흡 (5분)", "물병 불기 (5분)", "코어 운동 (10분)", "보컬 냅 (20분)"])
        if st.button("타이머 시작"):
            sec = 300 if "5분" in timer_type else (600 if "10분" in timer_type else 1200)
            bar = st.progress(0)
            status = st.empty()
            for i in range(sec):
                time.sleep(1) # 실제 사용시 1초
                bar.progress((i + 1) / sec)
                status.text(f"🏃 {timer_type} 진행 중... {sec - i - 1}초")
            st.success("완료!")

# --- TAB 2: 트레이닝 가이드북 (내용 불러오기) ---
with tab2:
    st.header("📖 핵심 훈련법 & 오답 노트")
    with st.expander("🧘 1. 알렉산더 테크닉 & 호흡", expanded=True):
        st.markdown(CONTENT["alexander"], unsafe_allow_html=True)
    with st.expander("🦆 2. 에스틸 '트왱' (고음 효율)", expanded=False):
        st.markdown(CONTENT["estill"], unsafe_allow_html=True)
    with st.expander("🔥 3. 피지컬: 코어 & 유산소", expanded=False):
        st.markdown(CONTENT["physical"], unsafe_allow_html=True)

# --- TAB 3 & 4 (로직 동일) ---
# (코드 길이상 생략했지만, 이전 코드의 Tab 3, 4 내용을 그대로 넣으시면 됩니다. 
# 단, save_data 함수는 위에서 정의한 것을 사용하므로 문제 없습니다.)
with tab3:
    # ... (이전 코드의 Tab 3 내용 복사) ...
    pass 

with tab4:
    st.header("📝 훈련 기록")
    with st.form("log_form"):
        c1, c2 = st.columns(2)
        inp_date = c1.date_input("날짜", value=today)
        inp_dur = c2.number_input("시간(분)", step=10, value=60)
        inp_cont = st.text_input("내용")
        inp_memo = st.text_area("메모")
        if st.form_submit_button("저장"):
            save_data(inp_date, inp_dur, inp_cont, inp_memo)
            st.success("저장 완료!")
            
    st.markdown("### 📊 지난 기록")
    log_df = load_data()
    if not log_df.empty:
        st.dataframe(log_df.sort_index(ascending=False), use_container_width=True)