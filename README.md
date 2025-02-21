# Healthcare Analysis

<img src="https://github.com/bhaskarkumar222/Healthcare-Analysis-/blob/f86282704d922c7e9e098a36bf19d251f7b34443/Healthcare%20Image.webp" alt="Sales Analysis Dashboard" width="1000" height="300"/>

## Project Overview
This project involves analyzing patient data using **SQL for data processing** and **Power BI for visualization** to derive insights into hospital admissions, medical conditions, and seasonal trends.

## Technologies Used
- **SQL** (Data Cleaning, Transformation, and Querying)
- **Power BI** (Data Visualization & Dashboarding)

## Situation
A healthcare provider needed a **data-driven approach** to monitor patient admissions, high-risk cases, billing trends, and seasonal patterns. The goal was to enhance decision-making for **better patient care and resource allocation**.

## Task
- clean and transform raw patient data.
- Create an interactive **Power BI dashboard** for real-time visualization.
- Identify key trends such as high-risk patient percentages, most common conditions, and seasonal impacts on hospital admissions.

## Action
**SQL**: Queried and structured the database to extract relevant patient data, including age groups, admission types, and seasonal trends.
- **Calculating Patients Hospitalized gender-wise from Maximum to Minimum.**
```sql
SELECT 	 gender, COUNT(*) AS total_patients
FROM     healthcare
GROUP BY gender;
```
- **Calculating Patients Hospitalized Age-wise from Maximum to Minimum.**
```sql
WITH age_group AS ( 
SELECT *, CASE WHEN age BETWEEN '1' AND '10' THEN '1-10' 
            WHEN age BETWEEN '11' AND '20' THEN '11-20'
            WHEN age BETWEEN '21' AND '30' THEN '21-30'
            WHEN age BETWEEN '31' AND '40' THEN '31-40'
            WHEN age BETWEEN '41' AND '50' THEN '41-50'
            WHEN age BETWEEN '51' AND '60' THEN '51-60'
            WHEN age BETWEEN '61' AND '70' THEN '61-70'
            WHEN age BETWEEN '71' AND '80' THEN '71-80'
            WHEN age BETWEEN '81' AND '90' THEN '81-90'
            ELSE '91-100'
		END AS age_group
FROM healthcare)
SELECT age_group , COUNT(*) AS total_patients
FROM age_group
GROUP BY age_group
ORDER BY age_group;
```
- **total patients by blood type.**
```sql
SELECT 	 `blood type`,
         COUNT(*) as total_patients
FROM     healthcare
GROUP BY `blood type`
ORDER BY total_patients DESC;
```
- **number of patients on the basis of medical condition.**
```sql
SELECT    `medical condition`  ,COUNT(*) AS total_patients
FROM      healthcare
GROUP BY `medical condition`
ORDER BY total_patients DESC;
```
- **What proportion of patients are classified as high-risk?**
```sql
SELECT 
      COUNT(*) AS High_Risk_Count,
      (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS High_Risk_Percentage
FROM 	healthcare
WHERE `Medical Condition` IN ('Heart Disease', 'Diabetes') 
 		`Test Results` = 'Abnormal';
```
- **How do Medical Condition rates vary seasonally?**
```sql
WITH season AS (
          SELECT *,
                  CASE WHEN MONTH(`Date of Admission`) IN (12, 1, 2) THEN 'Winter'
                       WHEN MONTH(`Date of Admission`) IN (3, 4, 5) THEN 'Spring'
                       WHEN MONTH(`Date of Admission`) IN (6, 7, 8) THEN 'Summer'
                       WHEN MONTH(`Date of Admission`) IN (9, 10, 11) THEN 'Fall'
                  END AS 'Season'
          FROM healthcare)
SELECT 	Season,`Medical Condition`,  COUNT(*) AS total_patients,
        (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY Season)) AS Percentage
FROM     season
GROUP BY `Medical Condition`,  Season;
```
- **How does patient volume vary day of the week?**
```sql
SELECT    DAYNAME(`date of admission`) AS Day_Name, 
          COUNT(*) AS Patient_Count
FROM      healthcare
GROUP BY Day_Name
ORDER BY FIELD(Day_Name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
```
- **What is the average treatment duration on the basis of Medical Condition?**
```sql
SELECT `Medical Condition`, 
        ROUND(AVG(DATEDIFF(`discharge date`, `date of admission`))) as Avg_treatment_duration
FROM    healthcare
GROUP BY `Medical Condition`;
```

**Power BI**: Developed a dashboard to present:
- Total Patients (56K)
- Average Billing Amount (25.54K)
- Most Common Medical Condition (Arthritis)
- High-Risk Patients Percentage (33.56%)
- Monthly and Seasonal Trends in Admissions
- Patient Distribution by Age Group, Admission Type, and Hospital
- Implemented slicers for gender, blood type, and years (2022-2024) for dynamic filtering.
### Dashboard Screenshot
<img src="https://github.com/bhaskarkumar222/Healthcare-Analysis-/blob/ae2cb94fa3c418389ab3e6cc29b71913b77cdce7/Dashboard%20Screenshort.png" alt="Sales Analysis Dashboard" width="1000" height="600"/>

## Result
- Provided real-time insights into patient demographics and seasonal patterns.
- Helped hospitals allocate resources effectively by understanding high-risk patient distribution.
- Enabled data-driven decision-making for healthcare management and planning.

## Final Conclusion
1️. **Patient Volume & Trends**
- The hospital has served **56K total patients**, with consistent **admissions throughout the year**.
- Monthly trends show fluctuations in patient intake, with peaks in certain months.

2️. **High-Risk Patients & Common Medical Conditions**
- **33.56% of patients** are classified as **high-risk**, requiring special medical attention.
- **Arthritis** is the **most common** medical condition, followed by asthma, cancer, and diabetes.

3. **Seasonal Impact on Healthcare**
- The **highest number** of patient admissions occurs in **Fall (27.93%) and Summer (27.03%)**, while **Winter (19.82%)** has the **lowest admissions**.
- Different medical conditions show seasonal variations, affecting hospital preparedness.

4️. **Admission & Billing Insights**
- Admissions are evenly distributed among Emergency (32.92%), Elective (33.61%), and Urgent (33.47%) cases.
- The **average billing amount** per patient is **$25.54K**, helping in financial forecasting.

5️. Hospital & Demographic Analysis
- Top hospitals handling most patients include LLC Smith and Ltd Smith.
- The **age group 31-70** has the **highest number of patients**, indicating a key demographic.




