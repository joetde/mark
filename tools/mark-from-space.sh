export MARK_PATH=~/.mark.config
export MARK_REPO=$MARK_PATH/repo

if [ -d "$MARK_PATH" ]
then
    echo "Watney talking, we have a problem. It seems that we already have the configuration set up buddy, exiting..."
    exit
fi

mkdir $MARK_PATH
git clone git@github.com:joetde/mark.git $MARK_REPO
