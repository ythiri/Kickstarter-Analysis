# Kickstarter Analysis

## Executive Summary

To understand the factors that influence the outcomes of Kickstarter campaigns, SQL and Tableau were used to conduct exploratory data analysis and develop visualizations that generate actionable insights. The analysis found that shorter campaign durations and smaller funding goal sizes are associated with higher success rates. Based on these findings, the following key considerations are recommended when developing a Kickstarter campaign:

- Shorter campaign durations, particularly in the 1–15 day range  
- Adequate funding targets that balance feasibility with project requirements  
- Category-level analysis for deeper insights  

## Business Problem

Kickstarter is a crowdfunding platform for individuals, small businesses, and early-stage startups that helps raise capital for projects and innovative ideas. The platform, however, uses what is known as an “all-or-nothing” funding model. Under this model, individuals and businesses only receive funds if their funding goal is met or exceeded. In other words, there are only two possible outcomes: a campaign either reaches its funding goal and receives the pledged amount (success) or it receives no funding at all (failure). Given these outcomes, an important question arises: what factors contribute to the success or failure of Kickstarter campaigns?

## Methodology

- SQL queries were used to extract, clean, and transform the data from the original Kaggle dataset.  
- Tableau dashboards were then built using the SQL outputs to conduct exploratory data analysis, develop visualizations, and generate insights and recommendations.  

## Skills

- SQL: Data cleaning, data filtering, data transformation, conditional logic, and aggregate functions  
- Tableau: Data visualization, dashboard design, calculated fields, distribution analysis, KPI tracking, and performance analysis  

## Insights & Recommendations

There is no significant difference in success rates across the 12 months in which campaigns were launched. July has the lowest success rate at 34%, while March has the highest at 40%, reflecting a narrow spread in outcomes across months.  

The amount contributed by backers does not appear to strongly correlate with campaign success or failure. Campaigns in the “goal achieved” and “exceeded goal” categories had a lower average pledged per backer compared to campaigns in the “below goal” and “near goal” categories.  

Consider shorter campaign durations. The 1–15 day range demonstrates the highest success rate at approximately 48%. This duration range also shows the highest proportion of campaigns that exceed their funding goals. Therefore, setting shorter campaign timelines may be more effective in improving the likelihood of reaching or surpassing funding targets. 

<img width="524" height="377" alt="YoonThiriKickstarterCampaignDuration" src="https://github.com/user-attachments/assets/cf4fe99c-3823-4fa8-8200-ad4c2230b69c" />



Set appropriate funding goals that balance achievability with project requirements. Smaller funding goals account for a larger proportion of campaigns that meet or exceed their targets. However, larger campaigns are still attainable, as campaigns with funding goals of $20,000 or more represent 13.84% of projects that achieve at least 150% of their goal. Therefore, funding goals should be set at a level that is realistic to achieve while still being sufficient to cover project needs and fulfill commitments to backers.  

<img width="394" height="293" alt="image" src="https://github.com/user-attachments/assets/cf73f522-9fb5-4840-a160-d1d5b654e8e4" />


Compare the campaigns against main category benchmarks using KPIs and performance metrics. Category performance varies significantly, and no single category consistently dominates across all metrics.  

## Next Steps

Since this project is primarily an exploratory analysis and does not focus on a single target Kickstarter campaign, minimal filtering and sorting were applied during the analysis. As a result, the transformed dataset includes a wide range of projects with varying characteristics, some of which may not be directly relevant to specific use cases. This can impact the precision and contextual relevance of certain results. The next steps are as follows:

- Define a target campaign or project while accounting for key factors influencing campaign outcomes  
- Apply more targeted filtering and sorting to refine the analysis  
- Perform category-level analysis for deeper insights

---
Created by Yoon Thiri
