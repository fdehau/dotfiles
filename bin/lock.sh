#!/bin/bash

set -e

scrot -q 10 /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
$1 -f -i /tmp/screen.png
rm /tmp/screen.png
