# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_APIS_INTERNAL_PROTOS
    serialized_input.proto
)

foreach(proto ${TENSORFLOW_SERVING_APIS_INTERNAL_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
