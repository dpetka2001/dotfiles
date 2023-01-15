function fish_user_key_bindings
  fzf_key_bindings
  #fish_default_key_bindings -M insert
  #fish_vi_key_bindings --no-erase insert
  bind \ck 'history-token-search-backward'
  bind \cj 'history-token-search-forward'
end
