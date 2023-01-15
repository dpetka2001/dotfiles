function fish_title
    set -q argv[1]; or set argv fish
    # Looks like ~/d/fish: git log
    # or /e/apt: fish
    # echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
    echo $argv;
end
