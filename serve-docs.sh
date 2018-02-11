#!/bin/sh
#
# Usage:
#
# ./serve-docs.sh [PORT_NUMBER]

set -e

SCRATCH=$(mktemp -d --tmpdir rules_haskell-docs.XXXX)
PORT=${1:-8000}

function finish {
    echo Deleting $SCRATCH ...
    rm -rf "$scratch"
}

trap finish EXIT

bazel build //haskell:docs
unzip -d $SCRATCH bazel-bin/haskell/docs-skydoc.zip
cd $SCRATCH
python -m SimpleHTTPServer $PORT
