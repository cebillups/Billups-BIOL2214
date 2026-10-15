sequences = {}

with open("Turkey_transcripts_15.fasta", "r") as file:
    for line in file:
        line = line.strip()

        if line.startswith(">"):
            name = line[1:].split()[0]
            sequences[name] = ""
        else:
            sequences[name] += line

with open("gc_content.txt", "w") as output:
    for name, seq in sequences.items():
        gc = (seq.count("G") + seq.count("C")) / len(seq)
        output.write(name + "\t" + str(gc) + "\n")
