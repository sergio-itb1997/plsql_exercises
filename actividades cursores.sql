1. Programar un bloc que ens retorni els empleats on el salari sigui més gran al valor que s’introdueix per teclat. S’ha de controlar mitjançant una funció anomenada CONTROLAR_NEGATIU, si el salari que s’introdueix per teclat és negatiu o no. En cas de que no sigui negatiu s’ha de mostrar el codi, nom i salari de l’empleat, en cas contrari s’ha d’imprimir “ERROR: salari negatiu i ha de ser positiu”.






accept salario prompt 'Introduce el salario';
declare
esNegatiu exception;
panoja employees.salary%type := &salario;
emp employees%rowtype;
cursor empleados is
select first_name into emp.first_name from employees 
where salary > panoja; 
begin
if controlar_negatiu(panoja) = true then
raise esNegatiu;
else
open empleados;
loop
  fetch empleados into emp.first_name;
  exit when empleados%NOTFOUND;
  dbms_output.put_line(emp.first_name);
end loop;
end if;
exception when esNegatiu then
dbms_output.put_line('ERROR: Salari negatiu ha de ser positiu');
end;
/


create or replace function controlar_negatiu(panoja number)
return boolean
is
negatiu boolean;
begin
if panoja < 0 then
negatiu := true;
return negatiu;
else
negatiu := false;
end if;
return negatiu;
end controlar_negatiu;
/
________________


2. Programar un bloc que introdueixi un empleat a la taula corresponent. Les dades de l’empleat s’ha d’introduir per teclat. Al mateix script s’ha de comprovar que s’ha realitzat correctament la inserció, a més de mantenir informat a l’usuari constantment (fent ús de cursors implícits).




accept empid prompt 'Introduce el id de empleado';
accept empname prompt 'Introduce el nombre de empleado';
accept empcognom prompt 'Introduce el cognom de empleado';
accept empjobid prompt 'Introduce el job id del empleado'
accept empsalary prompt 'Introduce el salario de empleado';
accept empmanager prompt 'Introduce el manger de empleado (opcional)';
accept empdept prompt 'Introduce el id del departamento del empleado';


declare


idemp employees.employee_id%type := '&empid';
nameemp employees.first_name%type := '&empname';
jobidemp jobs.job_id%type := '&empjobid';
cognomemp employees.last_name%type := '&empcognom';
salaryemp employees.salary%type := '&empsalary';
manageremp employees.manager_id%type := '&empmanager';
deptemp employees.department_id%type := '&empdept';


cursor emp_cursor is
select employee_id, first_name, last_name, job_id, salary, manager_id, department_id  
from employees where employee_id = idemp;


idNoIntroducido exception;
managerNoIntroducido exception;
departamentoNoIntroducido exception;
salarioNoIntroducido exception;
oficioNoIntroducido exception;




 emp_id employees.employee_id%type;  
 emp_name employees.first_name%type;  
 emp_cognom employees.last_name%type; 
 emp_jobid employees.job_id%type;
 emp_sal employees.salary%type;  
 emp_man employees.manager_id%type; 
 emp_dep employees.department_id%type;


begin
if controlar_negatiu(salaryemp) = true then 
  raise salarioNoIntroducido;
else 
  insert into employees (salary) values (salaryemp);
end if;
if comprobar_idemp(idemp) = true then
  raise idNoIntroducido;
else 
  insert into employees (employee_id) values (idemp);
end if;
if comprobar_deptemp(deptemp) = false then
   raise departamentoNoIntroducido;
else 
  insert into employees (department_id) values (deptemp);
end if;
if comprobar_jobid(jobidemp) then
  raise oficioNoIntroducido;
else 
  insert into employees (job_id) values (jobidemp);
end if;
if comprobar_manageremp(manageremp) = false then
  raise managerNoIntroducido;
else
insert into employees (manager_id) values(manageremp);
dbms_output.put_line('Usuario insertado correctamente');


-- ABRIMOS EL CURSOR
open emp_cursor;    
loop     
-- INTRODUCIMOS LOS DATOS QUE TIENE EL CURSOR EN LAS VARIABLES
fetch emp_cursor      
into emp_id, emp_name, emp_cognom, emp_job_id , emp_sal, emp_man, emp_dep;      
exit when emp_cursor%notfound;      
dbms_output.put_line('ID EMPLEADO: '||emp_id);     
dbms_output.put_line('NOMBRE: '||emp_name);  
dbms_output.put_line('APELLIDO: '||emp_cognom);


