# reatach to existing session by default
alias tmux="tmux -2 attach"

# reboot and poweroff
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"

# use nvim instead of vim if available
if [[ "$(command -v vim)" || "$(command -v nvim)" ]]; then
    vim() {
        if [[ "$(command -v nvim)" ]]; then
            command nvim "$@"
        else
            command vim "$@"
        fi
    }
fi

# enable ls colors
alias ls="ls --color=auto"
alias ll="ls -lah"

# enable color grep
alias grep="grep --color=auto"

# enable colordiff
# alias diff=colordiff

# http serve this directory
alias serve="python3 -m http.server"

# date formater
alias DATE='date +"%Y-%m-%d"'
alias NOW='date +"%Y-%m-%d-%H%M%S"'

# productivity
alias productivity="sleep 25m && watch -n 15 'notify-send \"Title\" \"Lets do sth different\"'"

if [ "$(command -v exa)" ]; then
    unalias -m 'll'
    unalias -m 'l'
    unalias -m 'la'
    unalias -m 'ls'
    alias ls='exa --color auto --icons -a -s type -h --time-style long-iso'
    alias ll='exa -l --color always --icons -a -s type -h'
fi

# use ydiff with chezmoi diff
if [ "$(command -v chezmoi)" ]; then
    chezmoi() {
        if [ "$(command -v vault)" ]; then
            command "$(command -v vault)" token lookup -format=json > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                command "$(command -v vault)" login -method=oidc role=gsuite > /dev/null 2>&1
            fi
        fi
        if [[ $@ == "diff" && "$(command -v ydiff)" ]]; then
            command "$(command -v chezmoi)" diff | "$(command -v ydiff)" -s -w0 --wrap
        else
            command "$(command -v chezmoi)" "$@"
        fi
    }
fi

# test if a GITHUB_TOKEN env variable contain a valid gh-token
test-token() {
    if [[ -z $GITHUB_TOKEN ]]; then
        echo "❌ GITHUB_TOKEN is not set" && return 1
    fi
    if [ $(curl -s -o /dev/null -I -H "Authorization: token $GITHUB_TOKEN" -w "%{http_code}" https://api.github.com/user/issues | grep "200") ]; then
        echo "✅ GITHUB_TOKEN is valid" && return 0
    else
        echo "❌ GITHUB_TOKEN is not valid" && return 1
    fi
}

[[ -f $(command -v git) ]] && source $ZDOTDIR/alias/git.zsh
