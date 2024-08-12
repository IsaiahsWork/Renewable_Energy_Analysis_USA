Introdduction

Due to the rise of renewable energy, I was wondering if the price of the avocado, depending on the varieties increased over time and if it has an impact on the total volume sold as well as the volume sold for three different PLU codes:
PLU4046: Hass small
PLU4225: Hass large
PLU4770: Hass extra large

I downloaded the data from the years 2015 to 2021 on the website
This research was built on using data retrieved from the [U.S. Energy Information Administration (EIA)]([https://www.eia.gov/opendata/]).


I then compiled them in one single sheet and cleaned the data, formatted the cells, and cleaned the region data as we had duplicates like “BaltimoreWashington” and “Baltimore/Washington” so I put all that in one single style. I then uploaded the dataset in my cluster on Databricks and started the analysis



🔍 SQL queries? Check them out here: project_sql folder

Background
Driven by a love for reserach and science.

Data hails from my SQL Course. It's packed with insights on job titles, salaries, locations, and essential skills.

The questions I wanted to answer through my queries were:
What states consume the most energy, specifically  renewable? (SQL, Power BI)
What states produce the most energy, specifically  renewable? (SQL, Power BI)
Rate of Regression of the production of Renewable Energy in America? (SQL, Python)
Rate of Regression of the consumption of Renewable Energy in America? (SQL, Python)

Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

SQL: The backbone of my analysis, allowing me to query the database and unearth critical insights.
PostgreSQL: The chosen database management system, ideal for handling the job posting data.
Visual Studio Code: My go-to for database management and executing SQL queries.
Git & GitHub: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

1. What states consume the most energy, specifically  renewable? (SQL, Power BI)
To identify the highest-paying roles, I filtered states by consumption and location, focusing on renewable energy. This query highlights the high paying opportunities in the field.

SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
Here's the breakdown of the top data analyst jobs in 2023:

Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.
Top Paying Roles Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results

2. What states produce the most energy, specifically  renewable? (SQL, Power BI)
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

SQL is leading with a bold count of 8.
Python follows closely with a bold count of 7.
Tableau is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.
Top Paying Skills Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results

3. Rate of Regression of the production of Renewable Energy in America? (SQL, Python)
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
Here's the breakdown of the most demanded skills for data analysts in 2023

SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.
Skills	Demand Count
SQL	7291
Excel	4611
Python	4330
Tableau	3745
Power BI	2609
Table of the demand for the top 5 skills in data analyst job postings

4. Rate of Regression of the production of Renewable Energy in America? (SQL, Python)
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
Here's a breakdown of the results for top paying skills for Data Analysts:

High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
Cloud Computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.
Skills	Average Salary ($)
pyspark	208,172
bitbucket	189,155
couchbase	160,515
watson	160,515
datarobot	155,486
gitlab	154,500
swift	153,750
jupyter	152,777
pandas	151,821
elasticsearch	145,000
Table of the average salary for the top 10 paying skills for data analysts

5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
Skill ID	Skills	Demand Count	Average Salary ($)
8	go	27	115,320
234	confluence	11	114,210
97	hadoop	22	113,193
80	snowflake	37	112,948
74	azure	34	111,225
77	bigquery	13	109,654
76	aws	32	108,317
4	java	17	106,906
194	ssis	12	106,683
233	jira	20	104,918
Table of the most optimal skills for data analyst sorted by salary

What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

🧩 Complex Query Crafting: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
📊 Data Aggregation: Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
💡 Analytical Wizardry: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.
Conclusions
Insights
From the analysis, several general insights emerged:


This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.