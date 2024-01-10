# Figuring out wether we're on my personal or professional Mac
PERSONAL_PATH=/Users/valentinlaurent
if [ -d "$PERSONAL_PATH" ]; then
PERSO=1
fi

ZSH=$HOME/.oh-my-zsh

# Load pyenv and virtualenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv virtualenv-init -)"
RPROMPT+='$(pyenv version-name)'

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# oh-my-zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Prevent the "Insecure completion-dependent directories detected:" error
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
export EDITOR=code

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# Command completion
## For gcloud
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi
## For Angular
source <(ng completion script)
# For Terraform & Terragrunt
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
complete -o nospace -C /opt/homebrew/bin/terragrunt terragrunt

# Adding a package I'm working on to the PYTHONPATH.
# TODO: Remove when done with it
if [ $PERSO ]; then
export PYTHONPATH="/Users/valentinlaurent/code/Valentin-Laurent/Perso/ProjectSpotify:$PYTHONPATH"
fi

# Defining directory abreviations using 'named directories'
if [ $PERSO ]; then
hash -d pers=~/code/Valentin-Laurent/Perso
hash -d cha=~/code/Valentin-Laurent/LeWagon/data-challenges
hash -d down=~/Downloads
else
hash -d pro=~/code/pro
hash -d pers=~/code/perso
hash -d down=~/Downloads
fi

# Use ipdb as the default debugging tool for Python breakpoint
export PYTHONBREAKPOINT=ipdb.set_trace

# Environnement variables needed for limbomp (LLVM OpenMP library)
# limbomp is a brew package that enable OpenMP support for the clang compiler shipped by default on macOS
# I need it to build sklearn from source (and thus to contribute)
# This may cause issues on my M1, so I'm not using it until I have to contribute to SKlearn with it
if [ $PERSO ]; then
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export CPPFLAGS="$CPPFLAGS -Xpreprocessor -fopenmp"
export CFLAGS="$CFLAGS -I/usr/local/opt/libomp/include"
export CXXFLAGS="$CXXFLAGS -I/usr/local/opt/libomp/include"
export LDFLAGS="$LDFLAGS -Wl,-rpath,/usr/local/opt/libomp/lib -L/usr/local/opt/libomp/lib -lomp"
fi

# QM Gitlab auth token
export GITLAB_AUTH_TOKEN=`cat ~pers/dotfiles/gitlab_auth_token_qm.txt`
