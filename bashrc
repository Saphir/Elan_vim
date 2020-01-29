
# ================ bashrc.Elan ===================
real_bashrc=$(readlink -m ~/.bashrc)
[[ -e $HOME/.bashrc.local ]] && source $HOME/.bashrc.local
[[ -e ${real_bashrc%/*}/bashrc.function ]] && source ${real_bashrc%/*}/bashrc.function
[[ -e ${real_bashrc%/*}/bashrc.expand ]] && source ${real_bashrc%/*}/bashrc.expand

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
