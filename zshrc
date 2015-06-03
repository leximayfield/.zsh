# Disable flow-control keys
stty stop undef
stty start undef

# Keybinds (because we can't trust terminfo)
bindkey "^[OH"  beginning-of-line
bindkey "^[[H"  beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OF"  end-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

# Colors
autoload -Uz colors && colors

# History
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt inc_append_history
setopt share_history

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

# Completion
export FPATH="/usr/local/share/zsh-completions:$FPATH"

zstyle ':completion:*' menu select
zstyle ':completion:*' use-ip true

autoload -Uz compinit && compinit

# Titlebar and tab title
HOSTNAME="$(hostname -s)"

precmd() {
	TITLE="$USER@$HOSTNAME:${PWD/#$HOME/~}"
	echo -ne "\e]0;${TITLE}\a"
}

# Prompt
export PROMPT="%n@%m %F{green}%1~%f %# "

# Colors for ls
type dircolors > /dev/null
if [[ $? == 0 ]]; then
	# GNU Coreutils
	eval "$(dircolors -b)"
	alias ls="ls --color=auto"
else
	# Darwin/BSD
	type gdirclors > /dev/null
	if [[ $? == 0 ]]; then
		# GNU Coreutils in BSD
		eval "$(gdircolors -b)"
		alias ls="gls --color=auto"
	fi
	# BSD
	export CLICOLOR="1"
fi

# GNU coreutils on BSD
type gfind > /dev/null
if [[ $? == 0 ]]; then
	alias find=gfind
fi
type ggrep > /dev/null
if [[ $? == 0 ]]; then
	alias grep=ggrep
fi

# Parallel gzip
type pigz > /dev/null
if [[ $? == 0 ]]; then
	alias gzip=pigz
fi

# Default less functionality
export LESS="FRSX"

# Path
export PATH="$HOME/.local/bin:$PATH"
