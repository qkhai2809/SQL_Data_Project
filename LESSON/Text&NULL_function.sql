SELECT LENGTH('Pham Quang Khai');

SELECT CHAR_LENGTH('Pham Quang Khai');

SELECT UPPER('Pham Quang Khai');

SELECT LOWER('Pham Quang Khai');

SELECT LEFT('Pham Quang Khai', 4);

SELECT RIGHT('Pham Quang Khai', 4);

SELECT SUBSTRING('Pham Quang Khai', 6, 5);

SELECT SUBSTRING('Pham Quang Khai', 1, 4) || '-' || SUBSTRING('Pham Quang Khai', 12, 4);

SELECT TRIM(' Pham Quang Khai ');

SELECT REPLACE('Pham Quang Khai', ' Quang', 'm');

--Final example to clean lower character
WITH title_lower AS(
    SELECT job_title,
    LOWER(TRIM(job_title)) AS lower_title
    FROM job_postings_fact
)


SELECT job_title,
    CASE
      WHEN lower_title LIKE '%analyst%' 
         AND lower_title LIKE '%data%' THEN 'Data Analyst'
      WHEN lower_title LIKE '%engineer%' 
         AND lower_title LIKE '%data%'THEN 'Data Engineer'
      WHEN lower_title LIKE '%scientist%'  
         AND lower_title LIKE '%data%'THEN 'Data Scientist'
      ELSE 'Other'
    END AS job_category,
FROM title_lower

ORDER BY RANDOM()
LIMIT 50;

--NULL FUNCTIONS
SELECT NULLIF(1+2999, 3000);

SELECT COALESCE(NULL, 1,2);


SELECT job_title_short,
salary_year_avg,
salary_hour_avg,
 ROUND(COALESCE(salary_year_avg, salary_hour_avg * 2080), 0) AS standardized_salary,
CASE 
WHEN ROUND(COALESCE(salary_year_avg, salary_hour_avg * 2080), 0) IS NULL THEN 'Missing'
WHEN ROUND(COALESCE(salary_year_avg, salary_hour_avg * 2080), 0) < 75000 THEN 'Low'
WHEN ROUND(COALESCE(salary_year_avg, salary_hour_avg * 2080), 0) > 150000 THEN 'Medium'
ELSE 'High'
END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC

;