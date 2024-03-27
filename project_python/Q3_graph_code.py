import matplotlib.pyplot as plt
import numpy as np

data = [
    {"location": "Andorra", "infection_percent": 17.125, "death_percent": 6.702},
    {"location": "Montenegro", "infection_percent": 15.506, "death_percent": 3.704},
    {"location": "Czechia", "infection_percent": 15.228, "death_percent": 3.540},
    {"location": "San Marino", "infection_percent": 14.927, "death_percent": 13.889},
    {"location": "Slovenia", "infection_percent": 11.558, "death_percent": 7.400},
    {"location": "Luxembourg", "infection_percent": 10.736, "death_percent": 2.756},
    {"location": "Bahrain", "infection_percent": 10.398, "death_percent": 0.955},
    {"location": "Serbia", "infection_percent": 10.134, "death_percent": 2.709},
    {"location": "United States", "infection_percent": 9.772, "death_percent": 10.909},
    {"location": "Israel", "infection_percent": 9.687, "death_percent": 1.705}
]

locations = [item["location"] for item in data]
infection_percentages = [item["infection_percent"] for item in data]
death_percentages = [item["death_percent"] for item in data]

fig, ax1 = plt.subplots(figsize=(12, 8))

index = np.arange(len(locations))
bar_width = 0.35

bar1 = ax1.bar(index, infection_percentages, bar_width, label='Infection %', color='blue')
ax1.set_xlabel('Locations')
ax1.set_ylabel('Infection Percentage', color='blue')
ax1.tick_params(axis='y', labelcolor='blue')

ax2 = ax1.twinx()
bar2 = ax2.bar(index + bar_width, death_percentages, bar_width, label='Death %', color='red')
ax2.set_ylabel('Death Percentage', color='red')
ax2.tick_params(axis='y', labelcolor='red')

ax1.set_ylim([0, 18])
ax2.set_ylim([0, 18])

bars = [bar1, bar2]
labels = [bar.get_label() for bar in bars]
plt.legend(bars, labels, loc='upper left')

plt.xticks(index + bar_width/2, locations, rotation=45, ha='right')
plt.title('Infection and Death Percentages by Location')

plt.tight_layout()
plt.show()
