# 신규 — 26.11.10 _ YSH _ 객체 프레임마다 한 건 (/daq/disturbance)
# 26.11.11 _ YSH _ mr_disturbance_msgs 에서 옮겼다 — 사용자 요청: 외란 메시지를 MORAI 메시지 패키지 하나로. 칸·순서·뜻은 같다
std_msgs/Header header        # stamp = 같은 프레임 TrackedObjects 의 header.stamp, frame_id map
uint64 frame_seq              # 난수 카운터 k. 시드 구간마다 0 부터, 객체 프레임마다 +1
float64 frame_period_s        # 직전 객체 프레임과의 stamp 간격 [s]. 첫 프레임, 0 이하, 1 s 초과면 0.1
bool fault_flag               # position_on || dropout_on || blackout_on
bool position_on
bool dropout_on
bool blackout_on              # 완전 끊김 진행 중 (recover 1 은 duration 뒤 false)
bool objects_visible          # false = 이 프레임 Autoware 에 빈 목록
string[] active_triggers      # 걸려 있는 트리거 문장, 순서 position, dropout, blackout
float64 lon_offset_m          # [m] 자차 앞 + (꺼짐이면 0)
float64 lon_std_m             # [m] 표준편차 (분산 아님)
float64 lat_offset_m          # [m] 자차 왼 +
float64 lat_std_m             # [m] 표준편차 (분산 아님)
float64 keep_prob             # 0~1 (dropout 꺼짐이면 1)
float64 mean_gap_s            # [s] (꺼짐이면 0)
float64 blackout_duration_s   # [s] (진행 중이 아니면 0)
bool blackout_recover         # (진행 중이 아니면 false)
uint64 base_seed              # 1 ~ 999999999999999, 0 = 시드 구간 없음
uint64 dropout_seed           # MRDIST-1 dropout_seed(base_seed), base_seed 0 이면 0
string seed_algorithm         # MRDIST-1
ObjectDisturbance[] objects   # GT 객체마다 한 칸, MORAI 응답 순서. 숨김 프레임에도 visible false 로 전부
