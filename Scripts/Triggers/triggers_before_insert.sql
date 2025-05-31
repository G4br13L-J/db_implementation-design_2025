host cls
spool triggers_before_insert.log

PROMPT Gabriel Jimenez Navarro 3PM Quiz 6

PROMPT con usuario bases1
conn bases1/bases123

set linesize 200
set pagesize 300

-- Eliminar la tabla
drop table campus cascade constraints;

-- Crear la tabla
create table campus (
    id number not null,
    nombre varchar(255) not null
);

-- PK
PROMPT ===========================================
PROMPT PK
alter table campus add constraint campus_pk primary key (id);

--Insertar el ID 1  (Sin error porque no hay trigger)
insert into campus (id, nombre) VALUES (1, 'Omar Dengo');
commit;

--Crear el trigger  (con el nombre apropiado) que impide que se inserten registros (30 puntos)
create or replace trigger campus_trg_bir before insert on campus
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN
	raise_application_error(-20001,'No se permite Insertar en Tabla Campus');
END campus_trg_bir;
/
show error


--Insertar el ID 2 (da error porque está el trigger) 
insert into campus (id, nombre) values (2, 'Benjamin Nunez');

--Deshabilitar el trigger creado (15 puntos)
alter trigger campus_trg_bir DISABLE;

--Insertar el ID 2 (Si se inserta pues se deshabilito el trigger)
insert into campus (id, nombre) values (2, 'Benjamin Nunez');
commit;

--Habilitar el trigger (15 puntos)
alter trigger campus_trg_bir ENABLE;

--Insertar el ID 3 (Error pues habilito el trigger)
insert into campus (id, nombre) values (3, 'Sarapiqui');
commit;

--Eliminar DROPEAR (El trigger) 10 puntos)
drop trigger campus_trg_bir;

--Insertar el ID 3 (Si se inserta pues ha dropeado el trigger)
insert into campus (id, nombre) values (3, 'Sarapiqui');
commit;

--Insertar el ID 4 (Si se inserta pues ha dropeado el trigger)
insert into campus (id, nombre) values (4, 'Nicoya');
commit;

--Hacer select de todos los campos de la tabla CAMPUS ordenado por id DESCENDENTE (10 puntos)
select * from campus order by id desc;

PROMPT Gabriel Jimenez Navarro 3PM Quiz 6

spool off
host start notepad triggers_before_insert.log
exit
