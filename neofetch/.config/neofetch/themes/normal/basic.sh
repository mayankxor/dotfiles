#!/bin/env bash
names=( 'acenoster.conf' 'bejkon/config.conf' 'bejkon2/config.conf' 'boxes.conf' 'config2.conf' 'config.conf' 'eldfetch.conf' 'hybridfetch.conf' 'idlifetch.conf' 'kenielf/config.conf' 'onrefetch.conf' 'ozozfetch.conf' 'ozozPredatorFetch.conf' 'papirus.conf' 'penguinfetch/config.conf' 'remfetch/config.conf' 'rootankush/config.conf' 'talljoe.conf' 'troutfetch.conf' 'tuxNature/config.conf' )
for item in "${names[@]}";
do
	neofetch --config "${item}"
done

