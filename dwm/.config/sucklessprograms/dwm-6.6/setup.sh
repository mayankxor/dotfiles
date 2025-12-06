#!/usr/bin/env bash

sudo touch file
sudo cp ./config.def.h ./file
sudo cp ./config.h ./config.def.h
sudo cp ./file ./config.h
sudo rm ./file
sudo make clean install
