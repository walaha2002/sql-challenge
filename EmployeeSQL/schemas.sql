create table employees(
	emp_no int not null,
	emp_title_id varchar,
	birth_date date,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date date,
	primary key (emp_no))
;

create table salaries(
	emp_no int not null,
	salary int,
	primary key(emp_no))
;



create table titles(
	title_id varchar not null,
	title varchar,
	primary key (title_id));

create table dept_emp(
	emp_no int,
	dept_no varchar)
;



create table departments(
	dept_no varchar not null,
	dept_name varchar,
	primary key (dept_no))
;

create table dept_manager(
	dept_no varchar,
	emp_no int not null,
	primary key (emp_no))
;