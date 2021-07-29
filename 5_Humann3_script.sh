#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 16
#SBATCH --mem-per-cpu 16G
#SBATCH -t 168:00:00


# Script for functional profiling of paired-end reads using HUMANn3



# Navigate to folder containing fastq files
#cd /home/AD/ehillman/Project_371/2_Merged_371_sample_files/test14/mergedR1nR2/
cd /Data/Users/ehillman/Project_371/MergedR1nR2/


# Load modules
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate Humann3

# If you already have the MetaPhlAn database downloaded and built, you can execute HUMAnN using metaphlan_options set with --index mpa_v30_CHOCOPhlAn_201901 and this will skip the check for a new version.

# Run HUMAnN3
for Reads in *.fastq.gz
do
  humann --input ${Reads} \
    --output hmn3_output \
    --metaphlan /home/AD/ehillman/.conda/envs/Humann3/ \
    --nucleotide-database /home/AD/ehillman/ref_databases/chocophlan \
    --protein-database /home/AD/ehillman/ref_databases/uniref \
    --threads 16
done


echo "All done"
