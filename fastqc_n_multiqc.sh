#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 16
#SBATCH --mem-per-cpu 16G
#SBATCH -t 48:00:00


inputdir=/home/AD/ehillman/Project_371/Merged_371_sample_files/*fastq.gz
outputdir=/home/AD/ehillman/Project_371/FastQC_371_beforeQC
inputdir2=/home/AD/ehillman/Project_371/FastQC_371_beforeQC
outputdir2=home/AD/ehillman/Project_371/MultiQC_371_beforeQC


#inputdir=/home/AD/ehillman/201013_6_samples/*fastq.gz
#outputdir=/home/AD/ehillman/201013_6_samples/test
#inputdir2=/home/AD/ehillman/201013_6_samples/test
#outputdir2=/home/AD/ehillman/201013_6_samples/test2

# FastQC
echo "About to start running FastQC"
mkdir $outputdir
/home/AD/ehillman/FastQC/fastqc $inputdir -o $outputdir --threads 16



# MultiQC
echo "About to start running MultiQC"
mkdir $outputdir2

#Load modules
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate Multiqc

multiqc $inputdir2 -o $outputdir2

conda deactivate 


echo "All done!"
