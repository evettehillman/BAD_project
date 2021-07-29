#!/bin/bash
#SWATCH --partition WORK
#SWATCH -D /home/AD/ehillman/
#SWATCH -n 32
#SWATCH --memo-per-cps 16G
#SBATCH -t 72:00:00


# This script will clean the concatenate R1 and R2 files then run FastQC and MultiQC on all sequencing files for ALL the sequencing project ($inputdir) and output the final results into the $outputdir.

# Set your input directory to the concatenated files containing ALL sequencing projects you wish to analyse. The output directory to name of the output directory you want, and adapters to where the adapters.fa file for BBDUK is. 

inputdir=/home/AD/ehillman/Project_371/Merged_371_sample_files
outputdir=/home/AD/ehillman/Project_371/Clean_merged_371
inputdir1=/home/AD/ehillman/Project_371/Clean_merged_371/*fastq.gz
outputdir1=/home/AD/ehillman/Project_371/FastQC_371_afterQC
inputdir2=/home/AD/ehillman/Project_371/FastQC_371_afterQC
outputdir2=/home/AD/ehillman/Project_371/MultiQC_371_afterQC


#adapters=/home/AD/ehillman/.conda/envs/bbtools/bbtools/lib/resources/adapters.fa
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
Mink=10 #"mink" allows it to use shorter kmers at the ends of the read 
Hdist=2 #number of permitted missmatches
Qtrim=r #quality trim on right
Trimq=20 #1 in 100 or 99% 
Minlen=50 #throw away reads shorter than 100bp after trimming
Maq=10 #This will discard reads with average quality below 20 ie 99%

for Prefix in  `ls -1 *_R1.fastq.gz | sed 's/_R1.fastq.gz//'`
do

bbduk.sh -Xmx128g in1=$Prefix\_R1.fastq.gz in2=$Prefix\_R2.fastq.gz out1=$Prefix\_clean_R1.fastq.gz out2=$Prefix\_clean_R2.fastq.gz ref=$adapters ordered=$Ordered ktrim=$Ktrim k=$K mink=$Mink hdist=$Hdist tpe tbo qtrim=$Qtrim trimq=$Trimq minlen=$Minlen maq=$Maq
	
done

conda deactivate 

mv $inputdir/*clean_R1.fastq.gz $outputdir
mv $inputdir/*clean_R2.fastq.gz $outputdir

echo "Running fastQC and MultiQC"


# FastQC
echo "About to start running FastQC"
mkdir $outputdir1
/home/AD/ehillman/FastQC/fastqc $inputdir1 -o $outputdir1 --threads 16



# MultiQC
echo "About to start running MultiQC"
mkdir $outputdir2

#Load modules
source /apps/anaconda3/etc/profile.d/conda.sh
conda activate Multiqc

multiqc $inputdir2 -o $outputdir2

conda deactivate 


echo "All done"

