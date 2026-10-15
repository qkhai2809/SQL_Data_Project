SELECT 
job_id::VARCHAR || '-' || company_id::VARCHAR AS unique_id,
job_work_from_home::INT AS job_work_from_home,
job_posted_date::DATE AS job_posted_date,
salary_year_avg::DEC(9,2) AS salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;