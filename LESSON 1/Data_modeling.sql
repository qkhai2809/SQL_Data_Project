SELECT job_id, job_title_short, salary_year_avg, company_id
FROM job_postings_fact
LIMIT 20;

SELECT *
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';

SELECT *
FROM(DESCRIBE job_postings_fact);

SELECT jpf.job_id,jpf.job_title_short,
       cd.company_id,
       cd.name as company_name,
       jpf.job_location
FROM job_postings_fact as jpf 

INNER JOIN 
company_dim AS cd 
ON jpf.company_id = cd.company_id;

SELECT COUNT(*) 
FROM job_postings_fact as jpf 
INNER JOIN skills_job_dim AS sjd 
ON jpf.job_id = sjd.job_id 
 INNER JOIN skills_dim as sd 
ON sjd.skill_id = sd.skill_id
-- Select top 10 company has greater than 3000 job_postings

EXPLAIN ANALYZE
SELECT 
       cd.name as company_name,
      
       COUNT(jpf.*) AS posting_count
FROM job_postings_fact as jpf 
LEFT JOIN company_dim as cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING posting_count >= 3000
ORDER BY posting_count DESC
LIMIT 10;
