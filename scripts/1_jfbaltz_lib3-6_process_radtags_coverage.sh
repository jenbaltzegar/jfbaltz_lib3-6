#! /bin/bash

#######################################
# This script will run process radtags
# and check the per sample coverage
#######################################

# change directory
cd ../cleaned/

# make output directories
mkdir lane1
mkdir lane1/index1
mkdir lane1/index2
mkdir lane1/index4
mkdir lane1/index6
mkdir lane2
mkdir lane2/index1
mkdir lane2/index2
mkdir lane2/index4
mkdir lane2/index6

###################################################
echo "Cleaning & demultiplexing the data..."
###################################################
# Create function to run process_radtags for all indices
function run_process_radtags {
	lane=$1  # lane name is given as an argument to the function
	index=$2 # index name is given as an argument to the function
	process_radtags -f ../raw/$lane/trimmed/$index/*.fq.gz \
		-b ../info/barcodes/*$lane.$index.tsv \
		-o ./$lane/$index \
		--renz_1 ecoRI --renz_2 mspI --inline_null \
		-c -q -r -t 115 -D -i gzfastq \
		&> ./$lane/$index/process_radtags.$lane.$index.oe
}
export -f run_process_radtags

# Run the function
for lane in lane1 lane2 ;do
	for index in index1 index2 index4 index6 ;do
		echo "Processing $lane $index..."
		run_process_radtags $lane $index
	done
done


#############################################
echo "Checking the per sample coverage..."
#############################################
# Extract the number of reads from the log of process_radtags.
header='#sample\tn_reads'

for lane in lane1 lane2 ;do
	for index in index1 index2 index4 index6 ;do

		# Retrieve the part of the log between 'Barcode...' and the next empty line,
		# then discard the first and last lines and keep the 2nd and 6th columns.
		sed -n '/^Barcode\tFilename\t/,/^$/ p' \
			./$lane/$index/process_radtags.$index.log \
			| sed '1 d; $ d' | cut -f2,6

	# Write the numbers to a file, adding a header line with sed
	done
done | sed "1 i $header" > ../info/n_reads_per_sample.tsv

#############################################
echo "Plotting per-sample coverage..."
#############################################
cd ../scripts/R_scripts/
./plot_n_reads_per_sample.R
