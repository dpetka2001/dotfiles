function ll --wraps='eza -lah' --description 'alias ll eza -lah'
    eza -lah --group-directories-first --color=always --icons $argv
end
