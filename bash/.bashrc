[ -f /etc/bashrc ] && source /etc/bashrc

# fetch on new terminals (not inside nix-shell)
[ -z "$IN_NIX_SHELL" ] && command -v fetch >/dev/null && fetch --static
