#!/bin/bash
#SBATCH -N 1
#SBATCH -t 24:00:00
#SBATCH -p normal

python 00_analyzing_bash.py 101 150


