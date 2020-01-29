#!/bin/bash

######################################
# Pick twelve representative samples.
######################################
# Make population map
cd ../info

# A subset of the samples (n=24, 2/population) used in each of the singular
# stacks runs, plus a few samples to make sure every population has been
# included in the test samples.

printf "\
SRL34.1	4
SRL33.3	4
YAV1.2	1
YAV5.2	1
HUX45.3	12
HUX42.8	12
NVL61.3	9
NVL65.6	9
yai.c7	3
yai.d9	3
vlc.c8	10
vlc.a8	10
gol.e2	11
gol.h2	11
nop.f5	6
nop.h6	6
isd.g12	5
isd.c11	5
zag.d2	2
zag.a3	2
mtc.c5	8
mtc.h6	8
poc.g12	7
poc.f11	7
" > ./popmaps/popmap.test_samples.tsv

# Copy files to test_samples directory
cd ../cleaned
mkdir test_samples

cp ./lane1/index1/SRL34.1.fq.gz ./test_samples
cp ./lane1/index1/SRL33.3.fq.gz ./test_samples
cp ./lane1/index2/YAV1.2.fq.gz ./test_samples
cp ./lane1/index2/YAV5.2.fq.gz ./test_samples
cp ./lane1/index4/HUX45.3.fq.gz ./test_samples
cp ./lane1/index4/HUX42.8.fq.gz ./test_samples
cp ./lane1/index6/NVL61.3.fq.gz ./test_samples
cp ./lane1/index6/NVL65.6.fq.gz ./test_samples
cp ./lane2/index1/yai.c7.fq.gz ./test_samples
cp ./lane2/index6/yai.d9.fq.gz ./test_samples
cp ./lane2/index2/vlc.c8.fq.gz ./test_samples
cp ./lane2/index2/vlc.a8.fq.gz ./test_samples
cp ./lane2/index4/gol.e2.fq.gz ./test_samples
cp ./lane2/index4/gol.h2.fq.gz ./test_samples
cp ./lane2/index4/nop.f5.fq.gz ./test_samples
cp ./lane2/index6/nop.h6.fq.gz ./test_samples
cp ./lane2/index6/isd.g12.fq.gz ./test_samples
cp ./lane2/index2/isd.c11.fq.gz ./test_samples
cp ./lane2/index2/zag.d2.fq.gz ./test_samples
cp ./lane2/index4/zag.a3.fq.gz ./test_samples
cp ./lane2/index2/mtc.c5.fq.gz ./test_samples
cp ./lane2/index6/mtc.h6.fq.gz ./test_samples
cp ./lane2/index6/poc.g12.fq.gz ./test_samples
cp ./lane2/index4/poc.f11.fq.gz ./test_samples
