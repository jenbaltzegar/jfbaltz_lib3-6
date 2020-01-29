#!/bin/bash

###############################
# Set information for batch
###############################
batch=1
echo "Analyzing batch_$batch for tests.denovo.
Default settings."


###############################
# Run the tests for de novo
###############################
cd ../tests.denovo

for M in 1 2 3 4 5 6 7 8 9;do
	echo "Running Stacks for M=$M..."


	popmap=../info/popmaps/popmap.test_samples.tsv
	reads_dir=../cleaned/test_samples
	mkdir ./stacks.M$M
	stacks_dir=stacks.M$M
	mkdir ./$stacks_dir/populations.r80
	out_dir=$stacks_dir/populations.r80
	log_file1=$stacks_dir/denovo_map.oe
	log_file2=$out_dir/populations.oe

	# define pipeline
	denovo_map.pl --samples $reads_dir -O $popmap -o $stacks_dir \
		-M $M -n $M -m 3 -b 1 -S -T 10 &> $log_file1 \
		-X "populations: -P $stacks_dir -O $out_dir -r 0.80 -t 10 &> $log_file2"
done


#############################################################################################
# Extract the SNPs-per-locus distributions
# (they are reported in the log of populations).
#############################################################################################
mkdir results
cd results

echo "Tallying the numbers..."

full_table=./n_snps_per_locus.tsv
header='#par_set\tM\tn\tm\tn_snps\tn_loci'

for M in 1 2 3 4 5 6 7 8 9;do
	n=$M
	m=3

	# Extract the numbers for this parameter combination.
	log_file=../stacks.M$M/populations.r80/batch_$batch.populations.log

	sed -n '/^#n_snps\tn_loci/,/^[^0-9]/ p' $log_file | grep -E '^[0-9]' \
		> $log_file.snps_per_loc

	# Cat the content of this file, prefixing each line with information
	# on this parameter combination.
	line_prefix="M$M-n$n-m$m\t$M\t$n\t$m\t"
	cat $log_file.snps_per_loc | sed -r "s/^/$line_prefix/"

done | sed "1i $header" > $full_table


###############################
# Plot the results with R
###############################
cd ../../scripts

echo "Plotting the number of loci..."
./R_scripts/plot_n_loci.R

echo "Plotting the distribution of the number of SNPs..."
./R_scripts/plot_n_snps_per_locus.R
