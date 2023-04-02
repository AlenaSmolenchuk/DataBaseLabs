--TASK 0
SELECT sum(weight_pr) AS "Суммарный вес" FROM "Product";

--TASK 1
WITH LALA AS (SELECT DISTINCT name_cl,id_contract FROM "Client","Contract","Product"
WHERE "Client".id_client = "Contract".client_id
AND "Contract".contract_id = "Product".id_contract)
SELECT sum("Product".high_pr * "Product".width_pr * "Product".lenght_pr) 
AS "суммарный объём", name_cl AS "Компания" FROM "Product",LALA
WHERE LALA.id_contract = "Product".id_contract 
GROUP BY name_cl 
ORDER BY "суммарный объём" DESC 
LIMIT 3;

--TASK 2

	    SELECT DISTINCT "Rack".number AS "Номер стеллажа", MAX("Rack".quantity) - (COUNT("Place".place_id)) AS  "Загруженность"
        FROM "Place" LEFT JOIN "Rack"
	     ON "Rack".id_rack="Place".rack_id
	    FULL OUTER JOIN "Product"
	     ON "Product".id_place="Place".place_id
	    WHERE "Product".id_place="Place".place_id IS NULL
		GROUP BY "Номер стеллажа"
	    ORDER BY "Номер стеллажа";
	   
--TASK 3

DELETE FROM "Product" USING "Place",  "Rack"
WHERE "Place".place_id = "Product".id_place AND
"Rack".id_rack = "Place".rack_id AND max_load<100;

SELECT * FROM "Product";

SELECT DISTINCT "Rack".number AS "Номер стеллажа",
				COUNT("Place".place_id) AS "Товары",
				SUM("Product".weight_pr) AS "Вес",
				"Rack".max_load AS "Максимальная нагрузка"
				FROM "Rack", "Product", "Place"
		WHERE "Product".id_place="Place".place_id AND "Rack".id_rack="Place".rack_id
		GROUP BY "Номер стеллажа", "Максимальная нагрузка"
	   ORDER BY "Номер стеллажа";

--TASK 4
UPDATE "Contract"
  SET finished_at = DATE(finished_at + interval '1 month') 
FROM "Client" 
WHERE "Contract".client_id = "Client".id_client AND name_cl = 'Рога и копыта';


--TASK 5
ALTER TABLE "Product" ADD hrupkost_pr char CHECK(hrupkost_pr = '+' OR hrupkost_pr = '-');
--TASK 6
ALTER TABLE "Product" ADD CHECK (weight_pr < 500);
