-- create a join table
SELECT * FROM Absenteeism_at_work a
LEFT JOIN Reasons b
ON a.Reason_for_absence = b.Number
LEFT JOIN compensation c
ON a.ID = c.ID;

-- find the healthiest people at work
SELECT ID, body_mass_index FROM Absenteeism_at_work
WHERE social_drinker = 0 AND social_smoker=0 AND body_mass_index < 25 AND Absenteeism_time_in_hours < (select AVG(absenteeism_time_in_hours) from Absenteeism_at_work)

-- compensation rate increase for non-smokers | budget $983,221 so .68 increase/hour, $1414.4 per year
select count(*) as nonsmokers from Absenteeism_at_work
where Social_smoker = 0

-- optimize query
SELECT a.ID,
r.Reason, 
Month_of_absence, 
Body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	WHEN Body_mass_index between 18.5 and 24.9 then 'Healthy'
	WHEN Body_mass_index between 25 and 29.9 then 'Overweight'
	WHEN Body_mass_index > 30 then 'Obese'
	ELSE 'Unknown' end as BMI_Category,
CASE WHEN Month_of_absence IN (12, 1, 2) THEN 'Winter'
	WHEN Month_of_absence IN (3, 4, 5) THEN 'Spring'
	WHEN Month_of_absence IN (6, 7, 8) THEN 'Summer'
	WHEN Month_of_absence IN (9, 10, 11) THEN 'Fall'
	ELSE 'Unknown' end as Season,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Body_mass_index,
Day_of_the_week,
Distance_from_residence_to_work,
Service_time,
Age,
Work_load_Average_day,
Hit_target,
Disciplinary_failure,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Weight,
Height,
Absenteeism_time_in_hours
from Absenteeism_at_work a 
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number