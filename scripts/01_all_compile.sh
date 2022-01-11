for onnx_model in ../workdir/zoo/*.onnx;
do
    echo Compiling $onnx_model
    ./compile.sh $onnx_model
done
