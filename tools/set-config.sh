
export MARK_PATH=~/.mark.config
export MARK_DEPS=$MARK_PATH/deps
export MARK_REPO=$MARK_PATH/repo

if [ -d "$MARK_PATH" ]
then
    echo "Watney talking, we have a problem. It seems that we already have the configuration set up buddy, exiting..."
    exit
fi

mkdir $MARK_PATH
mkdir $MARK_DEPS

### Get repo and deps ###
echo "==Day:01== Okay folks, time to gather all that we need here..."
git clone git@github.com:joetde/mark.git $MARK_REPO
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh $MARK_DEPS/git-prompt.sh

### Bash config ###
echo "==Day:02== Mark speaking, setting up our beloved bash config"
echo ". $MARK_REPO/config/.bashrc" > ~/.bashrc

### Git config ###
echo "==Day:03== Here's Mark, ready to set git configuration"
printf "[include]\n\tpath = $MARK_REPO/config/.gitconfig" > ~/.gitconfig

