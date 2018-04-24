include (ExternalProject)

set(zlib_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/external/zlib_archive)
set(zlib_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/zlib/install/lib/libz.a)

set(zlib_URL https://github.com/madler/zlib/archive/v1.2.8.tar.gz)
set(zlib_HASH SHA256=e380bd1bdb6447508beaa50efc653fe45f4edc1dafe11a251ae093e0ee97db9a)
set(zlib_BUILD ${CMAKE_CURRENT_BINARY_DIR}/zlib/src/zlib)
set(zlib_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/zlib/install)

set(zlib_HEADERS
    "${zlib_INSTALL}/include/zconf.h"
    "${zlib_INSTALL}/include/zlib.h"
)

ExternalProject_Add(zlib
    PREFIX zlib
    URL ${zlib_URL}
    URL_HASH ${zlib_HASH}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    INSTALL_DIR ${zlib_INSTALL}
    BUILD_IN_SOURCE 1
    BUILD_BYPRODUCTS ${zlib_STATIC_LIBRARIES}
    CMAKE_CACHE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_INSTALL_PREFIX:STRING=${zlib_INSTALL}
)

# put zlib includes in the directory where they are expected
add_custom_target(zlib_create_destination_dir
    COMMAND ${CMAKE_COMMAND} -E make_directory ${zlib_INCLUDE_DIR}
    DEPENDS zlib)

add_custom_target(zlib_copy_headers_to_destination
    DEPENDS zlib_create_destination_dir)

foreach(header_file ${zlib_HEADERS})
    add_custom_command(TARGET zlib_copy_headers_to_destination PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${header_file} ${zlib_INCLUDE_DIR})
endforeach()
