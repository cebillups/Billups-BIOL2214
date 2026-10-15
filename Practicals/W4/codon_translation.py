#!/usr/bin/env python3

# Create an empty dictionary
codon_dict = {}

# Open and read the codon table
with open("CodonTable.tsv", "r") as file:
    next(file)  # Skip the header

    for line in file:
        columns = line.strip().split("\t")

        codon = columns[0]
        symbol = columns[2]

        codon_dict[codon] = symbol

# DNA sequence to translate
dna = "CTA GGA GTG ATT TCG"

# Split the DNA sequence into codons
codons = dna.split()

# Create an empty list for amino acids
amino_acids = []

# Translate each codon
for codon in codons:
    amino_acids.append(codon_dict[codon])

# Print the amino acid sequence
print(amino_acids)
