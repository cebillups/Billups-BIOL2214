## Problem 1: About Me

For this problem, I made a Python script that
prints my name and some of my favorite things.

I created variables for my name, favorite color,
favorite activity, and favorite animal.

Then I used print() to display each one.

### Output

My name: Catherine
My favorite color: Pink
My favorite activity: Reading
My favorite animal: Dog#!/usr/bin/env python3

# Make an empty dictionary
codon_dict = {}

# Read the codon table
with open("CodonTable.tsv", "r") as file:
    next(file)

    for line in file:
        columns = line.strip().split("\t")
        codon = columns[0]
        symbol = columns[2]
        codon_dict[codon] = symbol

# DNA sequence
dna = "CTA GGA GTG ATT TCG"

# Separate the codons
codons = dna.split()

# Make a list for the amino acids
amino_acids = []

# Find the amino acid for each codon
for codon in codons:
    amino_acids.append(codon_dict[codon])

# Show the result
print(amino_acids)
