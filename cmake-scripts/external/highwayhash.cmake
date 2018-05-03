include (ExternalProject)

set(highwayhash_URL https://github.com/google/highwayhash.git)
set(highwayhash_TAG be5edafc2e1a455768e260ccd68ae7317b6690ee)
set(highwayhash_BUILD ${CMAKE_CURRENT_BINARY_DIR}/highwayhash/src/highwayhash)
set(highwayhash_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/highwayhash/install)

set(highwayhash_INCLUDE_DIR ${highwayhash_BUILD})
set(highwayhash_STATIC_LIBRARIES ${highwayhash_INSTALL}/lib/libhighwayhash.a)

ExternalProject_Add(highwayhash
    PREFIX highwayhash
    GIT_REPOSITORY ${highwayhash_URL}
    GIT_TAG ${highwayhash_TAG}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_IN_SOURCE 1
    BUILD_BYPRODUCTS ${highwayhash_STATIC_LIBRARIES}
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_MODULE_PATH}/patches/highwayhash/CMakeLists.txt ${highwayhash_BUILD}
    INSTALL_DIR ${highwayhash_INSTALL}
    CMAKE_CACHE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:STRING=${highwayhash_INSTALL}
)

