function nvims
    set items nvim lazyTest LazyVimDev
    set config (printf "%s\n" $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if test -z $config
        echo "Nothing selected"
        return 0
    end
    NVIM_APPNAME="$config" nvim -- $argv
end
