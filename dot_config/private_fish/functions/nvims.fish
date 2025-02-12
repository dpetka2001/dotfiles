function nvims
    set items nvim LazyVimDev
    for item in (ls -d ~/.config/test_configs/*/)
        set -a items $(string match -rg '.*/(.*/.*)/$' $item)
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
