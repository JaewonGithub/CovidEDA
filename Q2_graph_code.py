import matplotlib.pyplot as plt

data = [
    {"date": "2020-02-01", "infection_count": 8, "death_count": 0},
    {"date": "2020-03-01", "infection_count": 32, "death_count": 1},
    {"date": "2020-04-01", "infection_count": 224560, "death_count": 6652},
    {"date": "2020-05-01", "infection_count": 1115946, "death_count": 68140},
    {"date": "2020-06-01", "infection_count": 1816154, "death_count": 108609},
    {"date": "2020-07-01", "infection_count": 2693993, "death_count": 128304},
    {"date": "2020-08-01", "infection_count": 4623604, "death_count": 155240},
    {"date": "2020-09-01", "infection_count": 6068759, "death_count": 184832},
    {"date": "2020-10-01", "infection_count": 7281081, "death_count": 208074},
    {"date": "2020-11-01", "infection_count": 9270467, "death_count": 232229},
    {"date": "2020-12-01", "infection_count": 13858551, "death_count": 273540},
    {"date": "2021-01-01", "infection_count": 20252991, "death_count": 354242},
    {"date": "2021-02-01", "infection_count": 26382255, "death_count": 451408},
    {"date": "2021-03-01", "infection_count": 28706973, "death_count": 516483},
    {"date": "2021-04-01", "infection_count": 30541255, "death_count": 553570}
]

dates = [item["date"] for item in data]
infection_counts = [item["infection_count"] for item in data]
death_counts = [item["death_count"] for item in data]

# Separate figure for infection counts with modified y-axis ticks
fig1, ax1 = plt.subplots(figsize=(10, 6))
ax1.plot(dates, infection_counts, marker='o', label='Infection Count', color='blue')
ax1.set_xlabel('Date')
ax1.set_ylabel('Count')
ax1.set_title('COVID-19 Infection Counts in the United States')
ax1.ticklabel_format(style='plain', axis='y')  # Show full values on y-axis
plt.xticks(rotation=45, ha='right')
plt.legend()
plt.tight_layout()
plt.show()

# Separate figure for death counts
fig2, ax2 = plt.subplots(figsize=(10, 6))
ax2.plot(dates, death_counts, marker='s', label='Death Count', color='red')
ax2.set_xlabel('Date')
ax2.set_ylabel('Count')
ax2.set_title('COVID-19 Death Counts in the United States')
plt.xticks(rotation=45, ha='right')
plt.legend()
plt.tight_layout()
plt.show()
