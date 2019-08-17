DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE "departments"(
	"dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
	)
);

SELECT * FROM departments;

CREATE TABLE "dept_emp" (
   "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

SELECT * FROM dept_emp;

CREATE TABLE "dept_manager"(
	"dept_no" VARCHAR NOT NULL,
	"emp_no" INT NOT NULL,
	"from_date" DATE NOT NULL,
	"to_date" DATE NOT NULL
	
);

SELECT * FROM dept_manager;

CREATE TABLE "employee"(
	"emp_no" INT NOT NULL,
	"birth_date" DATE NOT NULL,
	"first_name" VARCHAR NOT NULL,
	"last_name" VARCHAR NOT NULL,
	"gender" VARCHAR NOT NULL,
	"hire_date" DATE NOT NULL,
	CONSTRAINT pk_employee PRIMARY KEY (
	"emp_no"
	)
);

SELECT * FROM employee;

CREATE TABLE "salaries"(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

SELECT * FROM salaries;

CREATE TABLE titles(
	"emp_no" INT NOT NULL,
	"title" VARCHAR NOT NULL,
	"from_date" DATE NOT NULL,
	"to_date" DATE NOT NULL

);

SELECT * FROM titles;


--DATA ANALYSIS--

--Challenge #1
--List the details of each employee: employee number, last name, first name, gender, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employee e,
JOIN salaries s,
ON e.emp_no = s.emp_no;



--Challenge #2
--List employees who were hired in 1986 
SELECT hire_date,
FROM employee,
WHERE extract(year from hire_date) = '1986'; 


--Challenge #3
--List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates
SELECT m.dept_no, dept_name, m.emp_no, last_name, first_name, m.from_date, m.to_date
FROM dept_manager m,
JOIN departments on m.dept_no = departments.dept_no,
JOIN employee on m.emp_no = employee.emp_no;


--Challenge #4
--List the department of each employee with the following information: employee number, 
--last name, first name, and department name
SELECT e.emp_no, first_name, last_name, dept_name
FROM employee e,
JOIN dept_emp d,
ON e.emp_no = d.emp_no,
JOIN departments,
ON d.dept_no = departments.dept_no;


--Challenge #5
--List all employees whose first name is "Hercules" and last names begin with "B"
SELECT first_name, last_name
FROM employee e,
WHERE first_name lIKE 'Hercules',
AND last_name LIKE 'B%';


--Challenge #6
--List all employees in the Sales department, including their employee number, 
--last name, first name, and department name
SELECT e.emp_no, first_name, last_name, dept_name
FROM employee e
JOIN dept_emp d
ON e.emp_no = d.emp_no
JOIN departments
ON d.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';


--Challenge #7
--List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name
SELECT e.emp_no, last_name, first_name, dept_name
FROM employee e
JOIN dept_emp d
ON e.emp_no = d.emp_no
JOIN departments
ON d.dept_no = departments.dept_no
WHERE departments.dept_name ='Sales'
OR departments.dept_name = 'Development';


--Challenge #8
--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employee e
GROUP BY last_name
ORDER BY frequency DESC;
