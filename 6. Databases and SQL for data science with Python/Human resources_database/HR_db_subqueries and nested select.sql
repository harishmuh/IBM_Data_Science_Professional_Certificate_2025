-- -----------------------------------------------
-- Sub-queries and Nested Selects in HR database

-- Accessing HR database
USE hr;
SHOW tables;
DESC EMPLOYEES;

-- Retrieve all employee records whose salary is lower than the average salary!
SELECT *
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

--  Execute a query that retrieves all employee records with EMP_ID, SALARY, and maximum salary as MAX_SALARY in every row.
SELECT 	EMP_ID, 
		SALARY, 
        (SELECT MAX(SALARY) FROM EMPLOYEES) AS MAX_SALARY 
FROM EMPLOYEES;

-- Extract the first and last names of the oldest employee
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE = (SELECT MIN(B_DATE) FROM EMPLOYEES); -- the oldest employee will be the one with the smallest date of birth

-- Query the average salary of the top 5 earners in the company.
SELECT AVG(SALARY) 
FROM (SELECT SALARY 
      FROM EMPLOYEES 
      ORDER BY SALARY DESC 
      LIMIT 5) AS SALARY_TABLE;
      
-- More exercises

-- 1. Write a query to find the average salary of the five least-earning employees.
-- steps: 
-- We need to order the data in ascending salary order and limit it to the top five entries, treating this as a derived table. 
-- Then, take the average of these entries.
-- Solutions:
SELECT AVG(SALARY) 
FROM (SELECT SALARY 
      FROM EMPLOYEES 
      ORDER BY SALARY 
      LIMIT 5) AS SALARY_TABLE;
      
-- 2. Write a query to find the records of employees older than the average age of all employees.

-- Steps: 
-- Age in years can be calculated as the year component in the difference between DOB and current date. 
-- We need to compare the age in years with average age in years. Then, the average age in years will be evaluated as a sub-query.
-- Solutions:
SELECT * 
FROM EMPLOYEES 
WHERE YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE,B_DATE))) > 
    (SELECT AVG(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE,B_DATE)))) 
    FROM EMPLOYEES);
    
-- 3. From the Job_History table, display the list of Employee IDs, years of service, and average years of service for all entries.

-- Steps:
-- For this, we need to calculate the years of service as a difference between the date of joining and the current date. 
-- Average years of service need to be queried separately to be displayed.

-- Solution:
SELECT EMPL_ID, YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, START_DATE))), 
    (SELECT AVG(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, START_DATE)))) 
    FROM JOB_HISTORY)
FROM JOB_HISTORY;

-- Key learnings
-- Write SQL queries that demonstrate the necessity of using sub-queries
-- Compose sub-queries in the WHERE clause
-- Build Column Expressions (for example, sub-query in place of a column)
-- Write Table Expressions (for example, sub-query in place of a table)

