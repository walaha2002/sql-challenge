select last_name,count(emp_no) as Count from employees
group by last_name
order by Count desc;