SELECT *
FROM covid_deaths
WHERE continent is not null AND new_cases >0
ORDER BY date

-- Checking the Components of the two tables (CovidDeaths , CovidVaccinations)
SELECT *
FROM CovidVaccinations
WHERE continent is not null
ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1,2


-- Total Cases vs Total Deaths (Death percentage)
-- Shows likelihood of death if you contract COVID in your country (change '%states%' to your country to check your country)
SELECT location, date,total_cases, total_deaths, (total_deaths/total_cases) * 100 AS DeathPercentage
FROM CovidDeaths
WHERE location like '%states%' and continent is not null
ORDER BY total_cases, total_deaths

--Total Cases vs Population (Shows what percentage of population were infected by COVID)
SELECT location, date,population, total_cases, (total_cases/population) * 100 AS PercentPopulationInfected
FROM CovidDeaths
WHERE continent is not null
ORDER BY location,date

--Looking at Countries with Highest Infection Rate compared to population standard
SELECT location, population, MAX(total_cases) AS HighestInflectionCount, MAX((total_cases/population)) * 100 AS PercentPopulationInfected
FROM CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Showing Countries with Highest Death Count Per Population
SELECT location, MAX(cast(total_deaths as INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

--Breakdown by Continents (Shows total death counts of each continent in descending order)
SELECT continent, MAX(cast(total_deaths as INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global Weekly death rate ordered by Dates
SELECT date, SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths AS INT)) AS total_new_deaths, SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS WeeklyDeathPercent
FROM CovidDeaths
WHERE continent is not null AND ( new_cases > 2 )
GROUP BY date
ORDER BY date

-- Global Weekly death rate ordered by Weekly Death percent descending
SELECT date, SUM(new_cases) AS total_new_cases, SUM(CAST(new_deaths AS INT)) AS total_new_deaths, SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS WeeklyDeathPercent
FROM CovidDeaths
WHERE continent is not null AND ( new_cases > 2 )
GROUP BY date
ORDER BY WeeklyDeathPercent DESC

--Looking at Vaccination Rate for each country using two different methods (CTE, Temp)

--Usage of CTE
With PopvsVac (Continent, Location, Date, Population, New_vaccinations, total_vaccinations)
as
(
SELECT dea.continent , dea.location , dea.date , dea.population , vac.new_vaccinations 
, SUM(CONVERT(float, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as total_vaccinations
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null
)
SELECT *, (Total_vaccinations / Population ) * 100 AS percentageVaccinated
FROM PopvsVac


--Usage of Temp Table
DROP TABLE IF exists #VaccinatedPercentageTemp
CREATE TABLE #VaccinatedPercentageTemp
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Total_vaccinations numeric
)
INSERT INTO #VaccinatedPercentageTemp
SELECT dea.continent , dea.location , dea.date , dea.population , vac.new_vaccinations 
, SUM(CONVERT(float, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as total_vaccinations
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null

SELECT *, (Total_vaccinations/Population) * 100
FROM #VaccinatedPercentageTemp

--Creating View to store data for visualizations

CREATE VIEW VaccinatedPercentageTemp AS 
SELECT dea.continent , dea.location , dea.date , dea.population , vac.new_vaccinations 
, SUM(CONVERT(float, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as total_vaccinations
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null

SELECT *
FROM VaccinatedPercentageTemp
