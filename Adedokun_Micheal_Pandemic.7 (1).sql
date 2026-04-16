--1. Show all record in the dataset
SELECT *
from Historical_Pandemic_Epidemic_Dataset;

--2. Find the distint who classificati of diseases
SELECT DISTINCT who_classificati
FROM Historical_Pandemic_Epidemic_Dataset;

--3. Find the distint pathopathogen_type
SELECT DISTINCT pathogen_type
from Historical_Pandemic_Epidemic_Dataset;

--4. Find all diseases that started after 2015
SELECT event_name, start_year
from Historical_Pandemic_Epidemic_Dataset
WHERE start_year > 2015;

--5. Find all diseases that lasted between 2000 and 2024
SELECT event_name, start_year
from Historical_Pandemic_Epidemic_Dataset
where start_year BETWEEN 2000 and 2024;

--6. Find diseases that originated from Africa
SELECT 
    event_name,
    origin_region
FROM Historical_Pandemic_Epidemic_Dataset
WHERE LOWER(origin_region) = 'africa';

--7. Find name of diseases that contains string africa in them
SELECT event_name
FROM Historical_Pandemic_Epidemic_Dataset
WHERE event_name LIKE '%Virus';

--8. Find diseases that are either high or low
SELECT event_name, mortality_scale
from Historical_Pandemic_Epidemic_Dataset
WHERE mortality_scale in ('High', 'Catastrophic');

--9. Count diseases by transmis method
SELECT primary_transmis, COUNT(*) AS count_of_numbers
from Historical_Pandemic_Epidemic_Dataset
GROUP BY primary_transmis;

--10. Calculate the total estimated death from all the diseases
SELECT SUM(estimated_deaths)
from Historical_Pandemic_Epidemic_Dataset;

--11. Find the diseases with the highest estimated deaths
SELECT event_name, estimated_deaths
from Historical_Pandemic_Epidemic_Dataset
GROUP by 1
ORDER by 2 DESC
LIMIT 10;

--12. Find the names of diseases as the year advance
SELECT event_name, start_year
FROM Historical_Pandemic_Epidemic_Dataset
group BY 1
ORDER by 2 asc;

--13. Which containment method aooeared more than 2 times
SELECT containment_meth, COUNT(*) AS count_containment_method
from Historical_Pandemic_Epidemic_Dataset
GROUP by containment_meth
HAVING COUNT(*) > 2
order By 2 DESC
LIMIT 5;

--14. Categorize the names of diseases by severity using the estimated death
SELECT event_name, 
		estimated_deaths,
        CASE WHEN estimated_deaths BETWEEN 1 and 536.25 THEN 'Very Low Death Case'
        	 WHEN estimated_deaths BETWEEN 536.25 and 25000 THEN 'Low Death Case'
        	 when estimated_deaths BETWEEN 25000 and 1025000 then 'High Death Case'
             when estimated_deaths BETWEEN 1025000 and 75000000 THEN 'Estremely High Death Case'
             end as estimated_deaths_category
from Historical_Pandemic_Epidemic_Dataset
group by event_name;

--15. Top 3 Deadliest Diseases by Mortality Rate
SELECT 
    event_name,
    SUM(estimated_cases) AS cases,
    SUM(estimated_deaths) AS deaths,
    (SUM(estimated_deaths) * 1.0 / SUM(estimated_cases)) AS mortality_rate
FROM Historical_Pandemic_Epidemic_Dataset
WHERE estimated_cases > 0
GROUP BY event_name
ORDER BY mortality_rate DESC
LIMIT 3;

--16. Determine the year with the highest total number of deaths across all pandemics
SELECT 
    start_year,
    SUM(estimated_deaths) AS total_deaths
FROM Historical_Pandemic_Epidemic_Dataset
GROUP BY start_year
ORDER BY total_deaths DESC
LIMIT 1;

--17. Calculate the average mortality rate for each disease and rank them from highest to lowest
SELECT 
    event_name,
    SUM(estimated_cases) AS estimated_cases,
    SUM(estimated_deaths) AS estimated_deaths,
    (SUM(estimated_deaths) * 1.0 / SUM(estimated_cases)) AS mortality_rate
FROM Historical_Pandemic_Epidemic_Dataset
WHERE estimated_cases > 0
GROUP BY event_name
ORDER BY mortality_rate DESC;

/*Calculate the total number of cases per year and identify whether pandemics are 
increasing or decreasing over time*/
SELECT
    event_name,
    SUM(estimated_cases) AS yearly_cases
FROM Historical_Pandemic_Epidemic_Dataset
GROUP BY event_name
ORDER BY event_name ASC;
