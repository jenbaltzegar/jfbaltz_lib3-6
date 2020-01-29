#! /bin/bash

######################################################################
######################################################################
# Prepare directory for analysis
######################################################################
######################################################################
# Create a directory for the analysis, and subdirectories.
# Gather sequencing files (in raw/).
# Write text files containing the barcodes (in info/).
# Write text files specifying the populations (in info/).

######################################################################
# Make subdirectories for jfbaltz_lib6
######################################################################
cd ..

mkdir alignments
mkdir cleaned
mkdir extra
mkdir genome
mkdir info info/barcodes info/popmaps
mkdir raw raw/lane1 raw/lane2
mkdir stacks.denovo
mkdir stacks.ref
mkdir tests.denovo
mkdir tests.ref

#######################################################################
## Gather trimmed sequencing files (in raw/)
# Note: Starting with trimmed files as FastQC has already been
# done on each of the libraries independently. Therefore, there
# is no need to repeat this analysis.
#######################################################################
cp -r ../jfbaltz_lib3/raw/lane1/trimmed/ ./raw/lane1/
cp -r ../jfbaltz_lib6/raw/lane1/trimmed ./raw/lane2

######################################################################
# Write text files containing the barcodes (in info/).
######################################################################
cd ./info/barcodes

# for lane1 index 1
printf "\
CGCGGT	SRL32.1
CTATTA	SRL32.2
GCCAGT	SRL32.3
GGAAGA	SRL32.4
GTACTT	SRL32.5
GTTGAA	SRL32.6
TAACGA	SRL32.7
TGGCTA	SRL32.8
TGCAAGGA	SRL33.1
TGGTACGT	SRL33.2
TCTCAGTC	SRL33.3
CCGGATAT	SRL33.4
CGCCTTAT	SRL33.5
AACCGAGA	SRL33.6
ACAGGGAA	SRL33.7
ACGTGGTA	SRL33.8
CCATGGGT	SRL34.1
CGCGGAGA	SRL34.2
CGTGTGGT	SRL34.3
GCTGTGGA	SRL34.4
GGATTGGT	SRL34.5
GTGAGGGT	SRL34.6
TATCGGGA	SRL34.7
TTCCTGGA	SRL34.8
" > ./barcodes.lane1.index1.tsv

# for lane1 index 2
printf "\
CGCGGT	YAV1.1
CTATTA	YAV1.2
GCCAGT	YAV1.3
GGAAGA	YAV1.4
GTACTT	YAV1.5
GTTGAA	YAV1.6
TAACGA	YAV4.1
TGGCTA	YAV4.2
TGCAAGGA	YAV4.3
TGGTACGT	YAV4.4
TCTCAGTC	YAV4.5
CCGGATAT	YAV4.6
CGCCTTAT	YAV5.1
AACCGAGA	YAV5.2
ACAGGGAA	YAV5.3
ACGTGGTA	YAV5.4
CCATGGGT	YAV5.5
CGCGGAGA	YAV5.6
CGTGTGGT	YAV6.1
GCTGTGGA	YAV6.2
GGATTGGT	YAV6.3
GTGAGGGT	YAV6.4
TATCGGGA	YAV6.5
TTCCTGGA	YAV6.6
" > ./barcodes.lane1.index2.tsv

# for lane1 index 4
printf "\
CGCGGT	HUX42.1
CTATTA	HUX42.2
GCCAGT	HUX42.3
GGAAGA	HUX42.4
GTACTT	HUX42.5
GTTGAA	HUX42.6
TAACGA	HUX42.7
TGGCTA	HUX42.8
TGCAAGGA	HUX44.1
TGGTACGT	HUX44.2
TCTCAGTC	HUX45.1
CCGGATAT	HUX45.2
CGCCTTAT	HUX44.3
AACCGAGA	HUX44.4
ACAGGGAA	HUX44.5
ACGTGGTA	HUX44.6
CCATGGGT	HUX44.7
CGCGGAGA	HUX44.8
CGTGTGGT	HUX45.3
GCTGTGGA	HUX45.4
GGATTGGT	HUX45.5
GTGAGGGT	HUX45.6
TATCGGGA	HUX45.7
TTCCTGGA	HUX45.8
" > ./barcodes.lane1.index4.tsv

