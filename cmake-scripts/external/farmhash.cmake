include (ExternalProject)

set(farmhash_INCLUDE_DIR
    ${CMAKE_CURRENT_BINARY_DIR}/external/farmhash_archive
    ${CMAKE_CURRENT_BINARY_DIR}/external/farmhash_archive/util)
set(farmhash_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/farmhash/install/lib/libfarmhash.a)

set(farmhash_URL https://mirror.bazel.build/github.com/google/farmhash/archive/816a4ae622e964763ca0862d9dbd19324a1eaf45.tar.gz)
set(farmhash_HASH SHA256=6560547c63e4af82b0f202cb710ceabb3f21347a4b996db565a411da5b17aba0)
set(farmhash_BUILD ${CMAKE_CURRENT_BINARY_DIR}/farmhash/src/farmhash)
set(farmhash_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/farmhash/install)
set(farmhash_INCLUDES ${farmhash_BUILD})

set(farmhash_HEADERS
    "${farmhash_BUILD}/src/farmhash.h"
)

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

# put farmhash includes in the directory where they are expected
add_custom_target(farmhash_create_destination_dir
    COMMAND ${CMAKE_COMMAND} -E make_directory ${farmhash_INCLUDE_DIR}
    DEPENDS farmhash)

add_custom_target(farmhash_copy_headers_to_destination
    DEPENDS farmhash_create_destination_dir)

foreach(header_file ${farmhash_HEADERS})
    add_custom_command(TARGET farmhash_copy_headers_to_destination PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${header_file} ${farmhash_INCLUDE_DIR}/)
endforeach()
