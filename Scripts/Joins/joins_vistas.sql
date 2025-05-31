spool joins_vistas.log

conn bases1/bases123
--sqlplus /nolog @joins_vistas.sql

ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN';
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:mi:ss';
set linesize 200
set pagesize 300
set trimspool on

PROMPT Vista auxiliar con nombres completos (MANAGERS)
create or replace view bases1.managers as
select employee_id id,
       first_name || ' ' || last_name nom_completo
from   bases1.employees;

PROMPT Vista con empleados y nombre del jefe
create or replace view bases1.rep_emp_jefe_sal as
select e.employee_id id, e.first_name || ' ' || e.last_name as nom_empleado,
       m.nom_completo nom_jefe, e.salary salario
from   bases1.employees e
join   bases1.managers m on e.manager_id = m.id
order by m.nom_completo;

PROMPT Vista final: resumen de salarios por jefe
create or replace view bases1.rep_analisis_jefe as
select nom_jefe, trunc(avg(salario)) sal_prom,
       trunc(max(salario)) sal_max,
       trunc(min(salario)) sal_min,
       count(*) cant_emp_jefe
from   bases1.rep_emp_jefe_sal
group by nom_jefe
order by nom_jefe;

--SELECT * FROM bases1.managers ORDER BY nom_completo ASC;
--SELECT * FROM bases1.rep_emp_jefe_sal;
SELECT * FROM bases1.rep_analisis_jefe;
--SELECT employee_id, manager_id, first_name || ' ' || last_name AS nombre from bases1.employees ORDER BY manager_id ASC;

spool off
host start notepad.exe joins_vistas.log
--host cls
exit