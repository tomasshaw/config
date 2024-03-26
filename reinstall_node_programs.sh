#!/bin/bash

program_list="commitizen cz-conventional-changelog typescript yarn corepack neovim dependency-cruiser ts-node localtunnel serve npm-gui prettier eslint prettier-eslint jsonlint typescript-language-server vscode-langservers-extracted"

echo "-----    Installing globally    -----";
echo -e "$program_list" | tr ' ' '\n'
echo "-------------------------------------"

npm install --global $program_list
