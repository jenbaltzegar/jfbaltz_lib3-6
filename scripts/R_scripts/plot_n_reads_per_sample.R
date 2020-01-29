#!/usr/bin/env Rscript

setwd("/home/megan/temp_JenB/jfbaltz_libs3-6/info")

d = read.delim("./n_reads_per_sample.tsv")

n_reads = d$n_reads
names(n_reads) = d$X.sample

pdf('./n_reads_per_sample.pdf', height=12, width=12)

hist(n_reads, nclass=20)
dotchart(sort(n_reads))

null=dev.off()
