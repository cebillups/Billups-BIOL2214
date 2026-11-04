# R III: Simulation, Randomization, and Faster Code

## Problem 1: Are Most Toads Right Handed?

### 1. Testing handedness in individual toads

I used 100,000 simulations for each toad to test whether it preferred its right or left hand. The null hypothesis was that each toad had an equal chance of using either hand.

I calculated a two sided p value for each toad and used 0.05 as the significance level.

My results showed that 11 toads were right handed, 3 were left handed, and 4 did not show a statistically significant hand preference.

### 2. Are toads equally likely to be right or left handed?

I tested the null hypothesis that right and left handedness were equally likely. I included the 14 toads that showed a significant hand preference.

Out of these 14 toads, 11 were right handed and 3 were left handed.

I ran 100,000 simulations and obtained a p value of 0.05742.

Since the p value was greater than 0.05, I failed to reject the null hypothesis. Although more toads were right handed, there was not enough statistical evidence to conclude that right handedness was more common.

### 3. Does right handedness differ between males and females?

I used a randomization test with 10,000 repetitions to compare the proportion of right handed males and females.

The results showed that 66.7% of males and 55.6% of females were classified as right handed. The difference was 11.1 percentage points.

The randomization test produced a p value of 1. Since this is greater than 0.05, I failed to reject the null hypothesis. There was no statistically significant evidence that males and females differed in their likelihood of being right handed.

## Problem 2: Assortative Mating in Animals

### 1. Mean r for each taxon

I wrote an R function that takes a taxon name and calculates the mean correlation coefficient for that group.

The results were:

| Taxon | Mean r |
|---|---:|
| Fish | 0.3972 |
| Amphibian | 0.1855 |
| Chelicerate | 0.4911 |
| Bird | 0.1318 |
| Crustacean | 0.4030 |
| Gastropod | 0.4010 |
| Reptile | 0.1175 |
| Insect | 0.1966 |
| Annelids | 0.2000 |
| Protist | 0.6140 |
| Mammal | 0.0090 |

### 2. Is the mean r especially high for fish?

The mean r for fish was 0.3972, indicating positive assortative mating.

I ran 50,000 randomizations, randomly selecting 37 r values from the full dataset each time.

The p value was 0.00278. Since this was below 0.05, I rejected the null hypothesis. The results suggest that fish have an unusually high mean assortative mating correlation compared with random samples from the full dataset.

### 3. Randomization tests for all taxa

I repeated the procedure for every taxon, using the number of observations available for each group and 50,000 randomizations per taxon.

| Taxon | N | Mean r | p value |
|---|---:|---:|---:|
| Fish | 37 | 0.3972 | 0.00278 |
| Amphibian | 143 | 0.1855 | 0.99996 |
| Chelicerate | 9 | 0.4911 | 0.01066 |
| Bird | 52 | 0.1318 | 0.99992 |
| Crustacean | 149 | 0.4030 | <0.00002 |
| Gastropod | 10 | 0.4010 | 0.07806 |
| Reptile | 8 | 0.1175 | 0.93028 |
| Insect | 106 | 0.1966 | 0.99822 |
| Annelids | 1 | 0.2000 | 0.59210 |
| Protist | 5 | 0.6140 | 0.00404 |
| Mammal | 1 | 0.0090 | 0.84646 |

Fish, Chelicerate, Crustacean, and Protist had p values below 0.05, suggesting that their mean correlations were unusually high compared with random samples of the same size from the dataset.

These p values were not adjusted for multiple comparisons, and the results for taxa with very small sample sizes should be interpreted cautiously.

## R Code

The complete R code used for the simulations and randomization tests is saved in the accompanying file `Billups_RIII.R`.

## Complete R Code

```r
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

```

### Randomization Test for All Taxa

```r
set.seed(123)

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
```
