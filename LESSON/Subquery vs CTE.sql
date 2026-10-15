SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
) AS valid_salaries
LIMIT 10;

--CTE

WITH valid_salaries AS (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries
LIMIT 10;

--SUBQUERY
--Scenario 1 - subquery in 'SELECT'
SELECT job_title_short,
       salary_year_avg,
       ( 
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
       ) AS median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

--Subquery in 'FROM'
--stage only remote job before aggregating to determine the remote median salary per job

SELECT job_title_short, 
       MEDIAN(salary_year_avg) AS median_salary,
       (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE

       ) AS market_median_salary
FROM 
( 
    SELECT job_title_short, salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs

GROUP BY job_title_short
LIMIT 10;

--Subquery in 'HAVING' 
--Keep only job titles whose median salary > martket median salary

SELECT job_title_short, 
       MEDIAN(salary_year_avg) AS median_salary,
       (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE

       ) AS market_median_salary
FROM 
( 
    SELECT job_title_short, salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs

GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
    market_median_salary
)
ORDER BY median_salary DESC
LIMIT 10;

--CTEs
WITH  title_median AS(
    SELECT job_title_short,
           MEDIAN(salary_year_avg)::INT AS median_salary,
           job_work_from_home
    FROM job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY job_title_short,
            job_work_from_home
)

SELECT r.job_title_short,
       r.median_salary AS remote_median_salary,
       o.median_salary AS onsite_median_salary,
       (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r JOIN title_median AS o 
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC
;

--WHERE EXISTS/NOT EXISTS
SELECT *

FROM job_postings_fact AS jpf
WHERE EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd
    WHERE jpf.job_id = sjd.job_id
)
ORDER BY job_id ASC;