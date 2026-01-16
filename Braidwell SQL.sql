CREATE DATABASE HR_ANALYSIS;
SELECT * 
FROM hr_metrics;

-- Workforce Composition
-- Gender distribution across departments and job roles
SELECT Department, JobRole, Gender, COUNT(*) AS EmployeeCount
FROM hr_metrics
GROUP BY Department, JobRole, Gender
ORDER BY Department, JobRole;

-- Departments dominated by a particular gender
SELECT Department, Gender, COUNT(*) AS Count
FROM hr_metrics
GROUP BY Department, Gender
ORDER BY Department, Count DESC;

-- Salary Structure
-- Is there a gender pay gap?
SELECT Gender, AVG(MonthlyIncome) AS Avg_MonthlyIncome
FROM hr_metrics
GROUP BY Gender;

-- Are employees paid above the required minimum salary (₦9000)?
SELECT 
  CASE WHEN MonthlyIncome >= 9000 THEN 'Above Minimum' ELSE 'Below Minimum' END AS SalaryCategory,
  COUNT(*) AS EmployeeCount
FROM hr_metrics
GROUP BY SalaryCategory;

-- Salary distribution across 10,000 increments
SELECT 
  FLOOR(MonthlyIncome / 1000) * 1000 AS SalaryBand,
  COUNT(*) AS EmployeeCount
FROM hr_metrics
GROUP BY SalaryBand
ORDER BY SalaryBand;

-- Performance vs Pay
-- Are top performers being fairly compensated?
SELECT PerformanceRating, AVG(MonthlyIncome) AS AvgIncome
FROM hr_metrics
GROUP BY PerformanceRating
ORDER BY PerformanceRating DESC;

-- Do performance ratings align with years at company?
SELECT PerformanceRating, AVG(YearsAtCompany) AS AvgYearsAtCompany
FROM hr_metrics
GROUP BY PerformanceRating
ORDER BY PerformanceRating DESC;

-- Promotions & Opportunities
-- Who is being promoted more by gender and department?
SELECT Department, Gender, AVG(YearsSinceLastPromotion) AS AvgYearsSincePromotion
FROM hr_metrics
GROUP BY Department, Gender
ORDER BY Department;

-- Pattern in who gets promoted vs who doesn’t
SELECT 
  CASE WHEN YearsSinceLastPromotion = 0 THEN 'Recently Promoted' ELSE 'Not Recently Promoted' END AS PromotionStatus,
  Gender, Department, COUNT(*) AS Count
FROM hr_metrics
GROUP BY PromotionStatus, Gender, Department
ORDER BY PromotionStatus, Count DESC;

-- Attrition & Turnover
-- Which employees left the company and why?
SELECT Attrition, Department, Gender, JobRole, COUNT(*) AS Count
FROM hr_metrics
WHERE Attrition = 'Yes'
GROUP BY Attrition, Department, Gender, JobRole;

-- Patterns by department, gender, salary, or performance
SELECT Department, Gender, 
       AVG(MonthlyIncome) AS AvgIncome, 
       AVG(PerformanceRating) AS AvgPerformance, 
       COUNT(*) AS TotalLeft
FROM hr_metrics
WHERE Attrition = 'Yes'
GROUP BY Department, Gender
ORDER BY TotalLeft DESC;