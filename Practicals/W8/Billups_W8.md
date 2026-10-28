# BIOL 2214 Week 8 Assignment

## Disease Risks

### Number of SNPs

The genotype dataset contains 43,141 SNPs. After combining the genotype data with the disease risk data using the SNP identifiers, the combined dataset also contained 43,141 SNPs.

Of these SNPs, 409 were classified as Risk and 42,732 were classified as Non-Risk.

### Maximum Number of Individuals

I calculated the total number of individuals for each SNP by adding the counts of the three possible genotypes.

The maximum number of individuals recorded for a SNP was 124.

### Average Number of Heterozygous Individuals

I calculated the average number of heterozygous individuals for SNPs classified as Risk and Non-Risk.

The average for Risk SNPs was 37.31296, while the average for Non-Risk SNPs was 36.96878.

Risk SNPs had a slightly higher average number of heterozygous individuals. However, the difference was small, so the averages were fairly similar.

## Data Cleanup

### Number of Species

I used the genus and species columns in the Smith2003 dataset to determine the number of unique species.

The dataset contains 4,889 unique species.

### Missing Data

I checked columns 7 and 8 of the Smith2003 dataset for missing values represented by -999.

Both columns contained 1,372 values recorded as -999.

I replaced these values with NA so R would recognize them as missing data instead of actual measurements.

After cleaning the dataset, I checked the saved file and confirmed that there were no remaining -999 values in columns 7 and 8.

I saved the cleaned dataset as Smith2003_cleaned.txt.

## R Code Used

### Counting SNPs by Disease Risk

```r
table(combined$Risk)
```

This code counts how many SNPs are classified as Risk and Non-Risk in the combined dataset.

### Maximum Genotype Count

```r
max(geno$nA1A1 + geno$nA1A2 + geno$nA2A2)
```

This code adds the number of individuals with each of the three possible genotypes for every SNP. The max() function then finds the highest total.

The maximum number of individuals was 124.

### Average Heterozygote Counts

```r
mean(combined$nA1A2[combined$Risk == "Risk"], na.rm = TRUE)
mean(combined$nA1A2[combined$Risk == "Non-Risk"], na.rm = TRUE)
```

These commands calculate the average number of heterozygous individuals for Risk and Non-Risk SNPs separately. The `na.rm = TRUE` argument tells R to ignore missing values.

The average was 37.31296 for Risk SNPs and 36.96878 for Non-Risk SNPs.

### Counting Unique Species

```r
nrow(unique(smith[, c("V5", "V6")]))
```

This code selects the genus and species columns from the Smith2003 dataset. The `unique()` function removes repeated genus and species combinations, and `nrow()` counts how many unique species remain.

The result was 4,889 species.

### Cleaning Missing Values

```r
smith[, 7:8][smith[, 7:8] == -999] <- NA
```

This code checks columns 7 and 8 for values equal to -999 and replaces them with NA. This allows R to recognize these entries as missing data.

```r
sum(smith[, 7:8] == -999, na.rm = TRUE)
```

I used this command to confirm that no -999 values remained after cleaning. The result was 0.

### Exporting the Cleaned Dataset

```r
write.table(smith, file = "~/Documents/BIOL2214_R_Assignment/Smith2003_cleaned.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE, na = "NA")
```

This command saves the cleaned Smith2003 dataset as a tab separated text file. It does not include row or column headings, and missing values are written as NA.

I verified that the saved file contained no remaining -999 values in columns 7 and 8.
