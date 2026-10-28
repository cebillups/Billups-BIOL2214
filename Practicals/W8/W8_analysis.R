
data_folder <- "~/Documents/BIOL2214_R_Assignment/IntroBiolComp-2026/R/DataFiles"


# Exercise 1: Vectors

# Create a vector of even numbers from 2 to 100
z <- seq(2, 100, 2)

# Display the vector
print(z)



# Find the sum of all numbers in z
sum(z)

# Check if the sum equals 51 times 50
sum(z) == 51 * 50

# Square every number in z
z^2

# Check which numbers are at least 90
z >= 90

# Find the positions of numbers at least 90
which(z >= 90)



# Exercise 2: Data Frames

# Load the trees dataset
data(trees)

# Display the first six rows
head(trees)

# Find the number of rows and columns
dim(trees)
# Check the data types
str(trees)



# Calculate the average height
mean(trees$Height)



# Count trees taller than 75 feet
sum(trees$Height > 75)

# Final Problems: Disease Risks

# Set the location of the data files


geno <- read.table(file.path(data_folder, "H938_Euro_chr6.geno"), header = TRUE)
risks <- read.csv(file.path(data_folder, "SNP_risks.csv"))


# Calculate the total using rowSums()
total_rowsums <- rowSums(geno[, 5:7])

# Find the maximum
max(total_rowsums)


combined <- merge(geno, risks[, c("SNP", "Risk")], by = "SNP")



table(combined$Risk)



mean(combined$nA1A2[combined$Risk == "Risk"], na.rm = TRUE)


mean(combined$nA1A2[combined$Risk == "Non-Risk"], na.rm = TRUE)



# Disease Risks conclusion:
# The average number of heterozygous individuals at Risk sites
# was 37.31296, compared to 36.96878 at Non-Risk sites.
# Risk sites had a slightly higher average, with a difference
# of approximately 0.34 individuals per site.



smith <- read.delim(file.path(data_folder, "Smith2003_data.txt"), header = FALSE)




smith$V7[smith$V7 == -999] <- NA



smith$V8[smith$V8 == -999] <- NA




write.table(smith, file = "~/Documents/BIOL2214_R_Assignment/Smith2003_cleaned.txt", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE, na = "NA")

