include (ExternalProject)

set(nsync_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/external/nsync/public)
set(nsync_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/nsync/install/lib/libnsync.a)

set(nsync_URL https://github.com/google/nsync)
set(nsync_TAG 8502189abfa44c249c01c2cad64e6ed660a9a668)
set(nsync_BUILD ${CMAKE_CURRENT_BINARY_DIR}/nsync/src/nsync)
set(nsync_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/nsync/install)

set(nsync_HEADERS "${nsync_BUILD}/public/*.h")

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
        -DNSYNC_LANGUAGE:STRING=c++11)

# put nsync includes in the directory where they are expected
add_custom_target(nsync_create_destination_dir
    COMMAND ${CMAKE_COMMAND} -E make_directory ${nsync_INCLUDE_DIR}
    DEPENDS nsync)

add_custom_target(nsync_copy_headers_to_destination
    DEPENDS nsync_create_destination_dir)

add_custom_command(TARGET nsync_copy_headers_to_destination PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${nsync_INSTALL}/include/ ${nsync_INCLUDE_DIR}/)
