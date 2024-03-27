-- Q1. What was the total infection and death count by 2021-04-30?

SELECT 
	SUM(total_cases) AS global_infection_count,
	SUM(total_deaths) AS global_death_count
FROM (
	SELECT *
	FROM covid_deaths
	WHERE date = '2021-04-30' AND continent IS NOT NULL AND location IS NOT NULL
);

-- Q2. What was the total infection and death count for United States ?

SELECT 
	total_cases AS infection_count, 
	COALESCE(total_deaths , 0) AS death_count
FROM covid_deaths
WHERE
	location = 'United States' AND EXTRACT(DAY FROM date) = '1';

-- Q3. What are the top 10 countries with highest infection rate and what is the associated death rate?

SELECT 
	location,
	MAX(total_cases) AS total_cases, 
	ROUND(MAX((total_cases/population) * 100),3) AS infection_percent,
	MAX(total_deaths) AS total_deaths,
	ROUND(MAX((total_deaths/total_cases)*100),3) AS death_percent
FROM 
	covid_deaths
WHERE NOT
	(continent IS NULL OR
	 total_cases IS NULL OR 
	 total_deaths IS NULL OR
	 population IS NULL)
GROUP BY 
	location
ORDER BY 
	infection_percent DESC
LIMIT 10;

-- Q4. What are the countries with highest infection rate for each of the continent?

WITH ranking AS (
	SELECT 
		continent,
		location,
		population,
		total_cases,
		total_deaths,
		ROW_NUMBER() OVER (PARTITION BY continent ORDER BY (total_cases/population) DESC) as row_number
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
FROM ranking
WHERE NOT(
	 continent IS NULL OR
	 total_cases IS NULL OR 
	 total_deaths IS NULL OR
	 population IS NULL) AND row_number = 1;

-- Q5. What is the correlation between infection rate and other factors?

--Added id column to both tables for convenience of joining.
ALTER TABLE covid_deaths ADD id SERIAL;
ALTER TABLE covid_deaths ADD PRIMARY KEY (id);
ALTER TABLE covid_vaccinations ADD id SERIAL;
ALTER TABLE covid_vaccinations ADD PRIMARY KEY (id);

--Code begins
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

