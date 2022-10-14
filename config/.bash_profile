# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
