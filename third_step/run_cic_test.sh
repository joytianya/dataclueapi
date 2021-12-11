PWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

SECOND_STEP_DIR=$PWD/../second_step
export PREV_TRAIN_MODEL_DIR=$SECOND_STEP_DIR/prev_train_models
export BERT_BASE_DIR=$PREV_TRAIN_MODEL_DIR/chinese_L-12_H-768_A-12

TASK_NAME="cic"
export DATA_DIR=$PWD/data/$TASK_NAME
export MODEL_OUTPUT=$SECOND_STEP_DIR/model_output/$TASK_NAME
if [ ! -d $MODEL_OUTPUT ];then
  mkdir -p $MODEL_OUTPUT
fi

python $SECOND_STEP_DIR/bert/run_classifier.py \
  --task_name=$TASK_NAME \
  --do_train=false \
  --do_eval=false \
  --do_predict=true \
  --data_dir=$DATA_DIR \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=64 \
  --train_batch_size=64 \
  --learning_rate=2e-5 \
  --num_train_epochs=5.0 \
  --output_dir=$MODEL_OUTPUT
