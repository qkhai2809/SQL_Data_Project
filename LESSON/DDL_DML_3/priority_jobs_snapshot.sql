--.read LESSON/DDL_DML_3/priority_jobs_snapshot.sql

--Create temp table

CREATE OR REPLACE TEMPORARY TABLE priority_jobs AS
SELECT  jpf.job_id,
        jpf.job_title_short,
        cd.name as company_name,
        jpf.job_posted_date,
        jpf.salary_year_avg,
        r.priority_lv,
        CURRENT_TIMESTAMP AS updated_at
FROM data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd 
ON jpf.company_id = cd.company_id
    INNER JOIN staging.priority_roles AS r
ON jpf.job_title_short = r.role_name;

-- --Update statement
-- UPDATE main.priority_jobs_snapshot AS tgt
-- SET priority_lv = src.priority_lv,
--     updated_at = src.updated_at
-- FROM priority_jobs AS src
-- WHERE tgt.job_id = src.job_id
--   AND tgt.priority_lv IS DISTINCT FROM src.priority_lv;

  

-- --Insert statement
-- INSERT INTO main.priority_jobs_snapshot(
--     job_id,
--     job_title_short,
--     company_name,
--     job_posted_date,
--     salary_year_avg,
--     priority_lv,
--     updated_at
-- )
-- SELECT src.job_id,
--     src.job_title_short,
--     src.company_name,
--     src.job_posted_date,
--     src.salary_year_avg,
--     src.priority_lv,
--     src.updated_at
-- FROM priority_jobs AS src
-- WHERE NOT EXISTS
-- (
--     SELECT 1
--     FROM main.priority_jobs_snapshot AS tgt
--     WHERE tgt.job_id = src.job_id
-- );


-- --DELETE statement
-- DELETE FROM main.priority_jobs_snapshot AS tgt
-- WHERE NOT EXISTS(
--     SELECT 1
--     FROM main.priority_jobs AS src
--     WHERE src.job_id = tgt.job_id
-- );

--MERGE INTO
MERGE INTO main.priority_jobs_snapshot AS tgt
USING priority_jobs AS src
ON tgt.job_id = src.job_id

WHEN MATCHED AND tgt.priority_lv IS DISTINCT FROM src.priority_lv THEN
     UPDATE SET
     priority_lv = src.priority_lv,
     updated_at = src.updated_at
WHEN NOT MATCHED THEN
    INSERT (
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lv,
    updated_at
    )
    VALUES( src.job_id,
    src.job_title_short,
    src.company_name,
    src.job_posted_date,
    src.salary_year_avg,
    src.priority_lv,
    src.updated_at
    )
   
   
WHEN NOT MATCHED BY SOURCE THEN DELETE;
  


--Check query
SELECT job_title_short,
       COUNT(*) AS job_count,
       MIN(priority_lv) AS priority_lv,
       MIN(updated_at) AS updated_at
FROM main.priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;