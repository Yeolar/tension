file(GLOB_RECURSE tf_tools_transform_graph_lib_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/*.cc"
)

file(GLOB_RECURSE tf_tools_transform_graph_lib_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/compare_graphs.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/summarize_graph_main.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/transform_graph_main.cc"
)
list(REMOVE_ITEM tf_tools_transform_graph_lib_srcs ${tf_tools_transform_graph_lib_exclude_srcs})

add_library(tf_tools_transform_graph_lib OBJECT
    ${tf_tools_transform_graph_lib_srcs}
)
add_dependencies(tf_tools_transform_graph_lib
    tf_core_cpu
    tf_core_framework
    tf_core_kernels
    tf_core_lib
    tf_core_ops)

set(transform_graph "transform_graph")

add_executable(${transform_graph}
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/transform_graph_main.cc"
    $<TARGET_OBJECTS:tf_tools_transform_graph_lib>
    $<TARGET_OBJECTS:tf_core_lib>
    $<TARGET_OBJECTS:tf_core_cpu>
    $<TARGET_OBJECTS:tf_core_framework>
    $<TARGET_OBJECTS:tf_core_ops>
    $<TARGET_OBJECTS:tf_core_direct_session>
    $<TARGET_OBJECTS:tf_tools_transform_graph_lib>
    $<TARGET_OBJECTS:tf_core_kernels>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<$<BOOL:${BOOL_WIN32}>:$<TARGET_OBJECTS:tf_core_kernels_cpu_only>>>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<TARGET_OBJECTS:tf_stream_executor>>
)

target_link_libraries(${transform_graph} PUBLIC
  tf_protos_cc
  ${tf_core_gpu_kernels_lib}
  ${tensorflow_EXTERNAL_LIBRARIES}
)

set(summarize_graph "summarize_graph")

add_executable(${summarize_graph}
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/summarize_graph_main.cc"
    $<TARGET_OBJECTS:tf_tools_transform_graph_lib>
    $<TARGET_OBJECTS:tf_core_lib>
    $<TARGET_OBJECTS:tf_core_cpu>
    $<TARGET_OBJECTS:tf_core_framework>
    $<TARGET_OBJECTS:tf_core_ops>
    $<TARGET_OBJECTS:tf_core_direct_session>
    $<TARGET_OBJECTS:tf_tools_transform_graph_lib>
    $<TARGET_OBJECTS:tf_core_kernels>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<$<BOOL:${BOOL_WIN32}>:$<TARGET_OBJECTS:tf_core_kernels_cpu_only>>>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<TARGET_OBJECTS:tf_stream_executor>>
)

target_link_libraries(${summarize_graph} PUBLIC
  tf_protos_cc
  ${tf_core_gpu_kernels_lib}
  ${tensorflow_EXTERNAL_LIBRARIES}
)

set(compare_graphs "compare_graphs")

add_executable(${compare_graphs}
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/graph_transforms/compare_graphs.cc"
    $<TARGET_OBJECTS:tf_tools_transform_graph_lib>
    $<TARGET_OBJECTS:tf_core_lib>
    $<TARGET_OBJECTS:tf_core_cpu>
    $<TARGET_OBJECTS:tf_core_framework>
    $<TARGET_OBJECTS:tf_core_ops>
    $<TARGET_OBJECTS:tf_core_direct_session>
    $<TARGET_OBJECTS:tf_tools_transform_graph_lib>
    $<TARGET_OBJECTS:tf_core_kernels>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<$<BOOL:${BOOL_WIN32}>:$<TARGET_OBJECTS:tf_core_kernels_cpu_only>>>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<TARGET_OBJECTS:tf_stream_executor>>
)

target_link_libraries(${compare_graphs} PUBLIC
  tf_protos_cc
  ${tf_core_gpu_kernels_lib}
  ${tensorflow_EXTERNAL_LIBRARIES}
)

set(benchmark_model "benchmark_model")

add_executable(${benchmark_model}
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/benchmark/benchmark_model.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/tools/benchmark/benchmark_model_main.cc"
    $<TARGET_OBJECTS:tf_core_lib>
    $<TARGET_OBJECTS:tf_core_cpu>
    $<TARGET_OBJECTS:tf_core_framework>
    $<TARGET_OBJECTS:tf_core_ops>
    $<TARGET_OBJECTS:tf_core_direct_session>
    $<TARGET_OBJECTS:tf_core_kernels>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<$<BOOL:${BOOL_WIN32}>:$<TARGET_OBJECTS:tf_core_kernels_cpu_only>>>
    $<$<BOOL:${tensorflow_ENABLE_GPU}>:$<TARGET_OBJECTS:tf_stream_executor>>
)

target_link_libraries(${benchmark_model} PUBLIC
  tf_protos_cc
  ${tf_core_gpu_kernels_lib}
  ${tensorflow_EXTERNAL_LIBRARIES}
)

install(TARGETS ${transform_graph} ${summarize_graph} ${compare_graphs} ${benchmark_model}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)

