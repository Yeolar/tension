## batching

file(GLOB tf_serving_batching_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/batching/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/batching/*.cc"
)

file(GLOB tf_serving_batching_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/batching/*test.cc"
)

list(REMOVE_ITEM tf_serving_batching_srcs ${tf_serving_batching_exclude_srcs})

## core

file(GLOB tf_serving_core_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/core/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/core/*.cc"
)

file(GLOB tf_serving_core_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/core/*benchmark.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/core/*test.cc"
)

list(REMOVE_ITEM tf_serving_core_srcs ${tf_serving_core_exclude_srcs})

## model_servers

file(GLOB tf_serving_model_servers_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/model_servers/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/model_servers/*.cc"
)

file(GLOB tf_serving_model_servers_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/model_servers/*test.cc"
)

list(REMOVE_ITEM tf_serving_model_servers_srcs ${tf_serving_model_servers_exclude_srcs})

## resources

file(GLOB tf_serving_resources_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/resources/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/resources/*.cc"
)

file(GLOB tf_serving_resources_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/resources/*test.cc"
)

list(REMOVE_ITEM tf_serving_resources_srcs ${tf_serving_resources_exclude_srcs})

## servables

file(GLOB tf_serving_servables_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/hashmap/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/hashmap/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/tensorflow/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/tensorflow/*.cc"
)

file(GLOB tf_serving_servables_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/hashmap/*test.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/tensorflow/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/tensorflow/*test*.cc"
)

list(REMOVE_ITEM tf_serving_servables_srcs ${tf_serving_servables_exclude_srcs})

## sources

file(GLOB tf_serving_sources_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/sources/storage_path/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/sources/storage_path/*.cc"
)

file(GLOB tf_serving_sources_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/sources/storage_path/*test.cc"
)

list(REMOVE_ITEM tf_serving_sources_srcs ${tf_serving_sources_exclude_srcs})

## util

file(GLOB tf_serving_util_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/util/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/util/*.cc"
)

file(GLOB tf_serving_util_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/util/*benchmark.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/util/*test.cc"
)

list(REMOVE_ITEM tf_serving_util_srcs ${tf_serving_util_exclude_srcs})

###

add_executable(tf_serving
    ${tf_serving_batching_srcs}
    ${tf_serving_core_srcs}
    ${tf_serving_model_servers_srcs}
    ${tf_serving_resources_srcs}
    ${tf_serving_servables_srcs}
    ${tf_serving_sources_srcs}
    ${tf_serving_util_srcs}
)
target_link_libraries(tf_serving
    tensorflow
    tf_serving_protos_cc
)

