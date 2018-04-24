include (ExternalProject)

set(sqlite_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/external/sqlite)
set(sqlite_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/sqlite/install/lib/libsqlite.a)

set(sqlite_URL https://mirror.bazel.build/www.sqlite.org/2017/sqlite-amalgamation-3200000.zip)
set(sqlite_HASH SHA256=208780b3616f9de0aeb50822b7a8f5482f6515193859e91ed61637be6ad74fd4)
set(sqlite_BUILD ${CMAKE_CURRENT_BINARY_DIR}/sqlite/src/sqlite)
set(sqlite_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/sqlite/install)

set(sqlite_HEADERS
    "${sqlite_BUILD}/sqlite3.h"
    "${sqlite_BUILD}/sqlite3ext.h"
)

ExternalProject_Add(sqlite
    PREFIX sqlite
    URL ${sqlite_URL}
    URL_HASH ${sqlite_HASH}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_MODULE_PATH}/patches/sqlite/CMakeLists.txt ${sqlite_BUILD}
    INSTALL_DIR ${sqlite_INSTALL}
    CMAKE_CACHE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:STRING=${sqlite_INSTALL}
)

# put sqlite includes in the directory where they are expected
add_custom_target(sqlite_create_destination_dir
    COMMAND ${CMAKE_COMMAND} -E make_directory ${sqlite_INCLUDE_DIR}
    DEPENDS sqlite)

add_custom_target(sqlite_copy_headers_to_destination
    DEPENDS sqlite_create_destination_dir)

foreach(header_file ${sqlite_HEADERS})
    add_custom_command(TARGET sqlite_copy_headers_to_destination PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${header_file} ${sqlite_INCLUDE_DIR})
endforeach()
