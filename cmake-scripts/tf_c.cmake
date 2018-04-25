########################################################
# tf_c_framework library
########################################################

set(tf_c_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/c/c_api.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/c_api.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/c_api_function.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/eager/c_api.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/eager/c_api.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/eager/tape.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/eager/runtime.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/eager/runtime.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/checkpoint_reader.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/checkpoint_reader.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/tf_status_helper.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/tf_status_helper.h"
)

add_library(tf_c OBJECT
    ${tf_c_srcs}
)
add_dependencies(
    tf_c
    tf_cc_framework
    tf_cc_while_loop
    tf_core_lib
    tf_protos_cc
)

add_library(tf_c_python_api OBJECT
    "${PROJECT_SOURCE_DIR}/tensorflow/c/python_api.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/c/python_api.h"
)
add_dependencies(
    tf_c_python_api
    tf_c
    tf_core_lib
    tf_core_framework
    tf_protos_cc
)
