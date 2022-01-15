target=$1


for onnx_model in ../workdir/zoo/*.onnx;
do
    echo Running $onnx_model on $target
    ./run_remotely.sh $onnx_model $target
done

