# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_SOURCES_STORAGE_PATH_SRCS
    file_system_storage_path_source.cc
    static_storage_path_source.cc
)

add_library(tensorflow_serving_sources_storage_path OBJECT ${TENSORFLOW_SERVING_SOURCES_STORAGE_PATH_SRCS})

set(TENSORFLOW_SERVING_SOURCES_STORAGE_PATH_PROTOS
    file_system_storage_path_source.proto
    static_storage_path_source.proto
)

foreach(proto ${TENSORFLOW_SERVING_SOURCES_STORAGE_PATH_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
