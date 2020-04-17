--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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

ALTER TABLE ONLY public.mission DROP CONSTRAINT mission_customer_id_098dc93c_fk_user_id;
ALTER TABLE ONLY public.mission DROP CONSTRAINT mission_ad_id_8329a616_fk_ad_id;
ALTER TABLE ONLY public.message DROP CONSTRAINT message_sender_id_a2a2e825_fk_user_id;
ALTER TABLE ONLY public.message DROP CONSTRAINT message_conversation_id_87e8709d_fk_conversation_id;
ALTER TABLE ONLY public.conversation DROP CONSTRAINT conversation_ad_id_1e95ceb7_fk_ad_id;
ALTER TABLE ONLY public.address DROP CONSTRAINT address_user_id_c030de7d_fk_user_id;
ALTER TABLE ONLY public.ad DROP CONSTRAINT ad_user_id_c2e99f71_fk_user_id;
ALTER TABLE ONLY public.ad DROP CONSTRAINT ad_category_id_2d95fbd9_fk_category_id;
DROP INDEX public.user_email_7cf9e9_idx;
DROP INDEX public.user_email_54dc62b2_like;
DROP INDEX public.mission_customer_id_098dc93c;
DROP INDEX public.mission_ad_id_8329a616;
DROP INDEX public.message_sender_id_a2a2e825;
DROP INDEX public.message_conversation_id_87e8709d;
DROP INDEX public.conversation_ad_id_1e95ceb7;
DROP INDEX public.category_name_d601b7_idx;
DROP INDEX public.address_address_b207d7_idx;
DROP INDEX public.ad_user_id_c2e99f71;
DROP INDEX public.ad_title_fad397_idx;
DROP INDEX public.ad_category_id_2d95fbd9;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_phone_b2d089ae_uniq;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_key;
ALTER TABLE ONLY public.mission DROP CONSTRAINT mission_pkey;
ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
ALTER TABLE ONLY public.conversation DROP CONSTRAINT conversation_pkey;
ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
ALTER TABLE ONLY public.address DROP CONSTRAINT address_user_id_key;
ALTER TABLE ONLY public.address DROP CONSTRAINT address_pkey;
ALTER TABLE ONLY public.ad DROP CONSTRAINT ad_pkey;
ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.mission ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.message ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.conversation ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.address ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.ad ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.user_id_seq;
DROP TABLE public."user";
DROP SEQUENCE public.mission_id_seq;
DROP TABLE public.mission;
DROP SEQUENCE public.message_id_seq;
DROP TABLE public.message;
DROP SEQUENCE public.conversation_id_seq;
DROP TABLE public.conversation;
DROP SEQUENCE public.category_id_seq;
DROP TABLE public.category;
DROP SEQUENCE public.address_id_seq;
DROP TABLE public.address;
DROP SEQUENCE public.ad_id_seq;
DROP TABLE public.ad;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ad; Type: TABLE; Schema: public; Owner: ipssi
--

