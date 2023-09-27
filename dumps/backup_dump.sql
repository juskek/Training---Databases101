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
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.items (id, name) FROM stdin;
6667dbb8-e655-48d8-9e2a-a77a0d99e1db	Gym Badge - Pewter City
b4370100-ce50-45c6-a8a2-68ebde865111	Gym Badge - Cerulean City
f117c003-c81f-46b6-aaa9-38532033bc5e	Pokeball
67ca3875-6eff-4a0e-8962-085c24c6100a	Great Ball
084ca3ac-ff1e-4cca-a9f9-d144a57c0811	Ultra Ball
\.


--
-- Data for Name: pokemon; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.pokemon (id, species_id, nickname, trainer_id) FROM stdin;
d6cb36a2-69b1-477c-902a-48afb13fa80d	4a8fd9b6-c1e6-432d-b940-5d2a7833ce19	I Pikachuse You	\N
702671c1-4a05-4f24-b76c-e66c321c0e5a	b2645871-b70c-4c38-8693-17f37bf2ebef	I Charmander Your Socks Off	\N
9f9ca781-aa7c-487d-a5d1-d9eff3076407	2557569d-a492-4038-b1bb-91373922f4dd	And Squirtle On	\N
a7aa69e6-8905-4609-b0bc-15d6a4babf6d	4a8fd9b6-c1e6-432d-b940-5d2a7833ce19	I Pikarefuse	\N
2651e7d6-c14c-4c24-ac8d-fc45217f3163	b2645871-b70c-4c38-8693-17f37bf2ebef	You aint got no Charmander	\N
4696854c-5f84-41f4-ab82-377bbd7c99e0	4a8fd9b6-c1e6-432d-b940-5d2a7833ce19	Sparky	5b5bffdf-096d-428d-a3c8-b5e9c45e0791
e2ef03db-d225-4e0a-86d1-1660d93e4928	69884629-afcb-4207-87f0-0e41325be065	Bulby	5b5bffdf-096d-428d-a3c8-b5e9c45e0791
609490cb-c93a-47a6-81ad-d6be058a1500	b2645871-b70c-4c38-8693-17f37bf2ebef	Flame	5b5bffdf-096d-428d-a3c8-b5e9c45e0791
de8b4bae-c310-48a2-b6a7-c9ffd9b449eb	2557569d-a492-4038-b1bb-91373922f4dd	Squirt	ee76433d-0831-4a6f-80ee-ac8c374d13cb
\.


--
-- Data for Name: pokemon_species; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.pokemon_species (id, name) FROM stdin;
4a8fd9b6-c1e6-432d-b940-5d2a7833ce19	Pikachu
69884629-afcb-4207-87f0-0e41325be065	Bulbasaur
b2645871-b70c-4c38-8693-17f37bf2ebef	Charmander
2557569d-a492-4038-b1bb-91373922f4dd	Squirtle
ffb146a9-d67e-4c83-b699-5238975ff09f	Lanturn
\.


--
-- Data for Name: pokemon_type; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.pokemon_type (id, name) FROM stdin;
9df17e8e-eee9-44be-8a5d-3e2fe43c8929	Normal
b6a2b51b-beb7-4fcb-8677-61badf1e6681	Fire
2219c3df-9b1a-4596-90b6-12c391f7da45	Water
5738440f-b945-4a1a-bbcc-f72adf23ac67	Electric
80b993c3-7944-45d1-9c8a-ae245358b2d1	Grass
fe327319-f0f1-442c-9892-843b8c0a7a20	Ice
4869e432-4afb-4830-8e99-f834c0d31805	Fighting
2379d3a5-1ee8-426f-a9e3-bea2d6076138	Poison
64fd3965-fb5d-4275-b3c3-4b463e0c1475	Ground
33812b1f-d770-43ed-817a-234a8539261c	Flying
182ec730-d009-4a72-af33-19d98010792a	Psychic
7e4c766c-62a0-4ea6-a44e-344c99473c2c	Bug
d463ed6e-c3d6-40eb-9c77-3f7e830ab15c	Rock
da8739d5-da03-44da-9609-22b844ad8b5d	Ghost
4e9d9428-8056-42bf-8e65-89ee2c560aa4	Dragon
c56563c5-9640-45a2-9800-7f30bcf88f91	Dark
ef79aa93-a22a-485e-b73b-0875b93b3eb0	Steel
4a90f242-cd3d-4ec5-b485-3490f07b4b9a	Fairy
\.


--
-- Data for Name: species_type; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.species_type (species_id, type_id) FROM stdin;
4a8fd9b6-c1e6-432d-b940-5d2a7833ce19	5738440f-b945-4a1a-bbcc-f72adf23ac67
b2645871-b70c-4c38-8693-17f37bf2ebef	b6a2b51b-beb7-4fcb-8677-61badf1e6681
2557569d-a492-4038-b1bb-91373922f4dd	2219c3df-9b1a-4596-90b6-12c391f7da45
ffb146a9-d67e-4c83-b699-5238975ff09f	2219c3df-9b1a-4596-90b6-12c391f7da45
\.


--
-- Data for Name: trainer; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.trainer (id, name) FROM stdin;
5b5bffdf-096d-428d-a3c8-b5e9c45e0791	Ash
ee76433d-0831-4a6f-80ee-ac8c374d13cb	Misty
78ee0908-52a3-444c-a476-771ad60edad0	Brock
\.


--
-- Data for Name: trainer_items; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.trainer_items (trainer_id, item_id, quantity) FROM stdin;
5b5bffdf-096d-428d-a3c8-b5e9c45e0791	6667dbb8-e655-48d8-9e2a-a77a0d99e1db	1
5b5bffdf-096d-428d-a3c8-b5e9c45e0791	f117c003-c81f-46b6-aaa9-38532033bc5e	10
ee76433d-0831-4a6f-80ee-ac8c374d13cb	b4370100-ce50-45c6-a8a2-68ebde865111	1
ee76433d-0831-4a6f-80ee-ac8c374d13cb	67ca3875-6eff-4a0e-8962-085c24c6100a	5
\.


--
-- Data for Name: type_weakness; Type: TABLE DATA; Schema: public; Owner: justin
--

COPY public.type_weakness (type_id, weak_against_id) FROM stdin;
b6a2b51b-beb7-4fcb-8677-61badf1e6681	2219c3df-9b1a-4596-90b6-12c391f7da45
2219c3df-9b1a-4596-90b6-12c391f7da45	5738440f-b945-4a1a-bbcc-f72adf23ac67
80b993c3-7944-45d1-9c8a-ae245358b2d1	b6a2b51b-beb7-4fcb-8677-61badf1e6681
5738440f-b945-4a1a-bbcc-f72adf23ac67	64fd3965-fb5d-4275-b3c3-4b463e0c1475
\.


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

