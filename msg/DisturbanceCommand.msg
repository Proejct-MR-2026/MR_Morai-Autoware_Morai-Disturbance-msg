# 신규 — 26.11.10 _ YSH _ 명령 한 줄을 읽은 값 (SetDisturbance 응답)
# 26.11.11 _ YSH _ mr_disturbance_msgs 에서 옮겼다 — 사용자 요청: 외란 메시지를 MORAI 메시지 패키지 하나로. 칸·순서·뜻은 같다
string trigger             # 받은 문장 그대로
string type                # position | dropout | blackout | clear, 빈 문자열 = 상태 조회
bool clear                 # true = 해제 (type clear = 전체, type <종류> = 그 종류만)
float64 lon_offset_m
float64 lon_std_m
float64 lat_offset_m
float64 lat_std_m
float64 keep_prob
float64 mean_gap_s
float64 duration_s
bool recover
float64 angle_offset_deg   # 예약 (heading, mount)
float64 angle_std_deg      # 예약
