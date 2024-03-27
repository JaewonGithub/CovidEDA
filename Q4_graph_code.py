import matplotlib.pyplot as plt

data = [
    {"continent": "Africa", "location": "Seychelles", "infection_percent": 5.972, "death_percent": 0.477},
    {"continent": "Asia", "location": "Bahrain", "infection_percent": 10.398, "death_percent": 0.365},
    {"continent": "Europe", "location": "Andorra", "infection_percent": 17.125, "death_percent": 0.945},
    {"continent": "North America", "location": "United States", "infection_percent": 9.772, "death_percent": 1.781},
    {"continent": "Oceania", "location": "Papua New Guinea", "infection_percent": 0.123, "death_percent": 0.973},
    {"continent": "South America", "location": "Brazil", "infection_percent": 6.896, "death_percent": 2.754}
]

continents = [item["continent"] for item in data]
locations = [item["location"] for item in data]
infection_percentages = [item["infection_percent"] for item in data]
death_percentages = [item["death_percent"] for item in data]

fig, ax = plt.subplots(figsize=(10, 8))

bar_width = 0.4
index = range(len(continents))

bar1 = ax.barh(index, infection_percentages, bar_width, label='Infection %', color='blue')
bar2 = ax.barh([i + bar_width for i in index], death_percentages, bar_width, label='Death %', color='red')

ax.set_yticks([i + bar_width/2 for i in index])
ax.set_yticklabels(continents)
ax.set_xlabel('Percentage')
ax.set_title('Infection and Death Percentages by Continent')
plt.legend()

plt.tight_layout()
plt.show()
