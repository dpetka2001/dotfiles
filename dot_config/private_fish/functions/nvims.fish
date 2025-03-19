function nvims
    set items nvim LazyVimDev
    # assign glob pattern to a variable so that no warnings are shown
    # see also `help wildcards-globbing` which mentions
    # INFO:
    # ╭────────────────────────────────────────────────────────────────────╮
    # │ There are exceptions, namely set and path, overriding variables in │
    # │ overrides, count and for. Their globs will instead expand to zero  │
    # │ arguments (so the command won’t see them at all)                   │
    # ╰────────────────────────────────────────────────────────────────────╯
    set glob ~/.config/test_configs/*/
    for item in (ls -d $glob 2>/dev/null | string match -rg '.*(test_configs/.*)/$')
        set -a items $item
    end
    set config (printf "%s\n" $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if test -z $config
        echo "Nothing selected"
        commandline -f clear-screen # see `help bind` for special input functions
        return 0
    end
    NVIM_APPNAME="$config" nvim $argv
    commandline -f repaint
end
