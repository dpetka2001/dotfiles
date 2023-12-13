function rm_nvim
    rm -rf ~/.local/share/$argv
    rm -rf ~/.local/state/$argv
    rm -rf ~/.cache/$argv
    rm -rf ~/.config/$argv
end
