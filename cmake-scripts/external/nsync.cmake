include (ExternalProject)

set(nsync_URL https://github.com/google/nsync)
set(nsync_TAG 8502189abfa44c249c01c2cad64e6ed660a9a668)
set(nsync_BUILD ${CMAKE_CURRENT_BINARY_DIR}/nsync/src/nsync)
set(nsync_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/nsync/install)

set(nsync_INCLUDE_DIR ${nsync_INSTALL}/include)
set(nsync_STATIC_LIBRARIES ${nsync_INSTALL}/lib/libnsync.a)

ExternalProject_Add(nsync
    PREFIX nsync
    GIT_REPOSITORY ${nsync_URL}
    GIT_TAG ${nsync_TAG}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_IN_SOURCE 1
    BUILD_BYPRODUCTS ${nsync_STATIC_LIBRARIES}
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_MODULE_PATH}/patches/nsync/CMakeLists.txt ${nsync_BUILD}
    INSTALL_DIR ${nsync_INSTALL}
    CMAKE_CACHE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:STRING=${nsync_INSTALL}
        -DNSYNC_LANGUAGE:STRING=c++11
)

