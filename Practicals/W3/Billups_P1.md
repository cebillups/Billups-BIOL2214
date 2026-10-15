# BIOL 2214 Week 3 Practical
## Catherine Billups

## Problem 2: Semicolon-delimited to comma-delimited

### Objective
The objective was to write a Bash script that converts a semicolon-delimited file into a comma-delimited file.

### Script
I created a Bash script called semicolon_csv_converter.sh.

```bash
#!/bin/bash

input_file="$1"

if [ -z "$input_file" ]; then
    echo "Usage: bash semicolon_csv_converter.sh filename.csv"
    exit 1
fi

if [ ! -f "$input_file" ]; then
    echo "Error: File not found: $input_file"
    exit 1
fi

output_file="${input_file%.*}_converted.csv"

tr ';' ',' < "$input_file" > "$output_file"

echo "Converted file saved as: $output_file"
```

### Commands Used

I converted the original file using:

```bash
bash Practicals/W3/semicolon_csv_converter.sh ~/Downloads/Pacifici2013_data.csv
```

I displayed the first five lines using:

```bash
head -n 5 ~/Downloads/Pacifici2013_data_converted.csv
```

### First Five Lines of Converted File

```text
TaxID,Order,Family,Genus,Scientific_name,AdultBodyMass_g,Sources_AdultBodyMass,Max_longevity_d,Sources_Max_longevity,Rspan_d,AFR_d,Data_AFR,Calculated_GL_d,GenerationLength_d,Sources_GL
7580,Rodentia,Cricetidae,Eligmodontia,Eligmodontia typus,17.37,PanTHERIA,292,PanTHERIA,254.64,73.74,calculated,147.5856,147.5856,Rspan-AFR(SM+Gest)
42632,Rodentia,Cricetidae,Microtus,Microtus oregoni,20.35,PanTHERIA,456.25,PanTHERIA,445.85,58.06,calculated,187.3565,187.3565,Rspan-AFR(SM+Gest)
42653,Rodentia,Cricetidae,Peromyscus,Peromyscus gossypinus,27.68,PanTHERIA,471.45833335,PanTHERIA,444.87833335,72.58,calculated,201.59471667,201.5947166715,Rspan-AFR(SM+Gest)
42662,Macroscelidea,Macroscelididae,Elephantulus,Elephantulus myurus,59.51,PanTHERIA,401.5,PanTHERIA,412.34,90.48,calculated,210.0586,210.0586,Rspan-AFR(SM+Gest)
```

### Conclusion
The script successfully converted the semicolons into commas while preserving the original data.
