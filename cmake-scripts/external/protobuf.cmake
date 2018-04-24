include (ExternalProject)

set(protobuf_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/protobuf/src/protobuf/src)
set(protobuf_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/protobuf/src/protobuf/libprotobuf.a)
set(protobuf_PROTOC_EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/protobuf/src/protobuf/protoc)

set(protobuf_URL https://github.com/google/protobuf/archive/v3.4.1.tar.gz)
set(protobuf_HASH SHA256=8e0236242106e680b4f9f576cc44b8cd711e948b20a9fc07769b0a20ceab9cc4)

ExternalProject_Add(protobuf
    PREFIX protobuf
    DEPENDS zlib
    URL ${protobuf_URL}
    URL_HASH ${protobuf_HASH}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_IN_SOURCE 1
    BUILD_BYPRODUCTS ${protobuf_PROTOC_EXECUTABLE} ${protobuf_STATIC_LIBRARIES}
    SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/protobuf/src/protobuf
    # SOURCE_SUBDIR cmake/ # Requires CMake 3.7, this will allow removal of CONFIGURE_COMMAND
    # CONFIGURE_COMMAND resets some settings made in CMAKE_CACHE_ARGS and the generator used
    CONFIGURE_COMMAND ${CMAKE_COMMAND} cmake/
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -Dprotobuf_BUILD_TESTS:BOOL=OFF
        -DZLIB_ROOT=${zlib_INSTALL}
        ${protobuf_ADDITIONAL_CMAKE_OPTIONS}
    INSTALL_COMMAND ""
    CMAKE_CACHE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -Dprotobuf_BUILD_TESTS:BOOL=OFF
        -Dprotobuf_MSVC_STATIC_RUNTIME:BOOL=OFF
        -DZLIB_ROOT:STRING=${zlib_INSTALL}
)
