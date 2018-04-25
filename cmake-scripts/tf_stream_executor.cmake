########################################################
# tf_stream_executor library
########################################################

file(GLOB tf_stream_executor_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/lib/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/lib/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/platform/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/platform/default/*.h"
)

if (tensorflow_ENABLE_GPU)
    file(GLOB tf_stream_executor_gpu_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/cuda/*.cc"
    )
    list(APPEND tf_stream_executor_srcs ${tf_stream_executor_gpu_srcs})
endif()

#file(GLOB_RECURSE tf_stream_executor_test_srcs
#    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/*_test.cc"
#    "${PROJECT_SOURCE_DIR}/tensorflow/stream_executor/*_test.h"
#)
#list(REMOVE_ITEM tf_stream_executor_srcs ${tf_stream_executor_test_srcs})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lgomp")

add_library(tf_stream_executor OBJECT
    ${tf_stream_executor_srcs}
)
add_dependencies(tf_stream_executor
    tf_core_lib
)
#target_link_libraries(tf_stream_executor
#    ${CMAKE_THREAD_LIBS_INIT}
#    ${protobuf_LIBRARIES}
#    tf_protos_cc
#    tf_core_lib
#)
