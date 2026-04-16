set.seed(42)

# Parameters
n_samples <- 60
n_genes <- 100

# Sample labels
group <- rep(c("Tumor", "Normal"), each = n_samples/2)

# Batch effect (technical variation)
batch <- rep(c("Batch1", "Batch2"), times = n_samples/2)

# Base expression matrix
expr_matrix <- matrix(rnorm(n_samples * n_genes, mean = 5, sd = 1),
                      nrow = n_samples, ncol = n_genes)

colnames(expr_matrix) <- paste0("Gene", 1:n_genes)

# -------------------------------
# 🧠 Add biological structure
# -------------------------------

# Module 1 (Genes 1–20): Upregulated in Tumor
expr_matrix[group == "Tumor", 1:20] <- expr_matrix[group == "Tumor", 1:20] + 3

# Module 2 (Genes 21–40): Downregulated in Tumor
expr_matrix[group == "Tumor", 21:40] <- expr_matrix[group == "Tumor", 21:40] - 2

# Module 3 (Genes 41–60): Co-expression block
latent_signal <- rnorm(n_samples, mean = 0, sd = 2)
for (i in 41:60) {
  expr_matrix[, i] <- latent_signal + rnorm(n_samples, 0, 0.5)
}

# -------------------------------
# ⚠️ Add batch effect
# -------------------------------
expr_matrix[batch == "Batch2", ] <- expr_matrix[batch == "Batch2", ] + 1.5

# -------------------------------
# 📦 Convert to data frame
# -------------------------------
gene_data <- as.data.frame(expr_matrix)
gene_data$Group <- group
gene_data$Batch <- batch

# View
head(gene_data[, 1:10])
