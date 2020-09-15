--Activities
--1. Make a program that shows us the numbers in a range. The minimum range is 1 and the maximum should be asked to the user.
--Perform the program using the FOR structure or the WHILE structure. To perform this exercise you must use a procedure, in such a way that it shows the numbers between a range in this procedure.
--Help:
--* A procedure must be programmed within the program that, given the minimum range of 1 and the maximum that is passed as a parameter to the procedure, prints the numbers between the minimum and maximum range on the screen. The procedure will be called RANG.
--* In addition, a main block must be programmed in the same exercise, which must contain the following aspects:
 --  * ask the user for the maximum range.
  -- * check that the maximum range is not negative. If it is negative give the corresponding message and end the program.
  -- * Call the RANG procedure, passing the maximum range entered per keyboard as a parameter.




set serveroutput on
accept rang_maxim prompt 'Introduce el rango maximo';
declare
    maxim number := &rang_maxim;
begin
if maxim < 0 then
    DBMS_OUTPUT.PUT_LINE('el valor maximo debe ser un numero positivo');
else    
   rango(maxim);
end if ;
end;
/
    
create or replace procedure rango (maxim number)
is 
begin
    for i in 1..maxim loop
         DBMS_OUTPUT.PUT_LINE(i);
    end loop;
end rango;
/


-- 2. Make a program that contains a function that doubles the amount received as a parameter. The function will be named DUPLICATE_QUANTITY. In the same program, a main block must be programmed that asks for the quantity by the keyboard and calls the function that has just been programmed, passing the corresponding parameter.

accept cantidad_original prompt 'Introduce una cantidad'
declare 
cantidad number := &cantidad_original;
begin
if cantidad <= 0 then
DBMS_OUTPUT.PUT_LINE('La cantidad debe ser mayor que 0');
else
DBMS_OUTPUT.PUT_LINE(duplicar_quantitat(cantidad));
end if;
end;
/


create or replace function duplicar_quantitat(cantidad in out number)
return number 
is
begin
cantidad := cantidad * 2;
return (cantidad);
end;
/


drop procedure duplicar_quantitat;


-- 3. Make a program that contains a function that calculates the factorial of a number that is passed as a parameter. The function will be called FACTORIAL. In the same program, a main block must be programmed that asks the user for the number to be calculated and calls the FACTORIAL function, passing the corresponding parameter.

accept numero_original prompt 'Introduce un numero'
declare 
numero number := &numero_original;
begin
if numero <= 0 then
DBMS_OUTPUT.PUT_LINE('Numero debe ser mayor que 0');
else
DBMS_OUTPUT.PUT_LINE(factorial(numero));
end if;
end;
/


create or replace function factorial(numero in out number)
return number 
is
begin
numero := numero * numero;
return (numero);
end;
/


--4. Make a program that contains a procedure, a function, and a main block.
--    1. The procedure, which will be called PRINT, must display the numbers between a range and a hop. Minimum range, maximum range and jump must be passed as parameters in the procedure.
--    2. In the function named CHECK_NEGATIVE, you must program to control:
--       1. That the minimum range is not greater than the maximum range.
--       2. That the minimum range, maximum range and jump are not negative.
--    3. The anonymous blog should ask the user for the necessary data and should call the function to check the data and then if everything is correct, call the procedure to print the data.



accept rang_minim prompt 'Introduce el rango minimo'
accept rang_maximo prompt 'Introduce el rango maximo'
accept salto_1 prompt 'Introduce el salto'
declare 
minim number := &rang_minim;
maxim number := &rang_maximo;
salto number := &salto_1;
paso boolean := false;
begin
paso := comprovar_negatiu(minim,maxim,paso); 
if paso then
imprimir(maxim,minim,salto);
elsif paso = false then
      dbms_output.put_line('FALSO');
end if;
end;
/


drop function comprovar_negatiu;


create or replace function comprovar_negatiu(minim number, maxim number, paso in out boolean)
return boolean
is
begin
if minim >= maxim then
paso := false;
return (paso);
elsif maxim <= minim then
paso := false;
return (paso);
else
paso := true;
return (paso);
end if;
end;
/


