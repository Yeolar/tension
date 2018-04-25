########################################################
# tf_core_direct_session library
########################################################

file(GLOB tf_core_direct_session_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/direct_session.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/direct_session.h"
)

file(GLOB_RECURSE tf_core_direct_session_test_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/debug/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/debug/*test*.cc"
)

list(REMOVE_ITEM tf_core_direct_session_srcs ${tf_core_direct_session_test_srcs})

add_library(tf_core_direct_session OBJECT
    ${tf_core_direct_session_srcs}
)
add_dependencies(tf_core_direct_session
    tf_core_cpu
)
