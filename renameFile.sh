#!/bin/bash
for f in *
do
  if [ -d "$f" ]
  then
    echo "Skipping $f"
    continue
  fi
  if [[ $f == *.sh ]]
  then
    echo "Not copying $f"
    continue
  fi
  if [[ $f == *.part ]]
  then
    echo "Not copying $f"
    continue
  fi
  echo $f
  name=$(echo $f | sed 's/\(.*\)\.S0\{0,1\}[0-9].*/\1/')
  name=$(echo $name | sed 's/\./ /g')
  episodeAndSeason=$(echo $f | sed 's/.*\(S0\{0,1\}[0-9]*E[0-9]*\).*/\1/')
  season=$(echo $episodeAndSeason | sed 's/S0\{0,1\}\([0-9]*\)E[0-9]*/\1/')
  episode=$(echo $episodeAndSeason | sed 's/S[0-9]*E\([0-9]*\)/\1/')
  format=$(echo $f| sed 's/.*\.\(.*\)/\1/')
#  echo "$name $episodeAndSeason $season $episode"
  episodeAndSeason="$season x $episode"
  episodeAndSeason=$(echo $episodeAndSeason | sed 's/ //g')
  path="$name/Season $season/$name $episodeAndSeason.$format"
  echo "Path is $path"
  if [[ ! -e $name ]]
  then
    echo "Creating $name"
    mkdir "$name"
  fi
  seasonPath="$name/Season $season"
  if [[ ! -e $seasonPath ]]
  then
    echo "Creating $seasonPath"
    mkdir "$name/Season $season"
  fi
  mv -f $f "$path"

done
