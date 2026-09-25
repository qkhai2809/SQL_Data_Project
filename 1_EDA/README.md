# EXPLORATORY Data Analyst by SQL: Job Market Analysis  
![Project Overview](../EDA_images\images.png)

A project using SQL to analyze real world job postings related to data engineer remote job by measuring a factors like in-demand skills, median salary in every skill and what are the optimal skills based on these. It demonstrate my ability to show my skill at analyzing data from database, using sql skill and identify key insight in for business from real data in recruitment platform.
## Executive Summary  
- **Project scope**: Built **3 main analytical queries** to answer questions about the data engineer job market.
- **Data modeling**: Used **multiple table join** between fact and demension tables to extract insight.
- **Analytics**: Applied **aggregation, filtering and sorting** to find top skill demand, high paying skill and what are actually the optimal skills.
- **Outcome**: Delivered **actional insights** on trends, salary, demands of different skills for data engineer 

1. [01_top_demanded_skills.sql](01_top_demanded_skills.sql)  
2. [02_top_paying_skills.sql](02_top_paying_skills.sql)
3. [03_top_optimal_skills.sql](03_top_optimal_skills.sql)
## Problem & Content  
- **Most in-demand skills**: What the most demand-skills in data engineer?
- **High compensation for skill**: What top skills which is prioritized a high salary?
- **Optimal skills**: What are actually the skill that people should learn to become a data engineer with better career path?
his project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:
![Data warehouse](../EDA_images\1_2_Data_Warehouse.png)
- Fact table: `job_postings_fact`- Central table with columns like job_id, company_id, job_title, job_title_short, locations, salaries, date, etc.
- **Dimension Tables:**  
  - `copany_dim`: showing information company like company_id, name, link
  - `skills_dim`:  including information about skills equivalent to job postings like skill_id, skill name and type of skill
- **Bridge Tables:** `skill_job_dim` is bridge between tables like `job_postings_fact`, `company_dim`, `skills_dim`. It help optimizing queries 

## Tech Stack
- **Query Engine**: DuckDB for fast OLAP to process data and show insights
- **Language**: SQL  
- **Data model**: Star schema with fact + dimension tables + fact tables  
- **Development**: VScode for SQL editing + Gitbash terminal for DuckDB CLI
- **Version Control**: Git/Github for versioned SQL scripts

## Analysis Overview
- **Core language**: Fundamental skills like SQL and Python still have a large demand with ~29000 job offers   
- **Cloud platform**: Ranks of cloud platforms like AWS and Azure demonstrate needs of them in data engineer, so this platform still play an essential role  
- **Infra & tools**: Kubernet, Docker and Terraform though have less demand but they have competitive compensation for people who are specialize in them
- **Big data**: Apache Spark is an indispensable part of distributing big data, so it show a not less number of offers

## SQL Skills Demonstrated
### Query Design & Optimization

- **Complex Joins**: Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping**: `GROUP BY` for categorical analysis by skill
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics**: Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause**: Filtering aggregated results (skills with >= 100 postings)
- **NULL Handling**: Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)