# for lane1 index 6
printf "\
CGCGGT	NVL61.1
CTATTA	NVL61.2
GCCAGT	NVL61.3
GGAAGA	NVL61.4
GTACTT	NVL61.5
GTTGAA	NVL61.6
TAACGA	NVL63.1
TGGCTA	NVL63.2
TGCAAGGA	NVL63.3
TGGTACGT	NVL63.4
TCTCAGTC	NVL63.5
CCGGATAT	NVL63.6
CGCCTTAT	NVL64.1
AACCGAGA	NVL64.2
ACAGGGAA	NVL64.3
ACGTGGTA	NVL64.4
CCATGGGT	NVL64.5
CGCGGAGA	NVL64.6
CGTGTGGT	NVL65.1
GCTGTGGA	NVL65.2
GGATTGGT	NVL65.3
GTGAGGGT	NVL65.4
TATCGGGA	NVL65.5
TTCCTGGA	NVL65.6
" > ./barcodes.lane1.index6.tsv

# for lane 2 index 1
printf "\
CGCGGT	nop.c4
CTATTA	yai.a7
GCCAGT	vlc.b7
GGAAGA	yai.c7
GTACTT	isd.c10
GTTGAA	mtc.b4
TAACGA	poc.d10
TGGCTA	poc.a10
TGCAAGGA	gol.c1
TGGTACGT	zag.b1
TCTCAGTC	mtc.c4
CCGGATAT	mtc.a4
CGCCTTAT	gol.b1
AACCGAGA	vlc.e7
ACAGGGAA	zag.d1
ACGTGGTA	zag.c1
CCATGGGT	isd.a10
CGCGGAGA	yai.e7
CGTGTGGT	vlc.h7
GCTGTGGA	poc.a11
GGATTGGT	nop.d4
GTGAGGGT	gol.f1
TATCGGGA	isd.d10
TTCCTGGA	nop.b4
" > ./barcodes.lane2.index1.tsv

# for lane 2 index 2
printf "\
CGCGGT	yai.f7
CTATTA	poc.c11
GCCAGT	yai.a8
GGAAGA	poc.d11
GTACTT	isd.b11
GTTGAA	mtc.b5
TAACGA	mtc.c5
TGGCTA	gol.b2
TGCAAGGA	nop.g4
TGGTACGT	vlc.b8
TCTCAGTC	zag.h1
CCGGATAT	poc.e11
CGCCTTAT	isd.f10
AACCGAGA	gol.g1
ACAGGGAA	zag.d2
ACGTGGTA	isd.c11
CCATGGGT	mtc.g4
CGCGGAGA	gol.d2
CGTGTGGT	vlc.a8
GCTGTGGA	zag.g1
GGATTGGT	yai.b8
GTGAGGGT	nop.a5
TATCGGGA	nop.b5
TTCCTGGA	vlc.c8
" > ./barcodes.lane2.index2.tsv

# for lane 2 index 4
printf "\
CGCGGT	vlc.d8
CTATTA	zag.a3
GCCAGT	mtc.g5
GGAAGA	poc.b12
GTACTT	nop.a6
GTTGAA	isd.b12
TAACGA	nop.f5
TGGCTA	nop.b6
TGCAAGGA	vlc.f8
TGGTACGT	zag.f2
TCTCAGTC	poc.a12
CCGGATAT	mtc.f5
CGCCTTAT	poc.f11
AACCGAGA	zag.g2
ACAGGGAA	gol.h2
ACGTGGTA	vlc.a9
CCATGGGT	gol.e2
CGCGGAGA	isd.e11
CGTGTGGT	yai.c8
GCTGTGGA	isd.c12
GGATTGGT	yai.a9
GTGAGGGT	mtc.a6
TATCGGGA	yai.g8
TTCCTGGA	gol.a3
" > ./barcodes.lane2.index4.tsv

# for lane 2 index 6
printf "\
CGCGGT	vlc.c9
CTATTA	vlc.b9
GCCAGT	gol.h3
GGAAGA	zag.c3
GTACTT	yai.d9
GTTGAA	zag.g3
TAACGA	nop.g6
TGGCTA	mtc.d6
TGCAAGGA	gol.e3
TGGTACGT	vlc.f9
TCTCAGTC	poc.d12
CCGGATAT	mtc.h6
CGCCTTAT	poc.f12
AACCGAGA	zag.d3
ACAGGGAA	yai.b9
ACGTGGTA	isd.d12
CCATGGGT	nop.h6
CGCGGAGA	isd.g12
CGTGTGGT	gol.d3
GCTGTGGA	isd.e12
GGATTGGT	mtc.e6
GTGAGGGT	nop.e6
TATCGGGA	yai.e9
TTCCTGGA	poc.g12
" > ./barcodes.lane2.index6.tsv


######################################################################
# Write a text file specifying the populations (in info/).
######################################################################
cd ../popmaps

