#!/bin/bash

declare -r SCRIPT_DIR=$(dirname $(readlink -m "${BASH_SOURCE[0]}"))
declare -r GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

function die()
{
    echo -e "\e[0;31m[ERROR]\e[m $1" >&2
    exit ${2:-255}
}

function cleanup() {
    trap - EXIT SIGHUP SIGINT SIGTERM
    local rc=$?
    # Do Cleaning
    echo -e "\n[CLEAN-UP]"
    exit $rc
}
trap cleanup EXIT SIGHUP SIGINT SIGTERM

################################################################
# Main Process
################################################################

