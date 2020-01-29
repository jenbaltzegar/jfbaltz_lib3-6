#!/bin/bash

#####################################################
# This script will run the populations program and R
# code to plot a PCA and generate data for Structure.
#####################################################

cd ../stacks.denovo/rxstacks

# set parameters for project
project=jfbaltz_lib3-6

# set parameters for stacks
min_samples=0.80  # min % of indiv in pop required to process a locus
min_maf=0.05      # min minor allele freq required to process nt at a locus
max_obs_het=0.70  # max obs. het. required to process a nt site at a locus
threads=10        # number of computer threads to use for processing
min_pops=2        # min # of pops a locus must be present in to process a locus
popmap=../../info/popmaps/popmap.tsv

# set parameters for structure, CLUMPP, & distruct
BURNIN=50000      # number of burnin steps in mainparams
NUMREPS=50000     # number of reps in mainparams
NUMLOCI=1000      # number of loci to put in whitelist/for Structure
NUMINDS=192       # number of individuals in this project
MAXPOPS=15        # set high end for testing K in sturcture program
REPS=3            # set number of reps for testing K in structure
NUMPOPS=12        # set number of populations being tested

##############################################################
echo "Running populations to generate genepop files..."
##############################################################
# make directory for output
mkdir r$min_samples.maf$min_maf.het$max_obs_het.minpop$min_pops

# set output directory
out_dir=./r$min_samples.maf$min_maf.het$max_obs_het.minpop$min_pops

# # run populations
# populations --in_path ./ --out_path $out_dir --popmap $popmap --threads $threads \
#   -p $min_pops -r $min_samples --min_maf=$min_maf --max_obs_het=$max_obs_het \
#   --genepop \
#   &> $out_dir/populations.oe
#

##############################################################
echo "Performing and plotting the PCA using ADEgenet..."
##############################################################
cd $out_dir
mkdir ./genepop
genepop_dir=./genepop

mv batch_1.genepop ./$genepop_dir/batch_1.gen

cd $genepop_dir
ln -s batch_1.genepop batch_1.gen
../../../../scripts/R_scripts/plot_pca.R


