CREATE DATABASE Corona_virus_project


---CREATING TABLE IN SQL 

/*CREATE TABLE Corona_dataset
(Province VARCHAR(50) ,	
Country_Region VARCHAR(50) ,	
Latitude	FLOAT ,
Longitude	FLOAT ,
Date	DATE ,
Confirmed	INT ,
Deaths	INT,
Recovered INT)*/

---1) Write a code to check NULL values

SELECT * FROM Corona_dataset
WHERE Province IS NULL
OR Country_Region IS NULL	
OR Latitude	IS NULL
OR Longitude IS NULL
OR Date	IS NULL
OR Confirmed IS NULL
OR Deaths IS NULL
OR Recovered IS NULL;


---2) If NULL values are present,update them with zeros for all columns

UPDATE Corona_dataset
SET
    Province = COALESCE(Province, '0'), 
    Country_Region = COALESCE(Country_Region, '0'),	
    Latitude	= COALESCE(Latitude, '0'),
    Longitude = COALESCE(Longitude, '0'),
    Date	= COALESCE(Date, '0'),
    Confirmed = COALESCE(Confirmed, '0'), 
    Deaths = COALESCE(Deaths, '0'),
    Recovered = COALESCE(Recovered, '0');

	

---3) Check TOTAL numbers of rows

SELECT COUNT(*) AS Total_rows
FROM Corona_dataset

---4) Check what is start_date and end_date

SELECT
     MIN(Date) AS start_date,
	 MAX(Date) AS end_date
FROM Corona_dataset

---5) Number of MONTH present in dataset

SELECT COUNT(DISTINCT MONTH(Date)) AS month_number
FROM Corona_dataset

---6) Find MONTHLY AVERAGE for confirmed,deaths,recovered

SELECT
     MONTH(Date) AS month,
	 AVG(Confirmed) AS avg_confirmed,
	 AVG(Deaths) AS avg_deaths,
	 AVG(Recovered) AS avg_recovered
FROM Corona_dataset
GROUP BY
     MONTH(Date)
ORDER BY
     MONTH ASC;


---7) Find MOST FREQUENT VALUE for confirmed, deaths, recovered each month

SELECT 
    MONTH(Date) AS month,
    (SELECT TOP 1 confirmed 
     FROM Corona_dataset 
     WHERE MONTH(Date) = MONTH(Confirmed) 
     GROUP BY confirmed 
     ORDER BY COUNT(*) DESC) AS most_freq_confirmed,
    (SELECT TOP 1 deaths 
     FROM Corona_dataset
     WHERE MONTH(Date) = MONTH(Deaths)
     GROUP BY deaths 
     ORDER BY COUNT(*) DESC) AS most_freq_deaths,
    (SELECT TOP 1 recovered 
     FROM Corona_dataset 
     WHERE MONTH(Date) = MONTH(Recovered) 
     GROUP BY recovered 
     ORDER BY COUNT(*) DESC) AS most_freq_recovered FROM Corona_dataset AS t GROUP BY MONTH(Date)
ORDER BY MONTH ASC;

---8) Find MINIMUM VALUES for confirmed, deaths, recovered per year

SELECT 
    YEAR(Date) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM 
    Corona_dataset
GROUP BY 
    YEAR(Date);


---9) Find MAXIMUM VALUES for confirmed, deaths, recovered per year

SELECT 
    YEAR(Date) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM 
    Corona_dataset
GROUP BY 
    YEAR(Date);

---Q10) The total number of case of confirmed, deaths, recovered each month

SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM 
    Corona_dataset
GROUP BY 
    YEAR(Date), MONTH(Date)
ORDER BY 
    MONTH ASC;

---Q11) Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    SUM(confirmed) AS total_confirmed,
    AVG(confirmed) AS average_confirmed,
    VAR(confirmed) AS variance_confirmed,
    STDEV(confirmed) AS stdev_confirmed
FROM 
    Corona_dataset

---Q12) Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    SUM(Deaths) AS total_deaths,
    AVG(Deaths) AS average_deaths,
    VAR(Deaths) AS variance_deaths,
    STDEV(Deaths) AS stdev_deaths
FROM 
    Corona_dataset
GROUP BY 
    YEAR(Date), MONTH(Date)
ORDER BY
    MONTH ASC;

---Q13) Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    SUM(recovered) AS total_recovered,
    AVG(recovered) AS average_recovered,
    VAR(recovered) AS variance_recovered,
    STDEV(recovered) AS stdev_recovered
FROM 
    Corona_dataset;

---Q14) Find Country having highest number of the Confirmed case

SELECT TOP 1
    Country_Region,
    MAX(confirmed) AS max_confirmed_cases
FROM 
    Corona_dataset
GROUP BY 
    Country_Region
ORDER BY 
    max_confirmed_cases DESC;

---Q15) Find Country having lowest number of the death case

SELECT 
    Country_Region,
    MIN(Deaths) AS min_death_cases
FROM 
    Corona_dataset
GROUP BY 
    Country_Region
ORDER BY 
    min_death_cases ASC;


---Q16) Find top 5 countries having highest recovered case

SELECT TOP 5
    Country_Region,
    SUM(recovered) AS total_recovered_cases
FROM 
    Corona_dataset
GROUP BY 
    Country_Region
ORDER BY 
    total_recovered_cases DESC;
