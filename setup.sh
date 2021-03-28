#!/bin/bash

# setup script for Mac OS and Ubuntu Linux environments
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Ubuntu specific package installation options
    sudo apt-get -y update
    sudo apt-get -y dist-upgrade
    sudo apt-get -y install python3-pip nodejs npm
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OS specific package installation options (brew)
    brew install python3
    brew install nodejs
else
    echo "Unrecognized operating system; setup may fail."
fi

# operate in the project dir
cd "$(dirname "$0")"

# create a virtual environment and install python3 requirements
python3 -m venv env
source ./env/bin/activate
python3 -m pip install -r requirements.txt

# operate in the frontend dir
cd frontend
npm install
# uncomment to run build
# npm run build
# uncomment to run dev
# npm run dev

# swap back to the parent (project) dir
cd "$(dirname "$0")"
# ! uncomment the following line to run the Django server
# python manage.py runserver
