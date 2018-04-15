# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_BATCHING_SRCS
    batching_session.cc
    batching_util.cc
    streaming_batch_scheduler.cc
)

add_library(tensorflow_serving_batching OBJECT ${TENSORFLOW_SERVING_BATCHING_SRCS})
