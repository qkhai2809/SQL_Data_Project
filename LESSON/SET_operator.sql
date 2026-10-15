SELECT UNNEST([1, 1, 3, 3])
INTERSECT ALL
SELECT UNNEST([1, 1, 3]);

CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT('year' FROM job_posted_date) = 2023;

CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT('year' FROM job_posted_date) = 2024;

--Which unique job postings appeared in either 2023 or 2024?

SELECT *
FROM jobs_2023
UNION 
SELECT *
FROM jobs_2024;

--Which job postings appeared across both years, counting duplicates?

SELECT * FROM jobs_2023
UNION ALL
SELECT * FROM jobs_2024;

--Which job postings appeared in 2023 but not in 2024

SELECT * FROM jobs_2023
EXCEPT
SELECT * FROM jobs_2024;

--Which job postings from 2023 remain after substracting matching 2024 postings, one for one


SELECT * FROM jobs_2023
EXCEPT ALL
SELECT * FROM jobs_2024;

-- which job postings appeared in both 2023 and 2024?

SELECT * FROM jobs_2023
INTERSECT
SELECT * FROM jobs_2024;

--Which job postings in both years, remain duplicate counts?

SELECT * FROM jobs_2023
INTERSECT ALL
SELECT * FROM jobs_2024;