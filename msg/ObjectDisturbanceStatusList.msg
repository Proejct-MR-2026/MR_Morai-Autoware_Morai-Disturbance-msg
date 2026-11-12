# 신규 — 26.11.11 _ YSH _ /daq/object_disturbance_status — /daq/object_status(morai_ros2_msgs/ObjectStatusList) 의 외란 짝
# 26.11.11 _ YSH _ mr_disturbance_msgs 에서 옮겼다 — 사용자 요청: 외란 메시지를 MORAI 메시지 패키지 하나로. 칸·순서·뜻은 같다
#   - 앞 7칸은 morai_ros2_msgs/ObjectStatusList 와 이름·순서가 같다 (목록 원소만 ObjectDisturbanceStatus)
#   - 객체 프레임마다(약 10 Hz, Autoware 에 객체를 보내는 주기) 한 건. 숨김 프레임에도 GT 객체를 전부 싣는다 (visible false)
#   - 같은 프레임의 /daq/disturbance(DisturbanceStatus) 와 header.stamp·frame_seq 가 같다 — 켜진 외란·값은 그쪽에 있다
std_msgs/Header header              # stamp = 같은 프레임 TrackedObjects stamp, frame_id map
int32 num_of_npcs
int32 num_of_pedestrian
int32 num_of_obstacle
ObjectDisturbanceStatus[] npc_list
ObjectDisturbanceStatus[] pedestrian_list
ObjectDisturbanceStatus[] obstacle_list

# ── 짝 짓기·다시 계산
uint64 frame_seq                    # 외란 프레임 번호 (난수 카운터) — /daq/disturbance 와 같다
uint64 base_seed                    # 이 런의 기본 시드 (0 = 시드 구간 없음)
float64 ego_x                       # [m] 위치 외란을 돌릴 때 쓴 자차 (같은 스냅샷, MORAI world)
float64 ego_y                       # [m]
float64 ego_yaw_deg                 # [deg] — dx = d_lon·cos(yaw) − d_lat·sin(yaw), dy = d_lon·sin(yaw) + d_lat·cos(yaw)
