cmake_minimum_required(VERSION 3.12)
project(button)

add_executable(button button.cpp)

install(TARGETS button RUNTIME DESTINATION bin)
