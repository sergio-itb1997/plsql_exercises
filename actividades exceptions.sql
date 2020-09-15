-- 1 Code a main block and a procedure for consulting employee data. The employee code will be entered by keyboard. The anonymous blog will ask the user and call the procedure by going to the corresponding parameter. The procedure will consult the employee table and retrieve the following data: name, salary, commission, trade and boss.En cas de que la comissió sigui nul·la, ha d’aparèixer 0 i no en blanc.
--The procedure will be called data_printing.
--In addition, it must be checked whether or not the employee exists in the database. (Error handling)






accept emp_id number prompt 'Introduce el id del empleado';
declare    
idempleado number := &emp_id;    
begin 
imprimir(idempleado);
end;
/


create or replace procedure imprimir(id empleado number)
is
  nombre employees.first_name%type;
  salario employees.salary%type;
  comission employees.commission_pct%type;
  oficio jobs.job_title%type;
  cap employees.first_name%type;
  
begin
  select e.first_name, e.salary, e.commission_pct, j.job_title, e2.first_name 
    into nombre, salario, comission, oficio, cap from employees e, jobs j, employees e2 
    where e.employee_id like idempleado and e.manager_id = e2.employee_id and e.job_id like j.job_id;
     dbms_output.put_line('Nom: '||nombre);        
     dbms_output.put_line('Salari: '||salario);      
     if comission is null then        
     dbms_output.put_line('Comissió: 0');     
     else        
       dbms_output.put_line('Comissió: 0'||comission);      
     end if;        
      dbms_output.put_line('Ofici: '||oficio);        
      dbms_output.put_line('Cap: '||cap); 
     exception  
     when no_data_found 
     then
      dbms_output.put_line('ERROR: L ́empleat amb id '||idempleado||' no existeix');
end imprimir;
/


















-- 2 Code the same exercise as above but now the subprogram will be a function called return_data. The function will not print any data, but will return a variable of type record.S’ha de controlar els possibles errors (com abans) però ara a la funció.






accept emp_id number prompt 'Introduce el id del empleado';
declare    
idempleado number := &emp_id;    
begin 
 dbms_output.put_line(retornar_dades(idempleado));
end;
/


create or replace function retornar_dades(idempleado number)
return varchar2
is
  registro varchar2(100);
  nombre employees.first_name%type;
  salario employees.salary%type;
  comission employees.commission_pct%type;
  oficio jobs.job_title%type;
  cap employees.first_name%type;
  
begin
  select e.first_name, e.salary, e.commission_pct, j.job_title, e2.first_name 
    into nombre, salario, comission, oficio, cap from employees e, jobs j, employees e2 
    where e.employee_id like idempleado and e.manager_id = e2.employee_id and e.job_id like j.job_id;     
     if comission is null then        
     comission := 0;     
     
    registro := 'Nom: ' || nombre || chr(13) || 'Salari: ' || salario || chr(13) || 'Comissio: ' || comission || chr(13) 
                  || 'Ofici: ' || oficio || chr(13) || 'Cap: ' || cap;
      return registro;
     end if;        
     exception  
     when no_data_found 
     then
      registro := 'ERROR: L ́empleat amb id '||idempleado||' no existeix';
      return registro;
end retornar_dades;
/









-- 3 Code a block that tells us whether or not there is a department entered by screen in our database. The following aspects must be taken into account:
--    1. the code of the department will be entered by the user by keyboard.
--    2. To check whether or not the department exists, a function called CHECK_DEPT must be programmed. This function will be passed as a parameter from the main block to the code of the department to be checked.
--    3. The message to display is: "DEPARTMENT EXISTS" or "NO DEPARTMENT".


accept dept_id number prompt 'Introduce el ID del departamento';
declare
iddept number := &dept_id;
begin
if (comprovar_dept(iddept)) = true then 
 dbms_output.put_line('EXISTEIX DEPARTAMENT');
else 
  dbms_output.put_line('NO EXISTEIX DEPARTAMENT');
  end if;
end;
/


create or replace function comprovar_dept(iddept number)
  return boolean
is
  nombre varchar2(30);
  existencia boolean;
begin
    select department_name into nombre FROM departments where department_id = iddept;
    if nombre is not null then
    existencia := true;
    end if;
    return existencia;
    exception
     when no_data_found 
     then
      existencia := false;
      return existencia;
end comprovar_dept;
/


________________




-- 4 Code a block that inserts the data of a department in the corresponding table. This data must be entered by the user by keyboard. Before inserting the department, you must check whether or not the department exists in the database (to do this check we will use the function that was created in the previous exercise, CHECK_DEPT).



accept depart_id prompt 'Introduce el id del departamento: '
accept depnombre_id prompt 'Introduce el nombre del departamento: '
accept cap_id prompt 'Introduce el id del jefe de departamento: '
accept location_id prompt 'Introduce el id de la localización del departamento: ' 


declare    
departamento_id departments.department_id%type := '&depart_id';    
nombre departments.department_name%type := '&depnombre_id';    
idCap departments.manager_id%type := '&cap_id';    
localizacion departments.location_id%type := '&location_id'; 
begin    
if comprovar_dept(departamento_id) = true then     
dbms_output.put_line('EXISTEIX DEPARTAMENT');   
else     
insert into departments values (departamento_id, nombre, idCap, localizacion);     
dbms_output.put_line('Departamento introducido');    
end if; 
end;
/


create or replace function comprovar_dept(iddept number)
  return boolean
is
  nombre varchar2(30);
  existencia boolean;
begin
    select department_name into nombre FROM departments where department_id = iddept;
    if nombre is not null then
    existencia := true;
    end if;
    return existencia;
    exception
     when no_data_found 
     then
      existencia := false;
      return existencia;
end comprovar_dept;
/


