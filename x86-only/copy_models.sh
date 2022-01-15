target=$1

rsync -azh --progress ../workdir/zoo/*.bin ../workdir/zoo/*.so root@$target:~/

