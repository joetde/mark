
export MARK_PATH=~/.mark.config
export MARK_DEPS=$MARK_PATH/deps
export MARK_REPO=$MARK_PATH/repo

mkdir $MARK_DEPS

### Get repo and deps ###
echo "==Day:01== Okay folks, time to gather all that we need here..."
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O $MARK_DEPS/git-prompt.sh

### Bash config ###
echo "==Day:02== Mark speaking, setting up our beloved bash config"
echo ". $MARK_REPO/config/.bashrc" > ~/.bashrc

### Git config ###
echo "==Day:03== Here's Mark, ready to set git configuration"
printf "[include]\n\tpath = $MARK_REPO/config/.gitconfig" > ~/.gitconfig