dbms_output.put_line('SALARIO: '||emp_sal);
dbms_output.put_line('DEPARTAMENTO: '||emp_dep);
dbms_output.put_line('MANAGER: '||emp_man);
dbms_output.put_line('');   
end loop;
close emp_cursor;
-- CERRRAMOS EL CURSOR


end if;


exception when managerNoIntroducido then
    dbms_output.put_line('El manager debe existir en la base de datos');


     when departamentoNoIntroducido then
      dbms_output.put_line('El departamento al que pertenece el empleado a dar de alta no existe en la base de datos');


 when idNoIntroducido then
    dbms_output.put_line('El id del empleado a dar de alta no debe figurar en la base de datos');


 when salarioNoIntroducido then 
    dbms_output.put_line('El salario debe ser positivo');
    
  when oficioNoIntroducido then
    dbms_output.put_line('El oficio debe existir en la base de datos');
end;
/


--COMPROBAMOS SI EXSTE EL JOB_ID 
create or replace function comprobar_jobid(jobidemp jobs.job_id%type)
return boolean
is 
  numero number;
begin
select count(*) into numero from jobs where job_id like jobidemp;
if numero >= 1 then    
  return true; 
else    
   return false;
end if;
end comprobar_jobid;
/




-- COMPROBAMOS SI EXISTE EL EMPLEADO
create or replace function comprobar_idemp(idemp employees.employee_id%type)
return boolean
is 
  numero number;
begin
select count(*) into numero from employees where employee_id like idemp;
if numero >= 1 then    
  return true; 
else    
   return false;
end if;
end comprobar_idemp;
/






-- COMPROBAMOS SI EXISTE MANAGER
create or replace function comprobar_manageremp(manageremp employees.manager_id%type)
return boolean
is 
  numero number;
begin
select count(*) into numero from employees where employee_id like manageremp;
if numero >= 1 then    
  return true; 
else    
   return false;
end if;
end comprobar_manageremp;
/






-- COMPROBAMOS SI EXISTE DEPARTAMENTO
create or replace function comprobar_deptemp(deptemp employees.department_id%type)
return boolean
is 
  numero number;
begin
select count(*) into numero from departments where department_id like deptemp;
if numero >= 1 then    
  return true; 
else    
   return false;
end if;
end comprobar_deptemp;
/




-- COMPROBAMOS QUE EL SALARIO SEA POSITIVO
create or replace function controlar_negatiu(salaryemp number)
return boolean
is
negatiu boolean;
begin
if salaryemp < 0 then
negatiu := true;
return negatiu;
else
negatiu := false;
return negatiu;
end if;
end controlar_negatiu;
/


select * from employees;




________________
________________




3 -- Programar un  bloc que actualitzi el salari en 200 de l’empleat que s'introdueix per teclat. A més, s’ha de realitzar l’actualització si la comissió no és nul·la. Al mateix script s’ha de comprovar que s’ha realitzar correctament l’actualització. No oblidar de mantenir informat a l’usuari corresponent (fent ús dels cursors implícits).


accept empId prompt 'Introduce el id de empleado: '
declare  v_empid employees.employee_id%type := &empId;
emp employees%rowtype;
comisionNula exception;
empleado404 exception;
begin  


if comprobar_idemp (v_empid) = true then
dbms_output.put_line('Usuario encontrado con exito'); 
else 
raise empleado404;
end if;


if comprovar_comision(v_empid) = true then 
actualizar_salario(v_empid);    
dbms_output.put_line('Aumento de sueldo realizado con éxito'); 
select employee_id, first_name, salary
into emp.employee_id, emp.first_name, emp.salary    
from employees    
where employee_id = v_empid;  


dbms_output.put_line('ID: '||emp.employee_id);   


dbms_output.put_line('Nombre: '||emp.first_name); 


dbms_output.put_line('Salario: '||emp.salary);  


else 
raise comisionNula;
end if;
exception when comisionNula then
dbms_output.put_line('La comision de este empleado es nula, no se actualizara el salario'); 
when empleado404 then 
dbms_output.put_line('El empleado introducido no existe');
end;
/




-- COMPROBAMOS SI EXISTE LA COMISION
create or replace function comprovar_comision(idemp employees.employee_id%type)
return boolean
is 
  numero number;
begin
  select commission_pct into numero from employees where employee_id like idemp;
 if numero is null then
  return false; 
else    
   return true;
end if;
end comprovar_comision;
/




