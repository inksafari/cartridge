#!/usr/bin/env bash

#Date,Words
#2011-11-11,123
echo "$(date +%F),$(texcount main.tex -inc -ch-only | awk '/total/ {getline; print $4}')" >> data/words.csv