create or replace procedure imprimir(maxim number, minim number, salto NUMBER)
is 
i number := minim;
begin
while i < maxim loop
 DBMS_OUTPUT.PUT_LINE(i); 
       i := i + salto;
    end loop;
end i






-- 5. Make a program that asks for an employee's ID on screen and shows their code, name, job (job_title) and salary. You must rename the columns to be (employee_code, employee_name, position, salary).
To perform this exercise you must use a variable of type% rowtype.




accept id_employee prompt 'Introduce el id del employee'
declare 
codigo_empleat number := &id_employee;
codi_empleat employees.employee_id%type;
nom_empleat employees.first_name%type;
carrec jobs.job_title%type;
salari employees.salary%type;
begin
select e.employee_id, e.first_name, j.job_title, e.salary 
into codi_empleat,nom_empleat,carrec,salari
from employees e, jobs j
where e.job_id = j.job_id and e.employee_id = codigo_empleat;
DBMS_OUTPUT.PUT_LINE('codi del empleat es ' || codi_empleat || ' nom del empleat es ' || nom_empleat || chr(13) || ' carrec del empleat es ' ||carrec || ' salari del empleat es ' ||salari); 
end;
/



-- 6. Run a program that contains a procedure that registers a new position (job_title) in the jobs table. New charge data must be entered by keyboard. Before entering, it must be verified that the maximum and minimum value of the salary is not negative and, in addition, that the minimum wage is smaller than the maximum wage. Returns the corresponding error messages

accept id_job prompt 'Introduce el id del cargo'
accept title_job prompt 'Introduce el nombre del cargo'
accept minsalary_job prompt 'Introduce el salario minimo del cargo'
accept maxsalary_job prompt 'Introduce el salario maximo del cargo'


declare 
jobid varchar2(100) := '&id_job';
title varchar2(100) := '&title_job';
minsalary number := '&minsalary_job';
maxsalary number := '&maxsalary_job';
begin
if minsalary > maxsalary then
    dbms_output.put_line('Numero invalido');
elsif minsalary <= 0 or maxsalary <= 0 then
    dbms_output.put_line('Numero invalido');
else
    insert into jobs (job_id, job_title, min_salary, max_salary) values (jobid,title,minsalary, maxsalary);
end if;
end;
/




create or replace procedure imprimir(jobid varchar2, title varchar2, minsalary number, maxsalary number)
is 
begin
 insert into jobs (job_id, job_title, min_salary, max_salary) values (jobid,title,minsalary, maxsalary);
end; 
/


select * from jobs;


-- 7. Make a program to unsubscribe from a position (job_title). The charge code must be entered by keyboard.

accept idjob prompt 'Introdueix l´id del carrec a esborrar';


declare 
    jobid varchar2(30) := '&idjob';
BEGIN
    delete from jobs where job_id = jobid;
end;


--8. Make a program that contains a function that returns how many employees there are in a department, this will be passed as a parameter of the function. The function will be called COUNT and will be called from an anonymous or main block, and the parameter passed to the function will be asked to the user and therefore must be entered by keyboard.





set SERVEROUTPUT ON;
accept iddepartament prompt 'Introduce el numero del departamento a consultar y te dire cuantos empleados hay en ese departamento';
declare
    departamentoid number := &iddepartament;
begin
    DBMS_OUTPUT.PUT_LINE(comptar(departamentoid));
DBMS_OUTPUT.PUT_LINE('El número de empleados del departamento ' || departamentoid || ' perteneciente a ' || buscardepartamento(departamentoid) || ' es de '  ||comptar(departamentoid) || ‘ empleados ’);


end;
/




create or replace function comptar(departamentoid number)
    return number
is
    quantitat number;
begin
    select COUNT(*) into quantitat FROM employees where department_id = departamentoid;
    return quantitat;
end comptar;
/
// ESTA FUNCIÓN LA HE HECHO PARA SACAR EL NOMBRE TAMBIÉN Y PRINTEARLO
create or replace function buscardepartamento(departamentoid number)
  return varchar2
is
  nombre varchar2(30);
