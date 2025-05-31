host cls

spool Quiz_03_Gabriel_Jimenez.log
PROMPT ====Inicio Proyecto=========== Gabriel Jimenez
PROMPT 
PROMPT TEMA FUNCIONES DE BASES DE DATOS
PROMPT 
conn bases1/bases123

PROMPT 
PROMPT =====================================================
PROMPT Explicar de que se trata el nuevo "Modulo" con dos tablas
PROMPT Todas las lineas que necesite 
PROMPT 
PROMPT El nuevo modulo se encuentra compuesto por 2 tablas adicionales: DONATION_PROGRAMS y PAYROLL_DEDUCTIONS.
PROMPT En DONATION_PROGRAMS se muestran los programas de donacion existentes a los que los empleados pueden 
PROMPT hacer una donacion voluntaria mensualmente, rebajada de su salario. En ella se muestran los datos de 
PROMPT los programas de donacion, como su nombre, descripcion, fechas de inicio y de fin, entre otros.
PROMPT
PROMPT En PAYROLL_DEDUCTIONS se muestra de manera concreta la relacion que existe entre un empleado y el
PROMPT programa de donacion al que desea hacer la donacion. Se pueden ver los id del empleado que hace la
PROMPT donacion y del programa al que esta donando, asi como la cantidad que el empleado quiere que se le
PROMPT rebaje y la fecha de inicio y fin de esta deduccion.
PROMPT 
PROMPT ================================================
PROMPT Dropeamos secuencias
drop sequence seq_donation_programs;
drop sequence seq_payroll_deductions;

PROMPT ========================================
PROMPT Dropeamos Tablas
drop table payroll_deductions;
drop table donation_programs;

PROMPT ================================================
PROMPT Creamos tablas

create table donation_programs (
    donation_program_id number,
    program_name varchar2(50) not null,
    description varchar2(200),
    is_national char(1),
    start_date date not null,
    end_date date not null
);

create table payroll_deductions (
    deduction_id number,
    employee_id number not null,
    donation_program_id number not null,
    monthly_amount number(10,2),
    start_date date not null,
    end_date date not null
);

PROMPT ================================================
PROMPT Creamos secuencias
create sequence seq_donation_programs start with 1000;
create sequence seq_payroll_deductions start with 100;

PROMPT ================================================
PROMPT Creamos PKs
alter table donation_programs add constraint donation_programs_pk primary key (donation_program_id);
alter table payroll_deductions add constraint payroll_deductions_pk primary key (deduction_id);

PROMPT =================================
PROMPT Creamos las FK
alter table payroll_deductions add constraint payroll_deductions_fk_employees
foreign key (employee_id) references employees(employee_id);

alter table payroll_deductions add constraint payroll_deductions_fk_programs 
foreign key (donation_program_id) references donation_programs(donation_program_id);

PROMPT =================================
PROMPT Creamos las CK

-- Valor valido para campo is_national
alter table donation_programs add constraint donation_programs_is_national_ck 
check (is_national in ('Y','N'));

-- Monto mensual debe ser positivo
alter table payroll_deductions add constraint payroll_deductions_monthly_amount_ck 
check (monthly_amount > 0);

PROMPT ================================================
PROMPT Creamos procedimientos de insercion

create or replace procedure prc_insertar_donation_program (
    p_program_name varchar2,
    p_description varchar2,
    p_is_national char,
    p_start_date date,
    p_end_date date
) as
begin
    insert into donation_programs (
        donation_program_id, program_name, description, is_national, start_date, end_date
    ) values (
        seq_donation_programs.nextval, p_program_name, p_description, p_is_national, p_start_date, p_end_date
    );
end prc_insertar_donation_program;
/

create or replace procedure prc_insertar_payroll_deduction (
    p_employee_id number,
    p_donation_program_id number,
    p_monthly_amount number,
    p_start_date date,
    p_end_date date
) as
begin
    insert into payroll_deductions (
        deduction_id, employee_id, donation_program_id, monthly_amount, start_date, end_date
    ) values (
        seq_payroll_deductions.nextval, p_employee_id, p_donation_program_id, p_monthly_amount, p_start_date, p_end_date
    );
end prc_insertar_payroll_deduction;
/

PROMPT ================================================
PROMPT Insertamos datos usando procedimientos

begin
    prc_insertar_donation_program('Ninos de la calle', 'Programa para apoyar a ninos en situacion de calle', 'Y', to_date('20/04/2026', 'DD/MM/YYYY'), to_date('21/05/2027', 'DD/MM/YYYY'));
    prc_insertar_donation_program('Mujeres en riesgo social', 'Apoyo a mujeres en condiciones vulnerables', 'N', to_date('21/04/2026', 'DD/MM/YYYY'), to_date('22/06/2028', 'DD/MM/YYYY'));
    prc_insertar_donation_program('Ayuda a refugiados', 'Asistencia a personas refugiadas y desplazadas', 'Y', to_date('22/04/2027', 'DD/MM/YYYY'), to_date('21/05/2028', 'DD/MM/YYYY'));
    prc_insertar_donation_program('Comedores publicos', 'Apoyo a comedores comunitarios y publicos', 'Y', to_date('23/04/2027', 'DD/MM/YYYY'), to_date('22/06/2029', 'DD/MM/YYYY'));
    prc_insertar_donation_program('Seminarios de ayuda', 'Charlas y talleres para la asistencia social', 'N', to_date('24/04/2028', 'DD/MM/YYYY'), to_date('21/05/2029', 'DD/MM/YYYY'));

    prc_insertar_payroll_deduction(177, 1000, 2000, to_date('12/07/2024', 'DD/MM/YYYY'), to_date('03/03/2026', 'DD/MM/YYYY'));
    prc_insertar_payroll_deduction(204, 1001, 1500, to_date('13/08/2025', 'DD/MM/YYYY'), to_date('03/04/2026', 'DD/MM/YYYY'));
    prc_insertar_payroll_deduction(141, 1002, 3000, to_date('14/09/2026', 'DD/MM/YYYY'), to_date('03/05/2027', 'DD/MM/YYYY'));
    prc_insertar_payroll_deduction(206, 1003, 2500, to_date('12/08/2024', 'DD/MM/YYYY'), to_date('03/06/2027', 'DD/MM/YYYY'));
    prc_insertar_payroll_deduction(153, 1004, 1000, to_date('13/08/2026', 'DD/MM/YYYY'), to_date('03/07/2028', 'DD/MM/YYYY'));
end;
/

set linesize 300
COLUMN program_name FORMAT A30
COLUMN is_national FORMAT A15
COLUMN description FORMAT A60
COLUMN start_date FORMAT A11

select * from donation_programs;
select * from payroll_deductions;

show error
PROMPT ====Final Proyecto=========== Gabriel Jimenez
spool off
host start notepad.exe Quiz_03_Gabriel_Jimenez.log
exit
