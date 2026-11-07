function rice-save
    cp ~/.local/state/noctalia/settings.toml ~/dotfiles/state/noctalia-settings.toml
    cd ~/dotfiles; or return
    git add -A
    git commit -m "$argv"
    git push
end
