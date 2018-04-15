# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_SERVABLES_TENSORFLOW_SRCS
    bundle_factory_test.h
    bundle_factory_test_util.cc
    bundle_factory_util.cc
    classification_service.cc
    classifier.cc
    curried_session.cc
    get_model_metadata_impl.cc
    multi_inference.cc
    multi_inference_helper.cc
    predict_impl.cc
    predict_util.cc
    regression_service.cc
    regressor.cc
    saved_model_bundle_factory.cc
    saved_model_bundle_source_adapter.cc
    saved_model_warmup.cc
    serving_session.cc
    session_bundle_factory.cc
    session_bundle_source_adapter.cc
    simple_servers.cc
    util.cc
)

add_library(tensorflow_serving_servables_tensorflow OBJECT ${TENSORFLOW_SERVING_SERVABLES_TENSORFLOW_SRCS})

set(TENSORFLOW_SERVING_SERVABLES_TENSORFLOW_PROTOS
    saved_model_bundle_source_adapter.proto
    session_bundle_config.proto
    session_bundle_source_adapter.proto
)

foreach(proto ${TENSORFLOW_SERVING_SERVABLES_TENSORFLOW_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
