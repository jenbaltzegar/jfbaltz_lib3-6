#!/bin/bash

#####################################################
# This script will test the structure loop
#####################################################

cd ../stacks.denovo/rxstacks/r0.80.maf0.05.het0.70.minpop3/structure
cd ./CLUMPP

project=jfbaltz_libs3-6

MAXPOPS=15
REPS=3
NUMINDS=192
NUMPOPS=12

#####################################################
echo "Preparing CLUMPP..."
#####################################################
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


# #####################################################
# echo "Preparing CLUMPP..."
# #####################################################
# cd CLUMPP
#
# # Edit paramfile to adjust DATATYPE for individual file
# sed -i 's/DATATYPE\t[0-9]\t\t\t\t\t# The type of data to be read in./DATATYPE\t'0'\t\t\t\t\t# The type of data to be read in./' \
#   /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile
#
# # start at K=2 because K=1 results in seqfault
# for cluster in $(seq 2 $MAXPOPS); do
#   # mkdir output_K$cluster
#   # out_clmp=output_K$cluster
#   # cd $out_clmp
#   /home/megan/src/CLUMPP_Linux64.1.1.2/CLUMPP \
#     /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile \
#     -i ./input/indfile_K$cluster \
#     -o ./sz_indivq_K$cluster \
#     -j ./sz_indivq.miscfile_K$cluster \
#     -k $cluster \
#     -c $NUMINDS\
#     -r $REPS \
#     -m 3
#   # cd ..
# done
#
# # Edit paramfile to adjust DATATYPE for popfile
# sed -i 's/DATATYPE\t[0-9]\t\t\t\t\t# The type of data to be read in./DATATYPE\t'1'\t\t\t\t\t# The type of data to be read in./' \
#   /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile
#
# # start at K=2 because K=1 results in seqgault
# for cluster in $(seq 2 $MAXPOPS); do
#   # out_clmp=output_K$cluster
#   # cd $out_clmp
#   /home/megan/src/CLUMPP_Linux64.1.1.2/CLUMPP \
#     /home/megan/temp_JenB/$project/scripts/scripts_clumpp/paramfile \
#     -p ./input/popfile_K$cluster \
#     -o ./sz_popq_K$cluster \
#     -j ./sz_popq.miscfile_K$cluster \
#     -k $cluster \
#     -c $NUMPOPS \
#     -r $REPS \
#     -m 3
#   # cd ..
# done
#
#
# #####################################################
# echo "Testing distruct..."
# #####################################################
# # mkdir ../distruct
# # cd ../distruct
#
# # Make file with population names for labels
# printf "\
# 1 YAV
# 2 zag
# 3 yai
# 4 SRL
# 5 isd
# 6 nop
# 7 poc
# 8 mtc
# 9 NVL
# 10  vlc
# 11  gol
# 12  HUX
# " > ./sz_populations
#
# # Make file with state names for labels
# printf "\
# 1 Oaxaca
# 2 Oaxaca
# 3 Oaxaca
# 4 Oaxaca
# 5 Oaxaca
# 6 Oaxaca
# 7 Oaxaca
# 8 Chiapas
# 9 Chiapas
# 10  Chiapas
# 11  Chiapas
# 12  Chiapas
# " > ./sz_states


# infile_label_below=./population.names
# infile_label_atop=./state.names

# move all files in current directory to distruct directory in src
cp -r ./. ~/src/distruct1.1/

# script that will run distruct from command line

# Command line options:
# -d drawparams                         // Read a different parameter input file instead of drawparams
# -K K                                  // Change the number of clusters.
# -M NUMPOPS                            // Change the number of predefined populations.
# -N NUMINDS                            // Change the number of individuals.
# -p input file (population q's)        // Read a different input file for the population Q-matrix
# -i input file (individual q's)        // Read a different input file for the individual Q-matrix.
# -a input file (labels atop figure)    // Read a different input file for the labels to be printed atop the figure
# -b input file (labels below figure)   // Read a different input file for the labels to be printed below the figure
# -c input file (cluster permutation)   // Read a different input file for the permutation of clusters and the colors
# -o output file                        // Print results to a different output file.

# # Run distruct
# for cluster in $(seq 2 $MAXPOPS); do
#   /home/megan/src/distruct1.1/distructLinux1.1 \
#     -d ./drawparams \
#     -K $cluster \
#     -M $NUMPOPS \
#     -N $NUMINDS \
#     -p ../CLUMPP/output_K$cluster/popq \
#     -i ../CLUMPP/output_K$cluster/indivq \
#     -a $infile_label_atop \
#     -b $infile_label_below \
#     -o output_K$cluster
# done

#### This works!!! ####
# # Run distruct
# cd ~/src/distruct1.1
# ./distructLinux1.1 \
#   -d ./drawparams \
#   -K 5 \
#   -M $NUMPOPS \
#   -N $NUMINDS \
#   -p ./output_K5/popq \
#   -i ./output_K5/indivq \
#   -a ./state.names \
#   -b ./population.names \
#   -o ./output_K5.ps


# Run distruct
cd ~/src/distruct1.1
./distructLinux1.1 \
  -d ./drawparams \
  -K 5 \
  -M $NUMPOPS \
  -N $NUMINDS \
  -p ./sz_popq_K5 \
  -i ./sz_indivq_K5 \
  -a ./sz_states \
  -b ./sz_populations \
  -o ./sz_output_K5
