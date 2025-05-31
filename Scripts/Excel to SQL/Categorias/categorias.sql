host cls
PROMPT ====inicio===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea No 2) 
PROMPT 402640907 Didier Miranda Delgado  (Tarea No 2)
conn bases1/bases123

PROMPT =================================
PROMPT Dropeamos Secuencias
drop sequence sec_categorias;
drop sequence sec_productos;

PROMPT =================================
PROMPT Dropeamos Tablas en orden primero tablas HIJAS, luego PADRES
drop table productos;
drop table categorias;

PROMPT =================================
PROMPT Creamos Tablas  ORDENADO MUCHO MEJOR
create table categorias (
id 		   number 		not null,
nombre 	   varchar2(30) not null,
id_cat_pad number
);

create table productos (
id 		  	   number 		not null,
nombre    	   varchar2(30) not null,
precio 	  	   number 		not null,
id_cat 	 	   number,
estado 	  	   varchar2(20),
fec_ult_compra date,
inventario 	   number 		not null
);

PROMPT =================================
PROMPT Creamos las secuencias
create sequence sec_categorias start with 1;
create sequence sec_productos  start with 100;

PROMPT =================================
PROMPT Creamos las PK (Podemos abreviar) 
alter table categorias add constraint categorias_pk  primary key (id);
alter table productos  add constraint productos_pk   primary key (id);

PROMPT =================================
PROMPT Creamos las FK
alter table productos add constraint productos_fk_categorias 
foreign key (id_cat)  references categorias;

PROMPT =================================
PROMPT Creamos las CK  
--Productos
alter table productos add constraint prod_estado_ck1 Check
(estado in ('Activ','Desco') );

PROMPT =================================
PROMPT Insert Categorias

insert into categorias (id, nombre, id_cat_pad)
values (sec_categorias.nextval, 'Herramientas Electricas', null);

insert into categorias (id, nombre, id_cat_pad)
values (sec_categorias.nextval, 'Herramientas Manuales', null);

insert into categorias (id, nombre, id_cat_pad)
values (sec_categorias.nextval, 'Taladros', 1);

insert into categorias (id, nombre, id_cat_pad)
values (sec_categorias.nextval, 'De baterias', 3);

insert into categorias (id, nombre, id_cat_pad)
values (sec_categorias.nextval, 'Destornilladores', 2);

insert into categorias (id, nombre, id_cat_pad)
values (sec_categorias.nextval, 'Planos', 5);

insert into categorias (id, nombre, id_cat_pad)
values (sec_categorias.nextval, 'Phillips', 5);
commit;

PROMPT =================================
PROMPT Insert Productos

insert into productos (id, nombre, precio, id_cat, estado, fec_ult_compra, inventario)
values (sec_productos.nextval, 'Destorn. Phillips LOS PATITOS', 1000, 7, 'Activ', null, 0);

insert into productos (id, nombre, precio, id_cat, estado, fec_ult_compra, inventario)
values (sec_productos.nextval, 'Destorn. Phillips SUPERIOR', 1500, 7, 'Activ', null, 0);

insert into productos (id, nombre, precio, id_cat, estado, fec_ult_compra, inventario)
values (sec_productos.nextval, 'Taladro de Baterias SUPERIOR', 34500, 4, 'Desco', null, 0);

insert into productos (id, nombre, precio, id_cat, estado, fec_ult_compra, inventario)
values (sec_productos.nextval, 'Taladro Industrial LOS PATITOS', 78000, 3, 'Desco', null, 0);

insert into productos (id, nombre, precio, id_cat, estado, fec_ult_compra, inventario)
values (sec_productos.nextval, 'categ', 5000, null, 'Activ', null, 0);
commit;

set linesize 200
PROMPT =================================
PROMPT Select de las tablas
select * from categorias;
select * from productos;

PROMPT ====final===========
PROMPT 118990637 Gabriel Jimenez Navarro (Tarea No 2)
PROMPT 402640907 Didier Miranda Delgado  (Tarea No 2)