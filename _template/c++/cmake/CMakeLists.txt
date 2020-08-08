#==============================================================================#
# System Configuration
#==============================================================================#
CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

#==============================================================================#
# Project Name
#==============================================================================#
PROJECT(PositioningEngine)

IF(VERBOSE)
    SET(CMAKE_VERBOSE_MAKEFILE ON)
ENDIF()

#==============================================================================#
# User Configuration
#==============================================================================#
SET(CMAKE_CXX_STANDARD 14)
SET(PROJ_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/..)

ADD_DEFINITIONS("-Wall -g")

#==============================================================================#
# Set output folder
#==============================================================================#
SET(EXECUTABLE_OUTPUT_PATH ${PROJ_ROOT}/out/${CMAKE_SYSTEM_NAME}/bin/)

#==============================================================================#
# Load modes
#==============================================================================#
SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJ_ROOT}/cmake")

#==============================================================================#
# Source Files
#==============================================================================#
# -- Src Header Files
INCLUDE_DIRECTORIES(${PROJ_ROOT}/src/include)

# -- Source Files
AUX_SOURCE_DIRECTORY(${PROJ_ROOT}/src           ALL_SRC)
#AUX_SOURCE_DIRECTORY(${PROJ_ROOT}/src/module    ALL_SRC)

# -- library related source files
#FILE(GLOB @{source_files} @{file_path_1.cc} @{file_path_2.h})

#==============================================================================#
# Set link library(s) path
#==============================================================================#
#LINK_DIRECTORIES(${PROJ_ROOT}/ext/lib)

#==============================================================================#
# Set depend library(s)
#==============================================================================#
#SET(DEPEND_LIBS PELib_static)

#==============================================================================#
# Set executable file or STATIC/SHARED library
#==============================================================================#
FIND_PACKAGE(Threads)
ADD_EXECUTABLE(${PROJECT_NAME} ${ALL_SRC})

#==============================================================================#
# Link library(s)
#==============================================================================#
TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${DEPEND_LIBS} ${CMAKE_THREAD_LIBS_INIT})

