-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
SELECT * FROM departments;

CREATE TABLE employees (
	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
SELECT * FROM employees;
DROP TABLE employees CASCADE;

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
SELECT * FROM dept_manager;

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  PRIMARY KEY (emp_no)
);
DROP TABLE salaries CASCADE;
SELECT * FROM salaries; 

CREATE TABLE dept_emp (
emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
PRIMARY KEY (emp_no, dept_no)
);
DROP TABLE dept_emp CASCADE; 

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no, title, from_date),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
SELECT * FROM titles;
DROP TABLE titles CASCADE;

SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;
Select * FROM titles;
SELECT * FROM salaries;
SELECT * FROM dept_emp;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1/1/52' AND '12/31/55';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1/1/52' AND '12/31/52';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1/1/53' AND '12/31/53';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1/1/54' AND '12/31/54';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1/1/55' AND '12/31/55'

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1/1/52' AND '12/31/55')
AND (hire_date BETWEEN '1/1/85' AND '12/31/88');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1/1/52' AND '12/31/55')
AND (hire_date BETWEEN '1/1/85' AND '12/31/88');
	 
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1/1/52' AND '12/31/55')
AND (hire_date BETWEEN '1/1/85' AND '12/31/88');
	 
SELECT * FROM retirement_info;	 

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1/1/52' AND '12/31/55')
AND (hire_date BETWEEN '1/1/85' AND '12/31/88');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables (cleaning up code)
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('1/1/99');
SELECT * FROM current_emp;
DROP TABLE current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1/1/52' AND '12/31/55')
AND (hire_date BETWEEN '1/1/85' AND '12/31/88');
SELECT * FROM retirement_info;

SELECT emp_no,
    first_name,
last_name,
    gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1/1/52' AND '12/31/55')
AND (hire_date BETWEEN '1/1/85' AND '12/31/88');
DROP TABLE emp_info;
SELECT * FROM emp_info;

SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1/1/52' AND '12/31/55') 	  
     AND (e.hire_date BETWEEN '1/1/85' AND '12/31/88')
	 AND (de.to_date = '1/1/99');
DROP TABLE emp_info;
SELECT * FROM emp_info;
SELECT * FROM employees;

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- skill drill - info for sales and marketing
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
INTO sales_mkt_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS dpt
ON (de.dept_no = dpt.dept_no)
WHERE dept_name IN ('Sales', 'Development');
SELECT * FROM sales_mkt_info;




-- Deliverable 1: The Number of Retiring Employees by Title
-- creating Retirement Titles table
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1/1/52' AND '12/31/55')
ORDER BY e.emp_no ASC, to_date DESC;
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no ASC, to_date DESC;
SELECT * FROM unique_titles;

-- number of employees by their most recent job title about to retire
SELECT COUNT(ut.emp_no),
ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;
DROP TABLE retiring_titles; 
SELECT * FROM retiring_titles;


-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- creating Mentorship Eligibility Table
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    ti.title
INTO mentorship_eligibilty
FROM employees as e
LEFT OUTER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT OUTER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '1/1/99') AND
	(e.birth_date BETWEEN '1/1/65' AND '12/31/65')
ORDER BY e.emp_no;
SELECT * FROM mentorship_eligibilty; 


WHERE (e.birth_date BETWEEN '1/1/65' AND '12/31/65')
AND (de.to_date = '12/31/99')
ORDER BY e.emp_no ASC;
DROP TABLE mentorship_eligibilty;
SELECT * FROM mentorship_eligibilty;



-- Additional query
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
    employees.first_name,
    employees.last_name,
    titles.title,
    titles.from_date,
    titles.to_date
INTO all_employees
FROM employees
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
ORDER BY employees.emp_no, titles.to_date DESC;
SELECT * FROM all_employees;

-- Total Employees
SELECT COUNT (emp_no)
FROM employees;

-- Mentorship condidates by title
SELECT COUNT(title),title
FROM mentorship_eligibilty as me
GROUP BY title