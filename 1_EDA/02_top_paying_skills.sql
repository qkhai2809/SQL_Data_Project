/*
What are the highest-paying skills fro data engineer?
-Calculate median salary for each skill
-Focus on remote job
-Identify both salary and in-demand skills to show overview of this skills in the market
*/



SELECT sd.skills,
       COUNT(jpf.*) as skills_count,
       ROUND(MEDIAN(jpf.salary_year_avg), 1) as median_salary
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
  ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
  ON sjd.skill_id = sd.skill_id
WHERE 
 jpf.job_title_short = 'Data Engineer' 
AND jpf.job_work_from_home = 'True'
GROUP BY sd.skills
HAVING skills_count >= 100
ORDER BY median_salary DESC
LIMIT 25;


/*
-Rust is the most valuable skill with median salary ~210000, but it's only 232 job postings demand for this skill
-Terraform and Goland take top 2 and 3 perspectively with same 184K median salary
-Most of skills on the list require for a long time to get used to and learn so
those skills have a compensation which is higher than popular tools like SQL, Python or cloud platform like 
Azure and AWS. Beside, the number of demand in those skills also limited rather than in popular skills 
┌────────────┬──────────────┬───────────────┐
│   skills   │ skills_count │ median_salary │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ rust       │          232 │      210000.0 │
│ terraform  │         3248 │      184000.0 │
│ golang     │          912 │      184000.0 │
│ spring     │          364 │      175500.0 │
│ neo4j      │          277 │      170000.0 │
│ gdpr       │          582 │      169615.5 │
│ zoom       │          127 │      168437.5 │
│ graphql    │          445 │      167500.0 │
│ mongo      │          265 │      162250.0 │
│ fastapi    │          204 │      157500.0 │
│ django     │          265 │      155000.0 │
│ bitbucket  │          478 │      155000.0 │
│ crystal    │          129 │      154223.5 │
│ c          │          444 │      151500.0 │
│ atlassian  │          249 │      151500.0 │
│ typescript │          388 │      151000.0 │
│ kubernetes │         4202 │      150500.0 │
│ ruby       │          736 │      150000.0 │
│ node       │          179 │      150000.0 │
│ css        │          262 │      150000.0 │
│ airflow    │         9996 │      150000.0 │
│ redis      │          605 │      149000.0 │
│ vmware     │          136 │      148798.3 │
│ ansible    │          475 │      148798.3 │
│ jupyter    │          400 │      147500.0 │
└────────────┴──────────────┴───────────────┘
  25 rows                         3 columns
*/