CREATE TABLE titles(
	title_id VARCHAR(40),
	title varchar(20),
	PRIMARY KEY (title_id) 
);

CREATE TABLE employees(
	emp_no int NOT NULL,
	emp_title_id VARCHAR(40) NOT NULL,
	birth_date date,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	sex varchar(1) NOT NULL,
	hire_date date NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);


CREATE TABLE salaries(
	emp_no int,
	salary int,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL ,
	dept_name VARCHAR (50),
	PRIMARY KEY (dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no int NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_emp(
	emp_no int NOT NULL,
	dept_no VARCHAR(4) NOT NULL ,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
-- Query all Tables 
SELECT * from titles; 
SELECT * from salaries; 
SELECT * from employees; 
SELECT * from dept_manager; 
SELECT * from dept_emp;
SELECT * from departments; 

-- List the employee number (employee), last name (employee), first name (employee), sex (employee), and salary (salaries) of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;


-- List the first name (employees), last name (employees), and hire date (employees) for the employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE EXTRACT(YEAR from hire_date) = 1986;

-- List the manager (dept_manager:emp_no) of each department along with their department number (departments), department name(departments), employee number, last name (employees), and first name (employees).
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_name, employees.first_name, employees.last_name
FROM departments
INNER JOIN dept_manager -- INNER JOIN: Mathcing values of both tables
ON dept_manager.dept_no = departments.dept_no 
LEFT JOIN employees -- LEFT JOIN: All rows from left table and mathcing rows from right table 
ON dept_manager.emp_no = employees.emp_no;


-- List the department number (dept_emp :dept_no) for each employee along with that employee’s employee number (dept_emp:emp_no), last name(employees), first name (employees), and department name(departments:dept_name).
SELECT dept_emp.dept_no, dept_emp.emp_no, departments.dept_name, employees.last_name, employees.first_name
FROM departments 
INNER JOIN dept_emp -- INNER JOIN: Mathcing values of both tables
ON dept_emp.dept_no = departments.dept_no
LEFT JOIN employees -- LEFT JOIN: All rows from left table and mathcing rows from right table
ON dept_emp.emp_no = employees.emp_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE employees.first_name = 'Hercules'
AND LEFT(employees.last_name, 1) = 'B';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT dept_emp.emp_no, dept_emp.dept_no, departments.dept_name, employees.last_name, employees.first_name
FROM departments
INNER JOIN dept_emp 
ON dept_emp.dept_no = departments.dept_no
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, dept_emp.dept_no, departments.dept_name, employees.last_name, employees.first_name
FROM departments
INNER JOIN dept_emp 
ON dept_emp.dept_no = departments.dept_no
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales'
AND departments.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
HAVING COUNT(last_name) >1;

