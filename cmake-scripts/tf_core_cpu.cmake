########################################################
# tf_core_cpu library
########################################################

file(GLOB_RECURSE tf_core_cpu_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/cc/saved_model/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/cc/saved_model/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/*.cc"
    #"${PROJECT_SOURCE_DIR}/tensorflow/core/debug/*.h"
    #"${PROJECT_SOURCE_DIR}/tensorflow/core/debug/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/distributed_runtime/server_lib.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/distributed_runtime/server_lib.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/*/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/*/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/public/*.h"
)

file(GLOB_RECURSE tf_core_cpu_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/cc/saved_model/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/cc/saved_model/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/*main.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/gpu/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/gpu_device_factory.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/direct_session.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/direct_session.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/session.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/session_factory.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/session_options.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/edgeset.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/edgeset.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/graph.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/graph.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/graph_def_builder.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/graph_def_builder.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/node_builder.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/node_builder.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/tensor_id.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/tensor_id.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/while_context.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/graph/while_context.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/clusters/single_machine.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/clusters/single_machine.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/inputs/trivial_test_graph_input_yielder.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/inputs/trivial_test_graph_input_yielder.cc"
)

file(GLOB_RECURSE tf_core_cpu_whitelisted_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/gpu/gpu_id.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/gpu/gpu_id.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/gpu/gpu_id_manager.cc"
)

list(REMOVE_ITEM tf_core_cpu_exclude_srcs ${tf_core_cpu_whitelisted_srcs})
list(REMOVE_ITEM tf_core_cpu_srcs ${tf_core_cpu_exclude_srcs})

if(tensorflow_ENABLE_GPU)
    file(GLOB_RECURSE tf_core_gpu_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/gpu/*.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/default/gpu/cupti_wrapper.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/default/device_tracer.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/gpu_device_factory.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/devices.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/grappler/devices.cc"
    )
    file(GLOB_RECURSE tf_core_gpu_exclude_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/core/*test*.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/*test*.cc"
    )
    list(REMOVE_ITEM tf_core_gpu_srcs ${tf_core_gpu_exclude_srcs})
    list(REMOVE_ITEM tf_core_gpu_srcs ${tf_core_cpu_whitelisted_srcs})
    list(APPEND tf_core_cpu_srcs ${tf_core_gpu_srcs})
endif()

add_library(tf_core_cpu OBJECT
    ${tf_core_cpu_srcs}
)
add_dependencies(tf_core_cpu
    tf_core_framework
)

