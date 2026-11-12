# 신규 — 26.11.11 _ YSH _ 객체 하나의 외란 전·후 (/daq/object_disturbance_status 목록의 한 칸)
# 26.11.11 _ YSH _ mr_disturbance_msgs 에서 옮겼다 — 사용자 요청: 외란 메시지를 MORAI 메시지 패키지 하나로. 칸·순서·뜻은 같다
#
# 짝: /daq/object_status (morai_ros2_msgs/ObjectStatus, GT)  ↔  이 메시지 (외란 전·후·변화·시드)
#   - 아래 앞 8칸은 morai_ros2_msgs/ObjectStatus 와 이름·순서·타입·단위가 같다 = "외란 후" (이 프레임 Autoware 에 간 값)
#   - before 는 같은 프레임의 MORAI GT 그대로 = "외란 전" (/daq/object_status 와 같은 형식·같은 계산)
#   - 짝 짓는 열쇠는 unique_id (= /daq/object_status 의 unique_id), 한 메시지 안에서 전·후가 같은 프레임이다
#   - visible false (dropout·blackout 으로 Autoware 에 안 보냄) 면 heading·velocity·acceleration·position 은 NaN (보낸 값이 없다)
#   - 위치 외란은 position.x·y 만 바꾼다. heading·velocity·acceleration·size·position.z 는 외란 전과 같다

# ── 외란 후 (morai_ros2_msgs/ObjectStatus 와 같은 칸)
int32 unique_id                     # /daq/object_status 의 unique_id 와 같다 (짝 짓는 열쇠)
int32 type                          # MORAI 객체 종류 — 0 보행자 · 1 차량(NPC) · 2 장애물
string name                         # MORAI 이름
float64 heading                     # [deg] world
geometry_msgs/Vector3 velocity      # [km/h] world (MORAI global_velocity 원값)
geometry_msgs/Vector3 acceleration  # [m/s^2]
geometry_msgs/Vector3 size          # [m] (x 폭, y 길이, z 높이)
geometry_msgs/Vector3 position      # [m] world (MORAI 기준점, 차량은 뒤차축) — 외란 후

# ── 외란 전 = 같은 프레임 MORAI GT
# 26.11.11 _ YSH _ 같은 패키지라 접두어를 뺐다. 원문: morai_ros2_msgs/ObjectStatus before
ObjectStatus before

# ── 어떻게 바뀌었나 (다시 계산하는 길: z → noise → d_lon·d_lat → ego_yaw 로 돌림 → dx·dy → position = before.position + (dx, dy))
bool visible                        # 이 프레임에 Autoware 로 보냈다 (false = dropout·blackout 으로 숨김)
uint64 seed                         # 이 객체의 시드 = MRDIST-1 object_seed(base_seed, name). 객체마다 다르다
float64 z_lon                       # 이 프레임의 표준정규 난수 = gauss2(seed, frame_seq).lon (위치 외란 꺼짐·숨김이면 0)
float64 z_lat                       # = gauss2(seed, frame_seq).lat
float64 noise_lon_m                 # [m] = lon_std_m × z_lon (자차 앞 +)
float64 noise_lat_m                 # [m] = lat_std_m × z_lat (자차 왼 +)
float64 d_lon_m                     # [m] 자차 기준 이동 = lon_offset_m + noise_lon_m (위치 외란 꺼짐·숨김이면 0)
float64 d_lat_m                     # [m] = lat_offset_m + noise_lat_m
float64 dx_m                        # [m] world 이동 = position.x − before.position.x (d_lon·d_lat 을 ego_yaw_deg 로 돌린 값)
float64 dy_m                        # [m] = position.y − before.position.y
