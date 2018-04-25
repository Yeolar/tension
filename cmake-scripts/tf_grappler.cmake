########################################################
# tf_grappler library
########################################################

file(GLOB tf_grappler_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/clusters/single_machine.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/clusters/single_machine.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/python/grappler/cost_analyzer.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/python/grappler/cost_analyzer.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/python/grappler/model_analyzer.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/python/grappler/model_analyzer.h"
)

add_library(tf_grappler OBJECT
    ${tf_grappler_srcs}
)
add_dependencies(tf_grappler
    tf_core_cpu
)
