# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_CORE_SRCS
    aspired_version_policy.cc
    aspired_versions_manager.cc
    aspired_versions_manager_builder.cc
    availability_preserving_policy.cc
    basic_manager.cc
    caching_manager.cc
    load_servables_fast.cc
    loader_harness.cc
    log_collector.cc
    manager_wrapper.cc
    request_logger.cc
    resource_preserving_policy.cc
    servable_state_monitor.cc
    server_request_logger.cc
    static_manager.cc
)

add_library(tensorflow_serving_core OBJECT ${TENSORFLOW_SERVING_CORE_SRCS})

set(TENSORFLOW_SERVING_CORE_PROTOS
    logging.proto
)

foreach(proto ${TENSORFLOW_SERVING_CORE_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
