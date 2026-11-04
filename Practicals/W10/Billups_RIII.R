# Set the working directory
setwd("~/Billups-BIOL2214/Practicals/W10")

# Load the toad data
toads <- read.delim("Toad_Handedness.tsv")

# View the first six rows
head(toads)

# Check column names
names(toads)

# Check the number of rows and columns
dim(toads)

# Function to test handedness using simulations
test_handedness <- function(trials, rights) {
  
  # Simulate 100,000 experiments
  simulations <- rbinom(100000, size = trials, prob = 0.5)
  
  # Find results as extreme as the observed result
  extreme <- abs(simulations - trials / 2) >=
    abs(rights - trials / 2)
  
  # Calculate the p value
  p_value <- mean(extreme)
  
  return(p_value)
}

# Make simulations reproducible
set.seed(123)

# Calculate a p value for each toad
toads$p_value <- mapply(
  test_handedness,
  toads$N_trials,
  toads$N_rights
)

# Classify each toad
toads$Handedness <- ifelse(
  toads$p_value < 0.05,
  ifelse(toads$N_rights > toads$N_trials / 2,
         "Right", "Left"),
  "None"
)

# Display the results
print(toads)

# Count how many toads are right or left handed
table(toads$Handedness)

# Keep only toads with significant handedness
handed_toads <- subset(toads, Handedness != "None")

# Count the right handed toads
n_right <- sum(handed_toads$Handedness == "Right")

# Count all handed toads
n_total <- nrow(handed_toads)

print(n_right)
print(n_total)

# Make results reproducible
set.seed(123)

# Simulate 100,000 groups of 14 toads
simulated_right <- rbinom(
  100000,
  size = n_total,
  prob = 0.5
)

# Calculate a two sided p value
p_value <- mean(
  abs(simulated_right - n_total / 2) >=
    abs(n_right - n_total / 2)
)

# Display the p value
print(p_value)

# Mark right handed toads as TRUE
toads$Is_right <- toads$Handedness == "Right"

# Calculate proportion of right handed males
male_right <- mean(toads$Is_right[toads$Sex == "M"])

# Calculate proportion of right handed females
female_right <- mean(toads$Is_right[toads$Sex == "F"])

# Calculate the difference
observed_diff <- male_right - female_right

# Display results
print(male_right)
print(female_right)
print(observed_diff)

# Set seed so results can be repeated
set.seed(123)

# Number of randomizations
nPer <- 10000

# Create a vector to store differences
random_diffs <- numeric(nPer)

# Randomization test
for(i in 1:nPer) {
  
  # Randomly shuffle handedness
  shuffled <- sample(toads$Is_right)
  
  # Calculate proportion for males
  male_prop <- mean(shuffled[toads$Sex == "M"])
  
  # Calculate proportion for females
  female_prop <- mean(shuffled[toads$Sex == "F"])
  
  # Save the difference
  random_diffs[i] <- male_prop - female_prop
}

# Calculate the two sided p value
p_value_sex <- mean(
  abs(random_diffs) >= abs(observed_diff) - 1e-10
)

# Display the result
print(p_value_sex)

# Load the assortative mating data
jiang <- read.csv("Jiang2013_data.csv")

# View the first six rows
head(jiang)

# Check column names
names(jiang)

# Check the number of rows and columns
dim(jiang)

# Look at the first five lines of the original file
readLines("Jiang2013_data.csv", n = 5)

# Load the data using tabs as separators
jiang <- read.delim("Jiang2013_data.csv")

# View the first six rows
head(jiang)

# Check the column names
names(jiang)

# Check the dimensions
dim(jiang)

# Show the different animal groups
unique(jiang$Taxon)

# Count how many observations belong to each group
table(jiang$Taxon)

# Function to calculate mean r for a taxon
mean_r <- function(taxon_name) {
  
  # Select r values for the chosen taxon
  values <- jiang$r[jiang$Taxon == taxon_name]
  
  # Calculate the average
  average <- mean(values, na.rm = TRUE)
  
  # Return the result
  return(average)
}

# Calculate mean r for fish
mean_r("Fish")

# Calculate mean r for all taxa
taxa <- unique(jiang$Taxon)

taxon_means <- sapply(taxa, mean_r)

# Display results
print(taxon_means)

# Make results reproducible
set.seed(123)

# Number of randomizations
nPer <- 50000

# Observed mean r for fish
fish_mean <- mean_r("Fish")

# Create a vector to store random means
random_means <- numeric(nPer)

# Run 50,000 randomizations
for(i in 1:nPer) {
  
  # Randomly select 37 r values
  random_sample <- sample(jiang$r, size = 37, replace = FALSE)
  
  # Calculate and save the mean
  random_means[i] <- mean(random_sample)
}

# Calculate the p value
fish_p <- mean(random_means >= fish_mean)

# Display the results
print(fish_mean)
print(fish_p)
test_taxon <- function(taxon_name) {

  values <- jiang$r[jiang$Taxon == taxon_name]
  values <- values[!is.na(values)]

  n <- length(values)
  observed_mean <- mean(values)

  random_means <- numeric(50000)

  for(i in 1:50000) {

    random_sample <- sample(
      jiang$r[!is.na(jiang$r)],
      size = n,
      replace = FALSE
    )

    random_means[i] <- mean(random_sample)
  }

  p_value <- mean(random_means >= observed_mean)

  return(c(
    N = n,
    Mean_r = observed_mean,
    P_value = p_value
  ))
}

results <- t(sapply(taxa, test_taxon))

print(results)
