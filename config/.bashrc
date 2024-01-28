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

bind -x '"\C-l":~/.config/fzf/dispatcher.py $(fzf)'
bind -x '"\202":~/.config/fzf/wd_ops.py cwd_save && cd $(find . -type d -print 2> /dev/null | fzf)'
bind    '"\C-g":"\202\C-m"'
bind -x '"\201":cd $(~/.config/fzf/wd_ops.py cwd_load $(echo $$))'
bind    '"\C-h":"\201\C-m"'
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

### fzf - fuzzy finder ###

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:-1,bg:-1,hl:#81a1c1
    --color=fg+:reverse:-1,bg+:-1,hl+:reverse:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
    --layout=reverse
    --border=bottom'
