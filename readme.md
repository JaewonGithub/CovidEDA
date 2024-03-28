# Introduction

### **Welcome to my COVID-19 Data Exploration project!** 
In this project, I delve into the extensive realm of COVID-19 data to gain insights, uncover trends, and visualize patterns related to the global pandemic caused by the novel coronavirus. Using SQL query for exploratory data analysis and Python for data visualization, I aim to provide a comprehensive understanding of the pandemic's on various geographical regions. Join me on this journey as we navigate through data to shed light on the multifaceted aspects of the COVID-19 pandemic. 

🔍 Full SQL queries? Check them out here: [SQL Codes](https://github.com/JaewonGithub/CovidEDA/blob/main/project_sql/Q1~Q5_SQL_code.sql)<br> 
🔍 Full Visualization Python codes? They are here: [Python Codes](/project_python/)
<br>
<br>


# Background
The motivation to explore the dataset on COVID-19 is deeply rooted in the profound impact this global pandemic has had on all of us around the world, including myself. By immersing myself in the data and leveraging EDA techniques, I seek to uncover hidden trends, patterns, and correlations that can provide valuable insights into the dynamics of the pandemic. These insights not only inform my own understanding but also empower me to contribute meaningfully to the ongoing discourse surrounding COVID-19. Ultimately, my goal is to use data-driven insights to inform others about the significance of COVID-19 and contribute to the collective effort of addressing the challenges posed by it on a global scale.

Data hails from [Our World in Data](https://ourworldindata.org/covid-deaths) - contains COVID-19 information from 2020-01-01 to 2021-04-30. 

### The Questions answered throughout this project:
1. What were the cumulative global counts for COVID-19 infections and deaths as of April 30, 2021? 

2. How did the monthly counts of COVID-19 infections and deaths vary over time specifically for the United States?

3. Which ten countries had the highest infection rates, and what were their corresponding death rates?

4. Which countries exhibited the highest infection rates within each continent?

5. What is the correlation between the infection rate and other relevant variables, such as GDP per capita , ages, and population density?
<br>
<br>


# Utilized Tools
For this project, following tools were used:

1. **SQL:**  Used to query the database, serving as the primary tool for conducting exploratory data analysis (EDA) on the COVID-19 data.

2. **PostgreSQL:** Selected as the optimal database management system for efficiently managing the data for the analysis.  

3. **Python:** Matplotlib library within Python for data visualization, enabling the creation of visual representations of the outputs derived from SQL queries, thereby enhancing data comprehension and insights.

4. **Git:** Employed Git for version control and project management, facilitating the tracking of project progress.

5. **Visual Studio Code:** Utilized Visual Studio Code as the Integrated Development Environment (IDE), utilizing its terminal for executing Python scripts and extensions for SQL queries, enhancing productivity throughout the data exploration and analysis process.
<br>
<br>


# Analysis

## 1. Global Significance Of COVID-19
To determine the global infection count and death count of COVID-19 as of April 30th, 2021, the dataset was filtered to include only the last date available. Rows with missing location (country) were excluded from the analysis to ensure accurate and meaningful insights into the global situation of COVID-19. 

```sql
SELECT 
	SUM(total_cases) AS global_infection_count,
	SUM(total_deaths) AS global_death_count
FROM (
	SELECT *
	FROM covid_deaths
	WHERE date = '2021-04-30' AND continent IS NOT NULL AND
    location IS NOT NULL
);
```
| global_infection_count | global_death_count |
|------------------------|--------------------|
|       151,398,759      |       3,180,223    |

### Breakdown:
- **Total Infection** - The staggering global infection count underscores the profound impact of COVID-19 on a worldwide scale, highlighting its widespread reach and severity.

- **Total Death** - With a death count surpassing 3 million, COVID-19's impact extends significantly to the fatality aspect, emphasizing the profound toll the pandemic has taken on human lives globally.

<br>

## 2. Looking Into United States 
To delve deeper into the first question, I have narrowed my focus to the United States, which is my primary area of interest. Additionally, I have generated monthly reports to enhance the informativeness of visualizations.
```sql
SELECT 
	date,
	total_cases AS infection_count, 
	COALESCE(total_deaths , 0) AS death_count
FROM 
    covid_deaths
WHERE
	location = 'United States' AND EXTRACT(DAY FROM date) = '1';
```
|     date     | infection_count | death_count |
|--------------|-----------------|-------------|
|  2020-02-01  |        8        |      0      |
|  2020-03-01  |       32        |      1      |
|  2020-04-01  |     224,560      |    6,652     |
|  2020-05-01  |    1,115,946      |   68,140     |
|  2020-06-01  |    1,816,154      |  108,609     |
|  2020-07-01  |    2,693,993      |  128,304     |
|  2020-08-01  |    4,623,604      |  155,240     |
|  2020-09-01  |    6,068,759      |  184,832     |
|  2020-10-01  |    7,281,081      |  208,074     |
|  2020-11-01  |    9,270,467      |  232,229     |
|  2020-12-01  |   13,858,551      |  273,540     |
|  2021-01-01  |   20,252,991      |  354,242     |
|  2021-02-01  |   26,382,255      |  451,408     |
|  2021-03-01  |   28,706,973      |  516,483     |
|  2021-04-01  |   30,541,255      |  553,570     |
```python
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv("C:\Users\wodnj\Desktop\Q2output.csv")

dates = [item["date"] for item in data]
infection_counts = [item["infection_count"] for item in data]
death_counts = [item["death_count"] for item in data]

fig1, ax1 = plt.subplots(figsize=(10, 6))
ax1.plot(dates, infection_counts, marker='o', label='Infection Count', color='blue')
ax1.set_xlabel('Date')
ax1.set_ylabel('Count')
ax1.set_title('COVID-19 Infection Counts in the United States')
ax1.ticklabel_format(style='plain', axis='y') 
plt.xticks(rotation=45, ha='right')
plt.legend()
plt.tight_layout()
plt.show()

fig2, ax2 = plt.subplots(figsize=(10, 6))
ax2.plot(dates, death_counts, marker='s', label='Death Count', color='red')
ax2.set_xlabel('Date')
ax2.set_ylabel('Count')
ax2.set_title('COVID-19 Death Counts in the United States')
plt.xticks(rotation=45, ha='right')
plt.legend()
plt.tight_layout()
plt.show()
```
![Image1](assets/Q2_image1.png) 
### Breakdown:
- **Trend Analysis:** Observing the trend from the line chart, before July of 2020, the graph depicting infection counts shows a relatively flat slope, indicating a slower spread of COVID-19 during that period. However, starting from August 2020, there is a noticeable increase in the slope of curve, indicating a more rapid spread of the virus. This trend intensifies significantly from November 2020 to February 2021, where the infection count nearly triples within this period. The decreasing slope observed from February 2021 onward could potentially be attributed to the release and administration of better vaccinations, which likely contributed to reducing the rate of new infections. 
<br></br>



![Image2](assets/Q2_image2.png)
### Breakdown:
- **Sudden Increase in April 2020:** The notable spike in infection counts observed in April 2020 may be attributed to the absence of widely available vaccinations for COVID-19 during that period. This lack of preventive measures likely contributed to the rapid spread of the virus within the population. Although the infection rate maintains a relatively consistent slope until November 2020, the death count experiences another sudden surge from that point onward. This could indicate exposure to new variants of COVID-19 for which the population was not adequately prepared, leading to increased fatalities.

- **High Correlation with Infection Count:** Analysis of the two graphs reveal a strong positive correlation between infection and death counts in the United States at various time points. The rate of increase in death counts mirrors the trend of infection count escalation, indicating a direct relationship between the spread of the virus and resultant fatalities. This correlation underscores the critical importance of controlling and mitigating the spread of COVID-19 infections to reduce associated mortality rates effectively.

<br>

## 3. Highest Infection Rate Countries 
To identify the 10 countries with the highest infection rates and their corresponding death rates, following query was used to calculate the rates in percentage.
```sql
SELECT 
	location,
	population,
	MAX(total_cases) AS total_cases, 
	ROUND(MAX((total_cases/population) * 100),3) AS infection_percent,
	MAX(total_deaths) AS total_deaths,
	ROUND(MAX(total_deaths)/MAX(total_cases) * 100 , 3) AS death_percent
FROM 
	covid_deaths
WHERE NOT
	(continent IS NULL OR
	 total_cases IS NULL OR 
	 total_deaths IS NULL OR
	 population IS NULL)
GROUP BY 
	location, population
ORDER BY 
	infection_percent DESC
LIMIT 10;
```
| Location      | Population   | Total Cases | Infection Rate (%) | Total Deaths | Death Rate (%) |
|---------------|--------------|-------------|--------------------|--------------|----------------|
| Andorra       | 77,265       | 13,232      | 17.125             | 125          | 0.945          |
| Montenegro    | 628,062      | 97,389      | 15.506             | 1,495        | 1.535          |
| Czechia       | 10,708,982   | 1,630,758   | 15.228             | 29,267       | 1.795          |
| San Marino    | 33,938       | 5,066       | 14.927             | 90           | 1.777          |
| Slovenia      | 2,078,932    | 240,292     | 11.558             | 4,250        | 1.769          |
| Luxembourg    | 625,976      | 67,205      | 10.736             | 796          | 1.184          |
| Bahrain       | 1,701,583    | 176,934     | 10.398             | 646          | 0.365          |
| Serbia        | 6,804,596    | 689,557     | 10.134             | 6,362        | 0.923          |
| United States | 331,002,647  | 32,346,971  | 9.772              | 576,232      | 1.781          |
| Israel        | 8,655,541    | 838,481     | 9.687              | 6,363        | 0.759          |

```python
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
```
![Image2](assets/Q3_image1.png)

### Breakdown:
- **Country with the Greatest Infection Rate:** Surprisingly, Andorra, a European country known for its wealth, boasts the highest infection rate among the analyzed nations. This unexpected finding challenges common assumptions about wealth and healthcare infrastructure in relation to infection rates during the COVID-19 pandemic.

- **Lack of Correlation:** Analysis based on the histogram reveals a notable lack of correlation between infection rates and death rates in the countries. Despite having high infection rates, these countries exhibit varying death rates, indicating that the severity of COVID-19 outcomes may not be solely determined by the infection rate. This suggests that other factors such as healthcare capacity, treatment protocols, and demographics may significantly influence mortality rates.

- **High Death Rate Countries:** San Marino, United States, Slovenia, Czechia stand out for their unusually high death rates when infected with COVID-19, nearing 1.8%. This observation underscores the complexity of COVID-19 outcomes and highlights the importance of understanding and addressing factors contributing to higher mortality rates in specific regions or populations.

<br>

## 4. COVID-19 For Each Continent
```sql
WITH ranking AS (
	SELECT 
		continent,
		location,
		population,
		total_cases,
		total_deaths,
		ROW_NUMBER() OVER (PARTITION BY continent ORDER BY 
        (total_cases/population) DESC) as row_number
	FROM
		covid_deaths
	WHERE 
		total_cases > 0 AND continent IS NOT NULL 
	ORDER BY row_number ASC
)
SELECT 
	continent,
	location, 
	ROUND((total_cases / population)*100,3) AS infection_percent,
	ROUND((total_deaths / total_cases)*100,3) AS death_percent
FROM 
	ranking
WHERE NOT(
	 continent IS NULL OR
	 total_cases IS NULL OR 
	 total_deaths IS NULL OR
	 population IS NULL) AND row_number = 1;
```
| Continent      | Location          | Infection Rate (%) | Death Rate (%) |
|----------------|-------------------|--------------------|----------------|
| Africa         | Seychelles        | 5.972              | 0.477          |
| Asia           | Bahrain           | 10.398             | 0.365          |
| Europe         | Andorra           | 17.125             | 0.945          |
| North America  | United States     | 9.772              | 1.781          |
| Oceania        | Papua New Guinea  | 0.123              | 0.973          |
| South America  | Brazil            | 6.896              | 2.754          |
```python
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv("C:\Users\wodnj\Desktop\Q4output.csv")

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
```

![Image2](assets/Q4image1.png)

### Breakdown: 

- **COVID-19 Prevalency in Europe:** The unexpectedly large infection rate in Europe and the unexpectedly low infection rate in Africa highlight that the wealth of a country may not have a significant correlation with infection rates.

- **Insights on Oceania:** Oceania's low infection rate could be attributed to its relatively low total population. However, despite this, the death rate in Oceania does not significantly differ from other continents, indicating other potential factors at play.

- **Other potential factors:** The data suggests that there may be additional factors influencing infection and death rates beyond population and wealth, prompting the need to explore correlations with other factors.

<br>

## 5. Other possible correlated variables for COVID-19 rates
Based on the questions above, this query attempts to identify the correlation value between infection rate and other variables.
```sql
WITH infection AS (
	SELECT 
		location,
		id,
		total_cases,
		population,
		(total_cases/population) AS infection_rate
	FROM
		covid_deaths
	WHERE 
		continent IS NOT NULL AND
		total_cases IS NOT NULL AND
		population IS NOT NULL
	ORDER BY 
		infection_rate DESC)
SELECT 
	CORR(infection_rate , gdp_per_capita) AS corr_infection_gdp,
	CORR(infection_rate , aged_65_older) AS corr_infection_age65,
	CORR(infection_rate , population_density) AS corr_infection_popdensity
FROM infection 
INNER JOIN covid_vaccinations ON infection.id = covid_vaccinations.id
WHERE NOT 
	(gdp_per_capita IS NULL AND 
	aged_65_older IS NULL AND 
	population_density IS NULL)
```
| Correlation with Infection Rate | Value |
|---------------------------------|-------|
| GDP                             | 0.315 |
| Age 65+ Population              | 0.303 |
| Population Density              | 0.031 |

### Breakdown:
- **GDP Per Capita:** 
The positive correlation value of 0.315 indicates a moderate positive association between a country's GDP per capita and its infection rate from COVID-19. This suggests that wealthier nations may experience slightly higher infection rates.

- **Age 65+ Population:** 
With a correlation value of 0.303, there appears to be a moderate positive correlation between the percentage of the population aged 65 and above and the infection rate. Countries with a higher proportion of older individuals tend to have slightly higher infection rates, highlighting potential vulnerabilities in older age groups.

- **Population Density:** 
The correlation value of 0.031 suggests that there is almost no correlation between population density and the infection rate of COVID-19. This implies that factors other than population density play a more significant role in determining the spread and impact of the virus.

- **Possibility Of Flaws:** This dataset is limited to reported countries which may not be very consistent with entire population dataset. The absence of data from certain countries can skew the correlation analysis. 

<br>

# What I learned

- **Proficiency in Database Management:** Through this project, I have acquired skills in creating, modifying, and effectively managing databases.

- **Expertise in Python's Matplotlib:** I have gained mastery in utilizing Python's Matplotlib library for data visualization, which is widely recognized and used in the industry.

- **Effective Use of SQL Functions:** By leveraging functions like CORR() in my queries, I significantly reduced query length and improved analytical capabilities, highlighting the importance of SQL function knowledge.

- **Value of Data Visualization:** While SQL query outputs are essential, leveraging visualizations such as histograms and bar charts proved instrumental in identifying trends and patterns within the data.

- **Analytical Thinking:** By utilizing visualizations, I sharpened my analytical thinking skills and gained the ability to infer potential reasons for observed trends.

<br>

# Conclusion 

## Global Significance
&ensp; The extensive global infection count underscores COVID-19's immense impact on a global scale, highlighting its widespread reach and severity. Surpassing 3 million deaths further emphasizes the pandemic's toll on human lives worldwide due to COVID-19.

## COVID-19 In USA
&ensp; Analyzing trends in US COVID-19 data reveals significant shifts in infection and death rates over time. Before July 2020, the infection rate exhibited a slower increase, but from August 2020 onwards, a rapid spread was observed, peaking between November 2020 and February 2021. This surge aligns with a notable spike in deaths, indicating a direct relationship between virus spread and fatalities. Additionally, the strong positive correlation between infection and death counts in the United States emphasizes the need for effective strategies to mitigate COVID-19's impact and prevent future outbreaks.

## Top 10 Infection Rate Countries
&ensp; The analysis of the top 10 countries with the highest infection rates uncovers intriguing insights challenging common assumptions. Among these nations, Andorra, despite its wealth, surprisingly boasts the highest infection rate, defying expectations tied to economic prosperity and healthcare infrastructure during the pandemic. Moreover, unlike the USA's infection count versus death count, histogram analysis indicates a notable absence of a direct correlation between infection rates and death rates across these countries. This discrepancy suggests that a high infection rate is not necessarily the cause of a high death rate, or vice versa.

## Rates For Each Continent
&ensp; The prevalence of COVID-19 in Europe, with its unexpectedly high infection rate, contrasts starkly with Africa's surprisingly low infection rate, challenging assumptions about the correlation between a country's wealth and its infection rates. Similarly, Oceania's relatively low infection rate can be partially attributed to its smaller population size. However, despite this advantage, the death rate in Oceania remains comparable to other continents, indicating that factors beyond population and wealth play significant roles in COVID-19 outcomes. These findings underscore the complexity of pandemic dynamics and the need to delve deeper into potential correlations with additional factors such as healthcare infrastructure, public health measures, demographics, and cultural practices. Understanding these nuances is crucial for formulating targeted strategies to mitigate COVID-19's impact and enhance global pandemic response efforts.

## Understanding Other Possible Variables
&ensp; The analysis uncovers several interesting correlations between various factors and COVID-19 infection rates. A moderate positive correlation between GDP per capita and infection rates suggests that wealthier nations may experience slightly higher infection rates. Similarly, the moderate positive correlation between the percentage of the population aged 65 and above and infection rates indicates potential vulnerabilities in older age groups. Surprisingly, there is almost no correlation between population density and infection rates, implying that other factors play a more significant role in virus spread. However, it's essential to acknowledge potential flaws in the dataset, such as limited reporting from certain countries, which can skew correlation analyses.

<br>
<br>
<br>

# Closing Thoughts

&ensp; The exploratory data analysis and visualization of COVID-19 data from 2020 to 2021 have provided invaluable insights into the global impact of the pandemic. By examining trends in infection and death rates across different regions and analyzing correlations with various socio-economic factors, I have gained a deeper understanding of the complexities involved in the spread and outcomes of COVID-19. These analyses highlight the importance of data-driven approaches. Moving forward, continued exploration and visualization of COVID-19 data will be crucial in monitoring ongoing trends, identifying emerging patterns, and guiding effective strategies to mitigate the impact of the pandemic and safeguard public health worldwide.

