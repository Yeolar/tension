include (ExternalProject)

set(gemmlowp_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/gemmlowp/src/gemmlowp)

set(gemmlowp_URL https://github.com/google/gemmlowp/archive/6a2a90822e8546fc2bfa7044de0faf1c1cb4862f.zip)
set(gemmlowp_HASH SHA256=3447948d219f3270383766bbe08942888c0eb4e0ca6663c0e0548502ec5bb77d)
set(gemmlowp_BUILD ${CMAKE_CURRENT_BINARY_DIR}/gemmlowp/src/gemmlowp)

ExternalProject_Add(gemmlowp
    PREFIX gemmlowp
    URL ${gemmlowp_URL}
    URL_HASH ${gemmlowp_HASH}
    DOWNLOAD_DIR ${DOWNLOAD_LOCATION}
    BUILD_IN_SOURCE 1
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_MODULE_PATH}/patches/gemmlowp/CMakeLists.txt ${gemmlowp_BUILD}
    INSTALL_COMMAND ""
)
