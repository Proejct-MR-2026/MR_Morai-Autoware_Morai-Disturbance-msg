<!-- 26.11.24 _ YSH _ KATECH 공유용 사용법을 맨 앞에 더했다. "원래 README" 아래는 손대지 않았다 -->
# MR_Morai-Autoware_Morai-Disturbance-msg

**KATECH 공유본.** MORAI ROS2 메시지(26.R1)에 **외란 메시지를 더한 패키지** `morai_ros2_msgs` 다. 10·11 DAQ bag 을 읽는 PC 에서 빌드한다.

## 메시지만 빌드하기 (bag 을 읽는 PC)

```bash
mkdir -p ~/morai_msgs_ws/src && cd ~/morai_msgs_ws/src
git clone https://github.com/Proejct-MR-2026/MR_Morai-Autoware_Morai-Disturbance-msg.git morai_ros2_msgs
cd ~/morai_msgs_ws && source /opt/ros/humble/setup.bash
colcon build --packages-select morai_ros2_msgs
source install/setup.bash          # 그다음 ros2 bag info · play, PlotJuggler 등
```

- MORAI 공식 `MORAI-ROS2_morai_msgs` 태그 **26.R1** 의 메시지 · 서비스는 그대로이고, 외란 메시지 5개(`DisturbanceCommand` · `DisturbanceStatus` · `ObjectDisturbance` · `ObjectDisturbanceStatus` · `ObjectDisturbanceStatusList`)와 서비스 1개(`SetDisturbance`)만 더했다.
- 10 Mass Testing bag 도 이 패키지로 읽힌다.

## 전체 구성 (10~13)

충북대학교(YSH)가 MR ViLS 과제에서 KATECH 리그 ADS PC 로 쓴 **MORAI ↔ Autoware 스택**이다.
번호마다 따로 받아서 따로 빌드한다. 저장소는 모두 `https://github.com/Proejct-MR-2026/` 아래에 있다.

| 번호 | 무엇 | 저장소 | 원래 PC 의 위치 |
| :-- | :--- | :--- | :--- |
| **10** | **Mass Testing** - MORAI 정답(GT)으로 Autoware 주행 + DAQ 25항목 | `MR_Morai-Autoware_Masstesting`<br>`MR_Morai-Autoware-Bridge_Masstesting` | `~/10_Masstesting-Autoware/Morai_Autoware`<br>`~/10_Masstesting-Autoware/Morai_Autoware_Bridge` |
| **11** | **악의조건 외란 주입** - 10 + 외란 명령 + 외란 DAQ | `MR_Morai-Autoware_Disturbance`<br>`MR_Morai-Autoware-Bridge_Disturbance`<br>`MR_Morai-Autoware_Morai-Disturbance-msg` | `~/11_Disturbance-Autoware/` 아래 같은 이름 |
| **12** | **VILS 보관판** - 실차(아이오닉 6) + MORAI, 26.10.13 시험장 | `MR_Morai-Autoware_VILS`<br>`MR_Morai-Autoware-Bridge_VILS`<br>`MR_KATECH-VILS-ws`<br>`MR_GPS-localizer` | `~/12_VILS-Autoware/Autoware_VILS_261013/Morai_Autoware`<br>`~/12_VILS-Autoware/Autoware_VILS_261013/Morai_Autoware_Bridge`<br>`~/12_VILS-Autoware/katech-vils-ws`<br>`~/12_VILS-Autoware/gps_ws/src/localizer` |
| **13** | **외란 시각화 전용** - RViz 로만 보여 준다, MORAI 에 쓰지 않는다 | `MR_Disturbance-Viz-Rig`<br>`MR_Morai-Autoware_Viz` | `~/13_Disturbance-only-visual-Autoware`<br>`~/13_Disturbance-only-visual-Autoware/MR_Morai-Autoware_Viz` |

- **10·11·13 은 동시에 띄우지 않는다.** 같은 MORAI, 같은 ROS 도메인 10, 같은 cue 포트 50052 를 쓴다. 11·13 의 기동 스크립트는 다른 리그가 떠 있으면 멈춘다. 10 을 띄우기 전에는 직접 확인한다.

## 공통 준비

**원래 PC**

