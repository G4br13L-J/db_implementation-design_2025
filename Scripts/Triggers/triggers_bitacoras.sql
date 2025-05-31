host cls
--12.50
--Seguimos haciendo esta forma (.bat era para conocimiento general) 

--AUNQUE LES FUNCIONE el .BAT vamos a ejecutarlo en CMD todos igual por favor..
--Copiar y pegar esta linea en CMD
--sqlplus /nolog @Trig-Fun01-BASE-QUIZ5.sql

spool triggers_bitacoras.log
PROMPT =======================================================
PROMPT TRIGGERS Y FUNCIONES (Usando empleado; empleado_bit y parametros)

PROMPT con usuario bases1
conn bases1/bases123
---Luego de cada conexion
ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN';
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:mi:ss';
set linesize 200
set pagesize 300
set trimspool on
--------------------------------


PROMPT inicio
drop sequence sec_bit_emp;
drop table empleado cascade constraints;
drop table empleado_bit;
drop table parametros cascade constraints;

create table empleado(
codigo    number         not null,
nombre    varchar2(20)   not null,
id_depto  number(2)      not null,
fec_ingre date               null,
salario   number(10,2)   not null
);


create table empleado_bit(
id_bit    number         not null,
fec_bit   date           not null,
acc_bit   char(1)        not null,
usu_bit   varchar2(10)   not null,
codigo    number         not null,
nombre    varchar2(20)       null,
id_depto  number(2)          null,
fec_ingre date               null,
salario   number(10,2)       null
);


create table parametros(
id       number(3)    not null,
nom_par  varchar2(30) not null,
val_par  varchar2(5)  not null
);



PROMPT Creamos una secuencia de bitacora (solo para saber el orden)
--- porque el tipo DATE el minimo es segundo, podrían entrar "dos updates" en el mismo segunto...
create sequence sec_bit_emp start with 1000 increment by 1;

PROMPT ===========================================
PROMPT PKs
alter table empleado add constraint empleado_pk primary key (codigo);
alter table parametros add constraint parametros_pk primary key (id);

PROMPT ===========================================
PROMPT fun_val_par
create or replace function fun_val_par(Pid in number) return varchar2 is
  VValor varchar2(30);
begin
  select val_par
  into   VValor
  from   parametros
  where  id = Pid;
  return VValor;
end fun_val_par;
/
show error
PROMPT ===========================================
PROMPT Insertamos parametros
insert into parametros(id , nom_par , val_par ) values (1,'Emp Permite INS BIT S/N','S');
insert into parametros(id , nom_par , val_par ) values (2,'Emp Permite UPD BIT S/N','S');
insert into parametros(id , nom_par , val_par ) values (3,'Emp Permite DEL BIT S/N','S');
--nuevo para el quuiz
insert into parametros(id , nom_par , val_par ) values (4,'Emp Permite INS TABLA S/N','N');
insert into parametros(id , nom_par , val_par ) values (5,'Emp Permite UPD TABLA S/N','N');
insert into parametros(id , nom_par , val_par ) values (6,'Emp Permite DEL TABLA S/N','N');

select * from parametros order by 1;
commit;

PROMPT ===========================================
PROMPT Insertamos empleados antes de triggers
insert into empleado values (1,'Juan',1,to_date('31-10-2035','DD-MM-YYYY HH24:mi:ss'),5000 );
insert into empleado values (2,'Pedro',1,to_date('31-10-2015','DD-MM-YYYY HH24:mi:ss'),6000 );
insert into empleado values (3,'Ana',2,to_date('31-10-2016','DD-MM-YYYY HH24:mi:ss'),6000 );
commit;

PROMPT ===========================================
PROMPT Trigger validar INSERT

-- si el parametro del 4,5 y 6 S, S, S. Si estan en no, no permite actualizar, insertar ni borrar

create or replace trigger empleado_trg_bir
before insert on empleado
for each row
begin
    if fun_val_par(4) != 'S' then
        raise_application_error(-20001, 'Parametro 4 No permite insertar en tabla empleado');
    end if;
end;
/


show error

PROMPT ===========================================
PROMPT Trigger validar UPDATE

create or replace trigger empleado_trg_bur
before update on empleado
for each row
begin
    if fun_val_par(5) != 'S' then
        raise_application_error(-20001, 'Parametro 5 No permite actualizar en tabla empleado');
    end if;
end;
/


show error

PROMPT ===========================================
PROMPT Trigger validar DELETE

create or replace trigger empleado_trg_bdr
before delete on empleado
for each row
begin
    if fun_val_par(6) != 'S' then
        raise_application_error(-20001, 'Parametro 6 No permite borrar en tabla empleado');
    end if;
end;
/


show error

PROMPT ===========================================
PROMPT Pruebas con los triggers INSERT
insert into empleado values (4,'Luisa',2,to_date('31-10-2016','DD-MM-YYYY HH24:mi:ss'),6000 );

PROMPT ===========================================
PROMPT Pruebas con los triggers UPDATE
update empleado set nombre = 'JUAN 2' where codigo = 2;

PROMPT ===========================================
PROMPT Pruebas con los triggers DELETE
delete empleado where codigo = 2;
commit;

PROMPT ===========================================
PROMPT Pruebas Select Tabla Empleado
select * from empleado order by 1;

spool off
host start notepad triggers_bitacoras.log
exit