
# ================ bashrc.Elan ===================
real_bashrc=$(readlink -m ~/.bashrc)
[[ -e $HOME/.bashrc.local ]] && source $HOME/.bashrc.local
[[ -e ${real_bashrc%/*}/bashrc.function ]] && source ${real_bashrc%/*}/bashrc.function
[[ -e ${real_bashrc%/*}/bashrc.expand ]] && source ${real_bashrc%/*}/bashrc.expand

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t 0 || tmux new -s 0
fi

#PATH=$PATH:/home/elan/qx_work/cross_compiling/arm-rpi-4.9.3-linux-gnueabihf/bin
PATH=$PATH:/home/elan/qx_work/cross_compiling/gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf/bin
