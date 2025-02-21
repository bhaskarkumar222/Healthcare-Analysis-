# creating database
CREATE DATABASE healthcare;
USE healthcare;

# checking all columns
SELECT * FROM healthcare;


SELECT name , lower(name) FROM healthcare;

# updating name column to lower case
UPDATE healthcare
SET name =  lower(name);

SELECT * FROM healthcare;

-- Calculating Patients Hospitalized gender-wise from Maximum to Minimum
SELECT 	 gender, COUNT(*) AS total_patients
FROM 	 healthcare
GROUP BY gender;



-- Calculating Patients Hospitalized Age-wise from Maximum to Minimum
SELECT 	 age, COUNT(*) AS total_patients
FROM 	 healthcare
GROUP BY age
ORDER BY age;

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
        
SELECT * FROM healthcare;

-- total patients by blood type
SELECT 	 `blood type`,
		 COUNT(*) as total_patients
FROM 	 healthcare
GROUP BY `blood type`
ORDER BY total_patients DESC;
				-- The blood group with the highest number of patients is A-.



-- number of patients on the basis of medical condition 
SELECT `medical condition`  ,COUNT(*) AS total_patients
FROM  	healthcare
GROUP BY `medical condition`
ORDER BY total_patients DESC;
			-- The number of arthritis patients is the highest at 9,308, whereas the number of asthma patients is the lowest at 9,185.
            
            
            
-- What proportion of patients are classified as high-risk
SELECT 
		COUNT(*) AS High_Risk_Count,
		(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS High_Risk_Percentage
FROM 	healthcare
WHERE 	-- `Medical Condition` IN ('Heart Disease', 'Diabetes') 
 		`Test Results` = 'Abnormal';

select * from healthcare;



-- What are the outcomes of test results for each medical condition?
SELECT 	 `medical condition`, `test results`,
		  COUNT(*) AS total_patients
FROM 	  healthcare
GROUP BY  `medical condition`, `test results`;


-- How do Medical Condition rates vary seasonally?
WITH season AS (
				SELECT *,
						CASE 
							WHEN MONTH(`Date of Admission`) IN (12, 1, 2) THEN 'Winter'
							WHEN MONTH(`Date of Admission`) IN (3, 4, 5) THEN 'Spring'
							WHEN MONTH(`Date of Admission`) IN (6, 7, 8) THEN 'Summer'
							WHEN MONTH(`Date of Admission`) IN (9, 10, 11) THEN 'Fall'
						END AS 'Season'
				FROM healthcare)
SELECT 	Season,`Medical Condition`,  COUNT(*) AS total_patients,
		(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY Season)) AS Percentage
FROM 	season
GROUP BY `Medical Condition`,  Season;

-- Finding out most preffered Hospital
SELECT 	 hospital, COUNT(*) AS total_patients
FROM 	 healthcare
GROUP BY hospital
ORDER BY total_patients DESC
LIMIT 1;



-- List top 5 doctors who handle the most cases?
SELECT 	 doctor, COUNT(*) AS total_patients
FROM  	 healthcare
GROUP BY doctor
ORDER BY total_patients DESC
LIMIT 5;

-- What is the average treatment duration on the basis of Medical Condition?
SELECT `Medical Condition`, 
		ROUND(AVG(DATEDIFF(`discharge date`, `date of admission`))) as Avg_treatment_duration
FROM healthcare
GROUP BY `Medical Condition`;


SELECT * FROM healthcare;


-- How does patient volume vary day of the week?
SELECT 	 DAYNAME(`date of admission`) AS Day_Name, 
		 COUNT(*) AS Patient_Count
FROM 	 healthcare
GROUP BY Day_Name
ORDER BY FIELD(Day_Name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');


-- What is the average billing amount by hospital?
SELECT 	 hospital, ROUND(AVG(`billing amount`),2) AS avg_billing_amount
FROM 	 healthcare
GROUP BY hospital
ORDER BY hospital;


