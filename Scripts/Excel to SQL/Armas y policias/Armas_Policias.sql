host cls
PROMPT ====inicio===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea 1) 
conn bases1/bases123

-- Este script crea las tablas, secuencias, llaves primarias, foraneas y de chequeo
-- para el manejo de policias, armas y asignaciones de armas a policias

PROMPT ================================================
PROMPT Dropeamos secuencias
drop sequence seq_asignaciones;
drop sequence seq_policias;
drop sequence seq_armas;

PROMPT ========================================
PROMPT Dropeamos Tablas
drop table asignaciones;
drop table policias;
drop table armas;

PROMPT ================================================
PROMPT Creamos tablas

create table policias (
id      	  	 number,
nombre  	  	 varchar2(20),
celular 	  	 varchar2(20),
fecha_ingreso 	 date,
estado 		  	 varchar2(20));

create table armas (
id 	   		 number, 
modelo 		 varchar2(20),
numero_serie varchar2(20), 
estado 		 varchar2(20));

create table asignaciones (
id 		    	 number, 
id_policia 		 number,
id_arma    		 number);

PROMPT ================================================
PROMPT Creamos secuencias
create sequence seq_policias start with 1;
create sequence seq_armas start with 100;
create sequence seq_asignaciones start with 1000;

PROMPT ================================================
PROMPT Creamos PKs
alter table policias 	 add constraint policias_pk 	 primary key (id); 
alter table armas 	 	 add constraint armas_pk 		 primary key (id); 
alter table asignaciones add constraint asignaciones_pk  primary key (id); 

PROMPT =================================
PROMPT Creamos las FK
alter table asignaciones add constraint  asignaciones_fk_policias 
foreign key 			(id_policia) 	 	  references policias(id);

alter table asignaciones add constraint  asignaciones_fk_armas
foreign key 			(id_arma) 			  references armas(id);

PROMPT =================================
PROMPT Creamos las CK 
--Armas
alter table armas add constraint armas_estado_ck Check
(estado in ('Activa', 'Reparacion', 'Desuso', 'Danada') ); 

--Policias
alter table policias add constraint policias_estado_ck Check 
(estado in ('Activo', 'Inactivo', 'Vacaciones', 'Incapacitado') );

PROMPT =================================
PROMPT Insert Policias

insert into policias (id, nombre, celular, fecha_ingreso, estado) 
values (seq_policias.nextval, 'Clive Rosfield', '8877-9966', sysdate, 'Activo');

insert into policias (id, nombre, celular, fecha_ingreso, estado) 
values (seq_policias.nextval, 'Cloud Strife', '4455-3300', sysdate, 'Incapacitado');

insert into policias (id, nombre, celular, fecha_ingreso, estado) 
values (seq_policias.nextval, 'Cristiano Ronaldo', '7458-6985', sysdate, 'Vacaciones');

insert into policias (id, nombre, celular, fecha_ingreso, estado) 
values (seq_policias.nextval, 'Clark Kent', '6325-4125', sysdate, 'Activo');

insert into policias (id, nombre, celular, fecha_ingreso, estado) 
values (seq_policias.nextval, 'Bruno Diaz ', '1236-5478', sysdate, 'Activo');

PROMPT =================================
PROMPT Insert Armas

insert into armas (id, modelo, numero_serie, estado) 
values (seq_armas.nextval, 'Magnum ', 'MGNM-1234', 'Activa');

insert into armas (id, modelo, numero_serie, estado) 
values (seq_armas.nextval, 'AK-47', 'AK47-7890', 'Danada');

insert into armas (id, modelo, numero_serie, estado) 
values (seq_armas.nextval, 'Cold', 'CLD1-4567', 'Danada');

insert into armas (id, modelo, numero_serie, estado) 
values (seq_armas.nextval, 'Escopeta', 'STGN-6789', 'Activa');

insert into armas (id, modelo, numero_serie, estado) 
values (seq_armas.nextval, 'Francotirador', 'SNPR-7654', 'Activa');

PROMPT =================================
PROMPT Insert Asignaciones

insert into asignaciones (id, id_policia, id_arma)
values (seq_asignaciones.nextval, 1, 100);

insert into asignaciones (id, id_policia, id_arma)
values (seq_asignaciones.nextval, 4, 103);

insert into asignaciones (id, id_policia, id_arma)
values (seq_asignaciones.nextval, 5, 104);

set linesize 100
select * from policias;
select * from armas;
select * from asignaciones;

PROMPT ====final===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea No 1)



