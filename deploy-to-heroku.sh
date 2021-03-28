#!/bin/bash

# Check flag status
yes_flag=''
app_name=''

print_usage() {
  printf "Usage: -y to confirm deployment, -n to name the heroku app"
  printf "[e.g.] $ bash deploy-to-heroku.sh -y -n foo-bar"
  printf "would deploy the app to https://foo-bar.herokuapp.com/"
  printf "given that the app destination is not already occupied."
}

while getopts 'abf:v' flag; do
  case "${flag}" in
    y) yes_flag='true' ;;
    n) APP_NAME="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

# setup script for Mac OS and Ubuntu Linux environments
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Ubuntu specific package installation options
    sudo apt-get -y update
    sudo apt-get -y dist-upgrade
    sudo apt-get -y install snapd
    sudo snap install heroku --classic
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OS specific package installation options (brew)
    brew install heroku/brew/heroku
else
    echo "Unrecognized operating system; setup may fail."
    echo "The Heroku cli must be installed."
fi

# operate in the project dir
cd "$(dirname "$0")"

# Running this script in the git repository will deploy it
# to Heroku; don't do this until you're ready
heroku create $APP_NAME
git push heroku main
# Open the app in your browser
heroku ps:scale web=1
heroku open
