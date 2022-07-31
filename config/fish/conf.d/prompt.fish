if status is-interactive
    # disable greetings
    set fish_greeting

    fish_vi_key_bindings

    if type -q "starship"
        starship init fish | source
    else
        echo "starship is not installed, run: brew install starship"
    end
end
