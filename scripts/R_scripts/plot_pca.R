#!/usr/bin/env Rscript

library(adegenet)

# Make own color palette for ggplot colors
gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}

# For more information, see esp. Jombard's 'An introduction to adegenet 2.0.0',
# Chapter 6 'Multivariate analysis'.

# Load the genotypes.
x = read.genepop('batch_1.gen')
# x = read.genepop('/home/megan/temp_JenB/jfbaltz_libs3-6/stacks.denovo/rxstacks/r0.80.maf0.05.het0.70.minpop2/genepop/batch_1.gen')

# Remove unique identifiers from individual names
pop(x) <- sapply(substr(indNames(x), start = 1, stop = 3), function(x){x[1]})


# Principle Components Analysis -----------------------------------------------------------------
# turn NAs into zeros
x.scaled = scaleGen(x, NA.method='zero')
# compute the PCA
x.pca = dudi.pca(x.scaled, scannf=FALSE, nf=10)

# visualize coordinates of individual genotypes onto the priciple axes
s.label(x.pca$li)

# Examine first and second axes
pdf('pca_first-second_eigenLeft.pdf')
s.class(x.pca$li, fac = pop(x), col = transp(gg_color_hue(nPop(x)), 0.6)
        , xax = 1, yax = 2
        , axesell = FALSE, cstar = 0, cpoint = 4)
add.scatter.eig(x.pca$eig[1:10], posi ="bottomleft", xax = 1, yax = 2)
null=dev.off()

# Examine second and third axes
pdf('pca_second-third.pdf')
s.class(x.pca$li, fac = pop(x), col = transp(gg_color_hue(nPop(x)), 0.6)
        , xax = 3, yax = 2
        , axesell = FALSE, cstar = 0, cpoint = 4)
add.scatter.eig(x.pca$eig[1:10], posi ="bottomright", xax = 2, yax = 3, ratio = 0.2)
null=dev.off()

# Examine third and fourth axes
pdf('pca_third-fourth.pdf')
s.class(x.pca$li, fac = pop(x), col = transp(gg_color_hue(nPop(x)), 0.6)
        , xax = 3, yax = 4
        , axesell = FALSE, cstar = 0, cpoint = 4)
add.scatter.eig(x.pca$eig[1:10], posi ="topleft", xax = 3, yax = 4)
null=dev.off()

# Examine fourth and fifth axes
pdf('pca_fourth-fifth.pdf')
s.class(x.pca$li, fac = pop(x), col = transp(gg_color_hue(nPop(x)), 0.6)
        , xax = 4, yax = 5
        , axesell = FALSE, cstar = 0, cpoint = 4)
add.scatter.eig(x.pca$eig[1:10], posi ="topleft", xax = 4, yax = 5)
null=dev.off()

# # Plot the PCA.
# # pdf('pca.pdf')
# s.class(x.pca$li, xax=1, yax=2, pop(x), col=transp(gg_color_hue(nPop(x)), 0.6)
# add.scatter.eig(x.pca$eig[1:10], pos="topleft", xax=1, yax=2)
# # null=dev.off()

# # Verify eigenvalues
# x.pca$eig[1]
# pc1 <- x.pca$li[,1]
# var(pc1)
# var(pc1)*95/96
# mean(pc1^2)
# n <- length(pc1)
# 0.5*mean(dist(pc1)^2)*((n-1)/n)
#
# # express eigenvalues as percentages of total variation
# eig.perc <- 100*x.pca$eig/sum(x.pca$eig)
# head(eig.perc)

# # basic graphics for allele loadings
# s.arrow(x.pca$c1)
# # an alternative
# loadingplot(x.pca$c1^2)