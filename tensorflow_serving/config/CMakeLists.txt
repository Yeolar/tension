# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_CONFIG_PROTOS
    log_collector_config.proto
    logging_config.proto
    model_server_config.proto
    platform_config.proto
)

foreach(proto ${TENSORFLOW_SERVING_CONFIG_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