# for lane 1 index 1
printf "\
SRL32.1	low
SRL32.2	low
SRL32.3	low
SRL32.4	low
SRL32.5	low
SRL32.6	low
SRL32.7	low
SRL32.8	low
SRL33.1	low
SRL33.2	low
SRL33.3	low
SRL33.4	low
SRL33.5	low
SRL33.6	low
SRL33.7	low
SRL33.8	low
SRL34.1	low
SRL34.2	low
SRL34.3	low
SRL34.4	low
SRL34.5	low
SRL34.6	low
SRL34.7	low
SRL34.8	low
" > ./popmap.lane1.index1.tsv

# for lane 1 index 2
printf "\
YAV1.1	high
YAV1.2	high
YAV1.3	high
YAV1.4	high
YAV1.5	high
YAV1.6	high
YAV4.1	high
YAV4.2	high
YAV4.3	high
YAV4.4	high
YAV4.5	high
YAV4.6	high
YAV5.1	high
YAV5.2	high
YAV5.3	high
YAV5.4	high
YAV5.5	high
YAV5.6	high
YAV6.1	high
YAV6.2	high
YAV6.3	high
YAV6.4	high
YAV6.5	high
YAV6.6	high
" > ./popmap.lane1.index2.tsv

# for lane 1 index 4
printf "\
HUX42.1	low
HUX42.2	low
HUX42.3	low
HUX42.4	low
HUX42.5	low
HUX42.6	low
HUX42.7	low
HUX42.8	low
HUX44.1	low
HUX44.2	low
HUX45.1	low
HUX45.2	low
HUX44.3	low
HUX44.4	low
HUX44.5	low
HUX44.6	low
HUX44.7	low
HUX44.8	low
HUX45.3	low
HUX45.4	low
HUX45.5	low
HUX45.6	low
HUX45.7	low
HUX45.8	low
" > ./popmap.lane1.index4.tsv

# for lane 1 index 6
printf "\
NVL61.1	high
NVL61.2	high
NVL61.3	high
NVL61.4	high
NVL61.5	high
NVL61.6	high
NVL63.1	high
NVL63.2	high
NVL63.3	high
NVL63.4	high
NVL63.5	high
NVL63.6	high
NVL64.1	high
NVL64.2	high
NVL64.3	high
NVL64.4	high
NVL64.5	high
NVL64.6	high
NVL65.1	high
NVL65.2	high
NVL65.3	high
NVL65.4	high
NVL65.5	high
NVL65.6	high
" > ./popmap.lane1.index6.tsv

# for lane 2 index 1
printf "\
nop.c4	nop
yai.a7	yai
vlc.b7	vlc
yai.c7	yai
isd.c10	isd
mtc.b4	mtc
poc.d10	poc
poc.a10	poc
gol.c1	gol
zag.b1	zag
mtc.c4	mtc
mtc.a4	mtc
gol.b1	gol
vlc.e7	vlc
zag.d1	zag
zag.c1	zag
isd.a10	isd
yai.e7	yai
vlc.h7	vlc
poc.a11	poc
nop.d4	nop
gol.f1	gol
isd.d10	isd
nop.b4	nop
" > ./popmap.lane2.index1.tsv

# for lane 2 index 2
printf "\
yai.f7	yai
poc.c11	poc
yai.a8	yai
poc.d11	poc
isd.b11	isd
mtc.b5	mtc
mtc.c5	mtc
gol.b2	gol
nop.g4	nop
vlc.b8	vlc
zag.h1	zag
poc.e11	poc
isd.f10	isd
gol.g1	gol
zag.d2	zag
isd.c11	isd
mtc.g4	mtc
gol.d2	gol
vlc.a8	vlc
zag.g1	zag
yai.b8	yai
nop.a5	nop
nop.b5	nop
vlc.c8	vlc
" > ./popmap.lane2.index2.tsv

# for lane 2 index 4
printf "\
vlc.d8	vlc
zag.a3	zag
mtc.g5	mtc
poc.b12	poc
nop.a6	nop
isd.b12	isd
nop.f5	nop
nop.b6	nop
vlc.f8	vlc
zag.f2	zag
poc.a12	poc
mtc.f5	mtc
poc.f11	poc
zag.g2	zag
gol.h2	gol
vlc.a9	vlc
gol.e2	gol
isd.e11	isd
yai.c8	yai
isd.c12	isd
yai.a9	yai
mtc.a6	mtc
yai.g8	yai
gol.a3	gol
" > ./popmap.lane2.index4.tsv

