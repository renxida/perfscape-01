onnx_model=$1

TOP_DIR=$HOME/proxyvm_dependencies
echo Setting up environment using $TOP_DIR
# MLIR
LLVM_PROJ_SRC=$TOP_DIR/llvm-project

MLIR_DIR=$LLVM_PROJ_SRC/build/lib/cmake/mlir

LLVM_PROJ_BUILD=$LLVM_PROJ_SRC/build
PATH=$PATH:$LLVM_PROJ_BUILD/bin

# ONNX-MLIR

ONNX_MLIR_SRC=$TOP_DIR/onnx-mlir
ONNX_MLIR_UTIL=$ONNX_MLIR_SRC/utils
ONNX_MLIR_BIN=$ONNX_MLIR_SRC/build/Debug/bin
PATH=$PATH:$ONNX_MLIR_BIN
DRIVERNAME=RunONNXLib.cpp
# intel SDE
PATH=$PATH:$TOP_DIR/intel/sde

echo Done setting up environment.

onnx-mlir -o $onnx_model --EmitLib -O3 $onnx_model


ls $onnx_model.so
# compile .so into runner
g++ $ONNX_MLIR_UTIL/$DRIVERNAME -o $onnx_model.bin -std=c++14 \
-D LOAD_MODEL_STATICALLY=1 -I $LLVM_PROJ_SRC/llvm/include \
-I $LLVM_PROJ_BUILD/include -I $ONNX_MLIR_SRC/include \
-L $LLVM_PROJ_BUILD/lib -lLLVMSupport -lLLVMDemangle -lcurses -lpthread -ldl $onnx_model.so
