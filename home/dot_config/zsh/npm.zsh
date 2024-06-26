# add .npm-global/bin to path
[[ ! -d "$HOME/.npm-global" ]] && mkdir -p $HOME/.npm-global
export PATH=$HOME/.npm-global/bin/:$PATH

export NPM_PACKAGES=$HOME/.npm

# only load when available
if [[ -d /usr/share/nvm && -f /usr/share/nvm/init-nvm.sh ]]; then
  # init nvm
  source /usr/share/nvm/init-nvm.sh

  autoload -U add-zsh-hook
  load-nvmrc() {
    if [[ -f .nvmrc && -r .nvmrc ]]; then
      nvm use --silence
    elif [[ $(nvm version) != $(nvm version default)  ]]; then
      # echo "Reverting to nvm default version"
      nvm use default --silence
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi
