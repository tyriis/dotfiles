#!/usr/bin/env zsh
# use ydiff in git diff
# check if zsh-forgit is installed in nix, this will throw an error if not on nix need another solution then
ZSH_FORGIT_INSTALLED="0"
result=$(nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | grep -c zsh-forgit)
if [ "$result" -gt 0 ]; then
  ZSH_FORGIT_INSTALLED="1"
fi
git() {
  if [[  $@ == "diff" && "$ZSH_FORGIT_INSTALLED" == "1" ]]; then
    command "$(command -v git)" forgit diff
  elif [[ $@ == "diff" && "$(command -v ydiff)" ]]; then
    command "$(command -v git)" diff | "$(command -v ydiff)" -s -w0 --wrap
  elif [[  $@ == "add" && "$ZSH_FORGIT_INSTALLED" == "1" ]]; then
    command "$(command -v git)" forgit add
  elif [[  $@ == "log" && "$ZSH_FORGIT_INSTALLED" == "1" ]]; then
    command "$(command -v git)" forgit log
  elif [[ $@ == "broom" ]]; then
    command "$(command -v git)" branch --merged | grep -E -v "(^\*|master|main|development)" | xargs "$(command -v git)" branch -d
  else
    command "$(command -v git)" "$@"
  fi
}
