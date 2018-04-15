# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_MODEL_SERVERS_SRCS
    get_model_status_impl.cc
    grpc_status_util.cc
    model_service_impl.cc
    platform_config_util.cc
    server_core.cc
)

add_library(tensorflow_serving_model_servers OBJECT ${TENSORFLOW_SERVING_MODEL_SERVERS_SRCS})
