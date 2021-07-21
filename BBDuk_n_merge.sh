#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 16
#SBATCH --mem-per-cpu 16G
#SBATCH -t 72:00:00


# This script will clean the concatenate R1 and R2 files then merge on all sequencing files for ALL the sequencing project (inputdir) and output the final results into the outputdir.

# Set your input directory to the concatenated files containing ALL sequencing projects you wish to analyse. The output directory to name of the output directory you want, and adapters to where the adapters.fa file for BBDUK is. 


inputdir=/home/AD/ehillman/Project_371/2_Merged_371_sample_files/
outputdir=/home/AD/ehillman/Project_371/Clean_merged_371
adapters=/home/AD/ehillman/adapters.fa

mkdir -p $outputdir
cd $inputdir


echo "You are running QC on all sequencing files in $inputdir. Outputs will be put into the folder $outputdir"

echo "Quality control..."

# conda3 activate
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate bbtools
# source activate bbtools

# BBDuk will: 

Ordered=t #Set to true to output reads in same order as input 
Ktrim=r #once a reference kmer is matched in a read, that kmer and all the bases to the right will be trimmed
K=21 #specifies the kmer size
Mink=8 #"mink" allows it to use shorter kmers at the ends of the read 
Hdist=2 #number of permitted missmatches
#Qtrim=r #quality-trim on right
#Trimq=30 #1 in 1000 or 99.9% 
Minlen=100 #throw away reads shorter than 100bp after trimming
Maq=30 #This will discard reads with average quality below 30

for Prefix in  `ls -1 *_R1.fastq.gz | sed 's/_R1.fastq.gz//'`
do

bbduk.sh -Xmx128g in1=$Prefix\_R1.fastq.gz in2=$Prefix\_R2.fastq.gz out1=$Prefix\_clean_R1.fastq.gz out2=$Prefix\_clean_R2.fastq.gz ref=$adapters ordered=$Ordered ktrim=$Ktrim k=$K mink=$Mink hdist=$Hdist tpe tbo minlen=$Minlen maq=$Maq
	
done



#echo "Merging files"

#for read1 in ${inputdir}*_R1.fastq.gz

#do
#prefix=${read1/R1.fastq.gz/}
#cat $read1 ${prefix}R2.fastq.gz > $outputdir/${prefix##*fastq/}clean_combined.fastq.gz
#done


echo "All done"

