#!/usr/bin/env bash

set -e # Die on first error.

base_dir="$(dirname "$0")"

# Determine location of MARS.
if ! [ "$MARS" ]; then
    MARS="$base_dir/../bin/Mars4_5.jar"
    if [[ $(uname -o 2> /dev/null) = "Cygwin" ]]; then
        MARS="$(cygpath -w "$MARS")"
    fi
fi

# Verify that Java is installed.
java -version &> /dev/null || (echo "Could not find java" && exit 1)

java -jar "$MARS" nc "$@"


