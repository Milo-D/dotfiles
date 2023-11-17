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

export EDITOR=nvim
export BAT_THEME="Nord"

### bash prompt ###

branch() {

    git_branch=$(git branch 2>/dev/null)

    if [ $? -eq 0 ]; then
        branch=$(echo "$git_branch" | grep '^*' | colrm 1 2)
        echo " $branch"
    fi
}

export PS1='[\u@\h \W$(branch)]\$ '
