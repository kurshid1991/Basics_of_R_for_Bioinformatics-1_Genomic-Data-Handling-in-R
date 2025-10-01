# 👉 Here you learn how to set up your R environment for genomic data analysis, using both CRAN and Bioconductor packages.

#############################################################
###################1.	Setup##################################
#############################################################

# Install required packages (if not already)
install.packages(c("data.table", "readr"))

# Bioconductor installation helper (used for genomics-specific packages)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install 'rtracklayer' for handling genomic file formats (BED, GFF, BigWig)
BiocManager::install("rtracklayer")   # For BED/GFF/BigWig formats


# 👉 Here you practice the basics: creating a genomic table in R, writing it to disk, and reading it back in. These are core skills for handling tabular genomics data.

#############################################################
##############2.	Reading & Writing Basic Tables#############
#############################################################

# Create a toy genomic table with columns:
# chromosome, start, end, and a score
df <- data.frame(
  chr   = c("chr1","chr1","chr2"),
  start = c(100, 200, 300),
  end   = c(150, 250, 350),
  score = c(5, 10, 20),
  stringsAsFactors = FALSE
)


# 👉 Here you learn fast alternatives to base R read.table() when working with large genomic files. Both fread and read_tsv are optimized for speed.

################################################
###### Using data.table and readr for Speed #####
################################################
# Save the table as a tab-separated text file

# Write to disk
write.table(df, "toy_data.txt", sep = "\t",
            row.names = FALSE, quote = FALSE)

# Read it back
df2 <- read.table("toy_data.txt", header = TRUE, sep = "\t")
print(df2)

################################################
######Using data.table and readr for Speed######
################################################

library(data.table)
library(readr)

# data.table
df_dt <- fread("knownGene/knownGene.txt")
print(df_dt)

# readr
df_rr <- read_tsv("knownGene/knownGene.txt")
print(df_rr)

###################################################
###################################################

################### Exercise ######################

###################################################
###################################################

#Exercise: Download a larger file, e.g. UCSC knownGene table http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/knownGene.txt.gz . Compare read times:

system.time(fread("knownGene/knownGene.txt")) #Write the path to file here
system.time(read_tsv("knownGene/knownGene.txt")) #write the path to file here

############################################################################################

#########################################################
###########Saving & Loading R Objects####################
#########################################################

# Save multiple objects together into one file
save(df, df_dt, file = "objects.RData")

# Remove objects from memory
rm(df, df_dt)

# Reload them from .RData file (restores with original names)
load("objects.RData")  # restores same names

# Safer alternative: Save a single object with RDS
saveRDS(df2, "df2.rds")

# Load RDS back (you control the variable name this time)
obj <- readRDS("df2.rds")
print(obj)

#############################################################
############### Genomic-Specific File Formats ###############
#############################################################

library(rtracklayer)

# Export a genomic table (data.frame or GRanges) as a BED file
export(df, "toy_data.bed", format = "bed")

# Import the BED file back into R
bed <- import("toy_data.bed", format = "bed")
bed

# 👉 Exercise: Import a GTF file (Ensembl annotation), extract all entries from chr1, and write them into a new GTF file.