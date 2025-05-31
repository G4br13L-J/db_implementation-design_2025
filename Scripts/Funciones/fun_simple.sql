host cls
--Gabriel Jimenez

-- En cada comentario se indica el rebajo de puntos si incumple lo solicitado.
-- NO quitar los comentarios (DEBEN LEER TODOS LOS COMENTARIOS) -3puntos
-- Entregar solo script sin comprimir 
-- Nombre-Apellido-Quiz-4.sql  (sin tildes ni eñes) -3puntos
-- y que la salida sea Nombre-Apellido-Quiz-4.log  (sin tildes ni eñes) -3puntos
-- Colocar su nombre y apellido al inicio y al final del script  (sin tildes ni eñes) -3puntos

-- El archivo Base-Quiz-4.log  MUESTRA COMO ES LA SALIDA LUEGO DE EJECUTAR EL SCRIPT
-- no debe modificar, quitar o agregar, pruebas de la funcion 

--Cambiar .log con  Nombre-Apellido-Quiz-4.log  (sin tildes ni eñes)
spool Gabriel-Jimenez-Quiz-4.log

--Cambiar su nombre y apellido
PROMPT ====Inicio Quiz-4=========== Gabriel Jimenez
PROMPT 
conn bases1/bases123

PROMPT =====================================================
PROMPT Creando Funcion ====
-- Crear Funcion fun_dividir que reciba dos numeros PDividendo y PDivisor y haga una división 
-- PDividendo ENTRE PDivisor y retorne dicho resultado
-- PERO SI NUMERO DEL PDivisor es CERO, muestre mensaje de error NO SE PUEDE HACER DIVISION CON NUMERO CERO
-- SI NUMERO DEL PDivisor es NEgativo, muestre mensaje de error POR REGLA DE NEGOCIO NO SE PERMITE DIVISOR EN NEGATIVO
-- Nota división por un numero negativo es posible, pero para efectos de esta funcion, la regla de negocio lo Prohibe.
-- cualquier otra condicion retorne la división como se muestra en los ejemplos
-- DEBE DEJAR EL NOMBRE DE FUNCION con: fun_dividir  y recibir parametros en ese Orden PDividendo ; PDivisor
-- puede usar cualquier manera VISTA EN CLASES solamente.

-- ACA CREAR LA FUNCION SOlICITADA...

create or replace function fun_dividir(PDividendo in number, PDivisor in number) return varchar2 is
  Vresultado number;
begin
    if PDivisor = 0 then
        raise_application_error(-20001,'NO SE PUEDE HACER DIVISION CON NUMERO CERO');
    elsif PDivisor < 0 then
        raise_application_error(-20001,'POR REGLA DE NEGOCIO NO SE PERMITE DIVISOR EN NEGATIVO') ;
    else
        Vresultado := PDividendo / PDivisor;
        return Vresultado;
    end if;
end fun_dividir;
/
show error

PROMPT =====================================================
PROMPT PRUEBAS DE LA FUNCION NO CAMBIAR ESTO
select fun_dividir(10,2) salida_5 from dual;

select fun_dividir(8,3) salida_2_667 from dual;

select fun_dividir(10,0) error_cero1 from dual;

select fun_dividir(100,0) error_cero2 from dual;

select fun_dividir(10,-5) error_neg1 from dual;

select fun_dividir(10,-8) error_neg2 from dual;

show error
--Cambiar su nombre y apellido
PROMPT ====Final Quiz-4=========== Gabriel Jimenez
spool off

--Cambiar .log con  Nombre-Apellido-Quiz-4.log  (sin tildes ni eñes)
host start notepad.exe Gabriel-Jimenez-Quiz-4.log
exit


