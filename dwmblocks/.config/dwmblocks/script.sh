#!/usr/bin/env bash

rm blocks.h
make
sudo make install
kill -9 $(pgrep dwmblocks)
nohup ./dwmblocks > /dev/null 2>&1 < /dev/null &
