USE employees;
SELECT * FROM employees;
SELECT DISTINCT(title) FROM titles;

DROP PROCEDURE IF EXISTS select_employees; 
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN

		SELECT * FROM employees
        LIMIT 1000; 
        
END $$ 

DROP PROCEDURE IF EXISTS average_salary()
DELIMITER $$
CREATE PROCEDURE average_salary()
BEGIN

		SELECT AVG(salary) FROM salaries
        LIMIT 1000;

END $$
