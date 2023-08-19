set -g fish_prompt_pwd_dir_length 2
set -gx EDITOR nvim
set -gx VISUAL nvim

#################
# Configure fzf #
#################
set -gx FZF_DEFAULT_COMMAND "rg --files"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --bind='ctrl-r:reload(rg --hidden --files)' --header='"Press CTRL-R to reload\n\n"' --border -m \
--bind 'ctrl-v:execute(nvim {+})' --bind 'ctrl-d:reload(find . -type d)'"
# set -gx FZF_CTRL_T_COMMAND "rg --files"
set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"

# Avoid loading ranger default config more than once
set -gx RANGER_LOAD_DEFAULT_RC FALSE

# Set locale
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_NUMERIC en_US.UTF-8

# Change MANPAGER
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -gx TZ ":Europe/Athens"

# Start ssh-agent when starting fish shell
fish_ssh_agent
