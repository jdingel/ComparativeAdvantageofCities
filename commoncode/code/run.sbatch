#!/bin/sh

#SBATCH --partition=broadwl
#SBATCH --output=slurmlogs/%j.out
#SBATCH --error=slurmlogs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mail-type=END,FAIL

module load stata/15
stata-se -e $dofile
