if status is-interactive
    if type -q "starship"
        starship init fish | source
    else
        echo "starship is not installed, run: brew install starship"
    end
end
