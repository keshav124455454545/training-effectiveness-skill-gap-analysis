-- Data-Driven Training Effectiveness and Skill Gap Analysis
-- Academic/simulated data only; not confidential company operational data.
-- Import data/training_effectiveness_1500_records.csv into MySQL Workbench.
-- Suggested table name: training_effectiveness
-- If your import wizard changes column names, adjust identifiers accordingly.

-- 1. Inspect sample rows
SELECT * FROM training_effectiveness LIMIT 10;

-- 2. Overall KPIs
SELECT
  COUNT(*) AS total_learners,
  ROUND(AVG(Attendance_Percentage), 2) AS avg_attendance,
  ROUND(AVG(Assignment_Completion_Percentage), 2) AS avg_assignment_completion,
  ROUND(AVG(Final_Assessment), 2) AS avg_final_assessment,
  ROUND(AVG(Project_Score), 2) AS avg_project_score,
  ROUND(AVG(Technical_Skill_Average), 2) AS avg_technical_skill,
  ROUND(AVG(Readiness_Score), 2) AS avg_readiness
FROM training_effectiveness;

-- 3. Cohort-wise readiness
SELECT Cohort, COUNT(*) AS learner_count,
       ROUND(AVG(Readiness_Score), 2) AS avg_readiness
FROM training_effectiveness
GROUP BY Cohort
ORDER BY avg_readiness DESC;

-- 4. Technical skill averages
SELECT
  ROUND(AVG(Excel_Score), 2) AS excel_avg,
  ROUND(AVG(SQL_Score), 2) AS sql_avg,
  ROUND(AVG(Python_Score), 2) AS python_avg,
  ROUND(AVG(PowerBI_Score), 2) AS powerbi_avg,
  ROUND(AVG(Statistics_Score), 2) AS statistics_avg,
  ROUND(AVG(Data_Cleaning_Score), 2) AS data_cleaning_avg,
  ROUND(AVG(Data_Visualization_Score), 2) AS data_visualization_avg
FROM training_effectiveness;

-- 5. Performance band counts
SELECT Performance_Band, COUNT(*) AS learner_count
FROM training_effectiveness
GROUP BY Performance_Band
ORDER BY learner_count DESC;

-- 6. Training completion status
SELECT Training_Completion_Status, COUNT(*) AS learner_count
FROM training_effectiveness
GROUP BY Training_Completion_Status
ORDER BY learner_count DESC;

-- 7. Support requirement summary
SELECT Support_Required, COUNT(*) AS learner_count
FROM training_effectiveness
GROUP BY Support_Required;

-- 8. Skill-gap calculations (score scale assumed to be 0–100)
SELECT
  ROUND(100 - AVG(Excel_Score), 2) AS excel_gap,
  ROUND(100 - AVG(SQL_Score), 2) AS sql_gap,
  ROUND(100 - AVG(Python_Score), 2) AS python_gap,
  ROUND(100 - AVG(PowerBI_Score), 2) AS powerbi_gap,
  ROUND(100 - AVG(Statistics_Score), 2) AS statistics_gap,
  ROUND(100 - AVG(Data_Cleaning_Score), 2) AS data_cleaning_gap,
  ROUND(100 - AVG(Data_Visualization_Score), 2) AS data_visualization_gap
FROM training_effectiveness;
