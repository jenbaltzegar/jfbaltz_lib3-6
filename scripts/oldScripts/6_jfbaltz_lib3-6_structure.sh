#!/bin/bash

#########################################################################
# This script will run the populations program to identify SNPs
# to be used in Structure Analysis
#########################################################################
cd ../stacks.denovo/rxstacks

#################################################
echo "Running populations..."
#################################################
min_samples=0.95
min_maf=0.05
max_obs_het=0.70
popmap=../../info/popmaps/popmap.tsv

mkdir r$min_samples.maf$min_maf.het$max_obs_het

out_dir=./r$min_samples.maf$min_maf.het$max_obs_het

populations --in_path ./ --out_path $out_dir --popmap $popmap --threads 10 \
  -p 2 -r $min_samples --min_maf=$min_maf --max_obs_het=$max_obs_het \
	--write_single_snp \
  &> ./$out_dir/populations.oe


#################################################
echo "Creating whitelist of 1000 random SNPs..."
#################################################
cd $out_dir

# This script found here:
# https://groups.google.com/forum/#!msg/stacks-users/NTG3Bu85OC4/ToAvovnMeFQJ
#
# This command does the following at each step:
# 1) Grep pulls out all the lines in the sumstats file, minus the commented header
#    lines. The sumstats file contains all the polymorphic loci in the analysis.
# 2) cut out the second column, which contains locus IDs
# 3) sort those IDs
# 4) reduce them to a unique list of IDs (remove duplicate entries)
# 5) randomly shuffle those lines
# 6) take the first 1000 of the randomly shuffled lines
# 7) sort them again and capture them into a file.

grep -v "^#" batch_1.sumstats.tsv | cut -f 2 | sort | uniq | \
  shuf | head -n 1000 | sort -n > ./whitelist.tsv


############################################
echo "Running populations with whitelist..."
############################################
mkdir structure
new_out=./structure

populations --in_path ../ --out_path $new_out --popmap ../$popmap --threads 10 \
  -p 2 -r $min_samples --min_maf=$min_maf --max_obs_het=$max_obs_het \
	--write_single_snp \
  -W ./whitelist.tsv \
  --structure &> ./$new_out/populations.oe

###############################
# Structure Analysis
###############################
cd $new_out

# Delete first line of structure file and save new
sed '1d' batch_1.structure.tsv > structure.tsv

# Print number of columns in file
head -n 1 structure.tsv | wc -w
