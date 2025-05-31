-- SEGUIR ESTE ORDEN
-- =================
-- 1) Ver este video: https://www.youtube.com/watch?v=MWjjvKZaLXk
--    LEER completo este archivo: puntos-ambas-practicas.sql están las rubricas (puntos de cada sección) y formato de entrega del archivo .sql
--    además de los puntos menos en caso de incumplimientos.

-- 2) Explicación del Ejercicio específico asignado: https://www.youtube.com/watch?v=Qa3zdX9Wos8

-- 3) Este mismo archivo darle guardar como, y le pone el nombre Prac02_nombre_apellido.sql (su nombre y su apellido SIN EÑES ni tildes)
--    Quita todos los comentarios iniicales, el archivo inicia con host cls

-- 5) Ejecutar: IniciaBD.bat y luego hr.bat

-- LEER ESTE TEXTO, no se incluyó en el video, son las reglas de negocio básicas:
-- ==============================================================================
-- parques que la empresa tiene en diferentes localidades

-- yo les doy la cardinalidad: una localidad puede no tener, tener 1 o tener muchos parques (en dicha localidad)
-- y un parque SIEMPRE debe tener una localidad asociada

--OTRAS REGLAS DE NEGOCIO:
--un parque tiene una fecha de inauguracion  ***USAR TIPO DATE
--todos los campos de la tabla son obligatorios.

-- Listo puede iniciar a realizar su práctica No 2 (con este archivo base)


host cls

prompt ===========================================================Inicio PRACTICA No 2 (parques)
prompt Gabriel Jimenez Navarro - 118990637
conn bases1/bases123
prompt ===========================================================
prompt (2 ptos) dropear objetos 

drop table parques cascade constraints;
drop sequence seq_parq;

prompt ===========================================================
prompt (2 ptos) crear tabla (Con el nombre adecuado a las nomenclaturas usadas en clases)

create table parques (
id number not null,
nombre varchar2(10) not null,
id_loc number not null,
fec_inaug date not null
);

prompt ===========================================================
prompt (2 ptos) crear seq (Con el nombre adecuado a las nomenclaturas usadas en clases) Inicia en 1

create sequence seq_parq start with 1;

prompt ===========================================================
prompt (2 ptos) crear PK  (Con el nombre adecuado a las nomenclaturas usadas en clases)

alter table parques add constraint parques_pk primary key (id);

prompt ===========================================================
prompt (5 ptos) crear FK (Con el nombre adecuado a las nomenclaturas usadas en clases)

alter table parques add constraint parq_fk_loc foreign key (id_loc) references locations;

prompt ===========================================================
prompt (15 ptos) crear procedimiento inserta parques (usando sequencia) 

create or replace procedure prc_ins_parque (
Pnombre in varchar2,
Pid_loc in number,
Pfec_inaug in date
)is
begin
	insert into parques(id, nombre, id_loc, fec_inaug) values
	(seq_parq.NEXTVAL, Pnombre, Pid_loc, Pfec_inaug);
	commit;
end prc_ins_parque;
/
show error

prompt ===========================================================
prompt (4 ptos) Insertarmos 4 parques . 2 de una localidad, 2 de otra localidad (cualquiera pero de las primeras 1000 1100 1200 1300 solamente), 
prompt cada uno con menos 1 anios de haberse inaugurado (-1..-2..-3...-4) (usar fecha relativa o valor fijo)
--cambiar los nombres de los parques, usar nombres distintos a los usados por el profesor (-2 puntos si deja los mismos nombres)

execute prc_ins_parque('Sun.', 1200, sysdate-365);
execute prc_ins_parque('Qin.', 1200, sysdate-(365*2)-1);
execute prc_ins_parque('Tam.', 1300, sysdate-(365*3)-1);
execute prc_ins_parque('Mel.', 1300, sysdate-(365*4)-1);

prompt ===========================================================
prompt (2 ptos) UNO con un ID de localidad incorrecto 9999 (y cualqueir fecha y nombre), debe generar ERROR de FK  (ERROR ESPERADO EN PANTALLA)

execute prc_ins_parque('Err.', 9999, sysdate);

prompt ===========================================================
prompt (2 ptos) seleccionamos los 4 parques con la fecha en formato dd-mm-yyyy (ya sea por alter sesion o usando to_char como gusten!)
--

select id, nombre, id_loc, to_char(fec_inaug,'dd-mm-yyyy') fec_inaug
from parques;

prompt ===========================================================
prompt (6 ptos) Creamos procedimiento que borre un parque, pasando PK por parametro

create or replace procedure prc_del_parque (
Pid number
)
is
begin 
	delete from parques 
	where id = Pid;
end prc_del_parque;
/
show error;

prompt ===========================================================
prompt (2 ptos) Ejecutamos el procedimiento y Borramos solo uno de los parques (el primero creado)

execute prc_del_parque(1);

prompt ===========================================================
prompt (2 ptos) Select y ahora quedan 3 parques con la fecha en formato dd-mm-yyyy (ya sea por alter sesion o usando to_char como gusten!)

select id, nombre, id_loc, to_char(fec_inaug,'dd-mm-yyyy') fec_inaug
from parques;

prompt ===========================================================
prompt (15 ptos) Creamos funcion que cuenta la cantidad de parques (por localizacion) y recibe por parametro el id de localizacion

create or replace function fun_cant_parques_loc(Pid_loc number) return number is
VCantidad number;
begin
    select count(*)
    into VCantidad
    from parques
    where id_loc = Pid_loc;
    return VCantidad;
end fun_cant_parques_loc;
/
show error;

prompt ===========================================================
prompt (15 ptos) Creamos vista que muestra la ciudad (de locations) y la cantidad de parques en esa ciudad
prompt cuando el id de localidad sea menor a 1400 (YA SEA EN LA VISTA O EN EL SELECT A LA VISTA)

create or replace view rep_parq_loc as
select l.location_id loc_id, l.city ciudad, fun_cant_parques_loc(l.location_id) cant_parques
from locations l;

prompt ===========================================================
prompt (2 ptos) Consumimos la vista anterior (ordenado por id de localidad DESCENDENTE)
prompt cuando el id de localidad sea menor a 1400 (YA SEA EN LA VISTA O EN EL SELECT A LA VISTA)

select *
from rep_parq_loc
where loc_id < 1400
order by loc_id desc
;

prompt ===========================================================
prompt (20 ptos) creamos vista usando inner join USAR ALIAS PARA LA TABLA -3 puntos si no usa ALIAS de tabla y en los campos.

create or replace view rep_parq_loc_ij as
select l.location_id loc_id, l.city ciudad, p.nombre
from locations l, parques p
where p.id_loc = l.location_id
;

prompt ===========================================================
prompt (2 ptos) consumimos la vista anterior de inner join  (ordenado por id de localidad DESCENDENTE)

select * from rep_parq_loc_ij order by loc_id desc;

prompt ===========================================================Fin PRACTICA No 2 (parques)
prompt Gabriel Jimenez Navarro - 118990637

