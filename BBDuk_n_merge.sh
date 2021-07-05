#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 16
#SBATCH --mem-per-cpu 32G
#SBATCH -t 72:00:00


# This script will clean the concatenate R1 and R2 files then merge on all sequencing files for ALL the sequencing project (inputdir) and output the final results into the outputdir.

# Set your input directory to the concatenated files containing ALL sequencing projects you wish to analyse. The output directory to name of the output directory you want, and adapters to where the adapters.fa file for BBDUK is. 


inputdir2=/home/AD/ehillman/Merged_371_sample_files
outputdir2=/home/AD/ehillman/Clean_merged_371
adapters=/home/AD/ehillman/adapters.fa

#mkdir -p $inputdir2
cd $inputdir2


echo "You are running QC on all sequencing files in $inputdir2. Outputs will be put into the folder $inputdir2"

echo "Quality control..."

# conda3 activate
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate bbtools
# source activate bbtools

# BBDuk will: 

for i in `ls -1 *_R1_001.fastq.gz | sed 's/_R1_001.fastq.gz//'`
do
bbduk.sh -Xmx128g in1=$i\_R1_001.fastq.gz in2=$i\_R2 out1=$i\_clean_R1_001.fastq.qz out2=$i\_clean_R2 ref=$adapters ktrim=r k=21 mink=8 hdist=2 tpe tbo qtrim=rl trimq=20 minlen=100

#rm $i
	
done

conda deactivate 


echo "Merging files"

for f in ${inputdir2}*_R1_001.fastq.gz

do
prefix1=${f/R1_001.fastq.gz/}
cat $f ${prefix1}R2_001.fastq.gz > $outputdir1/${prefix1##*fastq/}combined.fastq.gz
done

rm *Undetermined*

echo "All done"

