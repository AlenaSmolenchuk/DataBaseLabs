BEGIN;
CREATE TABLE IF NOT EXISTS public."Client"
(
    id_client integer,
    name_cl character varying(64) COLLATE pg_catalog."default" NOT NULL,
    bank_doc character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Client_pkey" PRIMARY KEY (id_client),
    CONSTRAINT data_cl UNIQUE (name_cl, bank_doc)
); 
 
CREATE TABLE IF NOT EXISTS public."Contract"
(
    contract_id integer,
    started_at date NOT NULL,
    finished_at date NOT NULL,
    c_number character varying(64) COLLATE pg_catalog."default" NOT NULL,
    client_id integer NOT NULL,
    CONSTRAINT "Contract_pkey" PRIMARY KEY (contract_id),
    CONSTRAINT data_con UNIQUE (started_at, c_number, finished_at)
);

CREATE TABLE IF NOT EXISTS public."Place"
(
    place_id integer,
    high_pl numeric NOT NULL,
    lenght_pl numeric NOT NULL,
    width_pl numeric NOT NULL,
    rack_id integer NOT NULL,
    CONSTRAINT "Place_pkey" PRIMARY KEY (place_id)
);

CREATE TABLE IF NOT EXISTS public."Product"
(
    id_product integer,
    high_pr numeric NOT NULL,
    weight_pr numeric NOT NULL,
    lenght_pr numeric NOT NULL,
    width_pr numeric NOT NULL,
    temp_min_pr numeric NOT NULL,
    temp_max_pr numeric NOT NULL,
    wet_min_pr numeric NOT NULL,
    wet_max_pr numeric NOT NULL,
    id_place integer NOT NULL,
    id_contract integer NOT NULL,
    CONSTRAINT "Product_pkey" PRIMARY KEY (id_product),
    UNIQUE (id_place)
);

CREATE TABLE IF NOT EXISTS public."Rack"
(
    id_rack integer,
    "number" integer NOT NULL,
    quantity integer NOT NULL,
    room_id integer,
    CONSTRAINT "Rack_pkey" PRIMARY KEY (id_rack),
    CONSTRAINT rack_vol UNIQUE ("number")
);

CREATE TABLE IF NOT EXISTS public."Rooms"
(
    id_room integer,
    name character varying(64) COLLATE pg_catalog."default" NOT NULL,
    use_volume integer,
    temp_min numeric NOT NULL,
    temp_max numeric NOT NULL,
    wet_min numeric NOT NULL,
    wet_max numeric NOT NULL,
    PRIMARY KEY (id_room)
);

ALTER TABLE IF EXISTS public."Contract"
    ADD FOREIGN KEY (client_id)
    REFERENCES public."Client" (id_client) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Place"
    ADD FOREIGN KEY (rack_id)
    REFERENCES public."Rack" (id_rack) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Product"
    ADD FOREIGN KEY (id_place)
    REFERENCES public."Place" (place_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Product"
    ADD FOREIGN KEY (id_contract)
    REFERENCES public."Contract" (contract_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Rack"
    ADD CONSTRAINT "Rack_room_id_fkey" FOREIGN KEY (room_id)
    REFERENCES public."Rooms" (id_room) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
END;
