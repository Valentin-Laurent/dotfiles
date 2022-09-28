# If we're on my professional Mac (M1), putting brew in path
PRO_PATH=/Users/vlaurent
if [ -d "$PRO_PATH" ]
then
eval "$(/opt/homebrew/bin/brew shellenv)"
fi
