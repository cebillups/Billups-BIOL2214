# Python III: Writing Good Code

## 1. Debug This Code

### What each line does

- `import pickle` loads the pickle module.
- `genetic_code = pickle.load(...)` opens the file with the genetic code.
- `test_mRNA = ...` is the mRNA sequence we're testing.
- `def get_amino_acids(mRNA):` makes a function to translate mRNA.
- `i = 0` starts at the beginning of the sequence.
- `aa_sequence = []` makes an empty list for the amino acids.
- `while (i + 3) < len(mRNA):` keeps the loop going while there are enough bases left.
- `codon = mRNA[i:(i + 3)]` gets three bases from the sequence.
- `aa = genetic_code[codon]` finds the amino acid for that codon.
- `if aa == "Stop":` checks for a stop codon.
- `break` stops the loop.
- `else:` runs if it isn't a stop codon.
- `aa_sequence.append(aa)` adds the amino acid to the list.
- `i = i + 4` moves four bases forward.
- `return "".join(aa_sequence)` puts the amino acids together.
- `print(get_amino_acids(test_mRNA))` prints the result.

### Finding the bug

I used `pdb` to see what codons the code was reading. The first one was AUG, which was right, but the second one was AAU when it should have been GAA. I looked through the code and saw that `i = i + 4` was making it skip a base each time. I changed it to `i = i + 3` since codons have three bases. After that, I ran it again and got MEFSL, which was the correct result.