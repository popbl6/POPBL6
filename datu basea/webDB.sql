--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: ugaitz
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO ugaitz;

SET search_path = public, pg_catalog;

--
-- Name: aldatuerabiltzailea(text, text); Type: FUNCTION; Schema: public; Owner: ugaitz
--

CREATE FUNCTION aldatuerabiltzailea(text, text) RETURNS void
    LANGUAGE sql
    AS $_$
    update erabiltzaileak set password=md5($2) where username=$1;
$_$;


ALTER FUNCTION public.aldatuerabiltzailea(text, text) OWNER TO ugaitz;

--
-- Name: bidalierabiltzailea(text, text, integer, text); Type: FUNCTION; Schema: public; Owner: ugaitz
--

CREATE FUNCTION bidalierabiltzailea(text, text, integer, text) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare 
    r record;
    cur cursor for select username from erabiltzaileak where username = $1;
begin
    open cur;
    fetch cur into r;
    if found then 
        return false;
    end if;
    close cur;
    insert into Erabiltzaileak values(default,$1,md5($2),$3,$4);
    return true;
end
$_$;


ALTER FUNCTION public.bidalierabiltzailea(text, text, integer, text) OWNER TO ugaitz;

--
-- Name: bidaliusermota(text); Type: FUNCTION; Schema: public; Owner: ugaitz
--

CREATE FUNCTION bidaliusermota(text) RETURNS void
    LANGUAGE sql
    AS $_$
insert into userMota(usermotaizen) values($1);
$_$;


ALTER FUNCTION public.bidaliusermota(text) OWNER TO ugaitz;

--
-- Name: checkuser(text, text); Type: FUNCTION; Schema: public; Owner: ugaitz
--

CREATE FUNCTION checkuser(text, text) RETURNS integer
    LANGUAGE sql
    AS $_$

select usermota from erabiltzaileak where username = $1 and password = md5($2);

$_$;


ALTER FUNCTION public.checkuser(text, text) OWNER TO ugaitz;

--
-- Name: ezabatuerabiltzailea(text); Type: FUNCTION; Schema: public; Owner: ugaitz
--

CREATE FUNCTION ezabatuerabiltzailea(text) RETURNS void
    LANGUAGE sql
    AS $_$
    delete from erabiltzaileak where username=$1;
$_$;


ALTER FUNCTION public.ezabatuerabiltzailea(text) OWNER TO ugaitz;

--
-- Name: ezabatuusermota(text); Type: FUNCTION; Schema: public; Owner: ugaitz
--

CREATE FUNCTION ezabatuusermota(text) RETURNS void
    LANGUAGE sql
    AS $_$
delete from usermota where usermotaizen=$1;
$_$;


ALTER FUNCTION public.ezabatuusermota(text) OWNER TO ugaitz;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: erabiltzaileak; Type: TABLE; Schema: public; Owner: ugaitz; Tablespace: 
--

CREATE TABLE erabiltzaileak (
    userkod integer NOT NULL,
    username character varying(20),
    password character varying(250),
    usermota integer,
    email character varying(40)
);


ALTER TABLE public.erabiltzaileak OWNER TO ugaitz;

--
-- Name: erabiltzaileak_userkod_seq; Type: SEQUENCE; Schema: public; Owner: ugaitz
--

CREATE SEQUENCE erabiltzaileak_userkod_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.erabiltzaileak_userkod_seq OWNER TO ugaitz;

--
-- Name: erabiltzaileak_userkod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ugaitz
--

ALTER SEQUENCE erabiltzaileak_userkod_seq OWNED BY erabiltzaileak.userkod;


--
-- Name: erabiltzaileak_userkod_seq; Type: SEQUENCE SET; Schema: public; Owner: ugaitz
--

SELECT pg_catalog.setval('erabiltzaileak_userkod_seq', 8, true);


--
-- Name: usermota; Type: TABLE; Schema: public; Owner: ugaitz; Tablespace: 
--

CREATE TABLE usermota (
    usermota integer NOT NULL,
    usermotaizen character varying(20)
);


ALTER TABLE public.usermota OWNER TO ugaitz;

--
-- Name: usermota_usermota_seq; Type: SEQUENCE; Schema: public; Owner: ugaitz
--

CREATE SEQUENCE usermota_usermota_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.usermota_usermota_seq OWNER TO ugaitz;

--
-- Name: usermota_usermota_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ugaitz
--

ALTER SEQUENCE usermota_usermota_seq OWNED BY usermota.usermota;


--
-- Name: usermota_usermota_seq; Type: SEQUENCE SET; Schema: public; Owner: ugaitz
--

SELECT pg_catalog.setval('usermota_usermota_seq', 1, false);


--
-- Name: userkod; Type: DEFAULT; Schema: public; Owner: ugaitz
--

ALTER TABLE erabiltzaileak ALTER COLUMN userkod SET DEFAULT nextval('erabiltzaileak_userkod_seq'::regclass);


--
-- Name: usermota; Type: DEFAULT; Schema: public; Owner: ugaitz
--

ALTER TABLE usermota ALTER COLUMN usermota SET DEFAULT nextval('usermota_usermota_seq'::regclass);


