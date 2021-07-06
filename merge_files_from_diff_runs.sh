#!/bin/bash
#SBATCH --partition WORK
#SBATCH -D /home/AD/ehillman/
#SBATCH -n 8
#SBATCH --mem-per-cpu 16G
#SBATCH -t 24:00:00

## Put outdir here
OUTDIR=/home/AD/ehillman/Merged_371_sample_files
mkdir -p $OUTDIR
#put your folders here
array=("201013" "201020" "201023" "201026" "201028" "201102" "201104" "201106" "201203" "201216" "210105" "210115" "210122")
for DIR in "${array[@]}"
        do
        #Miseq data for READ1 in $(find /usr/share/sequencing/miseq/output/$DIR/Data/Intensities/BaseCalls -type f -name
        #"434*_L001_R1_001.fastq.gz");

        #Nextseq data
        for READ1 in $(find /usr/share/sequencing/nextseq/processed/$DIR/fastq/ -name "371_*_S*_R1_001.fastq.gz");
                do
                #create variable names
                SAMPLE=$(basename $READ1 | sed "s/_S.*_R1_001.fastq.gz//") #strip path and extension
                READ2=$(echo $READ1 | sed "s/_R1_001.fastq.gz/_R2_001.fastq.gz/") #replace with read2 extension
                #confirm right directory and samples
                echo 'directory & sample name' $DIR $SAMPLE #echo statements just to see if correct
                echo read1 $READ1
                echo read2 $READ2

                #can either: 1) concat R1 fastq and R2 fastq and keep seperate (Martin F has suggested most common) or 2) combine both into one
                #file
                # use only one of the below - commment out the other one
                # >> means append; will add each sample to end of file as it goes through loop

                ###### Approach 1
                #check looks correct
                echo cat $READ1 into $OUTDIR/${SAMPLE}\_combined_R1_001.fastq.gz
                cat $READ1 >> $OUTDIR/$SAMPLE\_combined_R1.fastq.gz

                echo cat $READ2 into $OUTDIR/${SAMPLE}\_combined_R2_001.fastq.gz
                cat $READ2 >> $OUTDIR/$SAMPLE\_combined_R2.fastq.gz
 		
                done
        done

echo "All done!"
