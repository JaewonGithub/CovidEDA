import matplotlib.pyplot as plt

locations = ["Andorra", "Montenegro", "Czechia", "San Marino", "Slovenia", "Luxembourg", "Bahrain", "Serbia", "United States", "Israel"]
infection_rates = [17.125, 15.506, 15.228, 14.927, 11.558, 10.736, 10.398, 10.134, 9.772, 9.687]
death_rates = [0.945, 1.535, 1.795, 1.777, 1.769, 1.184, 0.365, 0.923, 1.781, 0.759]

plt.figure(figsize=(10, 6))
plt.scatter(infection_rates, death_rates, color='blue')
plt.title('Infection Rate vs. Death Rate by Country')
plt.xlabel('Infection Rate (%)')
plt.ylabel('Death Rate (%)')

for i, location in enumerate(locations):
    plt.annotate(location, (infection_rates[i], death_rates[i]), textcoords="offset points", xytext=(0,10), ha='center')

plt.grid(True)
plt.tight_layout()
plt.show()