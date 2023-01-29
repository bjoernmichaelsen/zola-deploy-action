#!/bin/sh
set -e

echo "Starting build..."

echo "Fetching themes"
git config --global url."https://".insteadOf git://
git config --global url."https://github.com/".insteadOf git@github.com:
git config --global --add safe.directory "*"
git submodule update --init --recursive

version=$(zola --version)
echo "Using ${version}"

zola build

echo "Build complete."
