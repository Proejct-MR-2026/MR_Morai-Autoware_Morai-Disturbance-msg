# 신규 — 26.11.10 _ YSH _ 외란 프레임 안의 객체 하나 (DisturbanceStatus.objects)
# 26.11.11 _ YSH _ mr_disturbance_msgs 에서 옮겼다 — 사용자 요청: 외란 메시지를 MORAI 메시지 패키지 하나로. 칸·순서·뜻은 같다
int32 unique_id      # /daq/object_status 의 unique_id 와 같은 값
string name          # MORAI actor 이름 (actor_info.id.value)
uint64 seed          # 객체 시드 = MRDIST-1 object_seed(base_seed, name). base_seed 0 이면 0
bool visible         # 이 프레임에 이 객체를 Autoware 로 보냈다
float64 noise_lon_m  # 뽑힌 종방향 잡음 [m] = lon_std_m x z_lon, 자차 앞 +. 안 보냈거나 위치 외란이 꺼졌으면 0
float64 noise_lat_m  # 뽑힌 횡방향 잡음 [m] = lat_std_m x z_lat, 자차 왼 +
float64 dx_m         # 이동량 x [m, MORAI world] = 보낸 position.x - GT position.x (transform.location, 같은 프레임)
float64 dy_m         # 이동량 y [m, MORAI world]
