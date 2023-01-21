#!/bin/sh
set -e

#if test -n "${TOKEN}"; then
#    GITHUB_TOKEN=${TOKEN}
#fi
#
#if test -z "${GITHUB_TOKEN}"; then
#    echo "Set the GITHUB_TOKEN env variable."
#    exit 1
#fi
#
#if test -z "${GITHUB_REPOSITORY}"; then
#    echo "Set the GITHUB_REPOSITORY env variable."
#    exit 1
#fi

echo "Starting build..."

echo "Fetching themes"
git config --global url."https://".insteadOf git://
git config --global url."https://github.com/".insteadOf git@github.com:
git submodule update --init --recursive

version=$(zola --version)
echo "Using ${version}"

zola build

#tar czf github-pages -C public
echo "Build complete."
