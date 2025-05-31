host cls

-- sqlplus /nolog @Quiz-02-Gabriel-Jimenez.sql
-- nombres correctos de archivo .sql y archivo log 10 puntos (cambie Manuel Espinoza por su nombre en TODAS PARTES!)
-- no requieren usar bases.objeto... 
-- Vuelva a correr: IniciaBD.bat y luego hr.bat
-- 12.38 completo encendiendo instancia montando machote. termina 1253
-- unos 20 minutos...
-- SOLO SUBIR ARCHIVO .sql SIN COMPRIMIR, no colocar host pause -10 puntos. Estricto individual.
-- NO PEUDEN CAMBIAR LA ENTREGA, el profe anotará el nombre y la hora de salida (no salir hasta que el profe le confirme)

spool Fun_con_fun_agreg.log
PROMPT ====inicio=========== Gabriel Jimenez
PROMPT 
PROMPT TEMA FUNCIONES DE BASES DE DATOS
PROMPT 
conn bases1/bases123

PROMPT 
PROMPT Creamos funcion fun_sal_rangos CONTAR o PROMEDIO o SUMAR los salarios
PROMPT cualquier otro valor de texto retorna -1 
--ACA PROGRAMAR LA FUNCION fun_sal_rangos
create or replace function bases1.fun_sal_rangos(Pfun in varchar2, Pid1 in number, Pid2 in number) return number is 
VResult number;
begin
	if Pfun = 'CONTAR' then
		select COUNT(*) into VResult
		from employees
		where employee_id between Pid1 and Pid2;
	elsif Pfun = 'SUMAR' THEN
		select SUM(salary) INTO VResult
		from employees
		where employee_id between Pid1 and Pid2;
	elsif Pfun = 'PROMEDIO' then
		select AVG(salary) into VResult
		from employees
		where employee_id between Pid1 and Pid2;
	end if;
	return(VResult);
	exception
		when no_data_found then
			return -1;
end fun_sal_rangos;
/
show error

PROMPT NO MODIFICAR NADA DE ACA ABAJO (Solo crear la funcion con el nombre fun_sal_rangos
PROMPT ================================================================
set pagesize 200
COLUMN id FORMAT 999999
COLUMN resultado FORMAT 999999


select employee_id id, salary
from   employees
where  employee_id < 105;

PROMPT Prueba 01 fun_sal_rangos  fun_sal_rangos('CONTAR',101,103)
select fun_sal_rangos('CONTAR',101,103) resultado from dual;

PROMPT Prueba 02 fun_sal_rangos fun_sal_rangos('SUMAR',102,104)
select fun_sal_rangos('SUMAR',102,104) resultado from dual;

PROMPT Prueba 03 fun_sal_rangos fun_sal_rangos('PROMEDIO',102,103)
select fun_sal_rangos('PROMEDIO',102,103) resultado from dual;

PROMPT Prueba 04 fun_sal_rangos fun_sal_rangos('MAXIMO',102,103)
--If = MAXIMO   MAL.. 
-- HOla, Prueba, ABC...  retorna -1
select fun_sal_rangos('MAXIMO',102,103) resultado from dual;


show error
PROMPT ====final=========== Gabriel Jimenez
spool off
host start notepad.exe Fun_con_fun_agreg.log
exit
