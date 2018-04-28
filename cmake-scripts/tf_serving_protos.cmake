########################################################
# tf_serving_protos_cc library
########################################################

file(GLOB_RECURSE tf_serving_protos_cc_srcs RELATIVE ${PROJECT_SOURCE_DIR}
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/apis/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/config/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/core/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/model_servers/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/resources/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/servables/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/sources/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow_serving/util/*.proto"
)

RELATIVE_PROTOBUF_GENERATE_CPP(SERV_PROTO_SRCS SERV_PROTO_HDRS
    ${PROJECT_SOURCE_DIR} ${tf_serving_protos_cc_srcs}
)

add_library(tf_serving_protos_cc ${SERV_PROTO_SRCS} ${SERV_PROTO_HDRS})

