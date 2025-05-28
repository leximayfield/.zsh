# Path
export PATH="$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:$PATH"

# Force emacs keybinds, otherwise VISUAL=vim will sometimes force vi keybinds
bindkey -e

# Disable flow-control keys
stty stop undef
stty start undef

# Keybinds (because we can't trust terminfo)

# Home
bindkey "^[OH"    beginning-of-line
bindkey "^[[H"    beginning-of-line
bindkey "^[[1~"   beginning-of-line
# Alt + Left Arrow
bindkey "^[[1;3C" beginning-of-line
bindkey "^[^[[D"  beginning-of-line
# End
bindkey "^[OF"    end-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[4~"   end-of-line
# Alt + Right Arrow
bindkey "^[^[[C"  end-of-line
bindkey "^[[1;3D" end-of-line
# Delete
bindkey "^[[3~"   delete-char

# Colors
autoload -Uz colors && colors

# History
setopt glob_complete
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt inc_append_history
setopt share_history

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

# Completion
setopt extended_glob

zstyle ':completion:*' menu select
zstyle ':completion:*' use-ip true
zstyle ":completion:*:commands" rehash 1

autoload -Uz compinit && compinit

precmd() {
	TITLE="$USER@$HOST:${PWD/#$HOME/~}"
	echo -ne "\e]0;${TITLE}\a"
}

# Prompt
export PROMPT="%n@%m %F{green}%1~%f %# "

# Colors for ls
type dircolors > /dev/null
if [[ $? == 0 ]]; then
	# GNU Coreutils
	eval "$(dircolors -b)"
	alias ls="ls --color=auto --si"
else
	# Darwin/BSD
	type gdircolors > /dev/null
	if [[ $? == 0 ]]; then
		# GNU Coreutils in BSD
		eval "$(gdircolors -b)"
		alias ls="gls --color=auto --si"
	else
		# BSD
		alias ls="ls -Gh"
	fi
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

# Other aliases
alias sssh='ssh -o "UserKnownHostsFile /dev/null"'
alias sscp='scp -o "UserKnownHostsFile /dev/null"'

# Default less functionality
export LESS="FRSX"

# Default editor
export VISUAL="nvim"
