cmake_minimum_required(VERSION 3.14)
project(E01HelloWorld CXX)
set(CMAKE_CXX_STANDARD 14)

# ---- generated headers from your vendored tree
if(NOT DEFINED GEN_DIR)
  set(GEN_DIR ${CMAKE_SOURCE_DIR}/src-gen) # local build fallback
endif()
message(STATUS "Using generated headers at: ${GEN_DIR}")
include_directories(${GEN_DIR})

# ---- vSomeIP via pkg-config (official way)
find_package(PkgConfig REQUIRED)
pkg_check_modules(VSOMEIP REQUIRED vsomeip3)
include_directories(${VSOMEIP_INCLUDE_DIRS})
link_directories(${VSOMEIP_LIBRARY_DIRS})

# ---- Try CONFIG packages first (newer capicxx export imported targets)
set(HAVE_COMMONAPI_TARGETS OFF)
find_package(CommonAPI QUIET CONFIG)
if(TARGET CommonAPI::CommonAPI)
  set(HAVE_COMMONAPI_TARGETS ON)
endif()

find_package(CommonAPI-SomeIP QUIET CONFIG)
if(TARGET CommonAPI-SomeIP::CommonAPI-SomeIP)
  set(HAVE_COMMONAPI_TARGETS ON)
endif()

# ---- If no imported targets, fall back to pkg-config / find_library
if(NOT HAVE_COMMONAPI_TARGETS)
  # Try pkg-config names first
  pkg_check_modules(COMMONAPI QUIET CommonAPI)
  pkg_check_modules(COMMONAPI_SOMEIP QUIET CommonAPI-SomeIP)

  if(COMMONAPI_FOUND)
    include_directories(${COMMONAPI_INCLUDE_DIRS})
    link_directories(${COMMONAPI_LIBRARY_DIRS})
  endif()

  if(COMMONAPI_SOMEIP_FOUND)
    include_directories(${COMMONAPI_SOMEIP_INCLUDE_DIRS})
    link_directories(${COMMONAPI_SOMEIP_LIBRARY_DIRS})
  endif()

  # As a last resort, find the .so directly inside the toolchain sysroot
  if(NOT COMMONAPI_LIBRARIES)
    find_library(COMMONAPI_LIBRARIES NAMES CommonAPI)
  endif()
  if(NOT COMMONAPI_SOMEIP_LIBRARIES)
    find_library(COMMONAPI_SOMEIP_LIBRARIES NAMES CommonAPI-SomeIP)
  endif()
endif()

# ---- targets
add_executable(E01HelloWorldService
  E01HelloWorldService.cpp
  E01HelloWorldStubImpl.cpp
)
add_executable(E01HelloWorldClient
  E01HelloWorldClient.cpp
)

# ---- link depending on what we found
if(HAVE_COMMONAPI_TARGETS)
  target_link_libraries(E01HelloWorldService
    CommonAPI::CommonAPI
    CommonAPI-SomeIP::CommonAPI-SomeIP
    ${VSOMEIP_LIBRARIES}
  )
  target_link_libraries(E01HelloWorldClient
    CommonAPI::CommonAPI
    CommonAPI-SomeIP::CommonAPI-SomeIP
    ${VSOMEIP_LIBRARIES}
  )
else()
  target_link_libraries(E01HelloWorldService
    ${COMMONAPI_LIBRARIES}
    ${COMMONAPI_SOMEIP_LIBRARIES}
    ${VSOMEIP_LIBRARIES}
  )
  target_link_libraries(E01HelloWorldClient
    ${COMMONAPI_LIBRARIES}
    ${COMMONAPI_SOMEIP_LIBRARIES}
    ${VSOMEIP_LIBRARIES}
  )
endif()

install(TARGETS E01HelloWorldService E01HelloWorldClient RUNTIME DESTINATION bin)
