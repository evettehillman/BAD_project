#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 8
#SBATCH --mem-per-cpu 16G
#SBATCH -t 48:00:00

#navigate to folder containing files 
cd /Data/Users/ehillman/Project_371/MergedR1nR2/

mv `ls | head -49` /Data/Users/ehillman/Project_371/4_140_to_189/

echo "All done"
