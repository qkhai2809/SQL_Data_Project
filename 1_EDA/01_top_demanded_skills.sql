/*
Key Question: What are the most in-demand skills for Data Engineer
- Identify top 10 in-demand skills of Data Engineer based on job postings via Linkin,BeBee, Indeed,...
- Also this job which contains these skills require remote job


*/
SELECT sd.skills,
       COUNT(jpf.*) as count_skills
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
   ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
   ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_work_from_home
GROUP BY sd.skills
ORDER BY count_skills DESC
LIMIT 10;


/*
SQL and Python are dominant in job demand with around 29,000 job postings each. 
There is a following cloud platform which is aws and azure with from ~14000 to ~17000 
job postings for those skills. 
Apache Spark take top 5 position with around 12799 demands from recruiters
┌────────────┬──────────────┐
│   skills   │ count_skills │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns

*/