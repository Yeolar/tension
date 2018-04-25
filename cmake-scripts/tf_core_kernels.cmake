########################################################
# tf_core_kernels library
########################################################

if(tensorflow_BUILD_ALL_KERNELS)
    file(GLOB_RECURSE tf_core_kernels_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*.cc"
    )
else(tensorflow_BUILD_ALL_KERNELS)
    # Build a minimal subset of kernels to be able to run a test program.
    set(tf_core_kernels_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/bounds_check.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/constant_op.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/constant_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/fill_functor.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/fill_functor.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/matmul_op.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/matmul_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/no_op.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/no_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/ops_util.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/ops_util.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/sendrecv_ops.h"
        "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/sendrecv_ops.cc"
    )
endif(tensorflow_BUILD_ALL_KERNELS)

if(tensorflow_BUILD_CONTRIB_KERNELS)
    set(tf_contrib_kernels_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/kernels/model_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/kernels/prediction_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/kernels/quantile_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/kernels/split_handler_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/kernels/stats_accumulator_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/kernels/training_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/utils/batch_features.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/utils/dropout_utils.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/utils/examples_iterable.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/utils/parallel_for.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/utils/sparse_column_iterable.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/utils/tensor_utils.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/learner/common/partitioners/example_partitioner.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/models/multiple_additive_trees.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/lib/trees/decision_tree.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/model_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/prediction_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/quantile_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/split_handler_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/stats_accumulator_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/training_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/coder/kernels/range_coder.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/coder/kernels/range_coder_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/coder/kernels/range_coder_ops_util.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/coder/ops/coder_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/cudnn_rnn/kernels/cudnn_rnn_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/cudnn_rnn/ops/cudnn_rnn_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/data/kernels/ignore_errors_dataset_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/data/kernels/prefetching_kernels.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/data/kernels/threadpool_dataset_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/data/kernels/unique_dataset_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/data/ops/dataset_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/factorization/kernels/clustering_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/factorization/kernels/masked_matmul_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/factorization/kernels/wals_solver_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/factorization/ops/clustering_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/factorization/ops/factorization_ops.cc"
        #"${PROJECT_SOURCE_DIR}/tensorflow/contrib/ffmpeg/decode_audio_op.cc"
        #"${PROJECT_SOURCE_DIR}/tensorflow/contrib/ffmpeg/encode_audio_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/framework/kernels/zero_initializer_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/framework/ops/variable_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/kernels/adjust_hsv_in_yiq_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/kernels/bipartite_match_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/kernels/image_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/kernels/segmentation_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/kernels/single_image_random_dot_stereograms_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/ops/distort_image_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/ops/image_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/ops/single_image_random_dot_stereograms_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/layers/kernels/sparse_feature_cross_kernel.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/layers/ops/sparse_feature_cross_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/libsvm/kernels/decode_libsvm_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/libsvm/ops/libsvm_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/nccl/kernels/nccl_manager.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/nccl/kernels/nccl_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/nccl/ops/nccl_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/nearest_neighbor/kernels/hyperplane_lsh_probes.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/nearest_neighbor/ops/nearest_neighbor_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/resampler/kernels/resampler_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/resampler/ops/resampler_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/kernels/blas_gemm.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/kernels/gru_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/kernels/lstm_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/ops/gru_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/ops/lstm_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/seq2seq/kernels/beam_search_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/seq2seq/ops/beam_search_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/ops/tensor_forest_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/kernels/reinterpret_string_to_float_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/kernels/scatter_add_ndim_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/kernels/tree_utils.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/hard_routing_function_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/k_feature_gradient_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/k_feature_routing_function_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/routing_function_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/routing_gradient_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/stochastic_hard_routing_function_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/stochastic_hard_routing_gradient_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/unpack_path_op.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/utils.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/text/kernels/skip_gram_kernels.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/text/ops/skip_gram_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tpu/ops/cross_replica_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tpu/ops/infeed_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tpu/ops/outfeed_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tpu/ops/replication_ops.cc"
        "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tpu/ops/tpu_configuration_ops.cc"
    )
    list(APPEND tf_core_kernels_srcs ${tf_contrib_kernels_srcs})
endif(tensorflow_BUILD_CONTRIB_KERNELS)

# Cloud libraries require boringssl.
file(GLOB tf_core_kernels_cloud_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/cloud/kernels/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/cloud/kernels/*.cc"
)
list(REMOVE_ITEM tf_core_kernels_srcs ${tf_core_kernels_cloud_srcs})

file(GLOB_RECURSE tf_core_kernels_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/debug_ops.*" # Add
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*testutil.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*testutil.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*test_utils.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*test_utils.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*main.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*.cu.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/fuzzing/*"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/hexagon/*"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/remote_fused_graph_rewriter_transform*.cc"
)
list(REMOVE_ITEM tf_core_kernels_srcs ${tf_core_kernels_exclude_srcs})

file(GLOB_RECURSE tf_core_gpu_kernels_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/kernels/*.cu.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/framework/kernels/zero_initializer_op_gpu.cu.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/kernels/*.cu.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/kernels/*.cu.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/seq2seq/kernels/*.cu.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/resampler/kernels/*.cu.cc"
)

add_library(tf_core_kernels OBJECT
    ${tf_core_kernels_srcs}
)
add_dependencies(tf_core_kernels
    tf_core_cpu
)

if(tensorflow_ENABLE_GPU)
    set_source_files_properties(${tf_core_gpu_kernels_srcs}
        PROPERTIES CUDA_SOURCE_PROPERTY_FORMAT OBJ)
    set(tf_core_gpu_kernels_lib tf_core_gpu_kernels)
    cuda_add_library(${tf_core_gpu_kernels_lib} ${tf_core_gpu_kernels_srcs})
    set_target_properties(${tf_core_gpu_kernels_lib}
        PROPERTIES DEBUG_POSTFIX "" COMPILE_FLAGS "${TF_REGULAR_CXX_FLAGS}")
    add_dependencies(${tf_core_gpu_kernels_lib}
        tf_core_cpu)
endif()
