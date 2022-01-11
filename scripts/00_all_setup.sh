for target in $(cat hosts.txt)
do
    echo Setting up $target
    ssh root@$target 'apt update'
    ssh root@$target 'apt install -y linux-tools-`uname -r`'
    ssh root@$target 'echo 0 > sudo tee /proc/sys/kernel/nmi_watchdog'
    echo Done setting up $target
done
exit
