function __nvims_get_configs
    set prompt $argv[1]
    test -z "$prompt"; and set prompt " Neovim Config  "

    set items LazyVimDev
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

    set config (printf "%s\n" $items | fzf --prompt="$prompt" --height=~50% --layout=reverse --border --exit-0)
    set fzf_status $status

    if test $fzf_status -ne 0
        commandline -f clear-screen # see `help bind` for special input functions
        return $fzf_status
    end

    echo $config
end

function nvims
    set config (__nvims_get_configs " Neovim Config  "); or return 0
    NVIM_APPNAME="$config" nvim $argv
    commandline -f repaint
end

function nvims_source
    set config (__nvims_get_configs " Neovim Config (source build)"); or return 0
    NVIM_APPNAME="$config" ~/neovim/bin/nvim $argv
    commandline -f repaint
end
