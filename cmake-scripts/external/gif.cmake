include (ExternalProject)

set(gif_URL https://mirror.bazel.build/ufpr.dl.sourceforge.net/project/giflib/giflib-5.1.4.tar.gz)
set(gif_HASH SHA256=34a7377ba834397db019e8eb122e551a49c98f49df75ec3fcc92b9a794a4f6d1)
set(gif_BUILD ${CMAKE_BINARY_DIR}/gif/src/gif)
set(gif_INSTALL ${CMAKE_BINARY_DIR}/gif/install)

set(gif_INCLUDE_DIR ${gif_INSTALL}/include)
set(gif_STATIC_LIBRARIES ${gif_INSTALL}/lib/libgif.a)

set(ENV{CFLAGS} "$ENV{CFLAGS} -fPIC")

ExternalProject_Add(gif
    PREFIX gif
    URL ${gif_URL}
    URL_HASH ${gif_HASH}
    INSTALL_DIR ${gif_INSTALL}
    DOWNLOAD_DIR "${DOWNLOAD_LOCATION}"
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    CONFIGURE_COMMAND
        ${CMAKE_CURRENT_BINARY_DIR}/gif/src/gif/configure
        --with-pic
        --prefix=${gif_INSTALL}
        --libdir=${gif_INSTALL}/lib
        --enable-shared=yes
)

