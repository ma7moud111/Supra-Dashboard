cmake_minimum_required(VERSION 3.16)

project(dashboardhw VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appdashboardhw
    main.cpp
)

qt_add_qml_module(appdashboardhw
    URI dashboardhw
    VERSION 1.0
    QML_FILES main.qml
    QML_FILES CircularGauge.qml
    SOURCES dashboardcontroller.h dashboardcontroller.cpp
    SOURCES SeatController.h SeatController.cpp
    SOURCES speedcontroller.h speedcontroller.cpp
    SOURCES tachometercontroller.h tachometercontroller.cpp
    SOURCES temperaturecontroller.h temperaturecontroller.cpp
    SOURCES gpiocontroller.h gpiocontroller.cpp
    QML_FILES DigitalClock.qml
    QML_FILES Compass.qml
    SOURCES compasscontroller.h compasscontroller.cpp
    SOURCES fileseatreader.h fileseatreader.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appdashboardhw PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appdashboardhw
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdashboardhw
    PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(TARGETS appdashboardhw
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
