
export MARK_PATH=~/.mark.config

if [ -d "$MARK_PATH" ]
then
    echo "Watney talking, it seems that we already have the configuration set up buddy, exiting..."
    exit
fi

echo "==Day:01== Okay folks, time to gather all that we need here..."

git clone git@github.com:joetde/mark.git $MARK_PATH

### Git config ###
echo "==Day:02== Here's Mark, ready to set git configuration"

printf "[include]\n\tpath = $MARK_PATH" > ~/.gitconfig

