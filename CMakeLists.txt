cmake_minimum_required(VERSION 3.21)
project(ROVGroundStation VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(rov_ground_station
    src/main.cpp
    src/RovStatusModel.h
    src/RovStatusModel.cpp
)

qt_add_qml_module(rov_ground_station
    URI ROV.GroundStation
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/components/MetricCard.qml
)

target_link_libraries(rov_ground_station PRIVATE Qt6::Quick Qt6::QuickControls2)

include(GNUInstallDirs)
install(TARGETS rov_ground_station
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
