include (ExternalProject)

set(snappy_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/snappy/src/snappy)
set(snappy_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/snappy/src/snappy/libsnappy.a)

set(snappy_URL https://github.com/google/snappy.git)
set(snappy_TAG 55924d11095df25ab25c405fadfe93d0a46f82eb)
set(snappy_BUILD ${CMAKE_CURRENT_BINARY_DIR}/snappy/src/snappy)

set(snappy_HEADERS
    "${snappy_INCLUDE_DIR}/snappy.h"
)

ExternalProject_Add(snappy
    PREFIX snappy
    GIT_REPOSITORY ${snappy_URL}
    GIT_TAG ${snappy_TAG}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_IN_SOURCE 1
    BUILD_BYPRODUCTS ${snappy_STATIC_LIBRARIES}
    INSTALL_COMMAND ""
    LOG_DOWNLOAD ON
    LOG_CONFIGURE ON
    LOG_BUILD ON
    CMAKE_CACHE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DSNAPPY_BUILD_TESTS:BOOL=OFF
)

# actually enables snappy in the source code
add_definitions(-DTF_USE_SNAPPY)
