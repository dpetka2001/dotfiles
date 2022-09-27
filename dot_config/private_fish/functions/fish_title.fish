function fish_title
    # Looks like ~/d/fish: git log
    # or /e/apt: fish
    echo $argv[1] (fish_prompt_pwd_dir_length=2 prompt_pwd)
end
