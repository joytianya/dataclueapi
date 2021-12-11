# dataclueapi

1）从未标注的数据中找到相似数据查找（预训练模型)
输入：一条特定的数据，未标注数据列表
输出：相似数据的列表 

```shell
cd first_step
sh run.sh
```

2）训练接口
输入：全量数据集
输出：一个模型
以cic任务为例
```shell
cd second_step/bert
sh run_cic.sh
```
输出在second_step/model_output/cic下面
3）预测接口
输入：一条数据，一个模型
输出：一条数据，带上标签
```shell
cd third_step
sh run_cic_test.sh
```
输出结果在third_step/data/cic/test_results_label.json