# ##############################################################
# echo "Running populations with --write_single_snp..."
# ##############################################################
# cd ../../
#
# populations --in_path ./ --out_path $out_dir --popmap $popmap --threads $threads \
#   -p $min_pops -r $min_samples --min_maf=$min_maf --max_obs_het=$max_obs_het \
# 	--write_single_snp \
#   &> ./$out_dir/populations.oe
#
#
# #################################################
# echo "Creating whitelist of 1000 random SNPs..."
# #################################################
# cd $out_dir
#
# # This script found here:
# # https://groups.google.com/forum/#!msg/stacks-users/NTG3Bu85OC4/ToAvovnMeFQJ
# #
# # This command does the following at each step:
# # 1) Grep pulls out all the lines in the sumstats file, minus the commented header
# #    lines. The sumstats file contains all the polymorphic loci in the analysis.
# # 2) cut out the second column, which contains locus IDs
# # 3) sort those IDs
# # 4) reduce them to a unique list of IDs (remove duplicate entries)
# # 5) randomly shuffle those lines
# # 6) take the first 1000 of the randomly shuffled lines
# # 7) sort them again and capture them into a file.
#
# grep -v "^#" batch_1.sumstats.tsv | cut -f 2 | sort | uniq | \
#   shuf | head -n $NUMLOCI | sort -n > ./whitelist.tsv
#
#
# ############################################
# echo "Running populations with whitelist..."
# ############################################
# mkdir structure
# structure_dir=./structure
#
# populations --in_path ../ --out_path $structure_dir \
#   --popmap ../$popmap --threads $threads \
#   -p $min_pops -r $min_samples --min_maf=$min_maf --max_obs_het=$max_obs_het \
#   -W ./whitelist.tsv \
#   --write_single_snp \
#   --structure &> ./$structure_dir/populations.oe
#
# ###############################
# echo "Running structure..."
# ###############################
# cd $structure_dir
# mkdir output
# mkdir log_files
#
# # Delete first line of structure file and save new
# sed '1d' batch_1.structure.tsv > structure.tsv
#
# # Print number of columns in file to terminal
# head -n 1 structure.tsv | wc -w
#
# # Edit mainparams file to adjust number of BURNIN and NUMREPS
# sed -i 's/^\#define BURNIN.*$/\#define BURNIN\t'"$BURNIN"'\t\/\/ (int) length of burnin period/' \
#   ../../../../scripts/structure_scripts/mainparams
#
# sed -i 's/^\#define NUMREPS.*$/\#define NUMREPS\t'"$NUMREPS"'\t\/\/ (int) number of MCMC reps after burnin/' \
#   ../../../../scripts/structure_scripts/mainparams
#
#
# # script that will run structure from command line
# # Command line options:
# #
# # -m mainparams: set a different file for mainparams
# # -e extraparams: set a different file for extraparams
# # -s stratparams: set a different file for strat (used in conjunction with program strat)
# # -K MAXPOPS: set K to be examined
# # -L NUMLOCI: set number of loci in input file
# # -N NUMINDS: set number of individuals in input file
# # -i input file: set a different input file
# # -o output file: set a different output file
# # -D SEED: set a different SEED
#
# for i in $(seq 1 $REPS); do
#   for j in $(seq 1 $MAXPOPS); do
#     echo  "Running structure Rep $i, where K = $j..."
#     /home/megan/src/console/structure -i ./structure.tsv \
#       -m ../../../../scripts/structure_scripts/mainparams \
#       -e ../../../../scripts/structure_scripts/extraparams \
#       -K $j -L $NUMLOCI -N $NUMINDS \
#       -o output/output_K$j.rep$i > log_files/structure_K$j.rep$i.log
#   done
# done
#
#
# ###########################################
# echo "Analyzing structure results..."
# ###########################################
# # Extract the number of reads from the log of process_radtags.
# header='k\tlnPr'
#
# for output in ./output/output*; do
#
#   # Extract number from line that ends with "populations assumed"
#   kluster=$(grep 'populations assumed$' $output | tr -d "A-Za-z ")
#   # grep 'populations assumed$' $output | tr -d "A-Za-z "
#
#   # Extract ln Pr(X|K)
#   lnprb=$(grep '^Estimated Ln Prob of Data' $output | tr -d "A-Za-z= ")
#   # grep '^Estimated Ln Prob of Data' $output | tr -d "A-Za-z= "
#
#   printf "%s\t%s\n" $kluster $lnprb
#
# # Write the numbers to a file, adding a header line with sed
# done | sed "1 i $header" > ./k_probabilities.tsv
#
#
# #########################################
# echo "Plotting K vs ln Pr(X|K)..."
# #########################################
# # Call R script
# /home/megan/temp_JenB/$project/scripts/R_scripts/plot_KvslnPr.R
#
# #####################################################
# echo "Preparing CLUMPP..."
# #####################################################
# mkdir CLUMPP CLUMPP/input
#
# # Create the indfile
# for cluster in $(seq 1 $MAXPOPS); do
#   for file in ./output/output_K$cluster/output*; do
#     # Extract lines between line that begins with "Inferred ancestry"
#     # and the next blank line. Then, delete the first two lines
#     # and the last line and write information to file.
#     sed -n '/^Inferred ancestry/,/^$/ p' $file`` \
#     | sed '1,2 d; $ d' \
#     >> ./CLUMPP/input/indfile_K$cluster
#   done
# done
#
# # Change second column of indfile from names to numbers
# for cluster in $(seq 1 $MAXPOPS); do
#   for file in ./CLUMPP/input/indfile_K$cluster; do
#     # copy first column
#     awk '{print $1}' $file > tmp1
#     # delete second column
#     awk '!($2="")' $file > tmp2
#     # Paste tmp files together
#     paste tmp1 tmp2 > $file
#   done
# done
# # remove tmp files
# rm tmp1 tmp2
#
#
# # Create the popq file
# for cluster in $(seq 1 $MAXPOPS); do
#   for file in ./output/output_K$cluster/output*; do
#     # Extract lines between line that begins with "Given"
#     # and the last line of population data. Then, delete the first
#     # two lines and write information to file.
#     awk -v var="$NUMPOPS" '/^Given/{x=NR+var+2;next}(NR<=x){print}' $file \
#     | sed '1,2 d' \
#     >> ./CLUMPP/input/popfile_K$cluster
#   done
# done
#
#
# #####################################################
# echo "Preparing CLUMPP..."
# #####################################################
# cd CLUMPP
#
# # script that will run CLUMPP from command line
# # Command line options:
# #
# # -i INDFILE		# input file for individuals
# # -p POPFILE		# input file for populations
# # -o OUTFILE		# output file, always required
# # -j MISCFILE		# parameter output file, always required
# # -k K					# number of clusters
# # -c C					# Number of individuals or populations.
# # -r R					# number of reps for K
# # -m M					#	algorithm to use: 1=FullSearch, 2=Greedy, 3=LargeKGreedy
# # -w W					# weight number of individuals in population, use with popfile
# # -s S					# Pairwise matrix similarity stat to use: 1=G, 2=G'
#
# # Edit paramfile to adjust DATATYPE for individual file
# sed -i 's/DATATYPE\t[0-9]\t\t\t\t\t# The type of data to be read in./DATATYPE\t'0'\t\t\t\t\t# The type of data to be read in./' \
#   /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile
#
# # start at K=2 because K=1 results in seqfault
# for cluster in $(seq 2 $MAXPOPS); do
#   mkdir output_K$cluster
#   out_clmp=output_K$cluster
#   cd $out_clmp
#   /home/megan/src/CLUMPP_Linux64.1.1.2/CLUMPP \
#     /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile \
#     -i ../input/indfile_K$cluster \
#     -o ./indivq \
#     -j ./indivq.miscfile \
#     -k $cluster \
#     -c $NUMINDS\
#     -r $REPS \
#     -m 3
#   cd ..
# done
#
# # Edit paramfile to adjust DATATYPE for popfile
# sed -i 's/DATATYPE\t[0-9]\t\t\t\t\t# The type of data to be read in./DATATYPE\t'1'\t\t\t\t\t# The type of data to be read in./' \
#   /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile
#
# # start at K=2 because K=1 results in seqgault
# for cluster in $(seq 2 $MAXPOPS); do
#   out_clmp=output_K$cluster
#   cd $out_clmp
#   /home/megan/src/CLUMPP_Linux64.1.1.2/CLUMPP \
#     /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile \
#     -p ../input/popfile_K$cluster \
#     -o ./popq \
#     -j ./popq.miscfile \
#     -k $cluster \
#     -c $NUMPOPS \
#     -r $REPS \
#     -m 3
#   cd ..
# done
