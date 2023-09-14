--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: items; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.items (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.items OWNER TO justin;

--
-- Name: pokemon; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.pokemon (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    species_id uuid NOT NULL,
    nickname text NOT NULL,
    trainer_id uuid
);


ALTER TABLE public.pokemon OWNER TO justin;

--
-- Name: pokemon_species; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.pokemon_species (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.pokemon_species OWNER TO justin;

--
-- Name: pokemon_type; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.pokemon_type (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.pokemon_type OWNER TO justin;

--
-- Name: species_type; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.species_type (
    species_id uuid NOT NULL,
    type_id uuid NOT NULL
);


ALTER TABLE public.species_type OWNER TO justin;

--
-- Name: trainer; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.trainer (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.trainer OWNER TO justin;

--
-- Name: trainer_items; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.trainer_items (
    trainer_id uuid NOT NULL,
    item_id uuid NOT NULL,
    quantity integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.trainer_items OWNER TO justin;

--
-- Name: type_weakness; Type: TABLE; Schema: public; Owner: justin
--

CREATE TABLE public.type_weakness (
    type_id uuid NOT NULL,
    weak_against_id uuid NOT NULL
);


ALTER TABLE public.type_weakness OWNER TO justin;

--
-- Name: items items_name_key; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_name_key UNIQUE (name);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: pokemon pokemon_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon
    ADD CONSTRAINT pokemon_pkey PRIMARY KEY (id);


--
-- Name: pokemon_species pokemon_species_name_key; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon_species
    ADD CONSTRAINT pokemon_species_name_key UNIQUE (name);


--
-- Name: pokemon_species pokemon_species_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon_species
    ADD CONSTRAINT pokemon_species_pkey PRIMARY KEY (id);


--
-- Name: pokemon_type pokemon_type_name_key; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon_type
    ADD CONSTRAINT pokemon_type_name_key UNIQUE (name);


--
-- Name: pokemon_type pokemon_type_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon_type
    ADD CONSTRAINT pokemon_type_pkey PRIMARY KEY (id);


--
-- Name: species_type species_type_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.species_type
    ADD CONSTRAINT species_type_pkey PRIMARY KEY (species_id, type_id);


--
-- Name: trainer_items trainer_items_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.trainer_items
    ADD CONSTRAINT trainer_items_pkey PRIMARY KEY (trainer_id, item_id);


--
-- Name: trainer trainer_name_key; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.trainer
    ADD CONSTRAINT trainer_name_key UNIQUE (name);


--
-- Name: trainer trainer_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.trainer
    ADD CONSTRAINT trainer_pkey PRIMARY KEY (id);


--
-- Name: type_weakness type_weakness_pkey; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.type_weakness
    ADD CONSTRAINT type_weakness_pkey PRIMARY KEY (type_id, weak_against_id);


--
-- Name: pokemon unique_nickname; Type: CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon
    ADD CONSTRAINT unique_nickname UNIQUE (nickname);


--
-- Name: pokemon pokemon_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon
    ADD CONSTRAINT pokemon_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.pokemon_species(id);


--
-- Name: pokemon pokemon_trainer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.pokemon
    ADD CONSTRAINT pokemon_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainer(id);


--
-- Name: species_type species_type_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.species_type
    ADD CONSTRAINT species_type_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.pokemon_species(id);


--
-- Name: species_type species_type_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.species_type
    ADD CONSTRAINT species_type_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.pokemon_type(id);


--
-- Name: trainer_items trainer_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.trainer_items
    ADD CONSTRAINT trainer_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: trainer_items trainer_items_trainer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.trainer_items
    ADD CONSTRAINT trainer_items_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainer(id);


--
-- Name: type_weakness type_weakness_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.type_weakness
    ADD CONSTRAINT type_weakness_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.pokemon_type(id);


--
-- Name: type_weakness type_weakness_weak_against_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justin
--

ALTER TABLE ONLY public.type_weakness
    ADD CONSTRAINT type_weakness_weak_against_id_fkey FOREIGN KEY (weak_against_id) REFERENCES public.pokemon_type(id);


--
-- PostgreSQL database dump complete
--

