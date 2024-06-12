#!/bin/bash

export SE_MANAGER_PATH=/usr/bin/selenium-manager
python -m venv venv
source venv/bin/activate
pip install -r ./requirements.txt
python ./main.py >> ./run.log

