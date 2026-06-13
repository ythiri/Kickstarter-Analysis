/*
========================================
Project: Kickstarter Analysis
Script Type: Supporting Queries (Exploration, Testing & Validation)
Author: Yoon Thiri
Initials: YT
Date: 2026-06-08
========================================
*/


/*
This SQL script contains supporting queries used to develop and validate
the main queries in the "ks_projects_main_YoonThiri" script file.

These queries were used for data exploration, testing, and verification
during the query development process.
*/


DESCRIBE ks_projects;

SELECT
	COUNT(*) AS total_rows,
    COUNT(DISTINCT id) AS unique_projects
FROM ks_projects;


/*
Analysis 1: Project-level dataset with cleaned fields and derived metrics
for individual Kickstarter projects.
*/

-- Counts projects where the currency is USD.
-- Filters dataset to USD-only projects.
SELECT COUNT(*) AS usd_projects
FROM ks_projects
WHERE currency = 'USD';


-- Selects the required columns for the analysis.
SELECT 
	id, 
    name,
    main_category,
    goal,
    pledged,
    backers
FROM ks_projects
WHERE currency = 'USD';


-- Extracts the date, year, and month components from the 'launched' and 'deadline' columns.
-- Note: These date functions are MySQL-specific and may not be supported in other DBMS.
SELECT 
	DATE(launched) AS launched_date,
    YEAR(launched) AS launched_year,
    MONTHNAME(launched) AS launched_month,
    
    DATE(deadline) AS deadline_date,
	YEAR(deadline) AS deadline_year,
    MONTHNAME(deadline) AS deadline_month
FROM ks_projects
WHERE currency = 'USD';


-- Adds a new column that calculates the duration of each campaign in whole days.
SELECT DATEDIFF(deadline, launched) AS campaign_duration_days
FROM ks_projects
WHERE currency = 'USD';


-- Adds a new column that calculates dollars pledged per backer.
-- NULL values occur when the number of backers is zero.
SELECT ROUND (pledged / backers, 2) AS pledged_per_backer
FROM ks_projects
WHERE currency = 'USD';


-- Adds a new column that calculates pledged as a percentage of the goal.
SELECT ROUND((pledged / goal) * 100, 2) AS goal_achievement_pct
FROM ks_projects
WHERE currency = 'USD';


-- Categorizes projects based on their goal size.
SELECT 
	CASE
		WHEN goal >= 20000 THEN 'Extra Large'
        WHEN goal < 20000 AND goal >= 10000 THEN 'Large'
        WHEN goal < 10000 AND goal >= 5000 THEN 'Medium'
		WHEN goal < 5000 AND goal >= 2000 THEN 'Small'
		WHEN goal < 2000 THEN 'Extra Small'
	END AS project_goal_size
FROM ks_projects
WHERE currency = 'USD';


-- Reclassifies the 'state' column into 'Successful' or 'Failed' based on pledged vs goal amounts.
SELECT 
    CASE 
		WHEN pledged / goal >= 1 THEN 'Successful'
		ELSE 'Failed'
	END AS project_status
FROM ks_projects
WHERE currency = 'USD';


-- Categorizes projects into funding performance levels using the pledged-to-goal ratio.
SELECT 
	CASE
		WHEN pledged / goal >= 1.10 THEN 'Exceeded Goal'
        WHEN pledged / goal < 1.10 AND pledged / goal >= 1 THEN 'Goal Achieved'
        WHEN pledged / goal < 1 AND pledged / goal >= 0.75 THEN 'Near Goal'
        WHEN pledged / goal < 0.75 AND pledged / goal >= 0.50 THEN 'Below Goal'
        WHEN pledged / goal < 0.50 THEN 'Far Below Goal'
	END AS goal_achievement_status
FROM ks_projects
WHERE currency = 'USD';


/*
Analysis 2: Main category-level summary statistics and performance metrics.
*/

-- Aggregates projects by main category and counts total projects.
SELECT 
	main_category, 
    COUNT(*) AS total_projects
FROM ks_projects
WHERE currency = 'USD'
GROUP BY main_category;


-- Calculates the average goal and pledged amounts per main category.
SELECT 
	ROUND(AVG(goal), 2) AS avg_goal,
    ROUND(AVG(pledged), 2) AS avg_pledged
FROM ks_projects
WHERE currency = 'USD'
GROUP BY main_category;


-- Calculates total pledged as a percentage of total goal for each main category.
SELECT 
	ROUND((SUM(pledged) / SUM(goal)) * 100, 2) AS category_goal_achievement_pct
FROM ks_projects
WHERE currency = 'USD'
GROUP BY main_category;


-- Computes success rate (percentage of projects meeting or exceeding goal) per main category.
-- Sorts results by success rate in descending order.
SELECT 
	ROUND(
        AVG(
            CASE
                WHEN pledged / goal >= 1 THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS success_rate_pct
FROM ks_projects
WHERE currency = 'USD'
GROUP BY main_category
ORDER BY success_rate_pct DESC;


/*
Convert the main queries in the "ks_projects" script file into reusable views.
These views store query logic as virtual tables for easier reuse and structured analysis.

CREATE VIEW <view_name_1> AS ...
CREATE VIEW <view_name_2> AS ...

Note: Views do not store data themselves.
Views always reflect the current state of the underlying dataset.
The resulting views can then be exported as CSV files.
*/

