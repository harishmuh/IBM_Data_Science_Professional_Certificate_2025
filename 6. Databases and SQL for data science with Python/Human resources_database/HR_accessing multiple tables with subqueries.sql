-- -----------------------------------------------
-- Accessing multiple tables with sub-queries in HR database

-- Accessing HR database
USE hr;
SHOW tables;

-- 1. Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID IN 
	(SELECT JOB_IDENT FROM JOBS);
    
-- 2. Retrieve JOB information for employees earning over $70,000.
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT
FROM JOBS
WHERE JOB_IDENT IN 
	(select JOB_ID from EMPLOYEES where SALARY > 70000 );
    
-- -----------------------------------------------
-- Accessing multiple tables with implicit joins in HR database

-- 1. Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
SELECT *
FROM EMPLOYEES, JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

-- 2. Redo the previous query using shorter aliases for table names.
SELECT *
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- 3. In the previous query, retrieve only the Employee ID, Name, and Job Title.
SELECT EMP_ID,F_NAME,L_NAME, JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- 4. Redo the previous query, but specify the fully qualified column names with aliases in the SELECT clause.
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT;

-- More exercises

-- 1. Retrieve only the list of employees whose JOB_TITLE is Jr. Designer.

-- With sub-queries
SELECT *
FROM EMPLOYEES
WHERE JOB_ID IN (SELECT JOB_IDENT
                 FROM JOBS
                 WHERE JOB_TITLE= 'Jr. Designer');
                 
-- With implicit joins
SELECT *
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT AND J.JOB_TITLE= 'Jr. Designer';

-- 2. Retrieve JOB information and a list of employees whose birth year is after 1976.

-- With sub-queries
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, JOB_IDENT
FROM JOBS
WHERE JOB_IDENT IN (SELECT JOB_ID
                    FROM EMPLOYEES
                    WHERE YEAR(B_DATE)>1976 );
                    
-- With implicit join
SELECT J.JOB_TITLE, J.MIN_SALARY, J.MAX_SALARY, J.JOB_IDENT
FROM JOBS J, EMPLOYEES E
WHERE E.JOB_ID = J.JOB_IDENT AND YEAR(E.B_DATE)>1976;

-- Key learnings
-- We can Write SQL queries that access more than one table
-- Compose queries that access multiple tables using a nested statement in the WHERE clause
-- Build queries with multiple tables in the FROM clause
-- Write Implicit Join queries with join criteria specified in the WHERE clause
-- Specify aliases for table names and qualify column names with table aliases

