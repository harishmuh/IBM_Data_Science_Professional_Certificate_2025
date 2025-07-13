-- Database exploration in the Petrescue table

-- Using the database 
 use mysql_learners;

-- displaying the tables on the database
SHOW TABLES;

-- Displaying the table of petrescue
SELECT * FROM PETRESCUE;

-- Learning: Aggregation Functions

-- 1. Write a query that calculates the total cost of all animal rescues in the PETRESCUE table.
SELECT SUM(COST) as total_costs FROM PETRESCUE;

-- 2. Write a query that displays the maximum quantity of animals rescued (of any kind).
SELECT MAX(QUANTITY) as maximum_qty FROM PETRESCUE;

-- 3. Write a query that displays the average cost of animals rescued.
SELECT AVG(COST) as average_cost FROM PETRESCUE;

-- Learning: Scalar Functions and String Functions

-- 1. Write a query that displays the rounded integral cost of each rescue.
SELECT ROUND(COST) as rounded_number FROM PETRESCUE; -- no decimal place
SELECT ROUND(COST, 2) as rounded_2decimals FROM PETRESCUE; -- 2 decimals place

-- 2. Write a query that displays the length of each animal name.
SELECT ANIMAL, LENGTH(ANIMAL) as character_length FROM PETRESCUE;

-- 3. Write a query that displays the animal name in each rescue in uppercase and lowercase
SELECT UCASE(ANIMAL) FROM PETRESCUE; -- uppercase
SELECT LCASE(ANIMAL) FROM PETRESCUE; -- lowercase

-- Learning: Date Functions

-- 1. Write a query that displays the rescue date.
SELECT DAY(RESCUEDATE) FROM PETRESCUE; -- display the day from the rescue date
SELECT MONTH(RESCUEDATE) FROM PETRESCUE; -- display the month from the rescue date
SELECT YEAR(RESCUEDATE) FROM PETRESCUE; -- display the year from the rescue date

-- 2. Animals rescued should see the vet within three days of arrival. 
-- Write a query that displays the third day after each rescue.
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE; -- Three days after
-- Write a query that displays the two months after each rescue.
SELECT DATE_ADD(RESCUEDATE, INTERVAL 2 MONTH) FROM PETRESCUE; -- Two months after
-- Write a query that displays the third day before each rescue.
SELECT DATE_SUB(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE; -- three days before
-- Write a query that displays the different between the current date and the rescue date
SELECT DATEDIFF(CURRENT_DATE, RESCUEDATE) FROM PETRESCUE; -- the date difference (in days)
SELECT FROM_DAYS(DATEDIFF(CURRENT_DATE, RESCUEDATE)) FROM PETRESCUE; -- the date difference (in YYYY-MM-DD)

-- More exercises
-- 1. Write a query that displays the average cost of rescuing a single dog. 
-- Note that the cost per dog would not be the same in different instances.
SELECT AVG(COST/QUANTITY) as average_cost_single_dog 
FROM PETRESCUE 
WHERE ANIMAL = 'Dog';

-- 2. Write a query that displays the animal name in each rescue in uppercase without duplications.
SELECT DISTINCT UCASE(ANIMAL) as ucase_unique
FROM PETRESCUE;

-- 3. Write a query that displays all the columns from the PETRESCUE table where the animal(s) rescued are cats. 
-- Use cat in lowercase in the query.
SELECT * FROM PETRESCUE WHERE LCASE(ANIMAL)="cat";

-- 4. Write a query that displays the number of rescues in the 5th month.
SELECT SUM(QUANTITY) FROM PETRESCUE WHERE MONTH(RESCUEDATE)="05";

-- 5. The rescue shelter is supposed to find good homes for all animals within 1 year of their rescue. 
-- Write a query that displays the ID and the target date.
SELECT ID, DATE_ADD(RESCUEDATE, INTERVAL 1 YEAR) FROM PETRESCUE;

-- Key learnings
-- Use aggregation functions to calculate total, maximum, minimum, and average values of numerical attributes.
-- Use scalar functions to round a floating value to the desired number of decimal places.
-- Use string functions to convert text into upper or lower cases.
-- Use date operations to manipulate data columns with the attribute as date.