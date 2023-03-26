--1
 
CREATE TABLE operations(
id int PRIMARY KEY,
account_number int,
operation_name text,
operation_sum double precision
);
CREATE TABLE operations_log(
operation_id int, account_number
int, operation_date timestamp,
operation_type char,
CHECK(operation_type in ('-','+'))
);
INSERT INTO operations VALUES
(1, 1200,'Снятие',150000),
(2, 2400,'Внесение',-340),
(3, 2354,'Снятие',274),
(4, 2345,'Снятие',-90),
(5, 5647,'Снятие',150),
(6, 4070,'Внесение',-157);
INSERT INTO operations_log VALUES
(1, 1200,'14.06.2003','+'),
(2, 2080,'27.07.2003','+'),
(3, 2354,'25.06.2006','-'),
(4, 4070,'05.10.2006','-'),
(5, 5647,'18.12.2000','+');

--2

CREATE OR REPLACE PROCEDURE statement_of_acount(begin_date
timestamp,
end_date timestamp,
acc_number int) AS $$ DECLARE
 e_attrs record;
BEGIN
 FOR e_attrs IN (SELECT operation_type,
 operation_sum,
operation_date from operations_log ol
 join operations o using(account_number)
 where operation_date <= end_date
 and operation_date >= begin_date
and o.account_number = acc_number
and operation_sum > 0 order by
operation_sum desc limit 3)
 LOOP
 raise info '% %', e_attrs.operation_date, e_attrs.operation_sum;
 END LOOP;
 FOR e_attrs IN (SELECT operation_type,
 operation_sum,
operation_date from
operations_log ol join
operations o using(account_number)
where operation_date <= end_date
and operation_date >= begin_date
and o.account_number = acc_number
 and operation_sum < 0 order
by operation_sum desc limit 3)
 LOOP
 raise info '% %', e_attrs.operation_date, e_attrs.operation_sum; END
LOOP;
 raise info '%', (SELECT count(*) from operations_log
 where operation_date <= end_date
 and operation_date >= begin_date);
 raise info '%', (SELECT to_char(avg(operation_sum),'FM999999999999999.99')
 from operations o
 join operations_log ol using (account_number) where
(ol.operation_date <= end_date and ol.operation_date >=
begin_date));
END
$$ LANGUAGE plpgsql;
call statement_of_acount('2000-01-01 00:00:0.0', '2013-12-31 00:00:0.0',1200);

--3

CREATE OR REPLACE PROCEDURE account_operation(account_number int,
 id int,

operation_sum double precision)
 AS $$
BEGIN
IF operation_sum > 0 THEN
INSERT INTO operations VALUES(id,
 account_number,
 'внесение денег на счет',
 operation_sum);
END IF;
END
$$ LANGUAGE plpgsql; 
