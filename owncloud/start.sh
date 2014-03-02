#!/bin/bash

# Don't continue if we catch an error.
set -e

./deploy.sh

./run.sh
