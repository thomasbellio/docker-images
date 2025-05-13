#!/bin/bash
set -e
chmod +x install-dev-dependencies.sh
chmod +x setup-user.sh
chmod +x install-docker.sh
source install-dev-dependencies.sh
source install-docker.sh
source setup-user.sh
