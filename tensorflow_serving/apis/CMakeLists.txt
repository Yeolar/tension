# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_APIS_PROTOS
    classification.proto
    get_model_metadata.proto
    get_model_status.proto
    inference.proto
    input.proto
    model.proto
    model_management.proto
    model_service.proto
    predict.proto
    prediction_log.proto
    prediction_service.proto
    regression.proto
    session_service.proto
)

foreach(proto ${TENSORFLOW_SERVING_APIS_PROTOS})
    execute_process(protoc --cpp_out=. --proto_path=${PROJECT_SOURCE_DIR} ${proto})
endforeach()
