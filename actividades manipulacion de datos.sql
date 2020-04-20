Activitats
1. Realitza un programa que ens mostri els números entre un rang. El rang mínim és 1 i el màxim se l’ha de preguntar a l’usuari.
Realitzar el programa utilitzant l’estructura FOR o l’estructura WHILE. Per realitzar aquest exercici has de fer servir un procediment, de tal manera que mostri els números entre un rang en aquest procediment.
Ajuda: 
* S’ha de programar dins del programa un procediment que donat el rang mínim a 1 i el màxim que se li passa com a paràmetre al procediment, imprimeixi per pantalla els números que hi ha entre el rang mínim i el màxim. El procediment rebrà el nom de RANG. 
* A més, al mateix exercici s’ha de programar un bloc principal, que ha de contenir els següents aspectes:
   * preguntar a l’usuari pel rang màxim.
   * comprovar que el rang màxim no és negatiu. Si és negatiu donar el missatge corresponent i acabar el programa. 
   * Cridar al procediment RANG, passant com a paràmetre el rang màxim introduït per teclat.




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














2. Realitzar un programa que contingui una funció que dupliqui la quantitat rebuda com a paràmetre. La funció rebrà el nom de DUPLICAR_QUANTITAT. Al mateix programa s’ha de programa un bloc principal que demani per teclat la quantitat i que cridi a la funció que s’acaba de programar, passant el paràmetre corresponent.








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






































3. Realitzar un programa que contengui una funció que calculi el factorial d’un número que es passa com a paràmetre. La funció rebrà el nom de FACTORIAL. Al mateix programa s’ha de programar un bloc principal que pregunti a l’usuari pel número a calcular i cridi a la funció FACTORIAL, passant el paràmetre corresponent.


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










































4. Realitzar un programa que contingui un procediment, una funció i un bloc principal.
   1. El  procediment  que  rebrà  el  nom  de IMPRIMIR,  ha  de mostrar  els  números  entre  un  rang  amb  un  salt.  El  rang mínim, el rang màxim i el salt s’han de passar com a paràmetre  al  procediment.   
   2. A la funció que rebrà el nom de COMPROVAR_NEGATIU, s’ha de programar per a controlar:
      1. Que el rang mínim no sigui més gran que el rang màxim.
      2. Que el rang mínim, el rang màxim i el salt no sigui negatiu.
   3. El bloc anònim ha de preguntar a l’usuari les dades necessàries i ha de cridar a la funció per comprovar les dades i després si tot és correcta, crida al procediment per imprimir les dades. 




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






5. Realitzar un programa que demani per pantalla l’id d’un empleat i mostri el seu codi, el seu nom, el seu càrrec (job_title) i el seu salari. Has de canviar els nom de les columnes perquè sigui (codi_empleat, nom_empleat, càrrec, salari). 
Per realitzar aquest exercici has de fer servir una variable de tipus %rowtype.




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
















6. Realitzar un programa que contingui un procediment que doni d’alta un nou càrrec (job_title) a la taula jobs. Les dades del nou càrrec s’han d’introduir per teclat. Abans d’inserir s’ha de comprovar que el valor màxim i mínim del salari no sigui negatiu i a més, que el salari mínim sigui més petit que el salari màxim. Dóna els missatges d’error corresponents








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












7. Realitzar un programa per donar de baixa un càrrec (job_title). El codi del càrrec s’ha d'introduir per teclat.




accept idjob prompt 'Introdueix l´id del carrec a esborrar';


declare 
    jobid varchar2(30) := '&idjob';
BEGIN
    delete from jobs where job_id = jobid;
end;






8. Realitzar un programa que contingui una funció que retorni quants empleats hi ha a un departament, aquest es passarà com a paràmetre de la funció. La funció s’anomenarà COMPTAR i es cridarà des d’un bloc anònim  o principal, i el paràmetre que se li passa a la funció se li preguntarà a l’usuari i per tant, s’ha d’introduir per teclat.






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














9. Realitzar un programa que contingui una funció que retorni la suma total dels salaris dels empleats d’un departament en concret. El codi del departament s’ha d’introduir per teclat per part de l’usuari i el bloc anònim ha de cridar a una funció que realitzarà el càlcul de la suma. Aquesta funció rebrà el nom de SUMA_TOTAL.




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










10. Realitzar un programa que ens modifiqui el valor de la comissió d’un empleat que s’introdueixi per teclat. Per a modificar aquesta comissió hem de tenir en compte que: 
   1. Si el salari és menor a 1000, se li afegeix el 10%.
   2. Sii el salari està entre 1000 i 1500, se li afegeix el 15 %. 
   3. Si el salari és major a 1500, se li afegeix el 20%. 
   4. En cas contrari, es posa la comissió a 0.




Le he puesto una comprobación, si el commission_pct es null printeara que no tiene comision y no hará la operación


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
________________






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