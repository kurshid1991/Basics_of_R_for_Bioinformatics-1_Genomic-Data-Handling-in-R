# -------------------------------
# 🧬 HISTOGRAM COMPARISON:
# Frequency vs Density (Genomics Context)
# -------------------------------

set.seed(42)

# Parameters
n_samples <- 60
n_genes <- 100

# Sample labels
group <- rep(c("Tumor", "Normal"), each = n_samples/2)

# Batch effect
batch <- rep(c("Batch1", "Batch2"), times = n_samples/2)

# Base expression
expr_matrix <- matrix(rnorm(n_samples * n_genes, mean = 5, sd = 1),
                      nrow = n_samples, ncol = n_genes)

colnames(expr_matrix) <- paste0("Gene", 1:n_genes)

# Add biology
expr_matrix[group == "Tumor", 1:20] <- expr_matrix[group == "Tumor", 1:20] + 3
expr_matrix[group == "Tumor", 21:40] <- expr_matrix[group == "Tumor", 21:40] - 2

latent_signal <- rnorm(n_samples, mean = 0, sd = 2)
for (i in 41:60) {
  expr_matrix[, i] <- latent_signal + rnorm(n_samples, 0, 0.5)
}

# Add batch effect
expr_matrix[batch == "Batch2", ] <- expr_matrix[batch == "Batch2", ] + 1.5

# Convert to data frame
gene_data <- as.data.frame(expr_matrix)
gene_data$Group <- group
gene_data$Batch <- batch

# -------------------------------
# Select gene
# -------------------------------
gene <- "Gene5"

tumor <- gene_data[gene_data$Group == "Tumor", gene]
normal <- gene_data[gene_data$Group == "Normal", gene]

# -------------------------------
# 📊 Plot side-by-side
# -------------------------------
par(mfrow = c(1, 2))  # 2 plots in one row

# ==========================================================
# ❌ 1. WITHOUT probability = TRUE (FREQUENCY HISTOGRAM)
# ==========================================================
hist(tumor,
     col = rgb(1, 0, 0, 0.4),
     xlim = range(c(tumor, normal)),
     main = "Frequency Histogram (Counts)",
     xlab = "Expression",
     breaks = 10)

hist(normal,
     col = rgb(0, 0, 1, 0.4),
     add = TRUE,
     breaks = 10)

# ⚠️ IMPORTANT:
# Density curve is NOT meaningful here because:
# - Histogram = raw counts
# - Density curve = normalized probability
# → scales do not match


# ==========================================================
# ✅ 2. WITH probability = TRUE (DENSITY HISTOGRAM)
# ==========================================================
hist(tumor,
     probability = TRUE,  # converts counts → density
     col = rgb(1, 0, 0, 0.4),
     xlim = range(c(tumor, normal)),
     main = "Density Histogram + Curve",
     xlab = "Expression",
     breaks = 10)

hist(normal,
     probability = TRUE,
     col = rgb(0, 0, 1, 0.4),
     add = TRUE,
     breaks = 10)

# ✅ Now density curves are VALID (same scale)
lines(density(tumor), col = "red", lwd = 2)
lines(density(normal), col = "blue", lwd = 2)

# Optional: rug for sample-level view
rug(tumor, col = rgb(1, 0, 0, 0.5))
rug(normal, col = rgb(0, 0, 1, 0.5))

legend("topleft",
       legend = c("Tumor", "Normal"),
       fill = c(rgb(1,0,0,0.4), rgb(0,0,1,0.4)),
       border = NA,
       col = c("red", "blue"),
       lwd = 2)


legend("topright",
       inset = c(-0.3, 0),   # pushes legend outside
       legend = c("Tumor", "Normal"),
       fill = c(rgb(1,0,0,0.4), rgb(0,0,1,0.4)),
       border = NA,
       xpd = TRUE)  # allows drawing outside plot

# Reset layout
par(mfrow = c(1,1))
