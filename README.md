# ROV 岸端操作与监控系统

面向 Ubuntu 22.04 和 **Qt 6.8.3** 的 ROV 上位机起始工程。当前版本提供响应式实时监控首页、状态数据模型和可独立运行的模拟遥测，尚未接入真实设备。

## 依赖

- CMake 3.21+
- Ninja（推荐）或 Make
- Qt 6.8.3：`qtbase`、`qtdeclarative`、`qtquickcontrols2`
- C++17 编译器

## Ubuntu 构建与运行

将 Qt 安装目录按实际情况替换为 Qt 6.8.3 的目录：

```bash
cmake -S . -B build -G Ninja -DCMAKE_PREFIX_PATH=$HOME/Qt/6.8.3/gcc_64
cmake --build build
./build/rov_ground_station
```

## 当前架构与下一步

`RovStatusModel` 是唯一的 UI 遥测入口；现以定时模拟数据驱动。下一阶段新增 `MavlinkClient` 后，让它解析心跳、姿态、深度和电源消息，并更新该模型即可。视频流、3D 姿态、声呐、日志和配置管理应分别作为独立模块接入，避免把通信、业务和 QML 页面耦合。
