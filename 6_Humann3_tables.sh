#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 16
#SBATCH --mem-per-cpu 8G
#SBATCH -t 168:00:00


# Script for functional profiling of paired-end reads using HUMANn3


# notes:
#       - script outputs: stratified and unstratifed pathways and gene family files in CPM


# Navigate to folder containing fastq files
cd /home/AD/ehillman/Project_371/2_Merged_371_sample_files/test14/mergedR1nR2/
#cd /Data/Users/ehillman/Project_371/hmn3_out/



# Load modules
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate Humann3

# If you already have the MetaPhlAn database downloaded and built, you can execute HUMAnN using metaphlan_options set with --index mpa_v30_CHOCOPhlAn_201901 and this will skip the check for a new version.



#Join all gene family and pathway abudance files
humann_join_tables --input hmn3_output --output humann_pathabundance.tsv --file_name pathabundance
humann_join_tables --input hmn3_output --output humann_genefamilies.tsv --file_name genefamilies


#Normalising RPKs to CPM
humann_renorm_table --input humann_pathabundance.tsv --units cpm --output humann_pathabundance_cpm.tsv
humann_renorm_table --input humann_genefamilies.tsv --units cpm --output humann_genefamilies_cpm.tsv


#Generate stratified tables
humann_split_stratified_table --input humann_pathabundance_cpm.tsv --output ./
humann_split_stratified_table --input humann_genefamilies_cpm.tsv --output ./


#Cleaning up file structure
mkdir hmn3_pathway_abundance_files
mkdir hmn3_genefamily_abundance_files

mv *pathabundance* hmn3_pathway_abundance_files/.
mv *genefamilies* hmn3_genefamily_abundance_files/.

