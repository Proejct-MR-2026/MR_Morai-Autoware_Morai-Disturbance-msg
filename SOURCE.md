<!-- 26.10.05 _ YSH _ 신규 — 이 패키지는 외부 저장소 사본이다 (내부를 고치지 않는다) -->
# morai_ros2_msgs 출처

- 저장소: https://github.com/MORAI-Autonomous/MORAI-ROS2_morai_msgs
- 태그: `26.R1` (커밋 `c84d648638510d28b691b959b03502009f4e2070`, 2026-04-07)
- 받은 날: 2026-10-05, `.git` 없이 파일만 복사
- 쓰는 곳: `autoware_morai_interface` DAQ 토픽 `/daq/ego_status`(EgoVehicleStatus) · `/daq/object_status`(ObjectStatusList)
- 참고: `Morai_Autoware_Bridge/mapping/morai_ros2_msgs` 사본과는 EgoVehicleStatus 의 조향 칸 이름만 다르다
  (이 태그 `front_steer_angle`·`rear_steer_angle`, 그 사본 `front_steer`·`rear_steer`).
- 단위는 저장소 main 의 메시지 주석을 따른다: Ego 위치 m(ENU)·속도 m/s·가속도 m/s²·각속도 °/s·heading °·조향각 °,
  ObjectStatus 속도 km/h·가속도 m/s²·size (폭, 길이, 높이) m·heading °, type 0 보행자 · 1 NPC 차량 · 2 정적 물체.

<!-- 26.11.11 _ YSH _ 외란 추가판 -->
## 26.11.11 외란 주입 추가판 (충북대)

사용자 요청으로 이 사본에 외란 메시지를 **더했다**. 위 26.R1 의 메시지 32개·서비스 6개는 한 글자도 바꾸지 않았다 — 기존 bag·노드와 그대로 맞는다.
같은 이름(`morai_ros2_msgs`)이므로 외란 bag 을 읽는 PC 는 원래 `morai_ros2_msgs` 대신 이 사본을 빌드한다.

| 더한 것 | 쓰는 곳 |
| :--- | :--- |
| `msg/DisturbanceStatus.msg` | `/daq/disturbance` — 외란 프레임 상태 (켜짐·값·시드, 객체 요약) |
| `msg/ObjectDisturbance.msg` | `DisturbanceStatus.objects` 의 한 칸 |
| `msg/ObjectDisturbanceStatusList.msg` | `/daq/object_disturbance_status` — `/daq/object_status`(ObjectStatusList) 의 외란 짝 |
| `msg/ObjectDisturbanceStatus.msg` | 그 한 칸 — 외란 후(ObjectStatus 와 같은 8칸) + `before`(ObjectStatus, 같은 프레임 GT) + 시드·난수·잡음·이동 |
| `msg/DisturbanceCommand.msg` | `SetDisturbance` 응답의 읽은 명령 |
| `srv/SetDisturbance.srv` | `/morai_bridge/set_disturbance` — cue_server 가 브리지에 외란을 건다 (기록용 아님) |

26.11.10~11 에는 같은 내용이 별도 패키지 `mr_disturbance_msgs` 에 있었다 (그 폴더는 `COLCON_IGNORE` 로 빌드에서 뺐다).
그때 만든 bag 의 외란 토픽 타입 이름은 `mr_disturbance_msgs/msg/*` 다.
