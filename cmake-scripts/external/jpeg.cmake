include (ExternalProject)

set(jpeg_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/external/jpeg_archive)
set(jpeg_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/jpeg/install/lib/libjpeg.a)

set(jpeg_URL https://mirror.bazel.build/www.ijg.org/files/jpegsrc.v9a.tar.gz)
set(jpeg_HASH SHA256=3a753ea48d917945dd54a2d97de388aa06ca2eb1066cbfdc6652036349fe05a7)
set(jpeg_BUILD ${CMAKE_CURRENT_BINARY_DIR}/jpeg/src/jpeg)
set(jpeg_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/jpeg/install)

set(jpeg_HEADERS
    "${jpeg_INSTALL}/include/jconfig.h"
    "${jpeg_INSTALL}/include/jerror.h"
    "${jpeg_INSTALL}/include/jmorecfg.h"
    "${jpeg_INSTALL}/include/jpeglib.h"
    "${jpeg_BUILD}/cderror.h"
    "${jpeg_BUILD}/cdjpeg.h"
    "${jpeg_BUILD}/jdct.h"
    "${jpeg_BUILD}/jinclude.h"
    "${jpeg_BUILD}/jmemsys.h"
    "${jpeg_BUILD}/jpegint.h"
    "${jpeg_BUILD}/jversion.h"
    "${jpeg_BUILD}/transupp.h"
)

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

# put jpeg includes in the directory where they are expected
add_custom_target(jpeg_create_destination_dir
    COMMAND ${CMAKE_COMMAND} -E make_directory ${jpeg_INCLUDE_DIR}
    DEPENDS jpeg)

add_custom_target(jpeg_copy_headers_to_destination
    DEPENDS jpeg_create_destination_dir)

foreach(header_file ${jpeg_HEADERS})
    add_custom_command(TARGET jpeg_copy_headers_to_destination PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${header_file} ${jpeg_INCLUDE_DIR})
endforeach()
