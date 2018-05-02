include (ExternalProject)

set(png_URL https://storage.googleapis.com/libpng-public-archive/libpng-1.2.53.tar.gz)
set(png_HASH SHA256=e05c9056d7f323088fd7824d8c6acc03a4a758c4b4916715924edc5dd3223a72)
set(png_BUILD ${CMAKE_BINARY_DIR}/png/src/png)
set(png_INSTALL ${CMAKE_BINARY_DIR}/png/install)

set(png_INCLUDE_DIR ${png_INSTALL}/include/libpng12)
set(png_STATIC_LIBRARIES ${png_INSTALL}/lib/libpng12.a)

ExternalProject_Add(png
    PREFIX png
    #    DEPENDS zlib
    URL ${png_URL}
    URL_HASH ${png_HASH}
    BUILD_BYPRODUCTS ${png_STATIC_LIBRARIES}
    INSTALL_DIR ${png_INSTALL}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    CMAKE_CACHE_ARGS
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:STRING=${png_INSTALL}
        #-DZLIB_ROOT:STRING=${zlib_INSTALL}
)