-- COMPROBAMOS SI EXISTE USUARIO
create or replace function comprobar_idemp(idemp employees.employee_id%type)
return boolean
is 
  numero number;
begin
select count(*) into numero from employees where employee_id like idemp;
if numero >= 1 then    
  return true; 
else    
   return false;
end if;
end comprobar_idemp;
/


drop procedure aumentar_salario;


-- AUMENTAMOS SALARIO
create or replace procedure actualizar_salario(v_empid employees.employee_id%type)
is
v_salari employees.salary%type;
comision employees.commission_pct%type;
begin  
select commission_pct into comision
from employees  
where employee_id = v_empid;
update employees set salary = 200  
where employee_id = v_empid; 
end;
/
















4.  Programar un bloc que elimini l’empleat que s'introdueix per teclat. No oblidar de mantenir informat a l’usuari constantment (fent ús dels cursors implícits).








accept empId prompt 'Introduce el id del empleado'
declare


idemp employees.employee_id%type := '&empId';
emp employees%rowtype;
empleado404 exception;


begin
if COMPROBAR_IDEMP(idemp) = true then
  select employee_id, first_name, last_name, salary    
  into emp.employee_id, emp.first_name, emp.last_name, emp.salary    
  from employees   
  where employee_id = idemp;   
  
  dbms_output.put_line('ELIMINANDO LOS DATOS DEL SIGUIENTE EMPLEADO');
  
  dbms_output.put_line('');    
  
  dbms_output.put_line('ID: '||emp.employee_id);  
  
  dbms_output.put_line('Nombre: '||emp.first_name); 
  
   dbms_output.put_line('Apellido: '||emp.last_name);  
  
  dbms_output.put_line('Salario: '||emp.salary);   
  
  ELIMINAR(idemp);   
  
  dbms_output.put_line('');  
  
  dbms_output.put_line('Datos de empleado eliminados con éxito');
  
  else   
  raise empleado404;
end if;
exception when empleado404 then
  dbms_output.put_line('ERROR: ID DE EMPLEADO INEXISTENTE');
end; 
/


select * from employees;




-- COMPROBAMOS SI EXISTE USUARIO
create or replace function comprobar_idemp(idemp employees.employee_id%type)
return boolean
is 
  numero number;
begin
select count(*) into numero from employees where employee_id like idemp;
if numero >= 1 then    
  return true; 
else    
   return false;
end if;
end comprobar_idemp;
/




-- eliminamos
create or replace procedure eliminar(idemp employees.employee_id%type)
is
begin
delete from employees
where employee_id like idemp;
end;
/


________________




5. Programar un bloc que comprovi si un empleat existeix a la taula corresponent o no i no oblidar donar els missatges corresponents a l’usuari (fent ús dels cursors implícits).


accept empId prompt 'Introduce el id del empleado'
declare


idemp employees.employee_id%type := '&empId';
emp employees%rowtype;
empleado404 exception;


begin
if COMPROBAR_IDEMP(idemp) = true then
  select employee_id, first_name, last_name, salary    
  into emp.employee_id, emp.first_name, emp.last_name, emp.salary    
  from employees   
  where employee_id = idemp;   


  
  dbms_output.put_line('Empleado encontrado');    
  
  dbms_output.put_line('ID: '||emp.employee_id);  
  
  dbms_output.put_line('Nombre: '||emp.first_name); 
  
   dbms_output.put_line('Apellido: '||emp.last_name);  
  
  dbms_output.put_line('Salario: '||emp.salary);   
  


  else   
  raise empleado404;
end if;
exception when empleado404 then
  dbms_output.put_line('ERROR: ID DE EMPLEADO INEXISTENTE');
end; 
/


-- COMPROBAMOS SI EXISTE USUARIO
create or replace function comprobar_idemp(idemp employees.employee_id%type)
return boolean
is 
  numero number;
begin
select count(*) into numero from employees where employee_id like idemp;
if numero >= 1 then    
  return true; 
else    
   return false;
end if;
end comprobar_idemp;
/






6  Programar un bloc que determini els empleats amb salaris superiors al salari que s'introdueix per teclat (s’ha de tenir en compte que pot haver salaris nuls).




accept empSalary prompt 'Introduce un salario y te dire cuantos currelas cobran mas que la cantidad indicada'
declare


salaryemp employees.salary%type := '&empSalary';
salario404 exception;


cursor emp_cursor is  
select employee_id, first_name, salary  
from employees  
where salary > salaryemp;


 emp_id employees.employee_id%type;
 emp_name employees.first_name%type;
 emp_sal employees.salary%type;


