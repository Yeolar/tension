# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_MODEL_SERVERS_TEST_UTIL_SRCS
    server_core_test_util.cc
    storage_path_error_injecting_source_adapter.cc
)

add_library(tensorflow_serving_model_servers_test_util OBJECT ${TENSORFLOW_SERVING_MODEL_SERVERS_TEST_UTIL_SRCS})

set(TENSORFLOW_SERVING_MODEL_SERVERS_TEST_UTIL_PROTOS
    storage_path_error_injecting_source_adapter.proto
)

foreach(proto ${TENSORFLOW_SERVING_MODEL_SERVERS_TEST_UTIL_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
