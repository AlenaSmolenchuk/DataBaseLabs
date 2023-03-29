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
SELECT DISTINCT "Rack".number AS "Номер стеллажа",
       count("Place".place_id) AS "Загруженность" 
FROM "Rack", "Product", "Place" 
WHERE "Product".id_place="Place".place_id  
	   AND "Rack".id_rack="Place".rack_id 
	   GROUP BY "Номер стеллажа"
	   ORDER BY "Номер стеллажа";
--TASK 3

--TASK 4
SELECT name_cl AS "Компания", 
       DATE(finished_at + interval '1 month') AS "Дата окончания" 
	   FROM "Client","Contract"
       WHERE "Client".id_client = "Contract".client_id 
	   AND name_cl = 'Рога и копыта';
--TASK 5
ALTER TABLE "Product" ADD hrupkost_pr char CHECK(chrupkost_pr = '+' OR chrupkost_pr = '-');
--TASK 6
ALTER TABLE "Product" ADD CHECK (weight_pr < 500);
