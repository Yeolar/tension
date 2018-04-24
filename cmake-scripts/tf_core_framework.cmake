########################################################
# RELATIVE_PROTOBUF_GENERATE_CPP function
########################################################
# A variant of PROTOBUF_GENERATE_CPP that keeps the directory hierarchy.
# ROOT_DIR must be absolute, and proto paths must be relative to ROOT_DIR.
function(RELATIVE_PROTOBUF_GENERATE_CPP SRCS HDRS ROOT_DIR)
  if(NOT ARGN)
    message(SEND_ERROR "Error: RELATIVE_PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif()

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    set(ABS_FIL ${ROOT_DIR}/${FIL})
    get_filename_component(FIL_WE ${FIL} NAME_WE)
    get_filename_component(FIL_DIR ${ABS_FIL} PATH)
    file(RELATIVE_PATH REL_DIR ${ROOT_DIR} ${FIL_DIR})

    list(APPEND ${SRCS} "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb.cc")
    list(APPEND ${HDRS} "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb.h")

    add_custom_command(
      OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb.cc"
             "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb.h"
      COMMAND  ${protobuf_PROTOC_EXECUTABLE}
      ARGS --cpp_out  ${CMAKE_CURRENT_BINARY_DIR} -I ${ROOT_DIR} ${ABS_FIL} -I ${protobuf_INCLUDE_DIR}
      DEPENDS ${ABS_FIL} protobuf
      COMMENT "Running C++ protocol buffer compiler on ${FIL}"
      VERBATIM )
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

function(RELATIVE_PROTOBUF_TEXT_GENERATE_CPP SRCS HDRS ROOT_DIR)
  if(NOT ARGN)
      message(SEND_ERROR "Error: RELATIVE_PROTOBUF_TEXT_GENERATE_CPP() called without any proto files")
    return()
  endif()

  set(${SRCS})
  set(${HDRS})
  foreach(FIL ${ARGN})
    set(ABS_FIL ${ROOT_DIR}/${FIL})
    get_filename_component(FIL_WE ${FIL} NAME_WE)
    get_filename_component(FIL_DIR ${ABS_FIL} PATH)
    file(RELATIVE_PATH REL_DIR ${ROOT_DIR} ${FIL_DIR})

    list(APPEND ${SRCS} "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb_text.cc")
    list(APPEND ${HDRS} "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb_text.h")

    add_custom_command(
      OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb_text.cc"
             "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}/${FIL_WE}.pb_text.h"
      COMMAND ${PROTO_TEXT_EXE}
      ARGS "${CMAKE_CURRENT_BINARY_DIR}/${REL_DIR}" ${REL_DIR} ${ABS_FIL} "${ROOT_DIR}/tensorflow/tools/proto_text/placeholder.txt"
      DEPENDS ${ABS_FIL} ${PROTO_TEXT_EXE}
      COMMENT "Running C++ protocol buffer text compiler (${PROTO_TEXT_EXE}) on ${FIL}"
      VERBATIM )
  endforeach()

  set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
endfunction()

########################################################
# tf_protos_cc library
########################################################

file(GLOB_RECURSE tf_protos_cc_srcs RELATIVE ${PROJECT_SOURCE_DIR}
    "${PROJECT_SOURCE_DIR}/tensorflow/core/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/proto/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tpu/proto/*.proto"
)

RELATIVE_PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS
    ${PROJECT_SOURCE_DIR} ${tf_protos_cc_srcs}
)


set(PROTO_TEXT_EXE "proto_text")
set(tf_proto_text_srcs
    "tensorflow/core/example/example.proto"
    "tensorflow/core/example/feature.proto"
    "tensorflow/core/framework/allocation_description.proto"
    "tensorflow/core/framework/attr_value.proto"
    "tensorflow/core/framework/cost_graph.proto"
    "tensorflow/core/framework/device_attributes.proto"
    "tensorflow/core/framework/function.proto"
    "tensorflow/core/framework/graph.proto"
    "tensorflow/core/framework/graph_transfer_info.proto"
    "tensorflow/core/framework/kernel_def.proto"
    "tensorflow/core/framework/log_memory.proto"
    "tensorflow/core/framework/node_def.proto"
    "tensorflow/core/framework/op_def.proto"
    "tensorflow/core/framework/remote_fused_graph_execute_info.proto"
    "tensorflow/core/framework/resource_handle.proto"
    "tensorflow/core/framework/step_stats.proto"
    "tensorflow/core/framework/summary.proto"
    "tensorflow/core/framework/tensor.proto"
    "tensorflow/core/framework/tensor_description.proto"
    "tensorflow/core/framework/tensor_shape.proto"
    "tensorflow/core/framework/tensor_slice.proto"
    "tensorflow/core/framework/types.proto"
    "tensorflow/core/framework/versions.proto"
    "tensorflow/core/lib/core/error_codes.proto"
    "tensorflow/core/protobuf/cluster.proto"
    "tensorflow/core/protobuf/config.proto"
    "tensorflow/core/protobuf/debug.proto"
    "tensorflow/core/protobuf/device_properties.proto"
    "tensorflow/core/protobuf/rewriter_config.proto"
    "tensorflow/core/protobuf/tensor_bundle.proto"
    "tensorflow/core/protobuf/saver.proto"
    "tensorflow/core/util/memmapped_file_system.proto"
    "tensorflow/core/util/saved_tensor_slice.proto"
)
RELATIVE_PROTOBUF_TEXT_GENERATE_CPP(PROTO_TEXT_SRCS PROTO_TEXT_HDRS
    ${PROJECT_SOURCE_DIR} ${tf_proto_text_srcs}
)

add_library(tf_protos_cc ${PROTO_SRCS} ${PROTO_HDRS})

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
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/resource_handle.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/framework/resource_handle.cc"
)

if (NOT tensorflow_ENABLE_GPU)
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

file(GLOB tf_core_platform_posix_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/posix/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/posix/*.cc"
)
list(APPEND tf_core_lib_srcs ${tf_core_platform_posix_srcs})

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

add_library(tf_core_lib OBJECT ${tf_core_lib_srcs})
add_dependencies(tf_core_lib ${tensorflow_EXTERNAL_DEPENDENCIES} tf_protos_cc)

set(tf_version_srcs ${PROJECT_SOURCE_DIR}/tensorflow/core/util/version_info.cc)

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

add_library(tf_core_framework OBJECT
    ${tf_core_framework_srcs}
    ${tf_version_srcs}
    ${PROTO_TEXT_HDRS}
    ${PROTO_TEXT_SRCS})
add_dependencies(tf_core_framework
    tf_core_lib
    proto_text
)

