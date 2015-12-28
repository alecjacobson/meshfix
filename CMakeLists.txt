cmake_minimum_required(VERSION 2.6)
project(meshfix)

SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-strict-aliasing")

add_definitions(-DIS64BITPLATFORM)


set(JMESHEXT_DIR "${PROJECT_SOURCE_DIR}/JMeshExt-1.0alpha_src")
set(JMESH_DIR "${JMESHEXT_DIR}/JMeshLib-1.2/")

include_directories("${JMESHEXT_DIR}/include")
include_directories("${JMESH_DIR}/include")
add_subdirectory("${JMESHEXT_DIR}")
find_library(BLAS REQUIRED)
if(APPLE)
  set(CMAKE_CXX_LINK_FLAGS "-framework Accelerate")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
endif()

add_library(meshfix STATIC meshfix.cpp)
add_executable(meshfix-bin main.cpp)
target_link_libraries(
  meshfix-bin 
  ${BLAS_LIBRARIES} 
  meshfix 
  jmesh 
  jmeshext 
  nl 
  superlu)
set_target_properties(meshfix-bin PROPERTIES OUTPUT_NAME meshfix)

