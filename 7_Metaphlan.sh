#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 16
#SBATCH --mem-per-cpu 16G
#SBATCH -t 500:00:00


# This script will run  MetaPhlAn3,  a tool for profiling the composition of microbial communities from metagenomic shotgun sequencing data.

# Navigate to folder containing fastq files
cd /home/AD/ehillman/Project_371/test_Merged_371_sample_files/test14/


#Load modules 
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate M3


# Run MetaPhlan3

for Reads in *.fastq.gz
do
	metaphlan $Reads --nproc 16 --input_type fastq --no_map --unknown_estimation -o profiled_metagenome.txt
done


#The script merge_metaphlan_tables.py allows to combine MetaPhlAn output from several samples to be merged into one table Bugs (rows) vs Samples (columns) with the table enlisting the relative normalized abundances per sample per bug.
merge_metaphlan_tables.py metaphlan_output*.txt > output/merged_abundance_table.txt


echo "All done, finished Metaphlan3"


#Things to think about. -need to normalise using rnorn -have an outbowtie table so we can run other tests on it 
