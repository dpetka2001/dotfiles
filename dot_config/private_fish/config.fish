set -g fish_prompt_pwd_dir_length 2
set -gx EDITOR nvim
set -gx VISUAL nvim
# set -gx FZF_DEFAULT_COMMAND "rg --hidden --files"
set -gx FZF_DEFAULT_COMMAND "rg --files"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --bind='ctrl-r:reload(rg --hidden --files)' --header='"Press CTRL-R to reload\n\n"' --border -m \
--bind 'ctrl-v:execute(nvim {+})' --bind 'ctrl-d:reload(find . -type d)'"
set -gx FZF_CTRL_T_COMMAND "rg --files"
bind \cs 'fzf'

set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_NUMERIC en_US.UTF-8

set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
