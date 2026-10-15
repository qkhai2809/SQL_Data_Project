--EXTRACT
SELECT 
       EXTRACT(year FROM job_posted_date) AS year,
        EXTRACT(month FROM job_posted_date) AS month,
         
         COUNT(*) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY EXTRACT(year FROM job_posted_date),
        EXTRACT(month FROM job_posted_date)
ORDER BY year, month;
--DATE_TRUNC
SELECT 

        DATE_TRUNC('month', job_posted_date) AS job_posted_month,
      
        COUNT(*)
       
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer' AND  EXTRACT('year' FROM job_posted_date) = 2024
GROUP BY DATE_TRUNC('month', job_posted_date)
ORDER BY job_posted_month
LIMIT 10;

--AT TIME ZONE

SELECT 
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Ho_Chi_Minh') AS job_posted_hour,
    COUNT(*)
FROM job_postings_fact
WHERE job_location = 'New York, NY'
GROUP BY EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Ho_Chi_Minh')
ORDER BY job_posted_hour;
