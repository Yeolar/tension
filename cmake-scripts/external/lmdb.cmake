include (ExternalProject)

set(lmdb_URL https://mirror.bazel.build/github.com/LMDB/lmdb/archive/LMDB_0.9.19.tar.gz)
set(lmdb_HASH SHA256=108532fb94c6f227558d45be3f3347b52539f0f58290a7bb31ec06c462d05326)
set(lmdb_BUILD ${CMAKE_BINARY_DIR}/lmdb/src/lmdb)
set(lmdb_INSTALL ${CMAKE_BINARY_DIR}/lmdb/install)

set(lmdb_INCLUDE_DIR ${lmdb_INSTALL}/include)
set(lmdb_STATIC_LIBRARIES ${lmdb_INSTALL}/lib/liblmdb.a)

ExternalProject_Add(lmdb
    PREFIX lmdb
    URL ${lmdb_URL}
    URL_HASH ${lmdb_HASH}
    BUILD_BYPRODUCTS ${lmdb_STATIC_LIBRARIES}
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${CMAKE_MODULE_PATH}/patches/lmdb/CMakeLists.txt ${lmdb_BUILD}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    INSTALL_DIR ${lmdb_INSTALL}
    CMAKE_CACHE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:STRING=${lmdb_INSTALL}
)

