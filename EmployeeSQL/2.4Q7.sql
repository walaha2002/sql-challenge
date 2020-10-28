select e.emp_no, e.last_name,e.first_name,d.dept_name
from employees as e, departments as d, dept_emp
where e.emp_no=dept_emp.emp_no
and dept_emp.dept_no=d.dept_no
and dept_name in ('Sales','Development')
order by d.dept_name,e.last_name,e.first_name;