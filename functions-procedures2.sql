--Activities
--1. Create a function to which the department_id will pass and return the manager_id name. You have to do the function code and the anonymous block.



set SERVEROUTPUT ON;
accept iddepartment number prompt 'Introduce el id del departamento a consultar';
declare    
departamentoid number := &iddepartment;
begin
DBMS_OUTPUT.PUT_LINE(buscarmanager(departamentoid));
end;
/


create or replace function buscarmanager(departamentoid number)
return employees.first_name%type
is
nombre employees.first_name%type;
begin
select e.first_name into nombre from employees e, departments d 
        where e.employee_id = d.manager_id 
        and d.department_id = departamentoid;
return nombre;
end buscarmanager;
/



-- 2. Create a function that given an employee_id, returns the number of tasks performed by the employee. You have to make the function code and the blog anonymous.



set SERVEROUTPUT ON;
accept empleadoid number prompt 'Introduce el id del empleado a consultar y te dire cuantos apaños ha hecho';
declare    
idempleat number := &empleadoid;
begin
 DBMS_OUTPUT.PUT_LINE('El empleado numero ' || idempleat || ' con nombre ' 
                            ||  buscarnombre(idempleat) || ' ha realizado '
                            || buscartasques(idempleat) || ' tasques');
end;
/


create or replace function buscartasques(empleado number)
return number
is
numerotasques number;
begin
select count(j.job_id) into numerotasques from employees e, job_history j 
        where e.employee_id = j.employee_id 
        and e.employee_id = empleado;
return numerotasques;
end buscartasques;
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






________________




--3. Create a procedure that increases an employee’s salary, which will be requested in an anonymous block. This procedure has the following conditions:
--    1. If the experience is more than 10 years, the salary will be increased by 20%
--    2. If the experience is more than 5 years, the salary will be increased by 10%
--    3. For the rest, it will increase by 5%.




set SERVEROUTPUT ON;
accept empleadoid number prompt 'Introduce el id del empleado a consultar y le aumentare el salario en funcion de lo que gane';
declare    
idempleat number := &empleadoid;
begin
 DBMS_OUTPUT.PUT('El empleado numero ' || idempleat || ' con nombre ' 
                            ||  buscarnombre(idempleat) || ' y con un salario de '
                            || buscarsalario(idempleat) || ' euros');
                            
aumentarsalario(idempleat);
DBMS_OUTPUT.PUT_LINE( 'Ahora su salario es de ' || buscarsalario(idempleat) || ' euros' );                          
end;
/


select * from employees;






create or replace procedure aumentarsalario(empleado number)
is
  añosexperiencia number;
begin
select to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy')
into añosexperiencia from employees 
        where employee_id = empleado;
if añosexperiencia < 10 then
  update employees set salary = salary * 1.2 where employee_id = empleado;       
  dbms_output.put_line(' ha recibido un aumento del 20% ');
elsif añosexperiencia >5 then       
  update employees set salary = salary * 1.1 where employee_id = empleado;     
  dbms_output.put_line(' ha recibido un aumento del 10% ');    
else       
  update employees set salary = salary * 1.05 where employee_id = empleado;        
  dbms_output.put_line(' ha recibido un aumento del 5% ');
end if;
end aumentarsalario;
/


________________


create or replace function buscarsalario(idempleat number)
return number
is 
  salario number;
begin 
  select salary into salario from employees where idempleat = employee_id;
  return salario;
end buscarsalario;
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


-- 4. Create a procedure that exchanges salaries between two employees. These employees will be asked in a program independent of the user.


accept empleado1 number prompt 'Introduce el id del primer empleado';
accept empleado2 number prompt 'Introduce el id del segundo empleado';
declare    
primero number := &empleado1;    
segundo number := &empleado2;
begin 
DBMS_OUTPUT.PUT_LINE('Se han cambiado los salarios del empleado id ' || primero ||
                ' con nombre ' 
                            ||  buscarnombre(primero) || ' y del empleado id ' 
                            || segundo || ' con nombre '
                            || buscarnombre(segundo));
cambiosueldo(primero, segundo);
end;
/


select * from employees;


create or replace procedure cambiosueldo(primero number, segundo number)
is
salario1 number;
salario2 number;


begin   
select salary into salario1 from employees where employee_id = primero;   
select salary into salario2 from employees where employee_id = segundo;   
update employees set salary = salario2 where employee_id = primero;    
update employees set salary = salario1 where employee_id = segundo;    
DBMS_OUTPUT.PUT_LINE('Salarios modificados');
end cambiosueldo;
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

-- 5. Create a procedure that given a department_id, check who is the employee of that department with the highest salary and update the manager_id of that department with that employee. You have to make the function code and the blog anonymous.



accept iddepartment number prompt 'Introduce el id del departamento y pondre de manager al que maneje mas panoja';
declare    
departmentid number := &iddepartment;    
begin 
DBMS_OUTPUT.PUT('Hemos cambiado el manager del departamento ' || BUSCARDEPARTAMENTO(departmentid) || ' , el manager ' || BUSCARMANAGER(departmentid) ||
                     ' ha sido sustituido de su cargo por el empleado ');
cambiarmanager(departmentid);
end;
/






create or replace procedure cambiarmanager(departmentid number)
is
  empleado number;
  nombre varchar2(15);
  salariomaximo number;
begin
  select max(salary) into salariomaximo from employees where department_id = departmentid;
  select employee_id into empleado from employees where salary = salariomaximo and department_id = departmentid;
  update departments set manager_id = empleado where department_id like departmentid;
  select first_name into nombre from employees where employee_id like empleado;
  DBMS_OUTPUT.PUT(nombre);
end cambiarmanager;
/




create or replace function buscarmanager(departamentoid number)
return employees.first_name%type
is
nombre employees.first_name%type;
begin
select e.first_name into nombre from employees e, departments d 
        where e.employee_id = d.manager_id 
        and d.department_id = departamentoid;
return nombre;
end buscarmanager;
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
