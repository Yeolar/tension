########################################################
# tf_core_profiler library
########################################################

file(GLOB_RECURSE tf_core_profiler_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/*.proto"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/tfprof_options.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/tfprof_options.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/advisor/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/advisor/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/platform/regexp.h"
)

file(GLOB_RECURSE tf_core_profiler_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/*test.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/advisor/*test.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/print_model_analysis.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/profiler/internal/print_model_analysis.h"
)
list(REMOVE_ITEM tf_core_profiler_srcs ${tf_core_profiler_exclude_srcs})

add_library(tf_core_profiler OBJECT
    ${tf_core_profiler_srcs}
)
add_dependencies(tf_core_profiler
    tf_core_lib
)