begin
if controlar_negatiu(salaryemp) = false then
  if emp_sueldo_superior_a(salaryemp) >= 1 then
  open emp_cursor;
   loop    
   fetch emp_cursor    
   into emp_id, emp_name, emp_sal;   
   exit when emp_cursor%notfound;   
   dbms_output.put_line('ID: '||emp_id);   
   dbms_output.put_line('Nom: '||emp_name); 
   dbms_output.put_line('Salari: '||emp_sal); 
   dbms_output.put_line('');
   end loop;
   close emp_cursor;
  dbms_output.put_line('Hay ' || emp_sueldo_superior_a(salaryemp) || ' currelas cobrando mas de ' || salaryemp || '€');
  else 
  dbms_output.put_line('No hay ningun currela cobrando mas del salario indicado');
  end if;
else   
  raise salario404;
end if;
exception when salario404 then
  dbms_output.put_line('ERROR: SALARIO NEGATIVO O NULL');
end; 
/


-- contamos cuantos currelas hay cobrando mas del salario que le hemos pasado
create or replace function emp_sueldo_superior_a(salario employees.salary%type)
return number
is
numero number;
begin
select count(*) into numero from employees where salary > salario and salary is not null;
return numero;
end emp_sueldo_superior_a;
/


-- controlamos que el salario sea positivo
create or replace function controlar_negatiu(salaryemp number)
return boolean
is
negatiu boolean;
begin
if salaryemp < 0 then
negatiu := true;
return negatiu;
else
negatiu := false;
return negatiu;
end if;
end controlar_negatiu;
/
________________






7 Programar un bloc principal per a seleccionar el nom de l'empleat amb un valor de salari concret (que s’introdueix per teclat). Controlar si retorna més d’una fila, no retorna cap dada o qualsevol altre error.


accept empSalary prompt 'Introduce un salario para ver que empleados cobran esa cantidad'
declare


salaryemp employees.salary%type := '&empSalary';
salario404 exception;


cursor emp_cursor is  
select employee_id, first_name, salary  
from employees  
where salary = salaryemp;


 emp_id employees.employee_id%type;
 emp_name employees.first_name%type;
 emp_sal employees.salary%type;


begin
if controlar_negatiu(salaryemp) = false then
  if emp_sueldo_igual_a(salaryemp) >= 1 then
  open emp_cursor;
   loop    
   fetch emp_cursor    
   into emp_id, emp_name, emp_sal;   
   exit when emp_cursor%notfound;   
   dbms_output.put_line('ID: '||emp_id);   
   dbms_output.put_line('Nom: '||emp_name); 
   dbms_output.put_line('Salari: '||emp_sal); 
   dbms_output.put_line('');
   end loop;
   close emp_cursor;
  dbms_output.put_line('Hay ' || emp_sueldo_igual_a(salaryemp) || ' currelas cobrando ' || salaryemp || '€');
  else 
  dbms_output.put_line('No hay ningun currela cobrando mas del salario indicado');
  end if;
else    
  raise salario404;
end if;
exception when salario404 then
  dbms_output.put_line('ERROR: SALARIO NEGATIVO O NULL');
when salarionull then
  dbms_output.put_line('ERROR: SALARIO NEGATIVO O NULL');
end; 
/


-- contamos cuantos currelas hay cobrando mas del salario que le hemos pasado
create or replace function emp_sueldo_igual_a(salario employees.salary%type)
return number
is
numero number;
begin
select count(*) into numero from employees where salary = salario and salary is not null;
return numero;
end emp_sueldo_igual_a;
/


-- controlamos que el salario sea positivo
create or replace function controlar_negatiu(salaryemp number)
return boolean
is
negatiu boolean;
begin
if salaryemp < 0 then
negatiu := true;
return negatiu;
else
negatiu := false;
return negatiu;
end if;
end controlar_negatiu;
/






________________




8 Programar un bloc PL/SQL que consulti les dades de la taula departament i de la taula empleat i els doni d’alta a una nova taula DEPTEMP (aquesta taula es una taula física SQL i no una PL/SQL). Els passos a seguir son els següents: 
   1. Abans de començar el bloc principal:
      1. Crear amb sentències DDL la taula DEPTEMP, que ha de contenir tots els camps de la taula (DEPT) i el codi i nom dels empleats (taula EMP). L’ordre de creació dels camps ha de ser: detpno, dname, loc, empno i ename. 
      2. Abans de crear la taula, hem d’assegurar-nos que la taula no estigui donada d’alta, és a dir, esborrar-la abans. 
      3. Aquesta taula DEPTEMP, només ha de contenir la estructura, és a dir, no ens interessa els registres. Per tant, s’ha d’esborrar els registres de la taula, després de crear-la. 
      4. Comprovar que la taula DEPTEMP està buida. 
      5. Comença el bloc PL/SQL: en aquest bloc PL/SQL s’ha de consultar les dades corresponents a ambdós taules (deptno, dname, loc, empno i ename) e inserir-los a la nova taula creada (DEPTEMP). 
      6. Quan s’acabi el bloc PL/SQL: Comprovar que la nova taula ja conté registres




