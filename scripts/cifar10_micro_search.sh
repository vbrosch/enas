#!/bin/bash

export PYTHONPATH="$(pwd)"

OUTPUT_DIR=$1
DATA_DIR=$2

if [ -d $DATA_DIR ]
then
    echo "Directory $DATA_DIR exists, we assume that CIFAR-10 is available."
else
    echo "Error: Directory $DATA_DIR does not exist. Downloading cifar10 now."

    mkdir -p $DATA_DIR

    wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz -O $DATA_DIR
    tar xvf $DATA_DIR/cifar-10-python.tar.gz --directory $DATA_DIR
    mv $DATA_DIR/cifar-10-batches-py $DATA_DIR/cifar10

fi

if [ -d $OUTPUT_DIR ]
then
    echo "Directory $OUTPUT_DIR exists."
else
    echo "Error: Directory $OUTPUT_DIR does not exist. Creating it now."

    mkdir -p $OUTPUT_DIR
fi

python2 src/cifar10/main.py \
  --data_format="NCHW" \
  --search_for="micro" \
  --reset_output_dir \
  --data_path="$DATA_DIR/cifar10" \
  --output_dir="$OUTPUT_DIR" \
  --batch_size=160 \
  --num_epochs=150 \
  --log_every=50 \
  --eval_every_epochs=1 \
  --child_use_aux_heads \
  --child_num_layers=6 \
  --child_out_filters=20 \
  --child_l2_reg=1e-4 \
  --child_num_branches=5 \
  --child_num_cells=5 \
  --child_keep_prob=0.90 \
  --child_drop_path_keep_prob=0.60 \
  --child_lr_cosine \
  --child_lr_max=0.05 \
  --child_lr_min=0.0005 \
  --child_lr_T_0=10 \
  --child_lr_T_mul=2 \
  --controller_training \
  --controller_search_whole_channels \
  --controller_entropy_weight=0.0001 \
  --controller_train_every=1 \
  --controller_sync_replicas \
  --controller_num_aggregate=10 \
  --controller_train_steps=30 \
  --controller_lr=0.0035 \
  --controller_tanh_constant=1.10 \
  --controller_op_tanh_reduce=2.5 \
  "$@"

