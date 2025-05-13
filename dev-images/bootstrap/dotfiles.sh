#/usr/bin/zsh

echo "DOT FILES DIR: $DOT_FILES_DIR"
function cloneRepo() {
    local repoName=$1
    local targetDir=$2
    # # Check if the directory already exists
    if [ ! -d "$targetDir" ]; then
      echo "cloning $repoName to $targetDir"
      git clone $repoName "$targetDir"
    else
      echo "Repository already exists at $targetDir"
    fi
}

cloneRepo "https://github.com/thomasbellio/mydotfiles.git" $DOT_FILES_DIR

cd $DOT_FILES_DIR && ./install.sh && cd -

