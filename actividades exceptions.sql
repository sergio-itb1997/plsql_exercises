-- 1 Programar un bloc principal i un procediment per a consultar les dades de l’empleat. El codi de l’empleat s’introduirà per teclat. El bloc anònim preguntarà a l’usuari i cridarà al procediment passant al paràmetre corresponent. El procediment consultarà la taula empleat i recuperarà les següents dades: nom, salari, comissió, ofici i cap. 
En cas de que la comissió sigui nul·la, ha d’aparèixer 0 i no en blanc.
El procediment s’anomenarà imprimir_dades.
A més, s’ha de controlar si existeix o no l’empleat a la base de dades. (Gestió d’errors)






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


















-- 2  Programar el mateix exercici que l’anterior però ara el subprograma serà una funció anomenarà retornar_dades. La funció no imprimirà cap dada, sinó que retornarà una variable de tipus registre.
S’ha de controlar els possibles errors (com abans) però ara a la funció.






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










-- 3 Programar un bloc que ens indiqui si existeix o no un departament introduït per pantalla a la nostra base de dades. S’ha de tenir en compte els següents aspectes: 
   1. el codi del departament ho introduirà l’usuari per teclat.
   2. Per comprovar si existeix o no el departament, s’ha de programar una funció anomenada COMPROVAR_DEPT. A aquesta funció se li passarà per paràmetre des del bloc principal el codi del departament a comprovar. 
   3. El missatge que s’ha de mostrar és el següent: “EXISTEIX DEPARTAMENT” o “NO EXISTEIX DEPARTAMENT”.


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




-- 4  Programar un bloc que insereixi les dades d’un departament a la taula corresponent.  Aquestes dades les ha d’introduir l’usuari per teclat. Abans d’inserir el departament, s’ha de comprovar si existeix o no el departament a la base de dades (per fer aquesta comprovació ens ajudarem de la funció que s’ha creat a l’exercici anterior, COMPROVAR_DEPT).




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


-- 5 Programar un bloc plsql que modifiqui la taula DEPT(que serà una còpia de la taula departments)  on el codi del departament coincideixi amb el que s’introdueixi per teclat i desar els canvis. Controlar les excepcions corresponents, és a dir, si no existeix el departament o qualsevol altre error.


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






________________


 -- 6 Programar un bloc plsql  que pregunti a l’usuari el codi de l’empleat per tal de retornar el nom de l’empleat. El nom de l’empleat ho retornarà una funció que es crearà anomenada NOM. A aquesta funció se li passarà per paràmetre el codi de l’empleat que l’usuari ha introduït per teclat. A més, s’ha de controlar els errors al bloc anònim.


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


-- 7 Programar un bloc plsql  que ens comprovi si un departament existeix o no a la taula corresponent, consultant pel codi del departament. En cas d’existir el departament s’ha d’imprimir per pantalla i s’ha de comprovar si comença o no per la lletra A. Si comença per la lletra A, després d’imprimir el nom del departament, ha de dir, COMENÇA PER LA LLETRA A.  Observacions:
1. per a comprovar si comença el nom del departament per A, s’ha de programar una excepció i ha de rebre el nom de: noconteA.
2. A més, també s’ha de programar les següents excepcions:
   1. Si no hi ha dades, s’ha de retornar: “ERROR: no dades”.
   2. Si retorna més d’una fila: “ERROR: retorna més files” 
   3. Qualsevol altre error: “ERROR (sense definir)”.






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