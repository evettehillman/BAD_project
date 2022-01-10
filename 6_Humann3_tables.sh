#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 16
#SBATCH --mem-per-cpu 8G
#SBATCH -t 168:00:00


# Script for Manipulating HUMAnN3 output tables


# notes:
#       - this script groups reads into functional genes 


# Navigate to FOLDER containing FOLDER with HumanN3 output .tsv files
cd /Data/Users/ehillman/Project_371/HumanN3_tables/hmn3_genefamily_abundance_files/
#cd /Data/Users/ehillman/Project_371/HumanN3_tables/
#cd /home/AD/ehillman/Project_371/test_Merged_371_sample_files/test_HumanN_folders/
#cd /home/AD/ehillman/Project_371/2_Merged_371_sample_files/test14/mergedR1nR2/
#cd /Data/Users/ehillman/Project_371/hmn3_out/


# Load modules
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate Humann3


#Join all gene family and pathway abudance files
#humann_join_tables --input hmn3_output --output humann_pathabundance.tsv --file_name pathabundance
#humann_join_tables --input hmn3_output --output humann_genefamilies.tsv --file_name genefamilies


#Normalising RPKs to CPM
#humann_renorm_table --input humann_pathabundance.tsv --units cpm --output humann_pathabundance_cpm.tsv
#humann_renorm_table --input humann_genefamilies.tsv --units cpm --output humann_genefamilies_cpm.tsv


# Regroups genes to other functional categories 
#humann_regroup_table --input humann_pathabundance_cpm.tsv --output humann_pathabundance_cpm.regr.tsv --groups uniref90_ko
#humann_regroup_table --input humann_genefamilies_cpm.tsv --output humann_genefamilies_cpm.regr.tsv --groups uniref90_ko

# Translate Uniref names into meaningful names 
humann_rename_table --input humann_pathabundance_cpm.regr.tsv --output humann_pathabundance_cpm.regr.named.tsv --names kegg-orthology
humann_rename_table --input humann_genefamilies_cpm.regr.tsv --output humann_genefamilies_cpm.regr.named.tsv --names kegg-orthology


#Cleaning up file structure
#mkdir hmn3_pathway_abundance_files
#mkdir hmn3_genefamily_abundance_files

#mv *pathabundance* hmn3_pathway_abundance_files/.
#mv *genefamilies* hmn3_genefamily_abundance_files/.