begin
    select department_name into nombre FROM departments where department_id = departamentoid;
    return nombre;
end buscardepartamento;
/














--9. Make a program that contains a function that returns the total sum of the salaries of the employees of a specific department. The code of the department must be entered by keyboard by the user and the anonymous block must call a function that will perform the calculation of the sum. This function will be called SUM_TOTAL.



set SERVEROUTPUT ON;
accept iddepartament prompt 'Introduce el numero del departamento a consultar y te dire la suma de todos los salarios';
declare
    departamentoid number := &iddepartament;
begin
    DBMS_OUTPUT.PUT_LINE('El salario de todos los empleados del departamento ' || departamentoid || ' perteneciente a ' || buscardepartamento(departamentoid) || ' es de '  ||sumatotal(departamentoid));
end;
/


create or replace function buscardepartamento(departamentoid number)
  return varchar2
is
  nombre varchar2(30);
begin
    select department_name into nombre FROM departments where department_id = departamentoid;
    return nombre;
end buscardepartamento;
/
  


create or replace function sumatotal(departamentoid number)
    return number
is
    quantitat number;
begin
    select SUM(salary) into quantitat FROM employees where department_id = departamentoid;
    return quantitat;
end sumatotal;
/










--10. Make a program that changes the value of an employee's commission that is entered by keyboard. To modify this commission we must keep in mind that:
--    1. If the salary is less than 1000, 10% is added.
--    2. If the salary is between 1000 and 1500, 15% is added.
 --   3. If the salary is greater than 1500, 20% is added.
 --   4. Otherwise, the commission is set to 0.




-- I have used an extra check functionality, if the commission_pct is null it will print that it has no commission and will not do the operation

set SERVEROUTPUT ON;
accept idempleat prompt 'Introduce el id del empleado a consultar';
declare    
idempleat number := &idempleat;
begin
if buscarcomisio(idempleat) is null then
  DBMS_OUTPUT.PUT_LINE('La comision del empleado numero ' || idempleat || ' con nombre ' 
                            ||  buscarnombre(idempleat) || ' no existe');
else
 DBMS_OUTPUT.PUT_LINE('La comision del empleado numero ' || idempleat || ' con nombre ' 
                            ||  buscarnombre(idempleat) || ' y salario ' || buscarsalario(idempleat) || ' ha pasado de ser de 0'
                            || buscarcomisio(idempleat) || '% '  || ' a 0'  || canvi_comisio(idempleat) || '%');
end if;
end;
/



create or replace function buscarnombre(idempleat number)
return varchar2
is 
  nombre varchar2(15);
begin 
  select first_name into nombre from employees where idempleat = employee_id;
  return nombre;
end buscarnombre;
/



create or replace function buscarsalario(idempleat number)
return number
is 
  salario number;
begin 
  select salary into salario from employees where idempleat = employee_id;
  return salario;
end buscarsalario;
/




create or replace function buscarcomisio(idempleat number)
return number
is 
  comissio number(2,2);
begin 
  select commission_pct into comissio from employees where idempleat = employee_id;
  return comissio;
end buscarcomisio;
/





create or replace function canvi_comisio(idempleat number)    
return number
is 
  comissionova number(2,2);
  quantitat number;
begin    
  select salary into quantitat FROM employees where employee_id = idempleat;   
if quantitat < 1000 then       
  update employees set commission_pct = commission_pct*1.1 where employee_id =idempleat;  
  select commission_pct into comissionova FROM employees where employee_id = idempleat;  
elsif  quantitat >= 1000 and quantitat <=1500 then  
  update employees set commission_pct = commission_pct*1.15 where employee_id =idempleat;  
  select commission_pct into comissionova FROM employees where employee_id = idempleat;  
elsif quantitat > 1500 then        
  update employees set commission_pct = commission_pct*1.2 where employee_id =idempleat;
  select commission_pct into comissionova FROM employees where employee_id = idempleat;  
else 
  update employees set commission_pct = 0 where employee_id = idempleat;  
  select commission_pct into comissionova FROM employees where employee_id = idempleat;  
end if;    
return comissionova;
end;
/


select * from employees;
