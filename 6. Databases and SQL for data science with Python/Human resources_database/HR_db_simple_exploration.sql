-- Exploring HR database in MySQL

USE hr; # selecting database hr to work with
SHOW TABLES; # Displaying all tables in the hr database  

-- ------------------------------------------------------
-- String Patterns
-- ------------------------------------------------------

-- you need to retrieve the first names F_NAME and last names L_NAME of all employees who live in Elgin, IL
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE ADDRESS LIKE '%Elgin,IL%'; # % sign is used both before and after the required text. 
-- This is to indicate, that the address string can have more characters, both before and after, the required text

-- Now assume that you want to identify the employees who were born during the 70s or 1970.
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE LIKE '197%';
-- Note: since the date of birth in Employees records starts with the birth year, 
-- the % sign is applied after 197%, indicating that the birth year can be anything between 1970 to 1979.

-- Let us retrieve all employee records in department 5 where salary is between 60000 and 70000.
SELECT * 
FROM employees
WHERE (salary BETWEEN 60000 and 70000) AND DEP_ID = 5; 

-- ------------------------------------------------------
-- Sorting
-- ------------------------------------------------------
-- Sorting is done using the ORDER BY clause in your SQL query. 
-- By default, the ORDER BY clause sorts the records in ascending order.

-- Please select first name, last name, and department id, and sort it based on department id
SELECT F_NAME, L_NAME, DEP_ID 
FROM EMPLOYEES
ORDER BY DEP_ID;

-- Now, get the output of the same query in descending order of department ID, and within each department, 
-- the records should be ordered in descending alphabetical order by last name.
SELECT F_NAME, L_NAME, DEP_ID 
FROM EMPLOYEES
ORDER BY DEP_ID DESC, L_NAME DESC;

-- ------------------------------------------------------
-- Grouping
-- ------------------------------------------------------

--  Retrieve the average salary for all employees in the EMPLOYEES table
SELECT AVG(salary) as average_salary
FROM employees;

-- Retrieve the number of employees in the department.
SELECT DEP_ID, COUNT(*) as employee_numbers
FROM EMPLOYEES
GROUP BY DEP_ID;

-- Now, for each department, retrieve the number of employees in the department 
-- and the average employee salary in the department.
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID;

-- Sort the previous result from the lowest to highest "avg salary"
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG_SALARY;

-- Limit the result to departments with fewer than 4 employees
SELECT DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING count(*) < 4
ORDER BY AVG_SALARY;

-- ------------------------------------------------------
-- Exercises
-- ------------------------------------------------------

-- 1. Retrieve the list of all employees, first and last names, 
-- whose first names start with ‘S’.
SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE F_NAME LIKE 'S%';

-- 2. Arrange all the records of the EMPLOYEES table in ascending order 
-- of the date of birth.
SELECT *
FROM EMPLOYEES
ORDER BY B_DATE;

-- 3. Group the records in terms of the department IDs and filter them of ones that have average salary more than or equal to 60000. 
-- Display the department ID and the average salary.
SELECT DEP_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000;

-- 4. For the problem above, sort the results for each group in descending order of average salary.
SELECT DEP_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000
ORDER BY AVG(SALARY) DESC;

-- Key lessons
-- Use string patterns for filtering the data retrieved.
-- Sort the data retrieved upon one or more parameters using ORDER BY statement.
-- Group the data with respect to a parameter.