create table DEPTEMP 
as (select d.department_id,d.department_name,d.location_id,
 e.employee_id, e.first_name from departments d, employees e);


delete from DEPTEMP;




declare 
cursor emp_cursor is
select d.department_id , d.department_name, d.location_id, e.employee_id, e.first_name  
from departments d, employees e 
where e.employee_id = d.manager_id
and e.department_id = d.department_id  order by 1;  


v_did departments.department_id%type;
v_dname departments.department_name%type;
v_loc departments.location_id%type; 
v_empid employees.employee_id%type; 
v_name employees.first_name%type; 


begin    
open emp_cursor; 
loop      
fetch emp_cursor  
into v_did, v_dname, v_loc, v_empid, v_name;
exit when emp_cursor%notfound;  
insert into DEPTEMP values (v_did, v_dname, v_loc, v_empid, v_name);    
end loop;
close emp_cursor;
end;
/




9 Programar un bloc que imprimeix els nom i els lloc de tots els departaments. Aquest exercici s’ha de fer amb la clàusula: 
   1. OPEN, FETCH, CLOSE 






declare
cursor dept_cursor is
select d.department_name, l.city, c.country_name from departments d, locations l, countries c
where d.location_id = l.location_id 
and l.country_id = c.country_id;


dept dept_cursor%rowtype;
begin
open dept_cursor;
loop
fetch dept_cursor
into dept.department_name, dept.city, dept.country_name;
exit when dept_cursor%notfound;
dbms_output.put_line('Nombre de departamento: ' || dept.department_name);
dbms_output.put_line('Ciudad: ' || dept.city);
dbms_output.put_line('Pais: ' || dept.country_name);
dbms_output.put_line(' ');
end loop;
close dept_cursor;
end; 
/


select * from locations;
________________
   2. FOR … IN …
declare
cursor dept_cursor is
select d.department_name, l.city, c.country_name from departments d, locations l, countries c
where d.location_id = l.location_id 
and l.country_id = c.country_id;


begin


for v_cursor in dept_cursor loop
exit when dept_cursor%notfound;
dbms_output.put_line('Nombre de departamento: ' || v_cursor.department_name);
dbms_output.put_line('Ciudad: ' || v_cursor.city);
dbms_output.put_line('Pais: ' || v_cursor.country_name);
dbms_output.put_line(' ');
end loop;
close dept_cursor;
end; 
/
________________




10. Programar un bloc que ens retorni tots els empleats que hi ha a la taula corresponent. S’ha de mostrar les següents dades: codi, nom, salari, comissió i data d’alta.




declare 
cursor empcursor is
select employee_id, first_name, salary, commission_pct, hire_date
from employees
order by 1;
begin
for v_cursor in empcursor loop
exit when empcursor%notfound;
 dbms_output.put_line('ID: '||v_cursor.employee_id);   
 dbms_output.put_line('Nom: '||v_cursor.first_name);   
 dbms_output.put_line('Salari: '||v_cursor.salary);  
 dbms_output.put_line('Comissió: 0'||v_cursor.commission_pct);   
 dbms_output.put_line('Data d ́alta: '||v_cursor.hire_date);   
 dbms_output.put_line('');
end loop;
end;
/






________________


11. Programar un bloc que imprimeix tots els empleats de la taula corresponent, simplement els camps: codi i nom de l’empleat i codi i nom del departament al que pertany. Aquest exercici s’ha de fer amb la clàusula: 
   1. OPEN, FETCH, CLOSE 


        
        declare 
cursor empcursor is
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
order by 1;


v_cursor empcursor%rowtype;
begin
open empcursor;
loop
fetch empcursor
into v_cursor.employee_id, v_cursor.first_name,v_cursor.department_id, v_cursor.department_name;
exit when empcursor%notfound;
 dbms_output.put_line('ID: '||v_cursor.employee_id);   
 dbms_output.put_line('Nom: '||v_cursor.first_name);   
 dbms_output.put_line('ID de departament: '||v_cursor.department_id);  
 dbms_output.put_line('Nom de departament: '||v_cursor.department_name);   
 dbms_output.put_line('');
