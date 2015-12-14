#!/bin/sh
# 
#################################################
##### Author : Rajesh Patidar		   ######
##### rajbtpatidar@gmail.com		   ######
#################################################
#Assumptions
#	Bam file is located in $1/mapping/
#	Variants are going to be in $1/variants/
#	Bam file names should be given without extension

module load muTect/1.1.4
module load java/jre1.7.0_71
#module load java/jdk1.8.0_11
module load GATK/3.2-2

HG19=/data/Clinomics/Ref/ucsc.hg19.fasta
dbsnp=/data/Clinomics/Ref/dbsnp_138.hg19.vcf
cosmic=/data/Clinomics/Ref/cosmic_v67.b37.vcf
dir=$1 #/projects/clinomics/NCI0150/
$2 # Normal Bam file Name (without Extension)
$3 # Tumor Bam file Name (without Extension)
mkdir $1/variants/tmp/

cmd="java -Xmx1g -jar $MUTECTJARPATH/muTect-1.1.4.jar -T MuTect --reference_sequence $HG19 --dbsnp $dbsnp --cosmic $cosmic --input_file:normal $1/mapping/$2.bam --input_file:tumor  $1/mapping/$3.bam"
$cmd -L chr1 --vcf $1/variants/tmp/$3.muTect.chr1.vcf &
$cmd -L chr2 --vcf $1/variants/tmp/$3.muTect.chr2.vcf &
$cmd -L chr3 --vcf $1/variants/tmp/$3.muTect.chr3.vcf &
$cmd -L chr4 --vcf $1/variants/tmp/$3.muTect.chr4.vcf &
$cmd -L chr5 --vcf $1/variants/tmp/$3.muTect.chr5.vcf &
$cmd -L chr6 --vcf $1/variants/tmp/$3.muTect.chr6.vcf &
$cmd -L chr7 --vcf $1/variants/tmp/$3.muTect.chr7.vcf &
$cmd -L chr8 --vcf $1/variants/tmp/$3.muTect.chr8.vcf &
$cmd -L chr9 --vcf $1/variants/tmp/$3.muTect.chr9.vcf &
$cmd -L chr10 --vcf $1/variants/tmp/$3.muTect.chr10.vcf &
$cmd -L chr11 --vcf $1/variants/tmp/$3.muTect.chr11.vcf &
$cmd -L chr12 --vcf $1/variants/tmp/$3.muTect.chr12.vcf &
$cmd -L chr13 --vcf $1/variants/tmp/$3.muTect.chr13.vcf &
$cmd -L chr14 --vcf $1/variants/tmp/$3.muTect.chr14.vcf &
$cmd -L chr15 --vcf $1/variants/tmp/$3.muTect.chr15.vcf &
$cmd -L chr16 --vcf $1/variants/tmp/$3.muTect.chr16.vcf &
$cmd -L chr17 --vcf $1/variants/tmp/$3.muTect.chr17.vcf &
$cmd -L chr18 --vcf $1/variants/tmp/$3.muTect.chr18.vcf &
$cmd -L chr19 --vcf $1/variants/tmp/$3.muTect.chr19.vcf &
$cmd -L chr20 --vcf $1/variants/tmp/$3.muTect.chr20.vcf &
$cmd -L chr21 --vcf $1/variants/tmp/$3.muTect.chr21.vcf &
$cmd -L chr22 --vcf $1/variants/tmp/$3.muTect.chr22.vcf &
$cmd -L chrX --vcf $1/variants/tmp/$3.muTect.chrX.vcf &
$cmd -L chrY --vcf $1/variants/tmp/$3.muTect.chrY.vcf &
$cmd -L chrM --vcf $1/variants/tmp/$3.muTect.chrM.vcf &
wait
module unload java/jre1.7.0_71
module load java/jdk1.8.0_11
java -Xmx16g -Djava.io.tmpdir=$dir/.tmp -jar $GATKJAR\
        -T CombineVariants\
        -R $HG19\
	--variant $1/variants/tmp/$3.muTect.chr1.vcf\
	--variant $1/variants/tmp/$3.muTect.chr2.vcf\
	--variant $1/variants/tmp/$3.muTect.chr3.vcf\
	--variant $1/variants/tmp/$3.muTect.chr4.vcf\
	--variant $1/variants/tmp/$3.muTect.chr5.vcf\
	--variant $1/variants/tmp/$3.muTect.chr6.vcf\
	--variant $1/variants/tmp/$3.muTect.chr7.vcf\
	--variant $1/variants/tmp/$3.muTect.chr8.vcf\
	--variant $1/variants/tmp/$3.muTect.chr9.vcf\
	--variant $1/variants/tmp/$3.muTect.chr10.vcf\
	--variant $1/variants/tmp/$3.muTect.chr11.vcf\
	--variant $1/variants/tmp/$3.muTect.chr12.vcf\
	--variant $1/variants/tmp/$3.muTect.chr13.vcf\
	--variant $1/variants/tmp/$3.muTect.chr14.vcf\
	--variant $1/variants/tmp/$3.muTect.chr15.vcf\
	--variant $1/variants/tmp/$3.muTect.chr16.vcf\
	--variant $1/variants/tmp/$3.muTect.chr17.vcf\
	--variant $1/variants/tmp/$3.muTect.chr18.vcf\
	--variant $1/variants/tmp/$3.muTect.chr19.vcf\
	--variant $1/variants/tmp/$3.muTect.chr20.vcf\
	--variant $1/variants/tmp/$3.muTect.chr21.vcf\
	--variant $1/variants/tmp/$3.muTect.chr22.vcf\
	--variant $1/variants/tmp/$3.muTect.chrX.vcf\
	--variant $1/variants/tmp/$3.muTect.chrY.vcf\
	--variant $1/variants/tmp/$3.muTect.chrM.vcf\
	-o $dir/variants/$3.muTect.vcf

rm -rf $1/variants/tmp