CREATE TABLE public.ad (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    description text,
    status character varying(32) NOT NULL,
    updated timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    category_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.ad OWNER TO ipssi;

--
-- Name: ad_id_seq; Type: SEQUENCE; Schema: public; Owner: ipssi
--

CREATE SEQUENCE public.ad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ad_id_seq OWNER TO ipssi;

--
-- Name: ad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipssi
--

ALTER SEQUENCE public.ad_id_seq OWNED BY public.ad.id;


--
-- Name: address; Type: TABLE; Schema: public; Owner: ipssi
--

CREATE TABLE public.address (
    id integer NOT NULL,
    address1 character varying(255) NOT NULL,
    address2 character varying(255) NOT NULL,
    postal_code character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    country character varying(128) NOT NULL,
    latitude numeric(8,3),
    longitude numeric(8,3),
    updated timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer
);


ALTER TABLE public.address OWNER TO ipssi;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: public; Owner: ipssi
--

CREATE SEQUENCE public.address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_id_seq OWNER TO ipssi;

--
-- Name: address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipssi
--

ALTER SEQUENCE public.address_id_seq OWNED BY public.address.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: ipssi
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.category OWNER TO ipssi;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: ipssi
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO ipssi;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipssi
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: conversation; Type: TABLE; Schema: public; Owner: ipssi
--

CREATE TABLE public.conversation (
    id integer NOT NULL,
    updated timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    ad_id integer NOT NULL
);


ALTER TABLE public.conversation OWNER TO ipssi;

--
-- Name: conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: ipssi
--

CREATE SEQUENCE public.conversation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversation_id_seq OWNER TO ipssi;

--
-- Name: conversation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipssi
--

ALTER SEQUENCE public.conversation_id_seq OWNED BY public.conversation.id;


--
-- Name: message; Type: TABLE; Schema: public; Owner: ipssi
--

CREATE TABLE public.message (
    id integer NOT NULL,
    content text NOT NULL,
    updated timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    conversation_id integer NOT NULL,
    sender_id integer NOT NULL
);


ALTER TABLE public.message OWNER TO ipssi;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: ipssi
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO ipssi;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipssi
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- Name: mission; Type: TABLE; Schema: public; Owner: ipssi
--

CREATE TABLE public.mission (
    id integer NOT NULL,
    updated timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    ad_id integer NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE public.mission OWNER TO ipssi;

--
-- Name: mission_id_seq; Type: SEQUENCE; Schema: public; Owner: ipssi
--

CREATE SEQUENCE public.mission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mission_id_seq OWNER TO ipssi;

--
-- Name: mission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipssi
--

ALTER SEQUENCE public.mission_id_seq OWNED BY public.mission.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: ipssi
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    gender character varying(1),
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    phone character varying(16),
    birth_date date,
    updated timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE public."user" OWNER TO ipssi;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: ipssi
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO ipssi;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipssi
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: ad id; Type: DEFAULT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.ad ALTER COLUMN id SET DEFAULT nextval('public.ad_id_seq'::regclass);


--
-- Name: address id; Type: DEFAULT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.address ALTER COLUMN id SET DEFAULT nextval('public.address_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: conversation id; Type: DEFAULT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.conversation ALTER COLUMN id SET DEFAULT nextval('public.conversation_id_seq'::regclass);


--
-- Name: message id; Type: DEFAULT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- Name: mission id; Type: DEFAULT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.mission ALTER COLUMN id SET DEFAULT nextval('public.mission_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: ad; Type: TABLE DATA; Schema: public; Owner: ipssi
--

COPY public.ad (id, title, description, status, updated, created, category_id, user_id) FROM stdin;
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: ipssi
--

COPY public.address (id, address1, address2, postal_code, city, country, latitude, longitude, updated, created, user_id) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: ipssi
--

COPY public.category (id, name, description) FROM stdin;
\.


--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: ipssi
--

COPY public.conversation (id, updated, created, ad_id) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: ipssi
--

COPY public.message (id, content, updated, created, conversation_id, sender_id) FROM stdin;
\.


--
-- Data for Name: mission; Type: TABLE DATA; Schema: public; Owner: ipssi
--

COPY public.mission (id, updated, created, ad_id, customer_id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: ipssi
--

COPY public."user" (id, email, gender, first_name, last_name, phone, birth_date, updated, created) FROM stdin;
\.


--
-- Name: ad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ipssi
--

SELECT pg_catalog.setval('public.ad_id_seq', 1, false);


--
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ipssi
--

SELECT pg_catalog.setval('public.address_id_seq', 1, false);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ipssi
--

SELECT pg_catalog.setval('public.category_id_seq', 1, false);


--
-- Name: conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ipssi
--

SELECT pg_catalog.setval('public.conversation_id_seq', 1, false);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ipssi
--

SELECT pg_catalog.setval('public.message_id_seq', 1, false);


--
-- Name: mission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ipssi
--

SELECT pg_catalog.setval('public.mission_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ipssi
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- Name: ad ad_pkey; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.ad
    ADD CONSTRAINT ad_pkey PRIMARY KEY (id);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: address address_user_id_key; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_user_id_key UNIQUE (user_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: mission mission_pkey; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_email_phone_b2d089ae_uniq; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_phone_b2d089ae_uniq UNIQUE (email, phone);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: ad_category_id_2d95fbd9; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX ad_category_id_2d95fbd9 ON public.ad USING btree (category_id);


--
-- Name: ad_title_fad397_idx; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX ad_title_fad397_idx ON public.ad USING btree (title, status);


--
-- Name: ad_user_id_c2e99f71; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX ad_user_id_c2e99f71 ON public.ad USING btree (user_id);


--
-- Name: address_address_b207d7_idx; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX address_address_b207d7_idx ON public.address USING btree (address1, postal_code);


--
-- Name: category_name_d601b7_idx; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX category_name_d601b7_idx ON public.category USING btree (name);


--
-- Name: conversation_ad_id_1e95ceb7; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX conversation_ad_id_1e95ceb7 ON public.conversation USING btree (ad_id);


--
-- Name: message_conversation_id_87e8709d; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX message_conversation_id_87e8709d ON public.message USING btree (conversation_id);


--
-- Name: message_sender_id_a2a2e825; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX message_sender_id_a2a2e825 ON public.message USING btree (sender_id);


--
-- Name: mission_ad_id_8329a616; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX mission_ad_id_8329a616 ON public.mission USING btree (ad_id);


--
-- Name: mission_customer_id_098dc93c; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX mission_customer_id_098dc93c ON public.mission USING btree (customer_id);


--
-- Name: user_email_54dc62b2_like; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX user_email_54dc62b2_like ON public."user" USING btree (email varchar_pattern_ops);


--
-- Name: user_email_7cf9e9_idx; Type: INDEX; Schema: public; Owner: ipssi
--

CREATE INDEX user_email_7cf9e9_idx ON public."user" USING btree (email, phone);


--
-- Name: ad ad_category_id_2d95fbd9_fk_category_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.ad
    ADD CONSTRAINT ad_category_id_2d95fbd9_fk_category_id FOREIGN KEY (category_id) REFERENCES public.category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ad ad_user_id_c2e99f71_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.ad
    ADD CONSTRAINT ad_user_id_c2e99f71_fk_user_id FOREIGN KEY (user_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: address address_user_id_c030de7d_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_user_id_c030de7d_fk_user_id FOREIGN KEY (user_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: conversation conversation_ad_id_1e95ceb7_fk_ad_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_ad_id_1e95ceb7_fk_ad_id FOREIGN KEY (ad_id) REFERENCES public.ad(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: message message_conversation_id_87e8709d_fk_conversation_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_conversation_id_87e8709d_fk_conversation_id FOREIGN KEY (conversation_id) REFERENCES public.conversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: message message_sender_id_a2a2e825_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_sender_id_a2a2e825_fk_user_id FOREIGN KEY (sender_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mission mission_ad_id_8329a616_fk_ad_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_ad_id_8329a616_fk_ad_id FOREIGN KEY (ad_id) REFERENCES public.ad(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mission mission_customer_id_098dc93c_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ipssi
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_customer_id_098dc93c_fk_user_id FOREIGN KEY (customer_id) REFERENCES public."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

