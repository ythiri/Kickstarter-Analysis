/*
========================================
Project: Kickstarter Analysis
Script Type: Main Analysis Queries (Final Transformed Dataset)
Author: Yoon Thiri
Initials: YT
Date: 2026-06-08
========================================
*/


/*
Convert id to BIGINT, enforce NOT NULL, and set as the primary key.
This ensures each Kickstarter project has a unique identifier.

ALTER TABLE ks_projects
MODIFY id BIGINT NOT NULL;

ALTER TABLE ks_projects
ADD PRIMARY KEY (id);
*/


/*
Rename the column 'usd pledged' to 'usd_pledged'.

ALTER TABLE ks_projects
RENAME COLUMN `usd pledged` TO usd_pledged;
*/


/*
Analysis 1: Project-level dataset with cleaned fields and derived metrics
for individual Kickstarter projects.
*/
CREATE VIEW ks_projects_yt AS
SELECT 
	id, 
    name,
    main_category,
	goal,
    pledged,
    backers,
    
	DATE(launched) AS launched_date,
    YEAR(launched) AS launched_year,
    MONTHNAME(launched) AS launched_month,
    
    DATE(deadline) AS deadline_date,
	YEAR(deadline) AS deadline_year,
    MONTHNAME(deadline) AS deadline_month,
    
	DATEDIFF(deadline, launched) AS campaign_duration_days,
    
    ROUND (pledged / backers, 2) AS pledged_per_backer,
	ROUND((pledged / goal) * 100, 2) AS goal_achievement_pct,
    
	CASE
		WHEN goal >= 20000 THEN 'Extra Large'
        WHEN goal < 20000 AND goal >= 10000 THEN 'Large'
        WHEN goal < 10000 AND goal >= 5000 THEN 'Medium'
		WHEN goal < 5000 AND goal >= 2000 THEN 'Small'
		WHEN goal < 2000 THEN 'Extra Small'
	END AS project_goal_size,
    
	CASE 
		WHEN pledged / goal >= 1 THEN 'Successful'
		ELSE 'Failed'
	END AS project_status,
	
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
CREATE VIEW ks_category_yt AS
SELECT 
	main_category, 
    COUNT(*) AS total_projects,
    ROUND(AVG(goal), 2) AS avg_goal,
    ROUND(AVG(pledged), 2) AS avg_pledged, 
    ROUND((SUM(pledged) / SUM(goal)) * 100, 2) AS category_goal_achievement_pct,
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

