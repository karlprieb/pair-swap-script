#!/bin/bash

# get lists
while getopts a:f: option 
do 
 case "${option}" 
 in 
 a) ANCHOR=${OPTARG};; 
 f) FLOAT=${OPTARG};; 
 esac 
done 

# create arrays
IFS=","
anchor=($ANCHOR)
float=($FLOAT)
unset IFS

# shuffle arrays
anchor=( $(shuf -e "${anchor[@]}") )
float=( $(shuf -e "${float[@]}") )

# array count
anchorCount=${#anchor[@]}
floatCount=${#float[@]}

if [ $anchorCount -eq $floatCount ]; then
  for index in ${!anchor[@]}; do
    echo "${anchor[$index]} | ${float[$index]}"
  done  
else
  if [ $anchorCount -gt $floatCount ]; then
    for index in ${!float[@]}; do
      echo "${anchor[$index]} | ${float[$index]}"
    done

    leftCount=$(($anchorCount - $floatCount))
    leftList=(${anchor[@]:$floatCount:$leftCount})
    for((i=0; i < ${#leftList[@]}; i+=2)); do
      part=( "${leftList[@]:i:2}" )
      echo "${part[0]} | ${part[1]}"
    done
  else
    for index in ${!anchor[@]}; do
      echo "${anchor[$index]} | ${float[$index]}"
    done

    leftCount=$(($floatCount - $anchorCount))
    leftList=(${float[@]:$anchorCount:$leftCount})
    for((i=0; i < ${#leftList[@]}; i+=2)); do
      part=( "${leftList[@]:i:2}" )
      echo "${part[0]} | ${part[1]}"
    done
  fi

  for index in ${!mainList[@]}; do
    echo "${mainList[$index]} | ${leftList[$index]}"
  done  
fi

