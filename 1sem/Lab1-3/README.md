Request #1
Create a query that selects the following data from
the employees and jobs tables:
- employee name (employees table);
- employee's last name (employees table);
- the difference between the maximum salary for this
position (from the jobs table) and the real salary (from
the employees table).
At the same time, employees for whom such a difference is maximum should
be displayed first
Request #2
Write a query that selects the following data from
the employees and countries tables:
- employee name (employees table);
- employee's last name (employees table);
- the country in which the employee is located (the countries table).
Make sure that the Cartesian product is not obtained as a result of executing your query
.
Request #3
Create a query that selects the following data from
the employees and jobs tables:
- employee name (employees table);
- employee's last name (employees table);
- salary (salary column in the employees table);
- the minimum wage for
the position held by the employee (the min_salary column in the jobs table).
In this case, the lines should be selected only for those employees whose
the salary differs from the minimum for this position by no more
than 20 percent
Request No. 4
Write a query that selects information about the name, surname,
salary of all employees from the employees table whose salary
exceeds the average for the sales department (the value of Sales in the department_name column
of the departments table). Solve this problem using
a subquery.
Request No. 5
Write a query that selects the names and surnames of employees
based on information from the employees table. Records should be selected
only for those employees who perform managerial functions (for
which their employee_id number is found in the manager_id column of the same
table). Solve this problem using a multi-line subquery.
