#!/bin/bash

program_list="commitizen cz-conventional-changelog typescript yarn corepack neovim dependency-cruiser ts-node localtunnel serve npm-gui prettier eslint prettier-eslint jsonlint"

echo "        -----";
echo "Installing globally: \"$program_list\" ";
echo "        -----"

npm install --global $program_list
