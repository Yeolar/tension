# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_RESOURCES_SRCS
    resource_tracker.cc
    resource_util.cc
    resource_values.cc
)

add_library(tensorflow_serving_resources OBJECT ${TENSORFLOW_SERVING_RESOURCES_SRCS})

set(TENSORFLOW_SERVING_RESOURCES_PROTOS
    resources.proto
)

foreach(proto ${TENSORFLOW_SERVING_RESOURCES_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
