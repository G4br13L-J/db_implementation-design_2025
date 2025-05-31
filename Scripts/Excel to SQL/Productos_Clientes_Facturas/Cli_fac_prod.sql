host cls
PROMPT ====inicio===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea No 2) 
PROMPT 402640907 Didier Miranda Delgado  (Tarea No 2)
conn bases1/bases123

PROMPT =================================
PROMPT Dropeamos Secuencias
drop sequence sec_detalle_fact;
drop sequence sec_facturas;
drop sequence sec_productos;
drop sequence sec_clientes;


PROMPT =================================
PROMPT Dropeamos Tablas en orden primero tablas HIJAS, luego PADRES
drop table detalle_fact;
drop table facturas;
drop table productos;
drop table clientes;

PROMPT =================================
PROMPT Creamos Tablas  ORDENADO MUCHO MEJOR

create table productos(
id number not null, 
cod_barra varchar2(20) not null, 
producto varchar2(30) not null, 
precio number not null
);

create table clientes(
id number not null, 
cedula varchar2(20) not null, 
tipo varchar2(20) not null, 
nombre varchar2(20) not null
);

create table facturas(
id number not null, 
id_cli number not null, 
fecha varchar2(20) not null, 
total number
);

create table detalle_fact(
id number not null, 
id_fact number not null,
id_prod number not null,
cantidad number not null,
precio_unit number not null
);

PROMPT =================================
PROMPT Creamos las secuencias
create sequence sec_detalle_fact start with 1001;
create sequence sec_facturas  start with 101;
create sequence sec_productos start with 1;
create sequence sec_clientes start with 10;

PROMPT =================================
PROMPT Creamos las PK (Podemos abreviar) 
alter table productos       add constraint productos_pk  primary key (id);
alter table clientes        add constraint clientes_pk   primary key (id);
alter table facturas  add constraint facturas_pk  primary key (id);
alter table detalle_fact  add constraint detalle_fact_pk  primary key (id);

PROMPT =================================
PROMPT Creamos la UK
alter table productos add constraint cod_barra_pro_uk unique (cod_barra);
alter table clientes add constraint cedula_cli_uk unique (cedula);
alter table clientes add constraint tipo_cli_uk unique (tipo);

PROMPT =================================
PROMPT Creamos las FK
alter table  facturas       add constraint id_cli_fk 
foreign key (id_cli)   references clientes(id);

alter table detalle_fact  add constraint id_fact_fk
foreign key (id_fact)    references facturas(id);

alter table detalle_fact  add constraint id_prod_fk
foreign key (id_prod)    references productos(id);

PROMPT =================================
PROMPT Insert productos
insert into productos(id,cod_barra,producto,precio) values(sec_productos.NEXTVAL, '744800','Leche 1 lit', 1500); 
insert into productos(id,cod_barra,producto,precio) values(sec_productos.NEXTVAL, '744801','Jugo Naranja 1lt', 1850); 
insert into productos(id,cod_barra,producto,precio) values(sec_productos.NEXTVAL, '744802','Rompope 1lt', 1750); 
insert into productos(id,cod_barra,producto,precio) values(sec_productos.NEXTVAL, '744803','Jugo Uva 250ml', 650); 
insert into productos(id,cod_barra,producto,precio) values(sec_productos.NEXTVAL, '744804','Frescoleche 250ml', 700);
commit; 

PROMPT =================================
PROMPT Insert Clientes
insert into clientes(id,cedula,tipo,nombre) values(sec_clientes.NEXTVAL, '108880999', 'Fisica', 'Juan Perez');
insert into clientes(id,cedula,tipo,nombre) values(sec_clientes.NEXTVAL, '3101999888', 'Juridica', 'Los Patitos SA');
insert into clientes(id,cedula,tipo,nombre) values(sec_clientes.NEXTVAL, '15545454545', 'DIMEX', 'Roberth Miller');
insert into clientes(id,cedula,tipo,nombre) values(sec_clientes.NEXTVAL, 'AB-789911', 'Pasaporte', 'Kirk Jones');
commit; 

PROMPT =================================
PROMPT Insert Facturas
insert into facturas(id,id_cli,fecha,total) values(sec_facturas.NEXTVAL, 10, '3/14/2025', 5200); 
insert into facturas(id,id_cli,fecha,total) values(sec_facturas.NEXTVAL, 12, '3/14/2025', null); 
commit; 

PROMPT =================================
PROMPT Insert Detalle_Fact
insert into detalle_fact(id, id_fact, id_prod, cantidad, precio_unit) values(sec_detalle_fact.NEXTVAL, 101, 1, 1, 1500); 
insert into detalle_fact(id, id_fact, id_prod, cantidad, precio_unit) values(sec_detalle_fact.NEXTVAL, 101, 2, 2, 1850); 
insert into detalle_fact(id, id_fact, id_prod, cantidad, precio_unit) values(sec_detalle_fact.NEXTVAL, 102, 2, 3, 1850); 
insert into detalle_fact(id, id_fact, id_prod, cantidad, precio_unit) values(sec_detalle_fact.NEXTVAL, 102, 5, 5, 750); 
commit; 

set linesize 150
PROMPT =================================
PROMPT Select de las tablas
select * from productos;
select * from clientes;
select * from facturas;
select * from detalle_fact;

PROMPT ====final===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea No 2)
PROMPT 402640907 Didier Miranda Delgado  (Tarea No 2)