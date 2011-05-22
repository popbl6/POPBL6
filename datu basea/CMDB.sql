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
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: jabea
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO jabea;

SET search_path = public, pg_catalog;

--
-- Name: checkci(integer); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION checkci(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
cur cursor for select * from CI;
r record;
BEGIN
open cur;
fetch cur into r;
while found loop
if r.idCI=$1 then
return true;
end if;
fetch cur into r;
end loop; 
return false;
close cur;
END
$_$;


ALTER FUNCTION public.checkci(integer) OWNER TO jabea;

--
-- Name: checkuser(integer); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION checkuser(integer) RETURNS integer
    LANGUAGE sql
    AS $_$
select idDepartamentua from Langileak where idLangileak = $1;
$_$;


ALTER FUNCTION public.checkuser(integer) OWNER TO jabea;

--
-- Name: getaktiboak(integer); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION getaktiboak(integer) RETURNS SETOF record
    LANGUAGE sql
    AS $_$
select *
from ci 
where idmota=$1;
$_$;


ALTER FUNCTION public.getaktiboak(integer) OWNER TO jabea;

--
-- Name: getinzidentziak(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION getinzidentziak() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select * from inzidentziak where konponduta != true;
$$;


ALTER FUNCTION public.getinzidentziak() OWNER TO jabea;

--
-- Name: ikuskomunikaziolineak(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION ikuskomunikaziolineak() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select idCI,Deskribapena,aeKapa,Oharrak,abiadura,isp
from ci where idmota=(Select idMota from motak where mota='Komunikazio lineak');
$$;


ALTER FUNCTION public.ikuskomunikaziolineak() OWNER TO jabea;

--
-- Name: ikuskontratuak(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION ikuskontratuak() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select idCI,deskribapena,idMota,aekapa,oharrak,kontratuAmaiera,kontaktua,sinatzailea
from ci where idmota=(Select idMota from motak where mota='Kontratuak');
$$;


ALTER FUNCTION public.ikuskontratuak() OWNER TO jabea;

--
-- Name: ikusordenagailuak(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION ikusordenagailuak() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select idCI,Deskribapena,jabea,aeKapa,Marka,Prozesagailua,Ram,diskoGogorra,modeloa,serieZenbakia,Oharrak
from ci where idmota=(Select idMota from motak where mota='Ordenagailuak');
$$;


ALTER FUNCTION public.ikusordenagailuak() OWNER TO jabea;

--
-- Name: ikussoftware(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION ikussoftware() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select idCI,Deskribapena,jabea,aeKapa,Marka,Bertsioa,serieZenbakia,oharrak
from ci where idmota=(Select idMota from motak where mota='Software');
$$;


ALTER FUNCTION public.ikussoftware() OWNER TO jabea;

--
-- Name: ikustelefonoak(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION ikustelefonoak() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select idCI,Deskribapena,jabea,aeKapa,Marka,modeloa,serieZenbakia,Oharrak,extensioa,TelefonoZki
from ci where idmota=(Select idMota from motak where mota='Telefonoak');
$$;


ALTER FUNCTION public.ikustelefonoak() OWNER TO jabea;

--
-- Name: inzidentziaitxi(integer, text, integer); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION inzidentziaitxi(integer, text, integer) RETURNS void
    LANGUAGE sql
    AS $_$
update inzidentziak set inzidentziaItxi=$1,deskribapenaKonpon=$2,konponduta=true where idInzidentziak=$3;
$_$;


ALTER FUNCTION public.inzidentziaitxi(integer, text, integer) OWNER TO jabea;

--
-- Name: inzidentziamotak(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION inzidentziamotak() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select * from inzidentziaMotak;
$$;


ALTER FUNCTION public.inzidentziamotak() OWNER TO jabea;

--
-- Name: inzidentziasortu(integer, text, integer, integer); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION inzidentziasortu(integer, text, integer, integer) RETURNS void
    LANGUAGE sql
    AS $_$
insert into inzidentziak(inzidentziaHasi,timestamp,DeskribapenaArazo,idCi,inzidentziaMota,konponduta) values($1,now()::timestamp,$2,$3,$4,false)
$_$;


ALTER FUNCTION public.inzidentziasortu(integer, text, integer, integer) OWNER TO jabea;

--
-- Name: motak(); Type: FUNCTION; Schema: public; Owner: jabea
--

CREATE FUNCTION motak() RETURNS SETOF record
    LANGUAGE sql
    AS $$
select * from motak;
$$;


ALTER FUNCTION public.motak() OWNER TO jabea;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ci; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE ci (
    idci integer NOT NULL,
    deskribapena character varying(300),
    idmota integer,
    jabea character varying(60),
    aekapa character varying(45),
    marka character varying(200),
    bertsioa character varying(10),
    prozesagailua character varying(100),
    ram character varying(45),
    diskogogorra character varying(45),
    modeloa character varying(200),
    seriezenbakia character varying(45),
    oharrak character varying(500),
    extensioa character varying(15),
    abiadura character varying(45),
    telefonozki character varying(25),
    kontratuamaiera date,
    isp character varying(45),
    hasierakopuntua character varying(45),
    bukaerapuntua character varying(45),
    kontaktua character varying(45),
    sinatzailea character varying(45)
);


ALTER TABLE public.ci OWNER TO jabea;

--
-- Name: ci_idci_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE ci_idci_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ci_idci_seq OWNER TO jabea;

--
-- Name: ci_idci_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE ci_idci_seq OWNED BY ci.idci;


--
-- Name: ci_idci_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('ci_idci_seq', 6, true);


--
-- Name: cihornitzaileak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE cihornitzaileak (
    idcihornitzailea integer NOT NULL,
    idhornitzaileak integer,
    idci integer,
    deskribapena character varying(45)
);


ALTER TABLE public.cihornitzaileak OWNER TO jabea;

--
-- Name: cihornitzaileak_idcihornitzailea_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE cihornitzaileak_idcihornitzailea_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cihornitzaileak_idcihornitzailea_seq OWNER TO jabea;

--
-- Name: cihornitzaileak_idcihornitzailea_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE cihornitzaileak_idcihornitzailea_seq OWNED BY cihornitzaileak.idcihornitzailea;


--
-- Name: cihornitzaileak_idcihornitzailea_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('cihornitzaileak_idcihornitzailea_seq', 1, false);


--
-- Name: cilangileak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE cilangileak (
    idcilangile integer NOT NULL,
    idlangile integer,
    idci integer,
    deskribapena character varying(500)
);


ALTER TABLE public.cilangileak OWNER TO jabea;

--
-- Name: cilangileak_idcilangile_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE cilangileak_idcilangile_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cilangileak_idcilangile_seq OWNER TO jabea;

--
-- Name: cilangileak_idcilangile_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE cilangileak_idcilangile_seq OWNED BY cilangileak.idcilangile;


--
-- Name: cilangileak_idcilangile_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('cilangileak_idcilangile_seq', 1, false);


--
-- Name: departamentuak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE departamentuak (
    iddepartamentua integer NOT NULL,
    departamentua character varying(45)
);


ALTER TABLE public.departamentuak OWNER TO jabea;

--
-- Name: departamentuak_iddepartamentua_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE departamentuak_iddepartamentua_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.departamentuak_iddepartamentua_seq OWNER TO jabea;

--
-- Name: departamentuak_iddepartamentua_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE departamentuak_iddepartamentua_seq OWNED BY departamentuak.iddepartamentua;


--
-- Name: departamentuak_iddepartamentua_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('departamentuak_iddepartamentua_seq', 1, true);


--
-- Name: erlazioak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE erlazioak (
    iderlazioak integer NOT NULL,
    ci1 integer,
    ci2 integer,
    deskribapena character varying(500)
);


ALTER TABLE public.erlazioak OWNER TO jabea;

--
-- Name: erlazioak_iderlazioak_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE erlazioak_iderlazioak_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.erlazioak_iderlazioak_seq OWNER TO jabea;

--
-- Name: erlazioak_iderlazioak_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE erlazioak_iderlazioak_seq OWNED BY erlazioak.iderlazioak;


--
-- Name: erlazioak_iderlazioak_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('erlazioak_iderlazioak_seq', 1, false);


--
-- Name: hornitzaileak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE hornitzaileak (
    idhornitzaileak integer NOT NULL,
    izena character varying(45),
    abizena character varying(45),
    helbidea character varying(90),
    telefonoa character varying(45)
);


ALTER TABLE public.hornitzaileak OWNER TO jabea;

--
-- Name: hornitzaileak_idhornitzaileak_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE hornitzaileak_idhornitzaileak_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.hornitzaileak_idhornitzaileak_seq OWNER TO jabea;

--
-- Name: hornitzaileak_idhornitzaileak_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE hornitzaileak_idhornitzaileak_seq OWNED BY hornitzaileak.idhornitzaileak;


--
-- Name: hornitzaileak_idhornitzaileak_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('hornitzaileak_idhornitzaileak_seq', 1, false);


--
-- Name: inzidentziak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE inzidentziak (
    idinzidentziak integer NOT NULL,
    inzidentziahasi integer,
    inzidentziaitxi integer,
    "timestamp" timestamp without time zone,
    deskribapenaarazo character varying(500),
    deskribapenakonpon character varying(500),
    idci integer,
    konponduta boolean,
    inzidentziamota integer
);


ALTER TABLE public.inzidentziak OWNER TO jabea;

--
-- Name: inzidentziak_idinzidentziak_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE inzidentziak_idinzidentziak_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.inzidentziak_idinzidentziak_seq OWNER TO jabea;

--
-- Name: inzidentziak_idinzidentziak_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE inzidentziak_idinzidentziak_seq OWNED BY inzidentziak.idinzidentziak;


--
-- Name: inzidentziak_idinzidentziak_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('inzidentziak_idinzidentziak_seq', 2, true);


--
-- Name: inzidentziamotak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE inzidentziamotak (
    idinzidentziamotak integer NOT NULL,
    mota character varying(200)
);


ALTER TABLE public.inzidentziamotak OWNER TO jabea;

--
-- Name: inzidentziamotak_idinzidentziamotak_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE inzidentziamotak_idinzidentziamotak_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.inzidentziamotak_idinzidentziamotak_seq OWNER TO jabea;

--
-- Name: inzidentziamotak_idinzidentziamotak_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE inzidentziamotak_idinzidentziamotak_seq OWNED BY inzidentziamotak.idinzidentziamotak;


--
-- Name: inzidentziamotak_idinzidentziamotak_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('inzidentziamotak_idinzidentziamotak_seq', 1, true);


--
-- Name: langileak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE langileak (
    idlangileak integer NOT NULL,
    izena character varying(45),
    abizena character varying(45),
    helbidea character varying(90),
    telefonoa character varying(45),
    salarioa numeric(10,0),
    postua character varying(45),
    pasahitza character varying(45),
    iddepartamentua integer
);


ALTER TABLE public.langileak OWNER TO jabea;

--
-- Name: langileak_idlangileak_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE langileak_idlangileak_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.langileak_idlangileak_seq OWNER TO jabea;

--
-- Name: langileak_idlangileak_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE langileak_idlangileak_seq OWNED BY langileak.idlangileak;


--
-- Name: langileak_idlangileak_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('langileak_idlangileak_seq', 2, true);


--
-- Name: motak; Type: TABLE; Schema: public; Owner: jabea; Tablespace: 
--

CREATE TABLE motak (
    idmota integer NOT NULL,
    mota character varying(45)
);


ALTER TABLE public.motak OWNER TO jabea;

--
-- Name: motak_idmota_seq; Type: SEQUENCE; Schema: public; Owner: jabea
--

CREATE SEQUENCE motak_idmota_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.motak_idmota_seq OWNER TO jabea;

--
-- Name: motak_idmota_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jabea
--

ALTER SEQUENCE motak_idmota_seq OWNED BY motak.idmota;


--
-- Name: motak_idmota_seq; Type: SEQUENCE SET; Schema: public; Owner: jabea
--

SELECT pg_catalog.setval('motak_idmota_seq', 2, true);


--
-- Name: idci; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE ci ALTER COLUMN idci SET DEFAULT nextval('ci_idci_seq'::regclass);


--
-- Name: idcihornitzailea; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE cihornitzaileak ALTER COLUMN idcihornitzailea SET DEFAULT nextval('cihornitzaileak_idcihornitzailea_seq'::regclass);


--
-- Name: idcilangile; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE cilangileak ALTER COLUMN idcilangile SET DEFAULT nextval('cilangileak_idcilangile_seq'::regclass);


--
-- Name: iddepartamentua; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE departamentuak ALTER COLUMN iddepartamentua SET DEFAULT nextval('departamentuak_iddepartamentua_seq'::regclass);


--
-- Name: iderlazioak; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE erlazioak ALTER COLUMN iderlazioak SET DEFAULT nextval('erlazioak_iderlazioak_seq'::regclass);


--
-- Name: idhornitzaileak; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE hornitzaileak ALTER COLUMN idhornitzaileak SET DEFAULT nextval('hornitzaileak_idhornitzaileak_seq'::regclass);


--
-- Name: idinzidentziak; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE inzidentziak ALTER COLUMN idinzidentziak SET DEFAULT nextval('inzidentziak_idinzidentziak_seq'::regclass);


--
-- Name: idinzidentziamotak; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE inzidentziamotak ALTER COLUMN idinzidentziamotak SET DEFAULT nextval('inzidentziamotak_idinzidentziamotak_seq'::regclass);


--
-- Name: idlangileak; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE langileak ALTER COLUMN idlangileak SET DEFAULT nextval('langileak_idlangileak_seq'::regclass);


--
-- Name: idmota; Type: DEFAULT; Schema: public; Owner: jabea
--

ALTER TABLE motak ALTER COLUMN idmota SET DEFAULT nextval('motak_idmota_seq'::regclass);


--
-- Data for Name: ci; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY ci (idci, deskribapena, idmota, jabea, aekapa, marka, bertsioa, prozesagailua, ram, diskogogorra, modeloa, seriezenbakia, oharrak, extensioa, abiadura, telefonozki, kontratuamaiera, isp, hasierakopuntua, bukaerapuntua, kontaktua, sinatzailea) FROM stdin;
3	ordenagailu 1	1	norbait	5	asus	\N	core i7	6GB	seagate	3	999999999	ezer	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	ordenagailu 2	1	norbait	5	asus	\N	core i7	6GB	seagate	3	888888888	ezer	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	programa 1	2	norbait	4	gimp	2	\N	\N	\N	\N	\N	ezer	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	programa 2	2	norbait	4	firefox	4.0	\N	\N	\N	\N	\N	ezer	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: cihornitzaileak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY cihornitzaileak (idcihornitzailea, idhornitzaileak, idci, deskribapena) FROM stdin;
\.


--
-- Data for Name: cilangileak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY cilangileak (idcilangile, idlangile, idci, deskribapena) FROM stdin;
\.


--
-- Data for Name: departamentuak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY departamentuak (iddepartamentua, departamentua) FROM stdin;
1	departamentu1
\.


--
-- Data for Name: erlazioak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY erlazioak (iderlazioak, ci1, ci2, deskribapena) FROM stdin;
\.


--
-- Data for Name: hornitzaileak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY hornitzaileak (idhornitzaileak, izena, abizena, helbidea, telefonoa) FROM stdin;
\.


--
-- Data for Name: inzidentziak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY inzidentziak (idinzidentziak, inzidentziahasi, inzidentziaitxi, "timestamp", deskribapenaarazo, deskribapenakonpon, idci, konponduta, inzidentziamota) FROM stdin;
1	1	2	2011-05-22 18:33:13.918269	ez doa	Entxufatu	3	t	1
2	1	2	2011-05-22 18:47:52.242396	ez doa	aaaaaaaaaa	4	t	1
\.


--
-- Data for Name: inzidentziamotak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY inzidentziamotak (idinzidentziamotak, mota) FROM stdin;
1	inzidentzia1
\.


--
-- Data for Name: langileak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY langileak (idlangileak, izena, abizena, helbidea, telefonoa, salarioa, postua, pasahitza, iddepartamentua) FROM stdin;
1	izen1	abizen1	helbide1	telefono1	123456789	postu1	qwerty	1
2	izen2	abizen2	helbide2	telefono2	123456789	postu2	qwerty	1
\.


--
-- Data for Name: motak; Type: TABLE DATA; Schema: public; Owner: jabea
--

COPY motak (idmota, mota) FROM stdin;
1	Ordenagailuak
2	Software
\.


--
-- Name: ci_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY ci
    ADD CONSTRAINT ci_pkey PRIMARY KEY (idci);


--
-- Name: cihornitzaileak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY cihornitzaileak
    ADD CONSTRAINT cihornitzaileak_pkey PRIMARY KEY (idcihornitzailea);


--
-- Name: cilangileak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY cilangileak
    ADD CONSTRAINT cilangileak_pkey PRIMARY KEY (idcilangile);


--
-- Name: departamentuak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY departamentuak
    ADD CONSTRAINT departamentuak_pkey PRIMARY KEY (iddepartamentua);


--
-- Name: erlazioak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY erlazioak
    ADD CONSTRAINT erlazioak_pkey PRIMARY KEY (iderlazioak);


--
-- Name: hornitzaileak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY hornitzaileak
    ADD CONSTRAINT hornitzaileak_pkey PRIMARY KEY (idhornitzaileak);


--
-- Name: inzidentziak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY inzidentziak
    ADD CONSTRAINT inzidentziak_pkey PRIMARY KEY (idinzidentziak);


--
-- Name: inzidentziamotak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY inzidentziamotak
    ADD CONSTRAINT inzidentziamotak_pkey PRIMARY KEY (idinzidentziamotak);


--
-- Name: langileak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY langileak
    ADD CONSTRAINT langileak_pkey PRIMARY KEY (idlangileak);


--
-- Name: motak_pkey; Type: CONSTRAINT; Schema: public; Owner: jabea; Tablespace: 
--

ALTER TABLE ONLY motak
    ADD CONSTRAINT motak_pkey PRIMARY KEY (idmota);


--
-- Name: cihornicfk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY cihornitzaileak
    ADD CONSTRAINT cihornicfk FOREIGN KEY (idci) REFERENCES ci(idci);


--
-- Name: cihornihfk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY cihornitzaileak
    ADD CONSTRAINT cihornihfk FOREIGN KEY (idhornitzaileak) REFERENCES hornitzaileak(idhornitzaileak);


--
-- Name: cilangilec; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY cilangileak
    ADD CONSTRAINT cilangilec FOREIGN KEY (idci) REFERENCES ci(idci);


--
-- Name: cilangilelfk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY cilangileak
    ADD CONSTRAINT cilangilelfk FOREIGN KEY (idlangile) REFERENCES langileak(idlangileak);


--
-- Name: cimotafk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY ci
    ADD CONSTRAINT cimotafk FOREIGN KEY (idmota) REFERENCES motak(idmota);


--
-- Name: erlaci2fk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY erlazioak
    ADD CONSTRAINT erlaci2fk FOREIGN KEY (ci2) REFERENCES ci(idci);


--
-- Name: erlacifk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY erlazioak
    ADD CONSTRAINT erlacifk FOREIGN KEY (ci1) REFERENCES ci(idci);


--
-- Name: inzibukafk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY inzidentziak
    ADD CONSTRAINT inzibukafk FOREIGN KEY (inzidentziaitxi) REFERENCES langileak(idlangileak);


--
-- Name: inzicifk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY inzidentziak
    ADD CONSTRAINT inzicifk FOREIGN KEY (idci) REFERENCES ci(idci);


--
-- Name: inzihasifk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY inzidentziak
    ADD CONSTRAINT inzihasifk FOREIGN KEY (inzidentziahasi) REFERENCES langileak(idlangileak);


--
-- Name: inzimotafk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY inzidentziak
    ADD CONSTRAINT inzimotafk FOREIGN KEY (inzidentziamota) REFERENCES inzidentziamotak(idinzidentziamotak);


--
-- Name: langileakdeptfk; Type: FK CONSTRAINT; Schema: public; Owner: jabea
--

ALTER TABLE ONLY langileak
    ADD CONSTRAINT langileakdeptfk FOREIGN KEY (iddepartamentua) REFERENCES departamentuak(iddepartamentua);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: checkci(integer); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION checkci(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION checkci(integer) FROM jabea;
GRANT ALL ON FUNCTION checkci(integer) TO jabea;
GRANT ALL ON FUNCTION checkci(integer) TO PUBLIC;
GRANT ALL ON FUNCTION checkci(integer) TO "Programak";


--
-- Name: checkuser(integer); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION checkuser(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION checkuser(integer) FROM jabea;
GRANT ALL ON FUNCTION checkuser(integer) TO jabea;
GRANT ALL ON FUNCTION checkuser(integer) TO PUBLIC;
GRANT ALL ON FUNCTION checkuser(integer) TO "Programak";


--
-- Name: getaktiboak(integer); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION getaktiboak(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION getaktiboak(integer) FROM jabea;
GRANT ALL ON FUNCTION getaktiboak(integer) TO jabea;
GRANT ALL ON FUNCTION getaktiboak(integer) TO PUBLIC;
GRANT ALL ON FUNCTION getaktiboak(integer) TO "Programak";


--
-- Name: getinzidentziak(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION getinzidentziak() FROM PUBLIC;
REVOKE ALL ON FUNCTION getinzidentziak() FROM jabea;
GRANT ALL ON FUNCTION getinzidentziak() TO jabea;
GRANT ALL ON FUNCTION getinzidentziak() TO PUBLIC;
GRANT ALL ON FUNCTION getinzidentziak() TO "Programak";


--
-- Name: ikuskomunikaziolineak(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION ikuskomunikaziolineak() FROM PUBLIC;
REVOKE ALL ON FUNCTION ikuskomunikaziolineak() FROM jabea;
GRANT ALL ON FUNCTION ikuskomunikaziolineak() TO jabea;
GRANT ALL ON FUNCTION ikuskomunikaziolineak() TO PUBLIC;
GRANT ALL ON FUNCTION ikuskomunikaziolineak() TO "Programak";


--
-- Name: ikuskontratuak(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION ikuskontratuak() FROM PUBLIC;
REVOKE ALL ON FUNCTION ikuskontratuak() FROM jabea;
GRANT ALL ON FUNCTION ikuskontratuak() TO jabea;
GRANT ALL ON FUNCTION ikuskontratuak() TO PUBLIC;
GRANT ALL ON FUNCTION ikuskontratuak() TO "Programak";


--
-- Name: ikusordenagailuak(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION ikusordenagailuak() FROM PUBLIC;
REVOKE ALL ON FUNCTION ikusordenagailuak() FROM jabea;
GRANT ALL ON FUNCTION ikusordenagailuak() TO jabea;
GRANT ALL ON FUNCTION ikusordenagailuak() TO PUBLIC;
GRANT ALL ON FUNCTION ikusordenagailuak() TO "Programak";


--
-- Name: ikussoftware(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION ikussoftware() FROM PUBLIC;
REVOKE ALL ON FUNCTION ikussoftware() FROM jabea;
GRANT ALL ON FUNCTION ikussoftware() TO jabea;
GRANT ALL ON FUNCTION ikussoftware() TO PUBLIC;
GRANT ALL ON FUNCTION ikussoftware() TO "Programak";


--
-- Name: ikustelefonoak(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION ikustelefonoak() FROM PUBLIC;
REVOKE ALL ON FUNCTION ikustelefonoak() FROM jabea;
GRANT ALL ON FUNCTION ikustelefonoak() TO jabea;
GRANT ALL ON FUNCTION ikustelefonoak() TO PUBLIC;
GRANT ALL ON FUNCTION ikustelefonoak() TO "Programak";


--
-- Name: inzidentziaitxi(integer, text, integer); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION inzidentziaitxi(integer, text, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION inzidentziaitxi(integer, text, integer) FROM jabea;
GRANT ALL ON FUNCTION inzidentziaitxi(integer, text, integer) TO jabea;
GRANT ALL ON FUNCTION inzidentziaitxi(integer, text, integer) TO PUBLIC;
GRANT ALL ON FUNCTION inzidentziaitxi(integer, text, integer) TO "Programak";


--
-- Name: inzidentziamotak(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION inzidentziamotak() FROM PUBLIC;
REVOKE ALL ON FUNCTION inzidentziamotak() FROM jabea;
GRANT ALL ON FUNCTION inzidentziamotak() TO jabea;
GRANT ALL ON FUNCTION inzidentziamotak() TO PUBLIC;
GRANT ALL ON FUNCTION inzidentziamotak() TO "Programak";


--
-- Name: inzidentziasortu(integer, text, integer, integer); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION inzidentziasortu(integer, text, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION inzidentziasortu(integer, text, integer, integer) FROM jabea;
GRANT ALL ON FUNCTION inzidentziasortu(integer, text, integer, integer) TO jabea;
GRANT ALL ON FUNCTION inzidentziasortu(integer, text, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION inzidentziasortu(integer, text, integer, integer) TO "Programak";


--
-- Name: motak(); Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON FUNCTION motak() FROM PUBLIC;
REVOKE ALL ON FUNCTION motak() FROM jabea;
GRANT ALL ON FUNCTION motak() TO jabea;
GRANT ALL ON FUNCTION motak() TO PUBLIC;
GRANT ALL ON FUNCTION motak() TO "Programak";


--
-- Name: ci; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE ci FROM PUBLIC;
REVOKE ALL ON TABLE ci FROM jabea;
GRANT ALL ON TABLE ci TO jabea;
GRANT ALL ON TABLE ci TO "Programak";


--
-- Name: ci_idci_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE ci_idci_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE ci_idci_seq FROM jabea;
GRANT ALL ON SEQUENCE ci_idci_seq TO jabea;
GRANT ALL ON SEQUENCE ci_idci_seq TO "Programak";


--
-- Name: cihornitzaileak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE cihornitzaileak FROM PUBLIC;
REVOKE ALL ON TABLE cihornitzaileak FROM jabea;
GRANT ALL ON TABLE cihornitzaileak TO jabea;
GRANT ALL ON TABLE cihornitzaileak TO "Programak";


--
-- Name: cihornitzaileak_idcihornitzailea_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE cihornitzaileak_idcihornitzailea_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE cihornitzaileak_idcihornitzailea_seq FROM jabea;
GRANT ALL ON SEQUENCE cihornitzaileak_idcihornitzailea_seq TO jabea;
GRANT ALL ON SEQUENCE cihornitzaileak_idcihornitzailea_seq TO "Programak";


--
-- Name: cilangileak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE cilangileak FROM PUBLIC;
REVOKE ALL ON TABLE cilangileak FROM jabea;
GRANT ALL ON TABLE cilangileak TO jabea;
GRANT ALL ON TABLE cilangileak TO "Programak";


--
-- Name: cilangileak_idcilangile_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE cilangileak_idcilangile_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE cilangileak_idcilangile_seq FROM jabea;
GRANT ALL ON SEQUENCE cilangileak_idcilangile_seq TO jabea;
GRANT ALL ON SEQUENCE cilangileak_idcilangile_seq TO "Programak";


--
-- Name: departamentuak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE departamentuak FROM PUBLIC;
REVOKE ALL ON TABLE departamentuak FROM jabea;
GRANT ALL ON TABLE departamentuak TO jabea;
GRANT ALL ON TABLE departamentuak TO "Programak";


--
-- Name: departamentuak_iddepartamentua_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE departamentuak_iddepartamentua_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE departamentuak_iddepartamentua_seq FROM jabea;
GRANT ALL ON SEQUENCE departamentuak_iddepartamentua_seq TO jabea;
GRANT ALL ON SEQUENCE departamentuak_iddepartamentua_seq TO "Programak";


--
-- Name: erlazioak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE erlazioak FROM PUBLIC;
REVOKE ALL ON TABLE erlazioak FROM jabea;
GRANT ALL ON TABLE erlazioak TO jabea;
GRANT ALL ON TABLE erlazioak TO "Programak";


--
-- Name: erlazioak_iderlazioak_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE erlazioak_iderlazioak_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE erlazioak_iderlazioak_seq FROM jabea;
GRANT ALL ON SEQUENCE erlazioak_iderlazioak_seq TO jabea;
GRANT ALL ON SEQUENCE erlazioak_iderlazioak_seq TO "Programak";


--
-- Name: hornitzaileak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE hornitzaileak FROM PUBLIC;
REVOKE ALL ON TABLE hornitzaileak FROM jabea;
GRANT ALL ON TABLE hornitzaileak TO jabea;
GRANT ALL ON TABLE hornitzaileak TO "Programak";


--
-- Name: hornitzaileak_idhornitzaileak_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE hornitzaileak_idhornitzaileak_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE hornitzaileak_idhornitzaileak_seq FROM jabea;
GRANT ALL ON SEQUENCE hornitzaileak_idhornitzaileak_seq TO jabea;
GRANT ALL ON SEQUENCE hornitzaileak_idhornitzaileak_seq TO "Programak";


--
-- Name: inzidentziak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE inzidentziak FROM PUBLIC;
REVOKE ALL ON TABLE inzidentziak FROM jabea;
GRANT ALL ON TABLE inzidentziak TO jabea;
GRANT ALL ON TABLE inzidentziak TO "Programak";


--
-- Name: inzidentziak_idinzidentziak_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE inzidentziak_idinzidentziak_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE inzidentziak_idinzidentziak_seq FROM jabea;
GRANT ALL ON SEQUENCE inzidentziak_idinzidentziak_seq TO jabea;
GRANT ALL ON SEQUENCE inzidentziak_idinzidentziak_seq TO "Programak";


--
-- Name: inzidentziamotak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE inzidentziamotak FROM PUBLIC;
REVOKE ALL ON TABLE inzidentziamotak FROM jabea;
GRANT ALL ON TABLE inzidentziamotak TO jabea;
GRANT ALL ON TABLE inzidentziamotak TO "Programak";


--
-- Name: inzidentziamotak_idinzidentziamotak_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE inzidentziamotak_idinzidentziamotak_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE inzidentziamotak_idinzidentziamotak_seq FROM jabea;
GRANT ALL ON SEQUENCE inzidentziamotak_idinzidentziamotak_seq TO jabea;
GRANT ALL ON SEQUENCE inzidentziamotak_idinzidentziamotak_seq TO "Programak";


--
-- Name: langileak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE langileak FROM PUBLIC;
REVOKE ALL ON TABLE langileak FROM jabea;
GRANT ALL ON TABLE langileak TO jabea;
GRANT ALL ON TABLE langileak TO "Programak";


--
-- Name: langileak_idlangileak_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE langileak_idlangileak_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE langileak_idlangileak_seq FROM jabea;
GRANT ALL ON SEQUENCE langileak_idlangileak_seq TO jabea;
GRANT ALL ON SEQUENCE langileak_idlangileak_seq TO "Programak";


--
-- Name: motak; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON TABLE motak FROM PUBLIC;
REVOKE ALL ON TABLE motak FROM jabea;
GRANT ALL ON TABLE motak TO jabea;
GRANT ALL ON TABLE motak TO "Programak";


--
-- Name: motak_idmota_seq; Type: ACL; Schema: public; Owner: jabea
--

REVOKE ALL ON SEQUENCE motak_idmota_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE motak_idmota_seq FROM jabea;
GRANT ALL ON SEQUENCE motak_idmota_seq TO jabea;
GRANT ALL ON SEQUENCE motak_idmota_seq TO "Programak";


--
-- PostgreSQL database dump complete
--

