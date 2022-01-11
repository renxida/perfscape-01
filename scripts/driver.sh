targets="145.40.69.165
147.28.128.247"

for onnx_model in ../workdir/zoo/*.onnx;
do
    echo Compiling $onnx_model
    ./compile.sh $onnx_model
    for target in $targets
    do
        echo Running $onnx_model on $target
        ./run_remotely.sh $onnx_model $target
    done
done