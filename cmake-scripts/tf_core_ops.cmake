set(tf_op_lib_names
    "audio_ops"
    "array_ops"
    "batch_ops"
    "bitwise_ops"
    "candidate_sampling_ops"
    "checkpoint_ops"
    "control_flow_ops"
    "ctc_ops"
    "data_flow_ops"
    "dataset_ops"
    "functional_ops"
    "image_ops"
    "io_ops"
    "linalg_ops"
    "list_ops"
    "lookup_ops"
    "logging_ops"
    "manip_ops"
    "math_ops"
    "nn_ops"
    "no_op"
    "parsing_ops"
    "random_ops"
    "remote_fused_graph_ops"
    "resource_variable_ops"
    "script_ops"
    "sdca_ops"
    "set_ops"
    "sendrecv_ops"
    "sparse_ops"
    "spectral_ops"
    "state_ops"
    "stateless_random_ops"
    "string_ops"
    "summary_ops"
    "training_ops"
)

foreach(tf_op_lib_name ${tf_op_lib_names})
    ########################################################
    # tf_${tf_op_lib_name} library
    ########################################################
    file(GLOB tf_${tf_op_lib_name}_srcs
        "${PROJECT_SOURCE_DIR}/tensorflow/core/ops/${tf_op_lib_name}.cc"
    )

    add_library(tf_${tf_op_lib_name} OBJECT
        ${tf_${tf_op_lib_name}_srcs}
    )
    add_dependencies(tf_${tf_op_lib_name}
        tf_core_framework
    )
endforeach()

function(GENERATE_CONTRIB_OP_LIBRARY op_lib_name cc_srcs)
    add_library(tf_contrib_${op_lib_name}_ops OBJECT ${cc_srcs})
    add_dependencies(tf_contrib_${op_lib_name}_ops tf_core_framework)
endfunction()

file(GLOB_RECURSE tensor_forest_hybrid_srcs
     "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/hybrid/core/ops/*.cc"
)

file(GLOB_RECURSE tpu_ops_srcs
     "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tpu/ops/*.cc"
)

GENERATE_CONTRIB_OP_LIBRARY(boosted_trees_model
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/model_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(boosted_trees_split_handler
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/split_handler_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(boosted_trees_training
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/training_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(boosted_trees_prediction
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/prediction_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(boosted_trees_quantiles
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/quantile_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(boosted_trees_stats_accumulator
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/boosted_trees/ops/stats_accumulator_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(coder
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/coder/ops/coder_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(cudnn_rnn
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/cudnn_rnn/ops/cudnn_rnn_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(data_dataset
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/data/ops/dataset_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(factorization_clustering
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/factorization/ops/clustering_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(factorization_factorization
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/factorization/ops/factorization_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(framework_variable
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/framework/ops/variable_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(input_pipeline
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/input_pipeline/ops/input_pipeline_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(image
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/ops/image_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(image_distort_image
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/ops/distort_image_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(image_sirds
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/image/ops/single_image_random_dot_stereograms_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(layers_sparse_feature_cross
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/layers/ops/sparse_feature_cross_op.cc")
GENERATE_CONTRIB_OP_LIBRARY(memory_stats
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/memory_stats/ops/memory_stats_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(nccl
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/nccl/ops/nccl_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(periodic_resample
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/periodic_resample/ops/array_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(nearest_neighbor
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/nearest_neighbor/ops/nearest_neighbor_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(resampler
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/resampler/ops/resampler_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(rnn_gru
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/ops/gru_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(rnn_lstm
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/rnn/ops/lstm_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(seq2seq_beam_search
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/seq2seq/ops/beam_search_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(tensor_forest
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/ops/tensor_forest_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(tensor_forest_hybrid
    "${tensor_forest_hybrid_srcs}")
GENERATE_CONTRIB_OP_LIBRARY(tensor_forest_model
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/ops/model_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(tensor_forest_stats
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/tensor_forest/ops/stats_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(text_skip_gram
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/text/ops/skip_gram_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(tpu
    "${tpu_ops_srcs}")
GENERATE_CONTRIB_OP_LIBRARY(bigquery_reader
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/cloud/ops/bigquery_reader_ops.cc")
GENERATE_CONTRIB_OP_LIBRARY(reduce_slice_ops
    "${PROJECT_SOURCE_DIR}/tensorflow/contrib/reduce_slice_ops/ops/reduce_slice_ops.cc")

########################################################
# tf_user_ops library
########################################################

file(GLOB_RECURSE tf_user_ops_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/user_ops/*.cc"
)

add_library(tf_user_ops OBJECT
    ${tf_user_ops_srcs}
)
add_dependencies(tf_user_ops
    tf_core_framework
)

########################################################
# tf_core_ops library
########################################################

file(GLOB_RECURSE tf_core_ops_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/ops/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/ops/*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/user_ops/*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/user_ops/*.cc"
)

file(GLOB_RECURSE tf_core_ops_exclude_srcs
    "${PROJECT_SOURCE_DIR}/tensorflow/core/ops/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/ops/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/ops/*main.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/user_ops/*test*.h"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/user_ops/*test*.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/user_ops/*main.cc"
    "${PROJECT_SOURCE_DIR}/tensorflow/core/user_ops/*.cu.cc"
)

list(REMOVE_ITEM tf_core_ops_srcs ${tf_core_ops_exclude_srcs})

add_library(tf_core_ops OBJECT
    ${tf_core_ops_srcs}
)
add_dependencies(tf_core_ops
    tf_core_cpu
)

########################################################
# tf_debug_ops library
########################################################

#file(GLOB tf_debug_ops_srcs
#    "${PROJECT_SOURCE_DIR}/tensorflow/core/ops/debug_ops.cc"
#)
#
#add_library(tf_debug_ops OBJECT ${tf_debug_ops_srcs})
#
#add_dependencies(tf_debug_ops tf_core_framework)
