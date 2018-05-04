# Copyright 2018 Yeolar

include(ExternalProject)

set(raster_URL https://github.com/Yeolar/raster.git)
set(raster_TAG v1.2.2)
set(raster_BUILD ${CMAKE_CURRENT_BINARY_DIR}/raster/)
set(raster_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/raster/src/raster)
set(raster_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/raster/src/raster/libraster.a)

ExternalProject_Add(raster
    PREFIX raster
    GIT_REPOSITORY ${raster_URL}
    GIT_TAG ${raster_TAG}
    DOWNLOAD_DIR "${DOWNLOAD_LOCATION}"
    BUILD_IN_SOURCE 1
    BUILD_BYPRODUCTS ${raster_STATIC_LIBRARIES}
    PATCH_COMMAND ""
    INSTALL_COMMAND ""
    CMAKE_CACHE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DBUILD_GMOCK:BOOL=OFF
        -DBUILD_GTEST:BOOL=ON
        -Dgtest_force_shared_crt:BOOL=ON
)
