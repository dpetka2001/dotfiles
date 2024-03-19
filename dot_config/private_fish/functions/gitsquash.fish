function gitsquash
    set -l COMMIT_HASH (git merge-base main HEAD)
    echo "Rebasing from: $COMMIT_HASH"
    git rebase -i "$COMMIT_HASH"
end
