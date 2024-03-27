CREATE TABLE public.covid_deaths
(
    iso_code TEXT,
    continent TEXT,
    location TEXT,
    population INT,
    date TIMESTAMP,
    total_cases INT,
    new_cases INT,
    total_deaths INT,
    new_deaths INT,
    total_vaccinations INT,
    new_vaccinations INT
);

CREATE TABLE public.covid_vaccinations
(
    iso_code TEXT,
    continent TEXT,
    location TEXT,
    date TIMESTAMP,
    total_vaccinations INT,
    new_vaccinations INT,
    population_density FLOAT,
    aged_65_older FLOAT,
    gdp_per_capita FLOAT,
    hospital_beds_per_thousand FLOAT,
    life_expectancy FLOAT,
    human_development_index FLOAT
);
ALTER TABLE covid_deaths
ALTER COLUMN population TYPE BIGINT

ALTER TABLE public.covid_deaths OWNER to postgres;
ALTER TABLE public.covid_vaccinations OWNER to postgres;

COPY covid_deaths
FROM 'C:\Users\wodnj\Desktop\Covid_table_1.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY covid_vaccinations
FROM 'C:\Users\wodnj\Desktop\CovidTable2.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

