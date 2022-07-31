function is_dark_mode -d "return whether the dark mode is activated on MacOS"
    set -l uname "$(uname)"
    if test "$uname" = "Darwin"
        set -l apple_inteface_style "$(defaults read -g AppleInterfaceStyle 2>&1 | string trim)"
        if test "$apple_inteface_style" != "Dark"
            return 1
        end
    end
    return 0
end
