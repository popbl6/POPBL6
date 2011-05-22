--CI-ekin zerikusia

create or replace function ikusTelefonoak()
returns setof record
as $$
select idCI,Deskribapena,jabea,aeKapa,Marka,modeloa,serieZenbakia,Oharrak,extensioa,TelefonoZki
from ci where idmota=(Select idMota from motak where mota='Telefonoak');
$$ language sql;

create or replace function ikusKontratuak()
returns setof record
as $$
select idCI,deskribapena,idMota,aekapa,oharrak,kontratuAmaiera,kontaktua,sinatzailea
from ci where idmota=(Select idMota from motak where mota='Kontratuak');
$$ language sql;

create or replace function ikusSoftware()
returns setof record
as $$
select idCI,Deskribapena,jabea,aeKapa,Marka,Bertsioa,serieZenbakia,oharrak
from ci where idmota=(Select idMota from motak where mota='Software');
$$ language sql;

create or replace function ikusOrdenagailuak()
returns setof record
as $$
select idCI,Deskribapena,jabea,aeKapa,Marka,Prozesagailua,Ram,diskoGogorra,modeloa,serieZenbakia,Oharrak
from ci where idmota=(Select idMota from motak where mota='Ordenagailuak');
$$ language sql;

create or replace function ikusKomunikazioLineak()
returns setof record
as $$
select idCI,Deskribapena,aeKapa,Oharrak,abiadura,isp
from ci where idmota=(Select idMota from motak where mota='Komunikazio lineak');
$$ language sql;

create or replace function getAktiboak(integer)
returns setof record
as $$
select *
from ci 
where idmota=$1;
$$ language sql;

create or replace function motak()
returns setof record
as $$
select * from motak;
$$language sql;


--Inzidentziekin zerikusia
create or replace function getInzidentziak()
returns setof record
as $$
select * from inzidentziak where konponduta != true;
$$language sql;


create or replace function inzidentziaMotak()
returns setof record
as $$
select * from inzidentziaMotak;
$$language sql;

create or replace function InzidentziaSortu(integer,text,integer,integer)
returns void
as $$
insert into inzidentziak(inzidentziaHasi,timestamp,DeskribapenaArazo,idCi,inzidentziaMota,konponduta) values($1,now()::timestamp,$2,$3,$4,false)
$$ language sql;

create or replace function InzidentziaItxi(integer,text,integer)
returns void
as $$
update inzidentziak set inzidentziaItxi=$1,deskribapenaKonpon=$2,konponduta=true where idInzidentziak=$3;
$$ language sql;

create or replace function checkUser(int)
returns integer
as $$
select idDepartamentua from Langileak where idLangileak = $1;
$$language sql;

create or replace function checkCI(integer)
returns boolean
as $$
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
$$ language plpgsql;
