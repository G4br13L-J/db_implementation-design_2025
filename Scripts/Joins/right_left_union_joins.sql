--sqlplus /nolog @Lec26-Base.sql
spool Lec26-Base.log
conn bases1/bases123
--------------------------------
ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN';
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:mi:ss';
set linesize 200
set pagesize 3000
set trimspool on
set termout off
--------------------------------

PROMPT =======================================================
PROMPT Lec 26 ================================================
PROMPT
PROMPT

PROMPT =======================================================
PROMPT Formato de Columnas Dejar Siempre. Agregar adicionales si es necesario
column nom_depto  format A20
column nombre     format A30
column dep_id     format 9999
column emp_id     format 9999


-- PROMPT =======================================================
-- PROMPT Explicación:
-- PROMPT LEFT OUTER JOIN: Devuelve todos los registros de la tabla de la izquierda (departments) 
-- PROMPT  y los que coinciden de la tabla de la derecha (employees). Si no hay coincidencia, 
-- PROMPT las columnas de la tabla derecha aparecen como NULL.
-- PROMPT Esto permite ver qué departamentos no tienen empleados asociados.
-- PROMPT
-- PROMPT ======De forma explicita con la palabra left outer join  122 registros
-- select  d.department_id dep_id , d.department_name nom_depto, e.employee_id emp_id, 
        -- e.first_name||' '||e.last_name nombre
-- from    departments d
-- left outer join  employees e on d.department_id = e.department_id
-- order by 1;

-- PROMPT ======De forma implicita (+) con un where  122 registros
-- select  d.department_id dep_id , d.department_name nom_depto, e.employee_id emp_id, 
        -- e.first_name||' '||e.last_name nombre
-- from    departments d, employees e
-- where   d.department_id = e.department_id(+)
-- order by 1;

-- PROMPT =======================================================
-- PROMPT VARIANTE USANDO inner join Sencillo + Union con select adicional 
-- select  d.department_id dep_id , d.department_name nom_depto, e.employee_id emp_id, 
        -- e.first_name||' '||e.last_name nombre
-- from    departments d, employees e
-- where   d.department_id = e.department_id
-- union
-- select  d.department_id dep_id , d.department_name nom_depto, null, null
-- from    departments d
-- where   d.department_id not in (select distinct e.department_id from employees e where e.department_id is not null)
-- order by 1; 

-- PROMPT =======================================================
-- PROMPT ==Orden de selects invertido no hay problema; pues order by ORDENA la totalidad del resultado
-- PROMPT VARIANTE USANDO inner join Sencillo + Union con select adicional 
-- select  d.department_id dep_id , d.department_name nom_depto, null emp_id, null nombre
-- from    departments d
-- where   d.department_id not in (select distinct e.department_id from employees e where e.department_id is not null)
-- union
-- select  d.department_id dep_id , d.department_name nom_depto, e.employee_id emp_id, 
        -- e.first_name||' '||e.last_name nombre
-- from    departments d, employees e
-- where   d.department_id = e.department_id
-- order by 1;

column country_name format A40
column region_name format A30

PROMPT =======================================================
PROMPT PARA RESOLVER LA TAREA HACEN dejen este update fijo al inicio del script (no importa que se repita)

update bases1.countries
set    region_id = null
where country_id in ('BE','FR','NG','ZM');
commit;

PROMPT =======================================================
PROMPT Forma 1)  explicito (+)

select c.country_name, r.region_name
from countries c, regions r
where c.region_id = r.region_id(+)
order by country_name asc
;

PROMPT =======================================================

PROMPT Forma 2) left
select c.country_name, r.region_name
from countries c
left outer join regions r on c.region_id = r.region_id
order by country_name asc
;

PROMPT =======================================================

PROMPT Forma 3) right 
select c.country_name, r.region_name
from regions r
right outer join countries c on c.region_id = r.region_id
order by country_name asc
;

PROMPT =======================================================

PROMPT Forma 4) INNER JOIN NORMAL + union + paises cuando region_id is null
select c.country_name, r.region_name
from countries c, regions r
where c.region_id = r.region_id

union

select c.country_name, null region_name
from countries c
where c.region_id is null
order by country_name asc
;

PROMPT =======================================================

create or replace function fun_nom_region (p_region_id in number)
return varchar2 is
  v_region_name varchar2(30);
begin
  if p_region_id is null then
    return null;
  end if;

  select region_name into v_region_name
  from regions
  where region_id = p_region_id;

  return v_region_name;
end fun_nom_region;
/
show error

PROMPT Forma 5) usamos funcion  fun_nom_region si recibe null retorna null, sino busca el nombre

select c.country_name, fun_nom_region(c.region_id) region_name
from countries c
order by country_name asc
;

spool off
host start notepad.exe Lec26-Base.log
host cls
exit










