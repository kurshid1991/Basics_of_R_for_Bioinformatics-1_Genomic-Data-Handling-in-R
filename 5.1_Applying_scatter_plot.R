##################################################
############### SCATTER PLOTS ####################
##################################################

# Co-expressed genes (Tumor vs Normal)
plot(gene_data$Gene1, gene_data$Gene5,
     col = ifelse(gene_data$Group == "Tumor", "red", "blue"),
     pch = 19,
     main = "Co-expressed Genes (Tumor vs Normal)",
     xlab = "Gene1",
     ylab = "Gene5")

abline(lm(Gene5 ~ Gene1, data = gene_data),
       col = "black", lwd = 2)


##################################################
############ UNRELATED GENES ######################
##################################################

# No correlation example
plot(gene_data$Gene10, gene_data$Gene80,
     col = "darkgray",
     pch = 19,
     main = "Unrelated Genes",
     xlab = "Gene10",
     ylab = "Gene80")


##################################################
############ BATCH EFFECT VISUAL ##################
##################################################

# Batch effect visualization
plot(gene_data$Gene1, gene_data$Gene5,
     col = ifelse(gene_data$Batch == "Batch1", "green", "orange"),
     pch = 19,
     main = "Batch Effect Impact",
     xlab = "Gene1",
     ylab = "Gene5")


##################################################
############ CORRELATION MATRIX ###################
##################################################

# Compute correlation matrix
cor_matrix <- cor(gene_data[, 1:60])


##################################################
############ PAIRWISE PLOTS #######################
##################################################

# Pairwise relationships (subset of genes)
pairs(gene_data[, 1:6],
      main = "Pairwise Gene Relationships",
      pch = 19,
      col = "darkblue")


##################################################
############ HEATMAP ##############################
##################################################

# Correlation heatmap
heatmap(cor_matrix,
        main = "Gene Correlation Heatmap",
        symm = TRUE)
