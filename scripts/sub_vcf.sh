#!/bin/bash

#subset

#$ -cwd
#$ -b y
#$ -l h_rt=08:30:00
#$ -N sub.vcf
#$ -l h_vmem=16G

dba="/broad/sankaranlab/DBA_cohort_analysis/10_burden/VEP_DBA.vcf.gz"
gnomad="/broad/sankaranlab/DBA_cohort_analysis/10_burden/VEP_gnomad.vcf.gz"
unrelated="/broad/sankaranlab/DBA_cohort_analysis/10_burden/unrel_affected2.txt"
outdir="/broad/sankaranlab/DBA_cohort_analysis/12_assembly/vcfs"
regions="/broad/sankaranlab/DBA_cohort_analysis/12_assembly/resources/rib_assem.bed"

bcftools view -R $regions -S $unrelated -Oz -o $outdir/DBA_rib_ass.vcf.gz $dba
bcftools view -R $regions -Oz -o $outdir/gnomAD_rib_ass.vcf.gz $gnomad
