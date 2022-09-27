# Initialize pyenv
type -a pyenv > /dev/null && eval "$(pyenv init --path)"

# Figuring out wether we're on my personal or professional Mac, and then utting brew in path
PRO_PATH=/Users/vlaurent
if [ -d "$PRO_PATH" ]
then eval "$(/opt/homebrew/bin/brew shellenv)"
