
--TASK 1

SELECT * FROM bd_employees WHERE email ~ '.*\D.*\D.*\D.*@.+';

--TASK 2

SELECT last_name, street, postal_code FROM bd_employees, bd_departments
WHERE bd_employees.department_id = bd_departments.id
AND last_name ~ '^[A-Z][a-z]+$' ;

--TASK 3

SELECT last_name, regexp_replace(phone_number,'^(.).*(.)$','\1_\2') as
phone_number
FROM bd_employees;

--TASK 4

GRANT ALL ON bd_departments to "C21-712-12" ;
GRANT SELECT ON bd_employees to "C21-712-12" ;
REVOKE UPDATE,DELETE ON bd_departments FROM "C21-712-12" ;

--TASK 5

SELECT last_name, REGEXP_REPLACE(last_name, '[eyuioaEYUIOA]', '', 'g')
from bd_employees
where 2*(length(last_name) - length(REGEXP_REPLACE(last_name,
'[eyuioaEYUIOA]', '', 'g')))
= length(REGEXP_REPLACE(REGEXP_REPLACE(last_name, '[^a-z]', '', 'ig'),
'[eyuioaEYUIOA]', '', 'g'));

--TASK 6

select first_name,last_name, phone_number,
(1*(length(phone_number)-length(regexp_replace(phone_number,'1', '', 'g')))+
2*(length(phone_number)-length(regexp_replace(phone_number,'2', '', 'g')))+
3*(length(phone_number)-length(regexp_replace(phone_number,'3', '', 'g')))+
4*(length(phone_number)-length(regexp_replace(phone_number,'4', '', 'g')))+
5*(length(phone_number)-length(regexp_replace(phone_number,'5', '', 'g')))+
6*(length(phone_number)-length(regexp_replace(phone_number,'6', '', 'g')))+
7*(length(phone_number)-length(regexp_replace(phone_number,'7','', 'g')))+
8*(length(phone_number)-length(regexp_replace(phone_number,'8','', 'g')))+
9*(length(phone_number)-length(regexp_replace(phone_number,'9','', 'g'))))
as sum from bd_employees;

--TASK 7

CREATE VIEW dep_staff_counts as
SELECT department as "department",
count(id) as "ecount"
FROM staff GROUP BY department;

--TASK 2*

SELECT last_name, regexp_replace(street, 'shosse','city'), postal_code FROM
bd_employees, bd_departments
WHERE bd_employees.department_id = bd_departments.id
AND last_name ~ '^[A-Z][a-z]+$' ;

