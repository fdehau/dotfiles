if status is-interactive
    if type -q "zoxide"
        zoxide init fish | source
    else
        echo "zoxide is not installed, run: cargo install zoxide"
    end
end