# for lane 2 index 6
printf "\
vlc.c9	vlc
vlc.b9	vlc
gol.h3	gol
zag.c3	zag
yai.d9	yai
zag.g3	zag
nop.g6	nop
mtc.d6	mtc
gol.e3	gol
vlc.f9	vlc
poc.d12	poc
mtc.h6	mtc
poc.f12	poc
zag.d3	zag
yai.b9	yai
isd.d12	isd
nop.h6	nop
isd.g12	isd
gol.d3	gol
isd.e12	isd
mtc.e6	mtc
nop.e6	nop
yai.e9	yai
poc.g12	poc
" > ./popmap.lane2.index6.tsv

# for all in one popmap
printf "\
gol.a3	11
gol.b1	11
gol.b2	11
gol.c1	11
gol.d2	11
gol.d3	11
gol.e2	11
gol.e3	11
gol.f1	11
gol.g1	11
gol.h2	11
gol.h3	11
HUX42.1	12
HUX42.2	12
HUX42.3	12
HUX42.4	12
HUX42.5	12
HUX42.6	12
HUX42.7	12
HUX42.8	12
HUX44.1	12
HUX44.2	12
HUX44.3	12
HUX44.4	12
HUX44.5	12
HUX44.6	12
HUX44.7	12
HUX44.8	12
HUX45.1	12
HUX45.2	12
HUX45.3	12
HUX45.4	12
HUX45.5	12
HUX45.6	12
HUX45.7	12
HUX45.8	12
isd.a10	5
isd.b11	5
isd.b12	5
isd.c10	5
isd.c11	5
isd.c12	5
isd.d10	5
isd.d12	5
isd.e11	5
isd.e12	5
isd.f10	5
isd.g12	5
mtc.a4	8
mtc.a6	8
mtc.b4	8
mtc.b5	8
mtc.c4	8
mtc.c5	8
mtc.d6	8
mtc.e6	8
mtc.f5	8
mtc.g4	8
mtc.g5	8
mtc.h6	8
nop.a5	6
nop.a6	6
nop.b4	6
nop.b5	6
nop.b6	6
nop.c4	6
nop.d4	6
nop.e6	6
nop.f5	6
nop.g4	6
nop.g6	6
nop.h6	6
NVL61.1	9
NVL61.2	9
NVL61.3	9
NVL61.4	9
NVL61.5	9
NVL61.6	9
NVL63.1	9
NVL63.2	9
NVL63.3	9
NVL63.4	9
NVL63.5	9
NVL63.6	9
NVL64.1	9
NVL64.2	9
NVL64.3	9
NVL64.4	9
NVL64.5	9
NVL64.6	9
NVL65.1	9
NVL65.2	9
NVL65.3	9
NVL65.4	9
NVL65.5	9
NVL65.6	9
poc.a10	7
poc.a11	7
poc.a12	7
poc.b12	7
poc.c11	7
poc.d10	7
poc.d11	7
poc.d12	7
poc.e11	7
poc.f11	7
poc.f12	7
poc.g12	7
SRL32.1	4
SRL32.2	4
SRL32.3	4
SRL32.4	4
SRL32.5	4
SRL32.6	4
SRL32.7	4
SRL32.8	4
SRL33.1	4
SRL33.2	4
SRL33.3	4
SRL33.4	4
SRL33.5	4
SRL33.6	4
SRL33.7	4
SRL33.8	4
SRL34.1	4
SRL34.2	4
SRL34.3	4
SRL34.4	4
SRL34.5	4
SRL34.6	4
SRL34.7	4
SRL34.8	4
vlc.a8	10
vlc.a9	10
vlc.b7	10
vlc.b8	10
vlc.b9	10
vlc.c8	10
vlc.c9	10
vlc.d8	10
vlc.e7	10
vlc.f8	10
vlc.f9	10
vlc.h7	10
yai.a7	3
yai.a8	3
yai.a9	3
yai.b8	3
yai.b9	3
yai.c7	3
yai.c8	3
yai.d9	3
yai.e7	3
yai.e9	3
yai.f7	3
yai.g8	3
YAV1.1	1
YAV1.2	1
YAV1.3	1
YAV1.4	1
YAV1.5	1
YAV1.6	1
YAV4.1	1
YAV4.2	1
YAV4.3	1
YAV4.4	1
YAV4.5	1
YAV4.6	1
YAV5.1	1
YAV5.2	1
YAV5.3	1
YAV5.4	1
YAV5.5	1
YAV5.6	1
YAV6.1	1
YAV6.2	1
YAV6.3	1
YAV6.4	1
YAV6.5	1
YAV6.6	1
zag.a3	2
zag.b1	2
zag.c1	2
zag.c3	2
zag.d1	2
zag.d2	2
zag.d3	2
zag.f2	2
zag.g1	2
zag.g2	2
zag.g3	2
zag.h1	2
" > ./popmap.tsv
