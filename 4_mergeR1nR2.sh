#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 8
#SBATCH --mem-per-cpu 16G
#SBATCH -t 48:00:00


#inputdir=/usr/share/sequencing/nextseq/processed/201013/fastq/
#outputdir=/home/AD/ehillman/201013

inputdir=/home/AD/ehillman/Project_371/Clean_merged_371/
outputdir=/home/AD/ehillman/Project_371/MergedR1nR2

mkdir -p $outputdir
cd $outputdir

echo "Merging files"

for f in ${inputdir}*combined_clean_R1.fastq.gz

do
prefix=${f/combined_clean_R1.fastq.gz/}
cat $f ${prefix}combined_clean_R2.fastq.gz > ${prefix}combined.fastq.gz
echo cat $f ${prefix}combined_clean_R2.fastq.gz into ${prefix}combined.fastq.gz
done

mv $inputdir/*combined.fastq.gz $outputdir

#copy all files to /Data/Users as there is more space in that folder
cp $outputdir/*fast.gz /Data/Users/ehillman/Project_371/MergedR1nR2

echo "All done"