end loop;
close empcursor;
end;
/










   2. FOR … IN …


declare 
cursor empcursor is
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
order by 1;
begin
for v_cursor in empcursor loop
exit when empcursor%notfound;
 dbms_output.put_line('ID: '||v_cursor.employee_id);   
 dbms_output.put_line('Nom: '||v_cursor.first_name);   
 dbms_output.put_line('ID de departament: '||v_cursor.department_id);  
 dbms_output.put_line('Nom de departament: '||v_cursor.department_name);   
 dbms_output.put_line('');
end loop;
end;
/




________________


12. Programar un bloc que imprimeix el codi i nom dels empleats d’un departament concret que s’ha d’introduir per teclat el codi del departament. Aquest exercici s’ha de fer amb CURSORS AMB PARÀMETRES i els paràmetre que s’ha de passar és el codi de departament que l’usuari introdueixi per teclat.




accept deptid prompt 'Introduce el id del departamento'
declare
iddept departments.department_id%type := &deptid;
cursor deptcursor(deptid departments.department_id%type) is
select employee_id, first_name
from employees
where department_id = deptid
order by 1;


vemp deptcursor%rowtype;


begin
open deptcursor(iddept);
loop
fetch deptcursor
into vemp.employee_id, vemp.first_name;
exit when deptcursor%notfound;
 dbms_output.put_line('ID Empleado: '||vemp.employee_id);  
 dbms_output.put_line('Nom: '||vemp.first_name);      
 dbms_output.put_line(''); 
 end loop;  
 close 
 deptcursor;
 end;
 /
________________




13 Programar un bloc principal que ens retorni els salaris que hi ha a la taula empleats. Se li ha d’aplicar un 18 % a cadascun dels salaris. Els passos a seguir són els següents:
   1. Crear una taula anomenada emp_salari_nou i ha de contenir la mateixa estructura i registre que la taula emp. 
   2. Al bloc PL/SQL s’ha de tenir una taula PL/SQL (que no té res a veure amb les taules físiques de la base de dades) per emmagatzemar tots els salaris dels empleats de la taula. Per tant, aquesta taula és temporal i serveix per fer el càlcul; després els resultats s’ha d’emmagatzemar a la nova taula emp_salario_nou. 
   3. Calcular el 18% del salari e imprimir-lo per pantalla, una vegada que ja s’han actualitzat a la taula emp_salari_nou. Per pantalla ha de sortir de la següent manera:  
El nou salari serà: 5800
El nou salari serà: 3306
El nou salari serà: 2842






actualizar un salario 




no se hace
________________






14. Programar un bloc que ens modifiqui totes les comissions dels empleats sumant 20 als empleats on el codi de departament coincideix amb el que s’introdueix per teclat.






accept deptid prompt 'Introduce el id del departamento'
declare
iddept departments.department_id%type := &deptid;
cursor deptcursor is
select employee_id, first_name, last_name, commission_pct
from employees
where department_id = iddept and commission_pct is not null
for update nowait;


vemp deptcursor%rowtype;


begin
open deptcursor;
loop
fetch deptcursor into vemp;
exit when deptcursor%notfound;
update employees 
set commission_pct = (vemp.commission_pct + 0.20)
where current of deptcursor;
end loop;  
close deptcursor;
commit;
end;
/
________________




15. Programar un bloc que ens actualitza la comissió el 18% de tots els empleats que tingui comissió assignada. 




create table emp_salari_nou as select * from employees;




declare
commision emp_salari_nou.commission_pct%type;
cursor deptcursor is
select employee_id, first_name, last_name, commission_pct
from emp_salari_nou
for update nowait;


vemp deptcursor%rowtype;


begin
open deptcursor;
loop
fetch deptcursor into vemp;
if vemp.commission_pct is null then
dbms_output.put_line('La comissió de lempleat ' || vemp.first_name ||
                    ' no sha pogu modificar correctament');
exit when deptcursor%notfound;
else
update emp_salari_nou 
set commission_pct = (commission_pct*1.18)
where current of deptcursor;
dbms_output.put_line('La comissió de lempleat ' || vemp.first_name ||
                    ' sha modificat correctament i és de 0' || vemp.commission_pct*1.18);
end if;
end loop;  
close deptcursor;
end;
/
