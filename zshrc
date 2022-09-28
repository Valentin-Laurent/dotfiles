# Figuring out wether we're on my personal or professional Mac
PERSONAL_PATH=/Users/valentinlaurent
if [ -d "$PERSONAL_PATH" ]
then
PERSO=1
fi

ZSH=$HOME/.oh-my-zsh

# Load pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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

# Virtual env stuff
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1
#type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
export EDITOR=code

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

# Adding a package I'm working on to the PYTHONPATH.
# TODO: Remove when done with it
export PYTHONPATH="/Users/valentinlaurent/code/Valentin-Laurent/Perso/ProjectSpotify:$PYTHONPATH"

# Defining directory abreviations using 'named directories'
if [ $PERSO ]
then
hash -d pers=/Users/valentinlaurent/code/Valentin-Laurent/Perso
hash -d cha=/Users/valentinlaurent/code/Valentin-Laurent/LeWagon/data-challenges
hash -d down=/Users/valentinlaurent/Downloads
else
hash -d pro=/Users/vlaurent/code/pro
hash -d pers=/Users/vlaurent/code/perso
hash -d down=/Users/vlaurent/Downloads
fi

# Use ipdb as the default debugging tool for Python breakpoint
export PYTHONBREAKPOINT=ipdb.set_trace

# Environnement variables needed for limbomp (LLVM OpenMP library)
# limbomp is a brew package that enable OpenMP support for the clang compiler shipped by default on macOS
# I need it to build sklearn from source (and thus to contribute)
if [ $PERSO ]
then
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export CPPFLAGS="$CPPFLAGS -Xpreprocessor -fopenmp"
export CFLAGS="$CFLAGS -I/usr/local/opt/libomp/include"
export CXXFLAGS="$CXXFLAGS -I/usr/local/opt/libomp/include"
export LDFLAGS="$LDFLAGS -Wl,-rpath,/usr/local/opt/libomp/lib -L/usr/local/opt/libomp/lib -lomp"
fi
