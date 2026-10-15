import re

# Open the file with the research articles
with open("pubmed_results.txt", "r") as file:
    text = file.read()

# Find ZIP codes in author affiliation lines
zip_codes = []

for line in text.splitlines():
    if line.startswith("AD  -"):
        matches = re.findall(r"\b\d{5}\b", line)
        zip_codes.extend(matches)

# Print the results
print("Total ZIP codes found:", len(zip_codes))
print("First 10 ZIP codes:", zip_codes[:10])
# Count how many times each ZIP code appears
zip_counts = {}

for zipcode in zip_codes:
    if zipcode in zip_counts:
        zip_counts[zipcode] += 1
    else:
        zip_counts[zipcode] = 1

# Show how many unique ZIP codes we found
print("Unique ZIP codes:", len(zip_counts))

# Show the first 10 ZIP codes and their counts
print("First 10 ZIP code counts:")
for zipcode, count in list(zip_counts.items())[:10]:
    print(zipcode, count)
import csv

# Create lists for the map
zip_code = []
zip_long = []
zip_lat = []
zip_count = []

# Open the coordinates file
with open("zipcodes_coordinates.txt", "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        zipcode = row["ZIP"]

        # Check if this ZIP code appeared in our research data
        if zipcode in zip_counts:
            zip_code.append(zipcode)
            zip_lat.append(float(row["LAT"]))
            zip_long.append(float(row["LNG"]))
            zip_count.append(zip_counts[zipcode])

# Check our results
print("ZIP codes with coordinates:", len(zip_code))
print("First 5 ZIP codes:", zip_code[:5])
print("First 5 latitudes:", zip_lat[:5])
print("First 5 longitudes:", zip_long[:5])
print("First 5 counts:", zip_count[:5])
import matplotlib.pyplot as plt

# Create the map
plt.scatter(zip_long, zip_lat, s=zip_count, c=zip_count)
plt.colorbar()

# Show only the continental United States
plt.xlim(-125, -65)
plt.ylim(23, 50)

# Make the map bigger
params = plt.gcf()
plSize = params.get_size_inches()
params.set_size_inches((plSize[0] * 3, plSize[1] * 3))

# Add a title
plt.title("Map of Science Publications in 2015")

# Display the map
# Save the map as an image
plt.savefig("map_of_science.png", dpi=300, bbox_inches="tight")
plt.show()
