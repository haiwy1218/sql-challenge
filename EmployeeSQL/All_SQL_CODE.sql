--drop tables--
drop table dept_emp;
drop table dept_manager;
drop table salaries;
drop table titles cascade;
drop table employees;
drop table departments;

--create department table--
create table departments(
dept_no varchar (10) PRIMARY KEY,
dept_name varchar(50) NOT NULL
);

--create dept_emp table--
create table dept_emp(
emp_no INTEGER NOT NULL,
dept_no varchar (10) NOT NULL
);

-- create dept_manager table--
create table dept_manager(
dept_no varchar (10) NOT NULL,
emp_no INTEGER NOT NULL
);



--create employees table--
create table employees(
emp_no INTEGER PRIMARY KEY,
emp_title varchar(10) NOT NULL,
birth_date date NOT NULL,
first_name varchar(50) NOT NULL,
last_name varchar(50) NOT NULL,
sex varchar(50) NOT NULL,
hire_date date NOT NULL
);

-- create salaries table--
create table salaries(
emp_no INTEGER PRIMARY KEY,
salary varchar(50) NOT NULL
);



--create titles table--
create table titles(
title_id varchar (10) PRIMARY KEY,
title varchar(50) NOT NULL
);


-- alter tables and put constraints--
alter table dept_emp ADD CONSTRAINT pk_dept_emp PRIMARY KEY  (emp_no, dept_no);
alter table dept_emp ADD CONSTRAINT fk_dept_emp_1 FOREIGN KEY (dept_no) REFERENCES departments(dept_no);
alter table dept_emp ADD CONSTRAINT fk_dept_emp_2 FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
alter table dept_manager ADD CONSTRAINT pk_dept_manager PRIMARY KEY (dept_no, emp_no);
alter table dept_manager ADD CONSTRAINT fk_dept_mgr_1 FOREIGN KEY (dept_no) REFERENCES departments(dept_no);
alter table dept_manager ADD CONSTRAINT fk_dept_mgr_2 FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
alter table salaries ADD CONSTRAINT fk_salaries_employee FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
alter table employees ADD CONSTRAINT fk_titles_employees FOREIGN KEY (emp_title) REFERENCES titles(title_id);

-- list employee number, last name, first name, sex, and salary--

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986--

SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department with the following information--

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--List the department of each employee with the following information--

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."--

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.--

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name--
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';


--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name--
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;