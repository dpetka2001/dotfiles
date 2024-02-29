function printpath
    for i in (seq (count $fish_user_paths))
        echo $i $fish_user_paths[$i]
    end
end

function removepath
    echo "PATH before removal:"
    printpath
    echo -e "\r"
    if set -l index (contains -i $argv[1] $fish_user_paths)
        set --erase --universal fish_user_paths[$index]
        echo "Updated PATH:"
        printpath
    else
        echo "$argv[1] not found in PATH:"
        printpath
    end
end
