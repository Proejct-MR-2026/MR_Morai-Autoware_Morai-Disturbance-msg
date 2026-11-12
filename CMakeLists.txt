cmake_minimum_required(VERSION 3.5)
project(morai_ros2_msgs)


find_package(ament_cmake REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(builtin_interfaces REQUIRED)
find_package(rosidl_default_generators REQUIRED)

set(msg_files
  "msg/CollisionData.msg"
  "msg/CtrlCmd.msg"
  "msg/EgoVehicleStatus.msg"
  "msg/EventInfo.msg"
  "msg/GetTrafficLightStatus.msg"
  "msg/GPSMessage.msg"
  "msg/GhostCmd.msg"
  "msg/IntersectionControl.msg"
  "msg/IntersectionStatus.msg"
  "msg/Lamps.msg"
  "msg/MapSpec.msg"
  "msg/MoraiSimProcHandle.msg"
  "msg/MoraiSimProcStatus.msg"
  "msg/MoraiSrvResponse.msg"
  "msg/TrafficLightIndex.msg"
  "msg/TrafficLightInfo.msg"
  "msg/MultiEgoSetting.msg"
  "msg/NpcGhostCmd.msg"
  "msg/NpcGhostInfo.msg"
  "msg/ObjectStatus.msg"
  "msg/ObjectStatusList.msg"
  "msg/RadarDetection.msg"
  "msg/RadarDetections.msg"
  "msg/ReplayInfo.msg"
  "msg/SaveSensorData.msg"
  "msg/ScenarioLoad.msg"
  "msg/SensorPosControl.msg"
  "msg/SetTrafficLight.msg"
  "msg/VehicleCollision.msg"
  "msg/VehicleCollisionData.msg"
  "msg/VehicleSpec.msg"
  "msg/VehicleSpecIndex.msg"
  # 26.11.11 _ YSH _ 충북대 외란 주입 추가판 — 외란 DAQ·명령 메시지 (mr_disturbance_msgs 에서 옮김). 위의 MORAI 메시지는 그대로다
  "msg/DisturbanceStatus.msg"
  "msg/ObjectDisturbance.msg"
  "msg/DisturbanceCommand.msg"
  "msg/ObjectDisturbanceStatus.msg"
  "msg/ObjectDisturbanceStatusList.msg"
)

set(srv_files
  "srv/EventCmd.srv"
  "srv/MapSpec.srv"
  "srv/ScenarioLoad.srv"
  "srv/MoraiSimProc.srv"
  "srv/TrafficLightInfo.srv"
  "srv/VehicleSpec.srv"
  # 26.11.11 _ YSH _ 외란 명령 넣기 (cue_server → 브리지, 기록용 아님)
  "srv/SetDisturbance.srv"
)

rosidl_generate_interfaces(${PROJECT_NAME}
  ${msg_files}
  ${srv_files}
  DEPENDENCIES std_msgs geometry_msgs builtin_interfaces
)

ament_package()
