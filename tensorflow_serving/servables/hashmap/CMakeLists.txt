# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_SERVABLES_HASHMAP_SRCS
    hashmap_source_adapter.cc
)

add_library(tensorflow_serving_servables_hashmap OBJECT ${TENSORFLOW_SERVING_SERVABLES_HASHMAP_SRCS})

set(TENSORFLOW_SERVING_SERVABLES_HASHMAP_PROTOS
    hashmap_source_adapter.proto
)

foreach(proto ${TENSORFLOW_SERVING_SERVABLES_HASHMAP_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
