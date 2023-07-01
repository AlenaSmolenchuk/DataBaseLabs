
--TASK1

SELECT first_name Имя, 
last_name Фамилия,
job_title Должность, 
trunc(j.max_salary - e.salary,0) Разница
FROM Jobs j JOIN employees e ON j.job_id=e.job_id 
ORDER BY Разница
DESC;

--TASK2

SELECT first_name Имя, last_name Фамилия,
country_name Страна FROM EMPLOYEES join DEPARTMENTS using
(department_id)
join LOCATIONS using(location_id) join COUNTRIES using (country_id);

--TASK3

SELECT first_name Имя, last_name Фамилия,
replace(to_char(trunc(salary, 2),'FM99999D00'),'.',',') Оклад,
trunc(min_salary, 0) "Мин.оклад"
FROM Jobs j JOIN Employees E ON j.job_id = e.job_id WHERE salary <=
1.2*min_salary ;

--TASK4

SELECT first_name Имя, last_name Фамилия,
replace(to_char(trunc(salary, 2),'FM99999D00'),'.',',') Оклад
FROM employees e WHERE salary > (SELECT avg(salary)
FROM employees WHERE department_id = (SELECT department_id FROM
DEPARTMENTS WHERE department_name = 'Sales'));

--TASK5

SELECT first_name Имя, last_name Фамилия
FROM employees e WHERE (SELECT count(*) FROM employees WHERE
e.employee_id = e.manager_id) = 0;


