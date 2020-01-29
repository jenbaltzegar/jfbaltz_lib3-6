#!/bin/bash

#####################################################
# This script will run the populations program and
# R code to plot a PCA analysis for the data
#####################################################

cd ../stacks.denovo/rxstacks

###############################
echo "Running populations..."
###############################
# set parameters
min_samples=0.75
min_maf=0.05
max_obs_het=0.70
popmap=../../info/popmaps/popmap.tsv

# make directory for output
mkdir r$min_samples.maf$min_maf.het$max_obs_het

# set output directory
out_dir=./r$min_samples.maf$min_maf.het$max_obs_het

# run populations
populations --in_path ./ --out_path $out_dir --popmap $popmap --threads 10 \
  -p 2 -r $min_samples --min_maf=$min_maf --max_obs_het=$max_obs_het \
  --genepop \
  &> $out_dir/populations.oe

###############################
echo "Performing and plotting the PCA using ADEgenet..."
###############################
cd $out_dir
mkdir ./genepop
new_out=./genepop

mv batch_1.genepop ./$new_out/batch_1.gen

cd $new_out
ln -s batch_1.genepop batch_1.gen
../../../../scripts/R_scripts/5_plot_pca.R
