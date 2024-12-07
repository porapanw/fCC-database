--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: userdata; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.userdata (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer NOT NULL,
    best_game integer
);


ALTER TABLE public.userdata OWNER TO freecodecamp;

--
-- Name: userdata_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.userdata_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userdata_user_id_seq OWNER TO freecodecamp;

--
-- Name: userdata_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.userdata_user_id_seq OWNED BY public.userdata.user_id;


--
-- Name: userdata user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userdata ALTER COLUMN user_id SET DEFAULT nextval('public.userdata_user_id_seq'::regclass);


--
-- Data for Name: userdata; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.userdata VALUES (2, 'user_1733577281667', 2, 537);
INSERT INTO public.userdata VALUES (1, 'user_1733577281668', 5, 616);
INSERT INTO public.userdata VALUES (4, 'user_1733577287488', 2, 725);
INSERT INTO public.userdata VALUES (3, 'user_1733577287489', 5, 403);
INSERT INTO public.userdata VALUES (6, 'user_1733577291206', 2, 98);
INSERT INTO public.userdata VALUES (5, 'user_1733577291207', 5, 175);
INSERT INTO public.userdata VALUES (8, 'user_1733577293640', 2, 504);
INSERT INTO public.userdata VALUES (7, 'user_1733577293641', 5, 50);
INSERT INTO public.userdata VALUES (10, 'user_1733577296201', 2, 124);
INSERT INTO public.userdata VALUES (9, 'user_1733577296202', 5, 61);
INSERT INTO public.userdata VALUES (12, 'user_1733577299051', 2, 767);
INSERT INTO public.userdata VALUES (11, 'user_1733577299052', 5, 80);
INSERT INTO public.userdata VALUES (14, 'user_1733577301342', 2, 633);
INSERT INTO public.userdata VALUES (13, 'user_1733577301343', 5, 68);
INSERT INTO public.userdata VALUES (16, 'user_1733577303824', 2, 390);
INSERT INTO public.userdata VALUES (15, 'user_1733577303825', 5, 192);
INSERT INTO public.userdata VALUES (18, 'user_1733577306277', 2, 109);
INSERT INTO public.userdata VALUES (17, 'user_1733577306278', 5, 6);


--
-- Name: userdata_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.userdata_user_id_seq', 18, true);


--
-- Name: userdata userdata_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userdata
    ADD CONSTRAINT userdata_pkey PRIMARY KEY (user_id);


--
-- Name: userdata userdata_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userdata
    ADD CONSTRAINT userdata_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

