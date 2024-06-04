--departments
-- Drop table if exists
DROP TABLE departments;
-- Create new table
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);
-- View table columns and datatypes
SELECT * FROM departments;


--dept_emp
-- Drop table if exists
DROP TABLE dept_emp;
-- Create new table
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	PRIMARY KEY (emp_no, dept_no)
);
-- View table columns and datatypes
SELECT * FROM dept_emp;


--dept_manager
-- Drop table if exists
DROP TABLE dept_manager;
-- Create new table
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY (dept_no, emp_no)
);
-- View table columns and datatypes
SELECT * FROM dept_manager;


--employees
-- Drop table if exists
DROP TABLE employees;
-- Create new table
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);
-- View table columns and datatypes
SELECT * FROM employees;


--salaries
-- Drop table if exists
DROP TABLE salaries;
-- Create new table
CREATE TABLE salaries (
	emp_no INT NOT NULL PRIMARY KEY,
	salary INT NOT NULL
);
-- View table columns and datatypes
SELECT * FROM salaries;


--titles
-- Drop table if exists
DROP TABLE titles;
-- Create new table
CREATE TABLE titles (
	title_id VARCHAR NOT NULL PRIMARY KEY,
	title VARCHAR NOT NULL
);
-- View table columns and datatypes
SELECT * FROM titles;



-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no)


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;


-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name 
FROM dept_manager m
JOIN departments d
ON (m.dept_no = d.dept_no)
	JOIN employees e
	ON (e.emp_no = m.emp_no)


-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON (de.emp_no = e.emp_no)
	JOIN departments d
	ON (de.dept_no = d.dept_no)

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT  e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules'
AND e.last_name LIKE 'B%'

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT de.emp_no, e.last_name, e.first_name
FROM dept_emp de
JOIN employees e
ON (de.emp_no = e.emp_no)
	JOIN departments d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales'

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON (de.emp_no = e.emp_no)
	JOIN departments d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development'

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY "count" DESC;