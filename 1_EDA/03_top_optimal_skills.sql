/*
Questions:
What are the most optimal skills for data engineers_balancing both demand and salary?
- Create a rank column that combines demand count and median salary to identify the most valuable skills
Focus on remote data engineer positions
*/
SELECT sd.skills,
      COUNT(jpf.*) as skill_count,
      ROUND(MEDIAN(jpf.salary_year_avg), 0) as median_salary,
      ROUND((LN(COUNT(jpf.*))*ROUND(MEDIAN(jpf.salary_year_avg), 0))/1_000_000, 2) AS optimal_skills,
      ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
  ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
  ON sjd.skill_id = sd.skill_id
WHERE 
 jpf.job_title_short = 'Data Engineer' 
AND jpf.job_work_from_home = 'True'
AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(jpf.*) >= 100
ORDER BY optimal_skills DESC
LIMIT 25;

/*
-Top 1 valuable skill to learn is terraform which has limited demands with 193 but this skill is really reward to acquire
to have competitive compensation in  data engineer with 184K in median salary
- The following skills are the fundamental tools like python and sql with over 2000 offers and over 130K each for salary
-The below ranks are dominant by cloud platform like aws, airflow and also data distribution tools like spark, snowflake or kafk
┌────────────┬─────────────┬───────────────┬────────────────┬─────────────────┐
│   skills   │ skill_count │ median_salary │ optimal_skills │ ln_demand_count │
│  varchar   │    int64    │    double     │     double     │     double      │
├────────────┼─────────────┼───────────────┼────────────────┼─────────────────┤
│ terraform  │         193 │      184000.0 │           0.97 │             5.3 │
│ python     │        1133 │      135000.0 │           0.95 │             7.0 │
│ sql        │        1128 │      130000.0 │           0.91 │             7.0 │
│ aws        │         783 │      137320.0 │           0.91 │             6.7 │
│ airflow    │         386 │      150000.0 │           0.89 │             6.0 │
│ spark      │         503 │      140000.0 │           0.87 │             6.2 │
│ snowflake  │         438 │      135500.0 │           0.82 │             6.1 │
│ kafka      │         292 │      145000.0 │           0.82 │             5.7 │
│ azure      │         475 │      128000.0 │           0.79 │             6.2 │
│ java       │         303 │      135000.0 │           0.77 │             5.7 │
│ scala      │         247 │      137290.0 │           0.76 │             5.5 │
│ git        │         208 │      140000.0 │           0.75 │             5.3 │
│ kubernetes │         147 │      150500.0 │           0.75 │             5.0 │
│ databricks │         266 │      132750.0 │           0.74 │             5.6 │
│ redshift   │         274 │      130000.0 │           0.73 │             5.6 │
│ gcp        │         196 │      136000.0 │           0.72 │             5.3 │
│ nosql      │         193 │      134415.0 │           0.71 │             5.3 │
│ hadoop     │         198 │      135000.0 │           0.71 │             5.3 │
│ pyspark    │         152 │      140000.0 │            0.7 │             5.0 │
│ docker     │         144 │      135000.0 │           0.67 │             5.0 │
│ mongodb    │         136 │      135750.0 │           0.67 │             4.9 │
│ r          │         133 │      134775.0 │           0.66 │             4.9 │
│ go         │         113 │      140000.0 │           0.66 │             4.7 │
│ github     │         127 │      135000.0 │           0.65 │             4.8 │
│ bigquery   │         123 │      135000.0 │           0.65 │             4.8 │
└────────────┴─────────────┴───────────────┴────────────────┴─────────────────┘
  25 rows                                                           5 columns
*/

