function ll --wraps='exa -lag' --description 'alias ll exa -lag'
    exa -lag --group-directories-first --color=always $argv
end
