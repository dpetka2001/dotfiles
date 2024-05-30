function printpath
    echo "fish Path: "
    for i in (seq (count $fish_user_paths))
        echo $i $fish_user_paths[$i]
    end
end
