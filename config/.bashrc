# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

### bindings ###

bind -x '"\C-l":~/.config/fzf/dispatcher.py $(fzf --layout=reverse)'
bind -x '"\C-k":clear'

### environment variables ###

export EDITOR=nvim
export BAT_THEME="Nord"

### bash prompt ###

branch() {

    git_branch=$(git branch 2>/dev/null)

    if [ $? -eq 0 ]; then
        echo -ne " "
        echo "$git_branch" | grep '^*' | colrm 1 2
    fi
}

export PS1='[\u@\h \W$(branch)]\$ '

### bash history (hstr) ###

alias hh=hstr                                                     # hh to be alias for hstr
shopt -s histappend                                               # append new history items to .bash_history
export HISTCONTROL=ignorespace:ignoredups                         # leading space hides commands from history
export HISTFILESIZE=10000                                         # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}                                   # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}" # ensure synchronization between bash memory and history file

function hstrnotiocsti {
    { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    READLINE_POINT=${#READLINE_LINE}
}

if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n

### fzf - fuzzy finder ###

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:-1,bg:-1,hl:#81a1c1
    --color=fg+:-1,bg+:-1,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
