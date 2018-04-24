include (ExternalProject)

set(eigen_INCLUDE_DIR
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}/external/eigen_archive
    ${PROJECT_SOURCE_DIR}/third_party/eigen3
)

set(eigen_URL https://bitbucket.org/eigen/eigen/get/2355b229ea4c.tar.gz)
set(eigen_HASH SHA256=0cadb31a35b514bf2dfd6b5d38205da94ef326ec6908fc3fd7c269948467214f)
set(eigen_BUILD ${CMAKE_CURRENT_BINARY_DIR}/eigen/src/eigen)
set(eigen_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/eigen/install)

ExternalProject_Add(eigen
    PREFIX eigen
    URL ${eigen_URL}
    URL_HASH ${eigen_HASH}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    INSTALL_DIR ${eigen_INSTALL}
    CMAKE_CACHE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:STRING=${eigen_INSTALL}
        -DINCLUDE_INSTALL_DIR:STRING=${CMAKE_CURRENT_BINARY_DIR}/external/eigen_archive
        -DBUILD_TESTING:BOOL=OFF
)
