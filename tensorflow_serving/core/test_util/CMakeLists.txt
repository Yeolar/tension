# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_CORE_TEST_UTIL_SRCS
    availability_test_util.cc
    fake_loader.cc
    fake_loader_source_adapter.cc
    fake_storage_path_source_adapter.cc
    manager_test_util.cc
    test_main.cc
)

add_library(tensorflow_serving_core_test_util OBJECT ${TENSORFLOW_SERVING_CORE_TEST_UTIL_SRCS})

set(TENSORFLOW_SERVING_CORE_TEST_UTIL_PROTOS
    fake_loader_source_adapter.proto
)

foreach(proto ${TENSORFLOW_SERVING_CORE_TEST_UTIL_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
