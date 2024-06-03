if status is-interactive
    # To add a key, set -Ua SSH_KEYS_TO_AUTOLOAD keypath
    # To remove a key, set -U --erase 
    if set -q SSH_KEYS_TO_AUTOLOAD
        for i in (seq (count $SSH_KEYS_TO_AUTOLOAD))
            keychain -q --eval $SSH_KEYS_TO_AUTOLOAD[$i] | source
        end
    end
end
