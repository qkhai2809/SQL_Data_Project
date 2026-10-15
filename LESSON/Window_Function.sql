SELECT job_title_short,
       MEDIAN(salary_year_avg) OVER()
FROM job_postings_fact

;

--PARTITION BY -Find hourly salary specific job_title_short


    SELECT job_id,
       job_title_short,
       salary_hour_avg,
       company_id,
       AVG(salary_hour_avg) OVER(PARTITION BY job_title_short, company_id) as avg_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 10;
--ORDER BY - Ranking hourly salary
SELECT job_id,
       job_title_short,
       salary_hour_avg,
        RANK() OVER(
                    ORDER BY salary_hour_avg DESC) as avg_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY avg_salary
LIMIT 50;


--PARTITION BY & ORDER BY -Running Average Hourly Salary
    SELECT job_posted_date,
       job_title_short,
       salary_hour_avg,
      
       AVG(salary_hour_avg) OVER(
        PARTITION BY job_title_short
        ORDER BY job_posted_date
         ) as running_avg_hourly_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY 
         job_title_short,
         job_posted_date
        
LIMIT 10;                                                     4 columns

-- ┌─────────────────────┬──────────────────┬───────────────────┬───────────────────────────┐
-- │   job_posted_date   │ job_title_short  │  salary_hour_avg  │ running_avg_hourly_salary │
-- │      timestamp      │     varchar      │      double       │          double           │
-- ├─────────────────────┼──────────────────┼───────────────────┼───────────────────────────┤
-- │ 2023-01-04 22:57:02 │ Business Analyst │              17.0 │                      17.0 │
-- │ 2023-01-04 23:44:05 │ Business Analyst │              20.0 │                      18.5 │
-- │ 2023-01-05 21:02:18 │ Business Analyst │              35.0 │                      24.0 │
-- │ 2023-01-06 19:02:18 │ Business Analyst │              26.0 │                      24.5 │
-- │ 2023-01-06 20:03:13 │ Business Analyst │              20.0 │                      23.6 │
-- │ 2023-01-09 22:02:50 │ Business Analyst │              30.0 │        24.666666666666668 │
-- │ 2023-01-10 23:19:18 │ Business Analyst │              30.0 │        25.428571428571427 │
-- │ 2023-01-12 17:01:24 │ Business Analyst │              70.0 │                      31.0 │
-- │ 2023-01-13 17:04:10 │ Business Analyst │ 25.98500061035156 │         30.44277784559462 │
-- │ 2023-01-15 19:00:18 │ Business Analyst │              27.0 │        30.098500061035157 │
-- └─────────────────────┴──────────────────┴───────────────────┴───────────────────────────┘
--   10 rows                                                                      4 columns

--RANK job_title_short by salary_hour_avg
 SELECT job_id,
       job_title_short,
       salary_hour_avg,
      
       PERCENT_RANK() OVER(
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC) AS avg_hourly_salary
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY 
         job_title_short,
        salary_hour_avg DESC
       
        
LIMIT 30;
--LAG()
SELECT job_title,
       company_id,
       job_posted_date,
       salary_year_avg,
       LAG(salary_year_avg) 
       OVER( PARTITION BY company_id
            ORDER BY job_posted_date) AS previous_salary,
       (salary_year_avg - LAG(salary_year_avg) OVER( PARTITION BY company_id
            ORDER BY job_posted_date)) AS salary_change
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY company_id,
        job_posted_date
LIMIT 50;
    