--
-- Data for Name: erabiltzaileak; Type: TABLE DATA; Schema: public; Owner: ugaitz
--

COPY erabiltzaileak (userkod, username, password, usermota, email) FROM stdin;
2	mantenu	d8578edf8458ce06fbc5bb76a58c5ca4	1	mantenu@localhost.com
4	admin	d8578edf8458ce06fbc5bb76a58c5ca4	2	admin@localhost.com
6	mantenu2	d8578edf8458ce06fbc5bb76a58c5ca4	1	mantenu2@localhost.com
7	admin2	d8578edf8458ce06fbc5bb76a58c5ca4	2	admin2@localhost.com
8	sa	7815696ecbf1c96e6894b779456d330e	0	2143124@.es
\.


--
-- Data for Name: usermota; Type: TABLE DATA; Schema: public; Owner: ugaitz
--

COPY usermota (usermota, usermotaizen) FROM stdin;
0	erabiltzaile
1	mantenu
2	admin
\.


--
-- Name: erabiltzaileak_pkey; Type: CONSTRAINT; Schema: public; Owner: ugaitz; Tablespace: 
--

ALTER TABLE ONLY erabiltzaileak
    ADD CONSTRAINT erabiltzaileak_pkey PRIMARY KEY (userkod);


--
-- Name: erabiltzaileak_username_key; Type: CONSTRAINT; Schema: public; Owner: ugaitz; Tablespace: 
--

ALTER TABLE ONLY erabiltzaileak
    ADD CONSTRAINT erabiltzaileak_username_key UNIQUE (username);


--
-- Name: usermota_pkey; Type: CONSTRAINT; Schema: public; Owner: ugaitz; Tablespace: 
--

ALTER TABLE ONLY usermota
    ADD CONSTRAINT usermota_pkey PRIMARY KEY (usermota);


--
-- Name: usermota_usermotaizen_key; Type: CONSTRAINT; Schema: public; Owner: ugaitz; Tablespace: 
--

ALTER TABLE ONLY usermota
    ADD CONSTRAINT usermota_usermotaizen_key UNIQUE (usermotaizen);


--
-- Name: usermotafk; Type: FK CONSTRAINT; Schema: public; Owner: ugaitz
--

ALTER TABLE ONLY erabiltzaileak
    ADD CONSTRAINT usermotafk FOREIGN KEY (usermota) REFERENCES usermota(usermota);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: aldatuerabiltzailea(text, text); Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON FUNCTION aldatuerabiltzailea(text, text) FROM PUBLIC;
GRANT ALL ON FUNCTION aldatuerabiltzailea(text, text) TO PUBLIC;
GRANT ALL ON FUNCTION aldatuerabiltzailea(text, text) TO "Programak";


--
-- Name: bidalierabiltzailea(text, text, integer, text); Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON FUNCTION bidalierabiltzailea(text, text, integer, text) FROM PUBLIC;
GRANT ALL ON FUNCTION bidalierabiltzailea(text, text, integer, text) TO PUBLIC;
GRANT ALL ON FUNCTION bidalierabiltzailea(text, text, integer, text) TO "Programak";


--
-- Name: bidaliusermota(text); Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON FUNCTION bidaliusermota(text) FROM PUBLIC;
GRANT ALL ON FUNCTION bidaliusermota(text) TO PUBLIC;
GRANT ALL ON FUNCTION bidaliusermota(text) TO "Programak";


--
-- Name: checkuser(text, text); Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON FUNCTION checkuser(text, text) FROM PUBLIC;
GRANT ALL ON FUNCTION checkuser(text, text) TO PUBLIC;
GRANT ALL ON FUNCTION checkuser(text, text) TO "Programak";


--
-- Name: ezabatuerabiltzailea(text); Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON FUNCTION ezabatuerabiltzailea(text) FROM PUBLIC;
GRANT ALL ON FUNCTION ezabatuerabiltzailea(text) TO PUBLIC;
GRANT ALL ON FUNCTION ezabatuerabiltzailea(text) TO "Programak";


--
-- Name: ezabatuusermota(text); Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON FUNCTION ezabatuusermota(text) FROM PUBLIC;
GRANT ALL ON FUNCTION ezabatuusermota(text) TO PUBLIC;
GRANT ALL ON FUNCTION ezabatuusermota(text) TO "Programak";


--
-- Name: erabiltzaileak; Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON TABLE erabiltzaileak FROM PUBLIC;
GRANT ALL ON TABLE erabiltzaileak TO "Programak";


--
-- Name: erabiltzaileak_userkod_seq; Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON SEQUENCE erabiltzaileak_userkod_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE erabiltzaileak_userkod_seq TO "Programak";


--
-- Name: usermota; Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON TABLE usermota FROM PUBLIC;
GRANT ALL ON TABLE usermota TO "Programak";


--
-- Name: usermota_usermota_seq; Type: ACL; Schema: public; Owner: ugaitz
--

REVOKE ALL ON SEQUENCE usermota_usermota_seq FROM PUBLIC;
GRANT ALL ON SEQUENCE usermota_usermota_seq TO "Programak";


--
-- PostgreSQL database dump complete
--

