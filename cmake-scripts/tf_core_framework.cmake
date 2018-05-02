########################################################
# tf_core_lib library
########################################################

file(GLOB_RECURSE tf_core_lib_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/lib/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/lib/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/public/*.h"
)

file(GLOB tf_core_platform_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/default/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/default/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/posix/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/posix/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/resource_handle.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/resource_handle.cc"
)

if(NOT tensorflow_ENABLE_GPU)
    file(GLOB tf_core_platform_gpu_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/cuda_libdevice_path.*"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/default/cuda_libdevice_path.*")
    list(REMOVE_ITEM tf_core_platform_srcs ${tf_core_platform_gpu_srcs})
else()
    file(GLOB tf_core_platform_srcs_exclude
        "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/default/device_tracer.cc")
    list(REMOVE_ITEM tf_core_platform_srcs ${tf_core_platform_srcs_exclude})
endif()

file(GLOB tf_core_platform_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/variant_coding.cc")
list(REMOVE_ITEM tf_core_platform_srcs ${tf_core_platform_exclude_srcs})

list(APPEND tf_core_lib_srcs ${tf_core_platform_srcs})

if (tensorflow_ENABLE_HDFS_SUPPORT)
    list(APPEND tf_core_platform_hdfs_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/hadoop/hadoop_file_system.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/hadoop/hadoop_file_system.h"
    )
    list(APPEND tf_core_lib_srcs ${tf_core_platform_hdfs_srcs})
endif()

file(GLOB_RECURSE tf_core_lib_test_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/lib/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/lib/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/public/*test*.h"
)
list(REMOVE_ITEM tf_core_lib_srcs ${tf_core_lib_test_srcs})

add_library(tf_core_lib OBJECT
    ${tf_core_lib_srcs}
)
add_dependencies(tf_core_lib
    ${tensorflow_EXTERNAL_DEPENDENCIES}
    tf_protos_cc
)

########################################################
# tf_core_framework library
########################################################

file(GLOB_RECURSE tf_core_framework_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/variant_coding.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/variant_coding.cc"
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
    "${PROJECT_SOURCE_DIR}/tensorflow/core/util/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/util/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/session.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/session_factory.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/common_runtime/session_options.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensorboard/db/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensorboard/db/*.h"
    "${PROJECT_SOURCE_DIR}/public/*.h"
)

file(GLOB_RECURSE tf_core_framework_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/*testutil.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/*testutil.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/*main.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/resource_handle.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/util/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/util/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/util/*main.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensorboard/db/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensorboard/db/loader.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensorboard/db/vacuum.cc"
)

# TODO(jart): Why doesn't this work?
# set_source_files_properties(
#     ${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensorboard/db/snapfn.cc
#     PROPERTIES COMPILE_FLAGS -DSQLITE_OMIT_LOAD_EXTENSION)

list(REMOVE_ITEM tf_core_framework_srcs ${tf_core_framework_exclude_srcs})

#set(tf_version_srcs ${PROJECT_SOURCE_DIR}/tensorflow/core/util/version_info.cc)

add_library(tf_core_framework OBJECT
    ${tf_core_framework_srcs}
    #    ${tf_version_srcs}
    ${PROTO_TEXT_HDRS}
    ${PROTO_TEXT_SRCS}
)
add_dependencies(tf_core_framework
    tf_core_lib
    proto_text
)

