
--TASK 1

CREATE TABLE deps( 
id integer primary key, 
name varchar(64) not null, 
region varchar(64) not null 
);

--TASK 2

CREATE SEQUENCE deps_id_seq start with 1 cycle increment by 4 cache 1;

--TASK 3

INSERT INTO deps(id, name, region) VALUES(nextval('deps_id_seq'),
'Direction', 'Mars') returning * ;

--TASK 4

INSERT INTO deps(id, name, region) SELECT nextval('deps_id_seq'),
department_name, substr(region_name,1,2) from departments join locations
using(location_id) join countries using(country_id) join regions using(region_id)
returning * ;

--TASK 5

UPDATE deps SET region = 'Europe' WHERE name = 'Sales';

--TASK 6

DELETE FROM deps WHERE (id%2)=0;

--TASK 8

WITH recursive rmanager (employee_id,manager_id) AS ( SELECT employee_id,
manager_id FROM employees WHERE employee_id = 111 UNION ALL
SELECT employees.employee_id, employees.manager_id FROM employees JOIN
rmanager ON rmanager.manager_id = employees.employee_id ) SELECT *
FROM rmanager;

--TASK 9
DELETE FROM departments d WHERE location_id IN (SELECT
location_id FROM locations WHERE country_id IN
(SELECT country_id FROM countries
WHERE char_length(country_id) = 2 ));

