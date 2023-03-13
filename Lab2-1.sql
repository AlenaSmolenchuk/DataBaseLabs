--Task1

--Task2

-- DROP SEQUENCE staff_id_seq;
CREATE SEQUENCE staff_id_seq
  start with 0
  INCREMENT BY -5
  MAXVALUE 0
  CACHE 100;


INSERT INTO staff(id,last_name,first_name,second_name,sex,birthday,post,department,head_id) VALUES
(nextval('staff_id_seq'), 'Сталин','Иосиф','Виссарионович','м', to_date('21.12.1879','DD.MM.YYYY'),'Председатель','ГКО', null);
INSERT INTO staff(id,last_name,first_name,second_name,sex,birthday,post,department,head_id) VALUES
(nextval('staff_id_seq'), 'Молотов','Вячеслав','Михайлович','м', to_date('09.03.1890', 'DD.MM.YYYY'), 'Заместитель председателя', 'ГКО', (SELECT id FROM staff LIMIT 1) );
INSERT INTO staff(id,last_name,first_name,second_name,sex,birthday,post,department,head_id) VALUES
(nextval('staff_id_seq'), 'Маленков','Георгий','Максимилианович','м', to_date('08.01.1902', 'DD.MM.YYYY'), 'Начальник', 'УК ЦК ВКП(б)', (SELECT id FROM staff LIMIT 1 OFFSET 1));
INSERT INTO staff(id,last_name,first_name,second_name,sex,birthday,post,department,head_id) VALUES
(nextval('staff_id_seq'), 'Ворошилов','Климент','Ефремович','м', to_date('04.02.1881', 'DD.MM.YYYY'), 'Председатель КО', 'СНК', (SELECT id FROM staff LIMIT 1 OFFSET 1));
INSERT INTO staff(id,last_name,first_name,second_name,sex,birthday,post,department,head_id) VALUES
(nextval('staff_id_seq'), 'Микоян','Анастас','Иванович','м', to_date('25.11.1895', 'DD.MM.YYYY'), 'Председатель', 'КП-ВС РККА', (SELECT id FROM staff LIMIT 1 OFFSET 1));
SELECT * FROM staff;

--Task3

--Task4

with help as (
  SELECT s1.id, s1.last_name, s1.first_name, s1.second_name, s1.post, 
s2.last_name AS hLast_name, s2.first_name AS hFirstName, s2.second_name AS hSecond_name, s2.post AS hPost
FROM staff s1 LEFT JOIN staff s2 ON (s1.id=s2.head_id)
)

update staff set id = id-2 where id in (select id from help where hSecond_name is null);

--Task5

--Task6

WITH RECURSIVE rstaff(id, head_id, len) AS(
  SELECT id, head_id , 1
    FROM staff
    WHERE head_id is null
  UNION ALL
  SELECT staff.id, staff.head_id, rstaff.len + 1
    FROM rstaff
    JOIN staff ON rstaff.id=staff.head_id
)  
SELECT max(len) FROM rstaff;
