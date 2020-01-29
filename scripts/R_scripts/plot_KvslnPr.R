#!/usr/bin/env Rscript

# This script will take the mean probability for each K and plot it.

library(ggplot2)

# Load Structure data for complete dataset
dat <- read.table("k_probabilities.tsv", header = TRUE, sep = "\t")

# Take average probability for each k
dat <- aggregate(dat[, 2], list(dat$k), mean)
names(dat) <- c("k", "lnPr")

# Basic line graph
p1 <- ggplot(data=dat, aes(x=k, y=lnPr)) +
  theme(text = element_text(size=20)
        , plot.title = element_text(hjust = 0.5)) +
  geom_line(colour="blue", size=1.5) + 
  geom_point(colour="blue", size=4, shape=21, fill = "blue") +
  xlab("K") +
  ylab("ln Pr(X|K)") +
  ggtitle("Mean ln Pr(X|K)")

ggsave("plot_KvslnPr.png", p1, width = 8, height = 5, units = "in")