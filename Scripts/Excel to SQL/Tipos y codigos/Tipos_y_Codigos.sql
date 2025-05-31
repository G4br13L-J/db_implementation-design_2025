host cls
PROMPT ====inicio===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea No 2) 
PROMPT 402640907 Didier Miranda Delgado  (Tarea No 2)
conn bases1/bases123

PROMPT =================================
PROMPT Dropeamos Secuencias
drop sequence sec_tipos;
drop sequence sec_codigos;

PROMPT =================================
PROMPT Dropeamos Tablas en orden primero tablas HIJAS, luego PADRES
drop table codigos;
drop table tipos;

PROMPT =================================
PROMPT Creamos Tablas  ORDENADO MUCHO MEJOR
create table tipos (
id 	   	 number 	  not null,
nombre 	 varchar2(30) not null,
fec_crea date 		  not null
);

create table codigos (
id 		   number 		not null,
id_tipo    number 		not null,
despliegue varchar2(20) not null,
tip_valor  varchar2(1)  not null,
valor      varchar2(15) not null,
fec_crea   date         not null
);

PROMPT =================================
PROMPT Creamos las secuencias
create sequence sec_codigos  start with 1001;
create sequence sec_tipos start with 1;

PROMPT =================================
PROMPT Creamos las PK (Podemos abreviar) 
alter table tipos add constraint tipos_pk  	 	primary key (id);
alter table codigos add constraint codigos_pk   primary key (id);

PROMPT =================================
PROMPT Creamos las FK
alter table codigos add constraint codigos_fk_tipos 
foreign key (id_tipo)  references tipos;

PROMPT =================================
PROMPT Insert Tipos

insert into tipos (id, nombre, fec_crea)
values (sec_tipos.nextval, 'Provincias', sysdate);

insert into tipos (id, nombre, fec_crea)
values (sec_tipos.nextval, 'Estados para Activos', sysdate);

insert into tipos (id, nombre, fec_crea)
values (sec_tipos.nextval, 'Estados Civil', sysdate);

commit;

PROMPT =================================
PROMPT Insert Codigos

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 1, 'San Jose', 'N', '1', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 1, 'Alajuela', 'N', '2', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 1, 'Cartago', 'N', '3', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 1, 'Heredia', 'N', '4', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 1, 'Guanacaste', 'N', '5', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 1, 'Puntarenas', 'N', '6', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 1, 'Limon', 'N', '7', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 2, 'En uso', 'V', 'En Uso', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 2, 'Desechado', 'V', 'Desechado', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 2, 'Disponible', 'V', 'Disponible', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 3, 'Soltero', 'N', '10', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 3, 'Casado', 'N', '11', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 3, 'Viudo', 'N', '12', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 3, 'Divorciado', 'N', '13', sysdate);

insert into codigos (id, id_tipo, despliegue, tip_valor, valor, fec_crea)
values (sec_codigos.nextval, 3, 'Union de Hecho', 'N', '14', sysdate);

commit;

set linesize 200
PROMPT =================================
PROMPT Select de las tablas
select * from tipos;
select * from codigos;

PROMPT ====final===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea No 2)
PROMPT 402640907 Didier Miranda Delgado  (Tarea No 2)