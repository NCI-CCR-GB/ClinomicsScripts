#!/bin/sh



#sbatch --nodes=3 --ntasks=4 --export=Sample=IC306C -o IC306C.out --exclusive --mem=60g -J IC306C craft.sh
#
# Assuming that the folder IC306C contains the fastq files and bam will be deposited in the same location
#

module load samtools
module load novocraft/3.02.10mpich2
DIR="/data/khanlab/projects/EGAD_AndyB/Fastq/"

cd $DIR/${Sample}
###################################
#				  #
#             Novoalign		  #
#				  #
###################################
mpiexec  -envall -host `scontrol show hostname ${SLURM_NODELIST} | paste -d',' -s` -np $SLURM_NTASKS novoalignMPI -F STDFQ -o SAM --hlimit 7 -d /fdb/novoalign/chr_all_hg19.nbx -f $DIR/${Sample}_R1.fastq.gz $DIR/${Sample}_R2.fastq.gz | samtools view -uS - | samtools sort -m 20000000000 - ${Sample} 
samtools index ${Sample}
