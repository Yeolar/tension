include (ExternalProject)

set(fft2d_STATIC_LIBRARIES ${CMAKE_CURRENT_BINARY_DIR}/fft2d/src/fft2d/libfft2d.a)

set(fft2d_URL https://mirror.bazel.build/www.kurims.kyoto-u.ac.jp/~ooura/fft.tgz)
set(fft2d_HASH SHA256=52bb637c70b971958ec79c9c8752b1df5ff0218a4db4510e60826e0cb79b5296)
set(fft2d_BUILD ${CMAKE_CURRENT_BINARY_DIR}/fft2d/)
set(fft2d_INSTALL ${CMAKE_CURRENT_BINARY_DIR}/fft2d/src)

ExternalProject_Add(fft2d
    PREFIX fft2d
    URL ${fft2d_URL}
    URL_HASH ${fft2d_HASH}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_IN_SOURCE 1
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_MODULE_PATH}/patches/fft2d/CMakeLists.txt ${fft2d_BUILD}/src/fft2d/CMakeLists.txt
    INSTALL_DIR ${fft2d_INSTALL}
    INSTALL_COMMAND ""
    BUILD_COMMAND $(MAKE)
)
