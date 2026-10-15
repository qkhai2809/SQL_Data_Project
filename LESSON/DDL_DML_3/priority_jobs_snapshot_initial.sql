--.read LESSON/DDL_DML_3/priority_jobs_snapshot_initial.sql
CREATE OR REPLACE TABLE main.priority_jobs_snapshot(
    job_id INTEGER PRIMARY KEY,
    job_title_short VARCHAR,
    company_name VARCHAR,
    job_posted_date TIMESTAMP,
    salary_year_avg DOUBLE,
    priority_lv INTEGER,
    updated_at TIMESTAMP
);

INSERT INTO main.priority_jobs_snapshot(
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lv,
    updated_at
 )

 SELECT jpf.job_id,
        jpf.job_title_short,
        cd.name as company_name,
        jpf.job_posted_date,
        jpf.salary_year_avg,
        r.priority_lv,
        CURRENT_TIMESTAMP
FROM data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd 
ON jpf.company_id = cd.company_id
    INNER JOIN staging.priority_roles AS r
ON jpf.job_title_short = r.role_name;

SELECT job_title_short,
       COUNT(*) AS job_count,
       MIN(priority_lv) AS priority_lv,
       MIN(updated_at) AS updated_at
FROM main.priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;

