include (ExternalProject)

set(jpeg_URL https://mirror.bazel.build/www.ijg.org/files/jpegsrc.v9a.tar.gz)
set(jpeg_HASH SHA256=3a753ea48d917945dd54a2d97de388aa06ca2eb1066cbfdc6652036349fe05a7)
set(jpeg_BUILD ${CMAKE_CURRENT_BINARY_DIR}/jpeg/src/jpeg)
set(jpeg_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/jpeg/install)

set(jpeg_INCLUDE_DIR ${jpeg_INSTALL}/include ${jpeg_BUILD})
set(jpeg_STATIC_LIBRARIES ${jpeg_INSTALL}/lib/libjpeg.a)

ExternalProject_Add(jpeg
    PREFIX jpeg
    URL ${jpeg_URL}
    URL_HASH ${jpeg_HASH}
    INSTALL_DIR ${jpeg_INSTALL}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    CONFIGURE_COMMAND
        ${jpeg_BUILD}/configure
        --prefix=${jpeg_INSTALL}
        --libdir=${jpeg_INSTALL}/lib
        --enable-shared=yes
    CFLAGS=-fPIC
)

