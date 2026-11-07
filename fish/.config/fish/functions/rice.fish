function rice
    set -l live ~/.local/state/noctalia/settings.toml
    set -l saved ~/dotfiles/state/noctalia-settings.toml
    cd ~/dotfiles; or return
    if test (count $argv) -eq 0
        git branch
        return
    end
    set -l was_running 0
    if pgrep -x noctalia >/dev/null
        set was_running 1
        pkill -x noctalia
        while pgrep -x noctalia >/dev/null
            sleep 0.2
        end
        cp $live $saved
    end
    if test -n "$(git status --porcelain)"
        echo "Unsaved changes on "(git branch --show-current)". Run rice-save first."
        test $was_running -eq 1; and niri msg action spawn -- noctalia
        return 1
    end
    if not git switch $argv[1]
        test $was_running -eq 1; and niri msg action spawn -- noctalia
        return 1
    end
    cp $saved $live
    echo "Switched to $argv[1]. Log out (Super+Shift+E) and back in to finish."
end
