include (ExternalProject)

set(re2_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/re2/install/include)
set(re2_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/re2/src/re2/libre2.a)

set(re2_URL https://github.com/google/re2)
set(re2_BUILD ${CMAKE_CURRENT_BINARY_DIR}/re2/src/re2)
set(re2_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/re2/install)
set(re2_TAG e7efc48)

set(re2_HEADERS
    ${re2_INSTALL}/include/re2/re2.h
)

ExternalProject_Add(re2
    PREFIX re2
    GIT_REPOSITORY ${re2_URL}
    GIT_TAG ${re2_TAG}
    INSTALL_DIR ${re2_INSTALL}
    BUILD_IN_SOURCE 1
    BUILD_BYPRODUCTS ${re2_STATIC_LIBRARIES}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    CMAKE_CACHE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_INSTALL_PREFIX:STRING=${re2_INSTALL}
        -DRE2_BUILD_TESTING:BOOL=OFF
)
