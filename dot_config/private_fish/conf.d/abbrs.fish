#     ╭────────────────────────────────────────────────────────────────────╮
#     │                            Git related                             │
#     ╰────────────────────────────────────────────────────────────────────╯
# abbr -a gc --set-cursor git commit -m \"%\"
abbr -a gc git commit
abbr -a gl "git log --color --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
abbr -a ga git add
abbr -a gch git checkout
abbr -a gr git reflog
abbr -a gsh git show
abbr -a gs git status
abbr -a gp git push
abbr -a gd git diff
abbr -a gsw git switch
abbr -a gb git branch
abbr -a gpo "git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)"
abbr -a gpd --set-cursor "git push origin  :%"
abbr -a gpu git pull
abbr -a gsq gitsquash
# WARN: 
#     ╭────────────────────────────────────────────────────────────────────╮
#     │ set environment variables that are used by files in `conf.d` in    │
#     │ files that are sourced before the files in question (i.e put       │
#     │ `forgit` variables here, so they are sourced before                │
#     │ `forgit.plugin.fish`                                               │
#     │ and not in `config.fish` because that is loaded last after all     │
#     │ files in `conf.d` are sourced)                                     │
#     ╰────────────────────────────────────────────────────────────────────╯
set -gx forgit_diff gdd

#     ╭────────────────────────────────────────────────────────────────────╮
#     │                             PiP stuff                              │
#     ╰────────────────────────────────────────────────────────────────────╯
abbr -a pipu "python3 -m pip list -o | cut -f1 -d' ' | tr \" \" \"\n\" | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 python3 -m pip install -U"
abbr -a pipl "python3 -m pip list -o"

#     ╭────────────────────────────────────────────────────────────────────╮
#     │                            Other extras                            │
#     ╰────────────────────────────────────────────────────────────────────╯
abbr -a nv nvim
abbr -a cl chezmoi git -- log --color --graph --date=format:\'\%Y-\%m-\%d \%H:\%M:\%S\' --pretty=format:\'\%Cred\%h\%Creset -\%C\(yellow\)\%d\%Creset \%s \%Cgreen\(\%ad\) \%C\(bold blue\)\<\%an\>\%Creset\'
abbr -a cs chezmoi git status
abbr -a nv_build make CMAKE_BUILD_TYPE=RelWithDebInfo
abbr -a nv_install "cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb"
abbr -a kitty_install "curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin"

#     ╭────────────────────────────────────────────────────────────────────╮
#     │                            Tmux related                            │
#     ╰────────────────────────────────────────────────────────────────────╯
abbr -a tn "tmux new -s"
abbr -a tl "tmux ls"
abbr -a ta "tmux attach -t"
