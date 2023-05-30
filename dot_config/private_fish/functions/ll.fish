function ll --wraps='exa -lag' --description 'alias ll exa -lag'
    exa -la --group-directories-first --color=always --icons $argv
end
