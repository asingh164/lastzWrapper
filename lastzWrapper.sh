#!/bin/bash

die() { echo -e "$@" 1>&2 ; exit 1; }

help_message="
Wrapper for running lastz with gnu-parallel
!!!!! Requires tweaks to the lastz code !!!!!!

©Santiago Sánchez-Ramírez, University of Toronto

Make
Run example:
./lastzWrapper [ -h | -threads INT ] -sp1 FILE -sp2 FILE
Arguments:
[-h|-help]      Prints this help message
-sp1    STR     Fasta file with genome 1 (target)
-sp2    STR     Fasta file with genome 2 (query)
-threads INT    Number of threads to use. Default is to use all threads.

Prints simple MAF format to STDOUT
"

target=''
query=''
threads=''
args=($@)
if [[ "$*" == -h* || "$*" == '' ]]; then
    die "$help_message"
else
    for i in `seq 0 $#`; do
        if [[ "${args[$i]}" == '-sp1' ]]; then
            target=${args[$(( i+1 ))]}
        elif [[ "${args[$i]}" == '-sp2' ]]; then
            query=${args[$(( i+1 ))]}
        elif [[ "${args[$i]}" == '-threads' ]]; then
            threads=${args[$(( i+1 ))]}
        fi
    done
fi

# check arg variables
if [[ ${#target} == 0 ]]; then
    die "No target file specified (-sp1)"
fi
if [[ ${#query} == 0 ]]; then
     die "No target file specified (-sp2)"
fi

if [[ ${#threads} == 0 ]]; then
    threads=1
fi

export query target
awk '{ if ($0 ~ /^>/){ 
          if (length(seq) != 0){ 
	     print head"\n"seq
          }
          head=$0
          seq=""
          } else { 
             seq=seq$0
          }
     } END { 
     print head"\n"seq
     }' $target | parallel -j$threads --pipe -N2 "lastz - $query --format=maf-"





#heads=(`echo ">" | cat $1 /dev/stdin | grep -n ">" | sed 's/:.*//'`)
#numbseqs=${#heads[@]}
#lines=$(( numbseqs - 1 ))
#for i in `seq 0 $numbseqs`; do 
#    j=$(( i + 1 ))
#    start=${heads[$i]}
#    end=$(( heads[$j] - 1 ))
#    echo $start $end
#done | head -$lines | parallel -j $4 --colsep=" " "sed -n '{1},{2}p' $1 | lastz /dev/stdin $2 $3 | lav2maf /dev/stdin $1 $2"

