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
abbr -a gpu git pull
abbr -a gsq gitsquash

#     ╭────────────────────────────────────────────────────────────────────╮
#     │                            Other extras                            │
#     ╰────────────────────────────────────────────────────────────────────╯
abbr -a nv nvim
abbr -a cl chezmoi git -- log --color --graph --date=format:\'\%Y-\%m-\%d \%H:\%M:\%S\' --pretty=format:\'\%Cred\%h\%Creset -\%C\(yellow\)\%d\%Creset \%s \%Cgreen\(\%ad\) \%C\(bold blue\)\<\%an\>\%Creset\'
abbr -a nv_build make CMAKE_BUILD_TYPE=RelWithDebInfo
abbr -a nv_install "cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb"
abbr -a kitty_install "curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin"
abbr -a tn "tmux new -s"
abbr -a tl "tmux ls"
abbr -a ta "tmux attach -t"