-- 5 Code a plsql block that modifies the DEPT table (which will be a copy of the departments table) where the department code matches the one entered by keyboard and save the changes. Check the corresponding exceptions, that is, if the department or any other error does not exist.

create table dept as select * from DEPARTMENTS;




accept departamento_id number prompt 'Introduce el id del departamento';
accept nombre_id prompt 'Introduce el nombre del departamento';
accept cap_id number prompt 'Introduce el manager id del departamento';
accept ubicacio_id number prompt 'Introduce el el location id del departamento';
declare
deptId number := &departamento_id;
idNombre varchar2 := &nombre_id;
idCap number := &cap_id;
idUbicacio number := &ubicacio_id;
begin
if comprovar_dept(deptId) = false then     
dbms_output.put_line('NO EXISTEIX DEPARTAMENT');   
elsif comprovar_manager(idCap) = false then     
dbms_output.put_line('NO EXISTEIX CAP');   
elsif comprovar_location(idUbicacio) = false then     
dbms_output.put_line('NO EXISTEIX UBICACIO'); 
else     
update dept set department_name = 'idNombre' where department_id like deptId; 
update dept set manager_id  = 'idCap' where department_id like deptId;
update dept set location_id  = 'idUbicacio' where department_id like deptId;
dbms_output.put_line('Departamento modificado correctamente');    
end if; 
end;
/




create or replace function comprovar_manager(idManager number)
  return boolean
is
  nombre varchar2(30);
  existencia boolean;
begin
    select employee_id into nombre FROM employees where employee_id = idManager;
    if nombre is not null then
    existencia := true;
    end if;
    return existencia;
    exception
     when no_data_found 
     then
      existencia := false;
      return existencia;
end comprovar_manager;
/


create or replace function comprovar_location(idLocation number)
  return boolean
is
  nombre varchar2(30);
  existencia boolean;
begin
    select location_id into nombre FROM locations where location_id = idLocation;
    if nombre is not null then
    existencia := true;
    end if;
    return existencia;
    exception
     when no_data_found 
     then
      existencia := false;
      return existencia;
end comprovar_location;
/



-- 6 Code a plsql block that asks the user for the employee code in order to return the employee name. The employee name will be returned by a function that will be created called NAME. This function will be used to set the employee code that the user entered by keyboard. In addition, errors must be checked in the anonymous blog.

SET SERVEROUTPUT ON
SET ECHO OFF
SET VERIFY OFF
accept empp_id prompt 'Introduce el codigo del empleado';


declare
  id_emp  number := &empp_id;
  empleat  employees.first_name%TYPE;
  
  funcion_no_devuelve EXCEPTION;    
  PRAGMA EXCEPTION_INIT(funcion_no_devuelve, -06503); --si la funcion no devuelve nada esta sera la excepcion
  
begin
 empleat := nom(id_emp); 
 DBMS_OUTPUT.PUT_LINE('NOM EMPLEAT ' || empleat);
 EXCEPTION 
 WHEN funcion_no_devuelve THEN    
 DBMS_OUTPUT.PUT_LINE ('NO EXISTEIX EMPLEAT(ERROR: funcion_no_devuelve)');
end;
/






create or replace function nom(idempleat number)
return varchar2
is 
  nombre employees.first_name%type;
  consulta_sin_datos EXCEPTION;  
  PRAGMA EXCEPTION_INIT(consulta_sin_datos, +100); -- error de no data found lo asociamos a esta excepcion
begin 
  select first_name into nombre from employees where idempleat = employee_id;
  return nombre;
  
  EXCEPTION  
  WHEN consulta_sin_datos THEN
  DBMS_OUTPUT.PUT_LINE ('NO EXISTEIX EMPLEAT(ERROR: consulta_no_devuelve)');
  
  end nom;
/


-- 7 Code a plsql block to check if a department exists or not in the corresponding table, consulting the code of the department. If the department exists, it must be printed on the screen and it must be checked whether or not it begins with the letter A. If it begins with the letter A, after printing the name of the department, it must say, START WITH THE LETTER A. Observations:
--1. to check if the department name starts with A, an exception must be programmed and it must be named: noconteA.
--2. In addition, the following exceptions must also be scheduled:
--    1. If there is no data, the following must be returned: "ERROR: no data".
--    2. If you return more than one row: "ERROR: returns more rows"
--    3. Any other error: “ERROR (undefined)”.


set serveroutput on;


create or replace function nom_dep(idDep number)
return boolean
is
  departament departments.department_id%type;
  no_dades exception;
  moltes_files exception;
  otros exception;
 -- pragma exception_init(otros,others);  esta no la definiremos
  pragma exception_init(moltes_files, -1422); -- too_many_rows
  pragma exception_init(no_dades,+100); -- no data found
  
  begin
  select department_id into departament
  from departments 
  where department_id like iddep;
  
  if departament is not null then 
    return true;
  end if;
  exception
  when no_dades then 
    DBMS_OUTPUT.PUT_LINE('ERROR: no_dades');
  when moltes_files then     
  dbms_output.put_line('ERROR: Retorna més files');   
  when others then  
  dbms_output.put_line('ERROR');     
  return false;  
  end;
  /
 
  
  accept iddept number prompt 'Introdueix el id del departament';
  declare
  departament departments.department_id%type := &iddept;
  nomdepartment departments.department_name%type;
  noconteA exception;
  begin
  
  if nom_dep(departament) = true then
    select department_name into nomdepartment from departments 
    where department_id like departament;
    
     dbms_output.put_line('Nom del departament: ' || nomdepartment);
     
     end if;
     
     if nomdepartment not like 'A%' then
     raise noconteA;
     end if;
     exception when noconteA then
      dbms_output.put_line('El departament: ' || nomdepartment || ' no comença per a');
  end;
  /
