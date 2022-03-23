#!/bin/zsh
uptime | rev | cut -d":" -f1 | rev