| 항목 | 값 |
| :--- | :--- |
| ADS PC (이 스택) | Ubuntu 22.04 · ROS 2 Humble · Docker 컨테이너 `Autoware-Morai` · 홈 `/home/autoware-morai` · IP `10.10.10.2` |
| MORAI PC | `10.10.10.1` · gRPC `7789` · KATECH cue 서비스 `50052` |
| ROS | `ROS_DOMAIN_ID=10` · `RMW_IMPLEMENTATION=rmw_cyclonedds_cpp` · `CYCLONEDDS_URI=file://$HOME/03_Setting/cyclonedds.xml` |

- **홈을 `/home/autoware-morai` 로 맞추는 것이 가장 쉽다.** 몇 곳이 이 경로를 그대로 쓴다 (`run_rig.sh` 의 `HOME_DIR`, e2e launch 의 기본 `map_path`, `dist_build.sh`·`viz_build.sh`).
- **Autoware 개발 환경**은 Autoware 저장소 루트의 `./setup-dev-env.sh` 로 깐다 (CUDA·acados 포함, acados 는 `/opt/acados` 에 있어야 빌드된다). 그다음 `rosdep install -y --from-paths src --ignore-src --rosdistro humble`.
- MORAI 주소는 모든 도구가 `MORAI_SIM_ADDRESS`·`MORAI_SIM_PORT` 를 따르고, 없으면 `10.10.10.1:7789` 다.

**저장소에 없는 것 (따로 준비)**

| 위치 | 무엇 |
| :--- | :--- |
| `~/03_Setting/cyclonedds.xml` | DDS 설정. 아래 내용 그대로 만든다 (이 PC 안에서만 통신) |
| `~/00_Autoware_Data/Autoware_Map/<지도>` | Lanelet2 지도. 운용 지도는 `Kiapi_mgeo_pure_lc_261005` · `Katri_mgeo_pure_lc_261005` · `Sangam_mgeo_pure_lc_261005` |
| `~/00_Autoware_Data/Autoware_Scenario/<사이트>` | 시나리오 시작·도착 CSV (`site_sweep.sh`·`scenario_pose.py` 가 쓴다) |
| `~/01_DAQ_Data/` | 녹화 결과가 쌓이는 곳 (없으면 만든다) |

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<CycloneDDS xmlns="https://cdds.io/config">
  <Domain id="any">
    <General>
      <Interfaces>
        <NetworkInterface address="127.0.0.1" multicast="false"/>
      </Interfaces>
      <AllowMulticast>false</AllowMulticast>
    </General>
    <Discovery>
      <ParticipantIndex>auto</ParticipantIndex>
      <MaxAutoParticipantIndex>250</MaxAutoParticipantIndex>
      <Peers>
        <Peer address="localhost"/>
      </Peers>
    </Discovery>
  </Domain>
</CycloneDDS>
```

---

<!-- 원래 README -->
**원래 README** (이 아래는 공유 전 그대로)

# MORAI ROS2 Messages

This package contains the ROS 2 message and service definitions (`.msg`, `.srv`) required for interfacing with **MORAI SIM: Drive**, an autonomous driving simulator.

## Resources

- [Website](https://www.morai.ai/)
- **Documentation**:
  - [MORAI ROS2 Messages](https://morai-autonomous.github.io/MORAI-ROS2_morai_msgs/)
  - [MORAI SIM Manual (English)](https://morai-sim-drive-user-manual-en-24-r2.scrollhelp.site/morai-sim-drive-user-manual-en-24.r2/Working-version/?l=en)
  - [MORAI SIM Manual (Korean)](https://help-morai-sim.scrollhelp.site/)
- **Quickstart Guides**:
  - [ROS2 Environment Setup](https://morai-sim-drive-user-manual-en-24-r2.scrollhelp.site/morai-sim-drive-user-manual-en-24.r2/Working-version/developer-setup-for-ros2)
  - [Data Sync Example](https://morai-sim-drive-user-manual-en-24-r2.scrollhelp.site/morai-sim-drive-user-manual-en-24.r2/Working-version/ros2-data-sync-example)

## License

This project is licensed under the [MIT License](LICENSE).
# MR_Morai-Autoware_Morai-Disturbance-msg
