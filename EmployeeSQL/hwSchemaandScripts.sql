-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/t4EYKY
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(255)   NOT NULL,
    "last_name" varchar(255)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(5)   NOT NULL,
    "title" varchar(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" int   NOT NULL
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

-- Question 1
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
inner join salaries as s
on e.emp_no=s.emp_no;

-- Question 2
select first_name, last_name, hire_date from employees
where hire_date between '1986/01/01' and '1986/12/31';


-- Question 3
select d.dept_no,d.dept_name, dm.emp_no, e.last_name, e.first_name
from departments as d, dept_manager as dm, employees as e
where d.dept_no=dm.dept_no
and dm.emp_no=e.emp_no
order by dept_name;

-- Question 4
select e.emp_no, e.last_name, e.first_name,d.dept_name
from employees as e, departments as d, dept_emp
where e.emp_no=dept_emp.emp_no
and dept_emp.dept_no = d.dept_no
order by d.dept_name, e.last_name,e.first_name;

-- Question 5
select first_name, last_name, sex from employees
where first_name = 'Hercules' and last_name like 'B%';


-- Question 6
select e.emp_no, e.last_name,e.first_name,d.dept_name
from employees as e, departments as d, dept_emp
where e.emp_no=dept_emp.emp_no
and dept_emp.dept_no=d.dept_no
and dept_name = 'Sales'
order by e.last_name,e.first_name;


-- Question 7
select e.emp_no, e.last_name,e.first_name,d.dept_name
from employees as e, departments as d, dept_emp
where e.emp_no=dept_emp.emp_no
and dept_emp.dept_no=d.dept_no
and dept_name in ('Sales','Development')
order by d.dept_name,e.last_name,e.first_name;


-- Question 8
select last_name,count(emp_no) as Count from employees
group by last_name
order by Count desc;