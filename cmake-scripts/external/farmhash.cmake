include (ExternalProject)

set(farmhash_URL https://mirror.bazel.build/github.com/google/farmhash/archive/816a4ae622e964763ca0862d9dbd19324a1eaf45.tar.gz)
set(farmhash_HASH SHA256=6560547c63e4af82b0f202cb710ceabb3f21347a4b996db565a411da5b17aba0)
set(farmhash_BUILD ${CMAKE_CURRENT_BINARY_DIR}/farmhash/src/farmhash)
set(farmhash_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/farmhash/install)

set(farmhash_INCLUDE_DIR ${farmhash_BUILD}/src)
set(farmhash_STATIC_LIBRARIES ${farmhash_INSTALL}/lib/libfarmhash.a)

ExternalProject_Add(farmhash
    PREFIX farmhash
    URL ${farmhash_URL}
    URL_HASH ${farmhash_HASH}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    CONFIGURE_COMMAND
        ${farmhash_BUILD}/configure
        --prefix=${farmhash_INSTALL}
        --libdir=${farmhash_INSTALL}/lib
        --enable-shared=yes
        CXXFLAGS=-fPIC
)
