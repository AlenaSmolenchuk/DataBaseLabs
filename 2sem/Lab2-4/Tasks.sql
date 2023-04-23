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

CREATE OR REPLACE FUNCTION max_dimensions_func(
  dimensions numeric[],
  height numeric,
  width numeric,
  lenght numeric
)
RETURNS numeric[]
AS $$
BEGIN
  dimensions[1] = greatest(dimensions[1], height);
  dimensions[2] = greatest(dimensions[2], width);
  dimensions[3] = greatest(dimensions[3], lenght);
  RETURN dimensions;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION max_dimensions_finalfunc(dimensions numeric[])
RETURNS text
AS $$
BEGIN
  RETURN dimensions[1] || ' X ' || dimensions[2] || ' X ' || dimensions[3];
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE AGGREGATE max_dimensions(numeric, numeric, numeric)
(
  sfunc = max_dimensions_func,
  stype = numeric[],
  finalfunc = max_dimensions_finalfunc
);


SELECT max_dimensions(high_pr, width_pr, lenght_pr) FROM "Product";

--task 3 

CREATE OR REPLACE VIEW cl_view AS
SELECT "Client".id_client, "Client".name_cl, "Client".bank_doc,
       "Product".id_product
FROM "Client" 
     JOIN "Contract" ON "Client".id_client = "Contract".client_id
	 LEFT JOIN "Product" ON "Contract".contract_id = "Product".id_contract
GROUP BY "Product".id_product, "Client".id_client;
	 
SELECT * FROM cl_view;


CREATE OR REPLACE FUNCTION update_client_description()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE "Client"
  SET name_cl = NEW.name_cl,
      bank_doc = NEW.bank_doc
  WHERE id_client = NEW.id_client;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER update_client_description_trigger
INSTEAD OF INSERT ON cl_view
FOR EACH ROW
EXECUTE FUNCTION update_client_description();

--task 4
