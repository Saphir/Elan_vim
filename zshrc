# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/Elan_vim/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
	echo "Installing antigen ..."
	[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
	[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
	# [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
	URL="http://git.io/antigen"
	TMPFILE="/tmp/antigen.zsh"
	if [ -x "$(which curl)" ]; then
		curl -L "$URL" -o "$TMPFILE"
	elif [ -x "$(which wget)" ]; then
		wget "$URL" -O "$TMPFILE"
	else
		echo "ERROR: please install curl or wget before installation !!"
		exit
	fi
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "ERROR: downloading antigen.zsh ($URL) failed !!"
		exit
	fi;
	echo "move $TMPFILE to $ANTIGEN"
	mv "$TMPFILE" "$ANTIGEN"
fi

# Initialize antigen
source "$ANTIGEN"

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"

ZSH_AUTOSUGGEST_USE_ASYNC=1

antigen use oh-my-zsh

# https://github.com/unixorn/awesome-zsh-plugins
#antigen bundle Vifon/deer
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma/fast-syntax-highlighting

# Load bundles from the default repo (oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle docker

# Select theme.
#antigen theme denysdovhan/spaceship-prompt
antigen theme romkatv/powerlevel10k

antigen apply

# Bind keys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

############################################################### Elan
test -s ~/.alias && . ~/.alias || true

[[ -e ~/.zshrc.local ]] && source ~/.zshrc.local

real_zshrc=$(readlink -m ~/.zshrc)
[[ -e ${real_zshrc%/*}/zshrc.function ]] && source ${real_zshrc%/*}/zshrc.function
[[ -e ${real_zshrc%/*}/zshrc.expand ]] && source ${real_zshrc%/*}/zshrc.expand

[ ! -d ~/.fzf ] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

