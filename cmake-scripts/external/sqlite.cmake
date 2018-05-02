include (ExternalProject)

set(sqlite_URL https://mirror.bazel.build/www.sqlite.org/2017/sqlite-amalgamation-3200000.zip)
set(sqlite_HASH SHA256=208780b3616f9de0aeb50822b7a8f5482f6515193859e91ed61637be6ad74fd4)
set(sqlite_BUILD ${CMAKE_CURRENT_BINARY_DIR}/sqlite/src/sqlite)
set(sqlite_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/sqlite/install)

set(sqlite_INCLUDE_DIR ${sqlite_BUILD})
set(sqlite_STATIC_LIBRARIES ${sqlite_INSTALL}/lib/libsqlite.a)

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
