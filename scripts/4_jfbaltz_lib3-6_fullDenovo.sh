#!/bin/bash


#########################################################################
# This script will take individual sample files in index
# subdirectories and copy them to ../cleaned
#########################################################################

#####################################
# Set information for run
#####################################
echo "Setting parameters..."

export M=5
export n=$M

export n_per_pop=4
export excluded=zag.c1
declare -a cities=("zag" "nop" "yai" "poc" "gol" "mtc" \
	"vlc" "isd" "srl" "yav" "hux" "nvl")


######################################
## Move .fq.gz files to ../cleaned
######################################
echo "Collecting files..."

cd ../cleaned

# # loop through subdirectories to move files
# for lane in lane1 lane2; do
# 	for index in index1 index2 index4 index6; do
# 		cd ./$lane/$index
# 		for file in *.fq.gz; do
# 			mv -i "$file" "../../$file"
# 		done
# 		cd ../../
# 	done
# done


######################################
## Run ustacks on every sample.
######################################
echo "Analyzing all data for stacks.denovo."

cd ../stacks.denovo

# Create function to run ustacks
function run_ustacks {
	sample=$1 # sample name and index are given as arguments to the function
	index=$2
	fqfile=../cleaned/$sample.fq.gz
	logfile=$sample.ustacks.oe
	ustacks -f $fqfile -i $index -o ./ -M $M -m 3 -p 10 &> $logfile
}
export -f run_ustacks

# Run the function
echo "Running ustacks on all samples..."

index=1
for sample in $(cut -f1 ../info/popmaps/popmap.tsv); do
	run_ustacks $sample $index
	index=$((index+1))
done


##############################################
# Pick the samples to include in the catalog.
##############################################
echo "Picking samples to include in catalog..."
cd ../info/popmaps

# For each population, we pick the n_per_pop=n samples with the
# highest coverage. Exclude high-coverage outliers. Note, parameters
# set at the beginning of this file.

sort -k1,1 ../n_reads_per_sample.tsv > reads_sorted.tsv
sort -k1,1 ./popmap.tsv > popmap_sorted.tsv
join ./reads_sorted.tsv ./popmap_sorted.tsv > popmap_joined.tsv
sed -e 's/ /\t/g' popmap_joined.tsv > popmap_joined2.tsv

for pop in "${cities[@]}"; do
	sort -k2,2nr ./popmap_joined2.tsv > ./joined_sorted.tsv
	grep -v $excluded ./joined_sorted.tsv > ./joined_sorted_exclud.tsv
	grep "$pop" ./joined_sorted_exclud.tsv > ./joined_$pop.tsv
	head -n $n_per_pop ./joined_$pop.tsv >> ./atopten.tsv
done

cut -f1,3 ./atopten.tsv > popmap.catalog.tsv

# remove intermediate files
rm -f *_sorted.tsv *joined*.tsv atopten.tsv


###############################
# Run cstacks
###############################
echo "Running cstacks on popmap.catalog.tsv..."

cd ../../stacks.denovo

cstacks -P ./ -M ../info/popmaps/popmap.catalog.tsv -n $n -p 10 &> cstacks.oe

###############################
# Run sstacks on every sample
###############################
echo "Running sstacks on popmap.tsv..."

function run_sstacks {
	sample=$1
	logfile=$sample.sstacks.oe
	sstacks -c ./batch_1 -s $sample -p 10 &> $logfile
}
export -f run_sstacks

#cut -f1 ../info/popmap.tsv | parallel run_sstacks {}
# Alternatively:
for sample in $(cut -f1 ../info/popmaps/popmap.tsv) ;do
	run_sstacks $sample
done


#######################################
# Use rxstacks to improve calls.
#######################################
mkdir rxstacks
cd rxstacks

echo "Running rxstacks..."
rxstacks -P ../ -o ./ --prune_haplo --conf_lim=0.10 -t 10 &> rxstacks.oe

##############################################################
# Re-run cstacks and sstacks
# (Same commands as above, but with updated paths.)
##############################################################
echo "Running cstacks on improved catalog..."
cstacks -P ./ -M ../../info/popmaps/popmap.catalog.tsv -n $n -p 10 &> cstacks.oe

echo "Running sstacks on improved catalog..."
for sample in $(cut -f1 ../../info/popmaps/popmap.tsv) ;do
	run_sstacks $sample
done
