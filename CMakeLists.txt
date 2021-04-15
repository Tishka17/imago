cmake_minimum_required(VERSION 2.8.6)
cmake_policy(VERSION 2.8.6)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

project(Imago)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/)
set(LIBS_LOCATION "${CMAKE_SOURCE_DIR}/imago-third-party")
message(STATUS ${LIBS_LOCATION})

include(BuildOptions)
include(imago-version.cmake)

INCLUDE(CTest)

add_subdirectory(imago)
add_subdirectory(applications/imago_console)
add_subdirectory(bindings/c)