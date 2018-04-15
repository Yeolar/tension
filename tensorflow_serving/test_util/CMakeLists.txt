# Copyright 2018 Yeolar

set(TENSORFLOW_SERVING_TEST_UTIL_SRCS
    test_util.cc
)

add_library(tensorflow_serving_test_util OBJECT ${TENSORFLOW_SERVING_TEST_UTIL_SRCS})
