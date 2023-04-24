--task 0
CREATE OR REPLACE FUNCTION check_rack_capacity() RETURNS trigger AS $$
DECLARE
    rack_max_weight numeric;
    rack_current_weight numeric;
BEGIN
    -- Получаем максимальную нагрузку стеллажа
    SELECT quantity INTO rack_max_weight 
	FROM "Rack"
	WHERE id_rack = OLD.id_rack;
    
    -- Получаем текущий вес товаров на стеллаже
    SELECT COALESCE(SUM(weight_pr), 0) INTO rack_current_weight
	FROM "Product"
	WHERE id_place IN (SELECT place_id FROM "Place" WHERE rack_id = OLD.id_rack);
    
    -- Если попытка добавить товар на стеллаж приведет к превышению его максимальной нагрузки, выбрасываем ошибку
    IF (TG_OP = 'INSERT' AND rack_current_weight + NEW.weight_pr > rack_max_weight)
	OR (TG_OP = 'UPDATE' AND rack_current_weight > rack_max_weight) THEN
        RAISE EXCEPTION 'НАГРУЗКА НА СТЕЛЛАЖ ПРЕВЫШЕНА';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_rack_capacity_trigger
    BEFORE INSERT OR UPDATE OR DELETE ON public."Product"
    FOR EACH ROW
    EXECUTE FUNCTION check_rack_capacity();


--task 1
DROP FUNCTION count_product(text,date);
CREATE OR REPLACE FUNCTION count_product(name_c text, date_cur date) 
RETURNS integer AS $$
DECLARE 
	name_c text;
	date_cur date;
	counter integer;
		BEGIN
			SELECT count(*) INTO counter FROM "Client"
			JOIN "Contract" ON id_client = "Contract".client_id WHERE finished_at < $2 and "Client".name_cl = $1;
			RAISE INFO '%', counter;
			RETURN counter;
			END;
$$ LANGUAGE plpgsql;

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
    
CREATE TABLE queue (
id SERIAL PRIMARY KEY,
data VARCHAR(64) NOT NULL
);

CREATE OR REPLACE PROCEDURE  enqueue(item VARCHAR(64)) AS $$
BEGIN
  INSERT INTO queue (data) VALUES (item);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE dequeue()  AS $$
DECLARE
    first_id INTEGER;
    result_data VARCHAR(64);
BEGIN
    SELECT id, data INTO first_id, result_data FROM queue ORDER BY id LIMIT 1;
    DELETE FROM queue WHERE id = first_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE  empty() AS $$
BEGIN
  DELETE FROM queue;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE init() AS $$
BEGIN
  TRUNCATE TABLE queue;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION top() RETURNS VARCHAR(64) AS $$
BEGIN
  RETURN (SELECT data FROM queue ORDER BY id ASC LIMIT 1);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION tail() RETURNS VARCHAR(64) AS $$
BEGIN
  RETURN (SELECT data FROM queue ORDER BY id DESC LIMIT 1);
END;
$$ LANGUAGE plpgsql;

-- Инициализация очереди
CALL init();

-- Добавление элемента в конец очереди
CALL enqueue('first');
CALL enqueue('second');
CALL enqueue('third');

-- Просмотр начала очереди
SELECT top();

-- Удаление элемента из начала очереди
CALL dequeue();

-- Просмотр конца очереди
SELECT tail();

-- Очистка очереди
CALL empty();

