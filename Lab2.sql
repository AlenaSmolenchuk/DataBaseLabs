
--TASK1

select (i*55-i) as "X" from (select 1 as i union
 select 2 as i union
 select 3 as i union
 select 4 as i union
 select 5 as i) as S order by "X" ASC ;
 
--TASK2

select * from EMPLOYEES where department_id = 50;

--TASK3

select first_name as "Имя",
last_name as "Фамилия", case
 when job_id = 'SA_REP' then 'Торговый представитель'
 when job_id = 'SA_MAN' then 'Менеджер по продажам'
 else 'Другое'
 end as "Должность"
from EMPLOYEES;

--TASK4

select job_id as "Должность",
trunc(max(salary),0) as "Максимальная зарплата" ,
trunc(min(salary),0) as "Минимальная зарплата",
to_char(avg(salary), '99999.00') as "Средняя зарплата"
from EMPLOYEES group by job_id ;

