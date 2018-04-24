# Copyright 2017 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
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

add_library(tf_core_profiler OBJECT ${tf_core_profiler_srcs})
add_dependencies(tf_core_profiler tf_core_lib)