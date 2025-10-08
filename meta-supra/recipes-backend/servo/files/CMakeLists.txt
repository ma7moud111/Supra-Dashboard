cmake_minimum_required(VERSION 3.12)
project(servo)

add_executable(servo servo.cpp)

install(TARGETS servo RUNTIME DESTINATION bin)
