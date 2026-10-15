-- salary_hour_avg <25 -> 'Low'
--                 <50 -> 'Medium'
--                 >50 -> 'High'
--                 IS NULL -> 'Missing'


SELECT job_title_short,
       salary_hour_avg,
       CASE
          WHEN salary_hour_avg IS NULL THEN 'Missing'
          WHEN salary_hour_avg < 25 THEN 'Low'
          WHEN salary_hour_avg < 50 THEN 'Medium'
          ELSE 'High'
        END AS salary_category
FROM job_postings_fact
LIMIT 10;

--Classify job_title column values as:
-- Data Analyst
-- Data Engineer
-- Data Scientist

SELECT job_title,
    CASE
      WHEN job_title LIKE '%Analyst%' AND job_title LIKE '%Data%' THEN 'Data Analyst'
      WHEN job_title LIKE '%Engineer%'  AND job_title LIKE '%Data%'THEN 'Data Engineer'
      WHEN job_title LIKE '%Scientist%'  AND job_title LIKE '%Data%'THEN 'Data Scientist'
      ELSE 'Other'
    END AS job_category,
    job_title_short,
    job_title
FROM job_postings_fact
WHERE job_title IS NOT NULL
ORDER BY RANDOM()
LIMIT 10;

--Conditional Aggregation
-- Calculate Median Salaries for Different Buckets
  -- < $100K
  -- >= $100K

SELECT job_title_short,
       COUNT(*) AS total_postings,
       MEDIAN(
        CASE 
           WHEN salary_year_avg < 100_000 THEN salary_year_avg
        END
       ) AS median_low_salary,
        MEDIAN(
        CASE 
           WHEN salary_year_avg >= 100_000 THEN salary_year_avg
        END
       ) AS median_high_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short

LIMIT 10;

--Category salary from standardized_salary

WITH salaries AS (SELECT job_title_short,
       salary_hour_avg,
       salary_year_avg,
       CASE 
         WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
         WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
       END AS standardized_salary
FROM job_postings_fact

)

SELECT *,
       CASE
       WHEN standardized_salary IS NULL THEN 'Missing'
        WHEN standardized_salary < 75_000 THEN 'Low' 
        WHEN standardized_salary < 150_000 THEN 'Medium'
       ELSE 'High'
        END AS category_salary
FROM salaries
WHERE standardized_salary IS NULL
LIMIT 10;