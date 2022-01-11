#target=145.40.69.165
#onnx_model=/tmp/mnist-8.onnx_perf/mnist-8.onnx

onnx_model=$1
target=$2

model_basename=$(basename $onnx_model)

OUTDIR=/home/perfscape-01/data/$model_basename/$target
mkdir -p $OUTDIR

ssh root@$target 'apt install -y linux-tools-common linux-tools-generic'
scp $onnx_model.so $onnx_model.bin root@$target:~/
echo $model_basename

ssh root@$target 'lscpu' > $OUTDIR/lscpu.txt

ssh root@$target \
"LD_LIBRARY_PATH=. perf stat -e task-clock,cycles,instructions,cache-references,cache-misses,branches,branch-misses ./$model_basename.bin" \
> $OUTDIR/perf_output.txt 2>&1