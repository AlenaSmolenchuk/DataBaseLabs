--task 0
--task 1

--DROP FUNCTION count_product(text,date);

CREATE OR REPLACE FUNCTION count_product(name_c text, date_cur date) 
RETURNS integer AS $$
DECLARE 
	name_c text;
	date_cur date;
	counter integer;
		BEGIN
			SELECT count(*) into counter FROM "Client"
			join "Contract" ON id_client = "Contract".client_id WHERE finished_at < $2 and "Client".name_cl = $1;
			RAISE INFO '%', counter;
			return counter;
			end;
$$ language plpgsql;

SELECT * FROM count_product('Кот в сапогах', '2029-12-31');

--task 2
--task 3 
--task 4
