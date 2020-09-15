--﻿1. Code a block to return employees where the salary is greater than the value entered by keyboard. It must be controlled by a function called CONTROL_NEGATIVE, whether the --salary entered by keyboard is negative or not. If it is not negative, the employee's code, name and salary must be displayed, otherwise "ERROR: negative salary and must be --positive" must be printed.


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


--2. Code a block that an employee enters in the appropriate table. Employee data must be entered by keyboard. In the same script it must be verified that the insertion has been carried out correctly, in addition to keeping the user constantly informed (using implicit cursors).




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


-- OPENING THE CURSOR
open emp_cursor;    
loop     
-- FETCHING THE CURSOR
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
-- CLOSING THE CURSOR


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


--CHECK JOB ID
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




-- CHECK EMPLOYEE
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






-- CHECK MANAGER
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






-- CHECK DEPARTMENT
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




-- VERIFY THAT THE SALARY IS NOT NEGATIVE
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


-- 3 Code a block that updates the salary of 200 of the employee entered by keyboard. In addition, the update must be performed if the commission is not zero. The same script ---should verify that the update was successful. Don't forget to keep the corresponding user informed (using the implicit cursors).


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




-- CHECK COMISSION
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




-- CHECK USER
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


-- RAISE SALARY
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
















--4.  Code a block that eliminates the employee entering by keyboard. Don't forget to keep the user informed (using implicit cursors).








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




-- CHECK USER
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




-- DEELETING USER
create or replace procedure eliminar(idemp employees.employee_id%type)
is
begin
delete from employees
where employee_id like idemp;
end;
/


________________




-- 5. Code a block to check if an employee exists in the corresponding table or not and do not forget to give the corresponding messages to the user (using the implicit cursors).


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






-- 6  Code a block that determines employees with higher salaries than the salary entered by keyboard (it should be noted that there may be zero salaries).




accept empSalary prompt 'Introduce un salario y te dire cuantos trabajadores cobran mas que la cantidad indicada'
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
  dbms_output.put_line('Hay ' || emp_sueldo_superior_a(salaryemp) || ' trabajadores cobrando mas de ' || salaryemp || '€');
  else 
  dbms_output.put_line('No hay ningun trabajador cobrando mas del salario indicado');
  end if;
else   
  raise salario404;
end if;
exception when salario404 then
  dbms_output.put_line('ERROR: SALARIO NEGATIVO O NULL');
end; 
/


-- we count how many workers there are charging more than the salary that we have paid
create or replace function emp_sueldo_superior_a(salario employees.salary%type)
return number
is
numero number;
begin
select count(*) into numero from employees where salary > salario and salary is not null;
return numero;
end emp_sueldo_superior_a;
/


-- VERIFY NEGATIVE SALARY
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




-- 7 Code a main block to select the employee's name with a specific salary value (entered by keyboard). Check if it returns more than one row, does not return any data or any --other error.


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
  dbms_output.put_line('Hay ' || emp_sueldo_igual_a(salaryemp) || ' trabajador cobrando ' || salaryemp || '€');
  else 
  dbms_output.put_line('No hay ningun trabajador cobrando mas del salario indicado');
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


-- we count how many workers there are charging more than the salary that we have paid
create or replace function emp_sueldo_igual_a(salario employees.salary%type)
return number
is
numero number;
begin
select count(*) into numero from employees where salary = salario and salary is not null;
return numero;
end emp_sueldo_igual_a;
/


-- verify positive salary
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



--8 Schedule a PL / SQL block that queries the data in the department table and the table used and registers it in a new DEPTEMP table (this table is a physical SQL table and not --a PL / SQL). The steps to follow are as follows:
--   1. Before starting the main block:
 --     1. Create the DEPTEMP table with DDL statements, which must contain all the fields in the table (DEPT) and the code and name of the employees (EMP table). The order in --which the fields were created must be: detpno, dname, loc, empno, and ename.
 --     2. Before creating the table, we must make sure that the table is not registered, that is, delete it beforehand.
  --    3. This table DEPTEMP, only has to contain the structure, that is to say, we are not interested in the records. Therefore, the records in the table must be deleted after --creating it.
--      4. Check that the DEPTEMP table is empty.
 --     5. Start the PL / SQL block: in this PL / SQL block you must consult the data corresponding to both tables (deptno, dname, loc, empno and ename) and insert them in the --newly created table (DEPTEMP).
--      6. When the PL / SQL block is finished: Check that the new table already contains records




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




--9 Schedule a block that prints the names and locations of all departments. This exercise must be done with the clause:
 --   1. OPEN, FETCH, CLOSE



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




-- 10. Code a block that returns all the employees in the corresponding table. The following information must be provided: code, name, salary, commission and registration date.




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


--11. Code a block that prints all the employees in the corresponding table, simply the fields: code and name of the employee and code and name of the department to which it belongs. This exercise must be done with the clause:
   -- 1. OPEN, FETCH, CLOSE


        
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


--12. Code a block that prints the code and name of the employees of a specific department to enter the department code by keyboard. This exercise must be done with CURSORS WITH PARAMETERS and the parameters to be passed are the department code that the user enters by keyboard.




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


--14. Code a block that modifies all of our employee commissions by adding 20 to the employees where the department code matches what is entered by keyboard.


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




--15. Code a blog that updates us commission 18% of all employees who have commission assigned.



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
