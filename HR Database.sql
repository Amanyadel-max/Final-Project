--الموظفين غير الراضين عن العمل
------
SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    p.JobSatisfaction, 
    p.EnvironmentSatisfaction, 
    p.WorkLifeBalance
FROM Employee e
JOIN [Performance Rating] p ON e.EmployeeID = p.EmployeeID
WHERE p.JobSatisfaction < 3 OR p.EnvironmentSatisfaction < 3 OR p.WorkLifeBalance < 3;
-------
--عدد الموظفين في كل قسم لمعرفة الأقسام التي لديها أكبر عدد من الموظفين

SELECT Department, COUNT(EmployeeID) AS EmployeeCount
FROM Employee
GROUP BY Department
ORDER BY EmployeeCount DESC;
-----
--معرفة الحد الأدنى والأقصى ومتوسط الرواتب لكل وظيفة
--تحويل نوع البيانات في العمود Salary إلى عدد صحيح (INT)

SELECT 
    CAST(Salary AS INT) AS Salary, 
    MIN(CAST(Salary AS INT)) AS MinSalary, 
    MAX(CAST(Salary AS INT)) AS MaxSalary, 
    AVG(CAST(Salary AS INT)) AS AvgSalary
FROM Employee
GROUP BY CAST(Salary AS INT)
ORDER BY AvgSalary DESC;
----
-- تحليل عدد الموظفين الذين يعملون ساعات إضافية مقابل الذين لا يعملون
SELECT OverTime, COUNT(EmployeeID) AS EmployeeCount,
       (COUNT(EmployeeID) * 100.0 / (SELECT COUNT(*) FROM Employee)) AS Percentage
FROM Employee
GROUP BY OverTime;
----
 --استخراج قائمة الموظفين الذين لم يحصلوا على ترقية منذ 5 سنوات أو أكثر

SELECT EmployeeID, FirstName, LastName, JobRole, YearsSinceLastPromotion
FROM Employee
WHERE YearsSinceLastPromotion >= 5
ORDER BY YearsSinceLastPromotion DESC;
----------
--تحليل نسبة الموظفين الذين استقالوا مقارنة بإجمالي عدد الموظفين
SELECT 
    (COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*)) AS AttritionRate
FROM Employee;

--------
----الموظفين الذين حصلوا على أعلى تقييم من المدير 
SELECT e.EmployeeID, e.FirstName, e.LastName, p.ManagerRating
FROM Employee e
JOIN [Performance Rating] p ON e.EmployeeID = p.EmployeeID
WHERE p.ManagerRating = 5
ORDER BY p.ManagerRating DESC;
------
 --تحليل عدد الفرص التدريبية التي حصل عليها الموظفون مقارنة بعدد الفرص المتاحة لهم
SELECT 
    SUM(CAST(TrainingOpportunitiesWithinYear AS INT)) AS TotalAvailableTraining,
    SUM(CAST(TrainingOpportunitiesTaken AS INT)) AS TotalTakenTraining,
    (SUM(CAST(TrainingOpportunitiesTaken AS FLOAT)) * 100.0 / NULLIF(SUM(CAST(TrainingOpportunitiesWithinYear AS FLOAT)), 0)) AS UtilizationRate
FROM [Performance Rating];
-------
