# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_UTIL_SRCS
    class_registration_util.cc
    file_probing_env.cc
    hash.cc
    inline_executor.cc
    optional.cc
    retrier.cc
    status_util.cc
    threadpool_executor.cc
)

add_library(tensorflow_serving_util OBJECT ${TENSORFLOW_SERVING_UTIL_SRCS})

set(TENSORFLOW_SERVING_UTIL_PROTOS
    class_registration_test.proto
    status.proto
)

foreach(proto ${TENSORFLOW_SERVING_UTIL_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
