#!/bin/bash
uptime | rev | cut -d":" -f1 | rev | sed -e 's/ //g' -e 's/,/ /g'
