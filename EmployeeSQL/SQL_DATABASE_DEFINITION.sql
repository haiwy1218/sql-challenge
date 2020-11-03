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