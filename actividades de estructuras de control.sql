--1. create an anonymous block with non-PL / SQL variables that displays the name of the department to which employee Pat Fay belongs.


set serveroutput on
variable v_department varchar2(20)
begin
select department_name
into :v_department
from departments d, employees e
where d.department_id = e.department_id
and lower(e.first_name) = 'pat';
end;
/
print v_department;


--2. Create an anonymous block with non-PL / SQL variables that asks the user for their id, and returns to which region it belongs to.


accept var_pregunta prompt 'introduce el id del user'


variable v_region varchar2;


begin
select r.region_name
into :v_region
from regions r, employees e, departments d,
locations l, countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and e.employee_id = &var_pregunta;
end;
/
print v_region;



--4. Create an anonymous block with two NUMBER variables. These variables must have an initial value of 10.2 and 20.1, respectively. The block must add these two variables and display on the screen ‘THE TOTAL SUM IS: 30.3’



set serveroutput on
    
declare
         v_number1 number := 10.2;
         v_number2 number := 20.1;
     resultado number;
begin
    resultado := v_number1+v_number2;  
    dbms_output.put_line('La suma total es ' || resultado);
end;
/



-- 6. Create an anonymous block that contains a constant variable called Percentage with a value of 10 This value is 10%. This block must contain a rowtype variable, from the employees table. Within this block, you will increase the salary of the employee who enters a user and will display on the screen the following: “A salary increase has been made to: The user with id:“ user_id ”The user with Name:“ first_name ”And last name“ last_name ”belonging to department“ id_department ””

 
set serveroutput on
accept v_pregunta prompt 'selecciona el id del usuari';
declare 
  v_pregunta number;
  v_percentatge constant number(2) := 10;
  v_nousalary employees%rowtype;
begin
select *
into v_nousalary
from employees
where employee_id = &v_pregunta;
dbms_output.put_line('Realitzat un augment de sou a usuari amb id '|| v_nousalary.employee_id || 
' amb nom '|| v_nousalary.first_name || ' I cognom ' || v_nousalary.last_name ||
' que pertany al departament '|| v_nousalary.department_id || ' que tiene el sueldo de ' || (v_nousalary.salary*1.1));
end;
/












-- 7. create a block that asks for a person's first and last name. Then the data corresponding to the person must be printed. Don't forget to clear the variables when the PL / SQL block is finished, using the UNDEFINE command <variable_name>).

set serveroutput on
accept nombre prompt 'Selecciona nombre';
accept apellido prompt 'Selecciona apellido';
accept edad prompt 'Selecciona edad';


declare 
  nomb varchar2(20) := '&nombre';
  apellido varchar2(30) := '&apellido';
  edad number := '&edad';


begin
   dbms_output.put_line('Hola '|| nomb || apellido || ' tu edad es ' || edad);
end;
/
UNDEFINE nombre;
UNDEFINE apellido;
UNDEFINE edad;



-- 8. Calculate 18% of a price you enter per keyboard. Show the result with a HOST variable or not PL / SQL. Print the rounded result using this non-PL / SQL variable and do not declare any program variables. Delete non-PL / SQL variables.



set serveroutput on
accept cifra prompt 'Calcularé el 18% de la cifra que me dirás ahora'
variable cifra number;
variable total number;
begin
  :total := &cifra*0.18;
end;
/
print total;
undefine cifra;
undefine total;



-- 9. Calculate 18% of a price you enter per keyboard. Print the ROUNDED result within the program.

accept cifra prompt 'Calcularé el 18% de la cifra que me dirás ahora'
declare 
  var_total number;
begin
  var_total := &cifra*0.18;
  dbms_output.put_line('El 18% de '||&cifra||' es: '||round(var_total));
end;
/


--10. Ask the user about the salary and the commission they earn. And salaries:
 --   1. is less than 100? the commission will be the salary applying 10%
  --  2. is it between 100 and 500? the commission will be the salary applying 15%.
  --  3. is it greater than 1000? the commission will be the salary applying 20%.
--In the end print the salary and the new commission.


accept salario prompt 'Introduce tu salario y te calculare la comision:'


declare
comision number;
salary number:=&salario;


begin


if salary < 1000 then 
        comision:= salary*1.10;
  elsif salary between 1000 and 5000 then
    comision:= salary*1.15;
  else
    comision:= salary*1.20;
    end if;
  dbms_output.put_line('Tu salario base: '||salary||'. Tu salario con la comisión aplicada: '||comision);
end;
/ 



--11. Ask the user their age and give the corresponding message, if:
 --   1. Under 18? you are a minor!
 --   2. = 18? you are almost of age!
 --   3.> 18? You are of legal age!
 --   4.> 40? you are older…
 --   5. If it is negative => age error cannot be negative.


accept v_edad prompt 'Introduce tu edad muerto de hambre'


declare 


edad number := &v_edad;


begin
if edad < 18 then
      dbms_output.put_line('eres menor de edad!');
elsif edad = 18 then 
    dbms_output.put_line('Casi eres mayor de edad!');
elsif edad between 18 and 39 then 
    dbms_output.put_line('YA eres mayor de edad!');
elsif edad > 40 then 
    dbms_output.put_line('Ya eres mas mayor!');


elsif edad < 0 then
    dbms_output.put_line('Error, la edad puede ser negativa!');
end if;
end;
/



--12. Code a block that asks for a number and the program must perform the following operations with that number. The operations must be independent and are:
--    1. add to it 4.
--    2. Subtract 3.
--    3. Multiply it 8.
-- Please note that to schedule this exercise:
-- * use a constant and assign the number entered by keyboard.
-- * make use of a variable for each operation
-- * print on the screen the results corresponding to each operation, putting the literal in front of Addition, Subtraction and Multiplication respectively




accept v_numero prompt 'Introduce un numero'


declare 


numero constant number := &v_numero;
suma number;
resta number;
multiplicacion number;
begin


suma := numero + 4;


resta := numero - 3;


multiplicacion := numero * 8;


dbms_output.put_line('La suma da ' || suma || ' la resta da ' || resta || ' la multiplicacion da ' || multiplicacion);


end;
/



-- 13. Program a block in PL / SQL that asks the user for the value of two numbers. These two numbers are assigned two PL / SQL variables (at the time of declaration). Both numbers must be positive, otherwise the user must be given the corresponding message. An operation must be performed with these numbers: divide them by one and add the second. The result must be assigned to a NO PL / SQL variable and then printed (outside the PL / SQL block) to verify that the operation was successful.



set serveroutput on
accept v_numero1 prompt 'Introduce numero 1';
accept v_numero2 prompt 'Introduce numero 2';
variable resultado number;
declare 


num1 number := &v_numero1;
num2 number := &v_numero2;


begin 


if num1 < 0 or num2 < 0 then
      dbms_output.put_line('Los numeros no puede ser negativos');
  else
    :resultado :=  (num1 / num2) + num2;    
end if;
end; 
/
print resultado;






-- 14. Same exercise as exercise 13, but now it must also be checked that the first number is greater than the second. Otherwise it should give the following message: Error! the first number must be greater than the second.

set serveroutput on
accept v_numero1 prompt 'Introduce numero 1';
accept v_numero2 prompt 'Introduce numero 2';
variable resultado number;
declare 


num1 number := &v_numero1;
num2 number := &v_numero2;


begin 


if num1 < 0 or num2 < 0 then
      dbms_output.put_line('Los numeros no puede ser negativos');
  elsif nu1 < nu2 then
    dbms_output.put_line('ERROR! El primer número ha de ser mayor que el segundo');
else
    :resultado :=  (num1 / num2) + num2;    
end if;
end; 
/
print resultado;

--15. Program a block that shows us the numbers between a range. The minimum range is 1 and the maximum should be asked to the user.
--    1. Program the block using the FOR structure.
--    2. Program the block using the WHILE structure.

--  for case

accept numero1 prompt 'Introduce un número';
begin
for i in 1..&numero1 loop
    dbms_output.put_line(i);
  end loop;
end;
/
 
--  while case

accept num1 prompt 'Introduce un numero';
declare 
i number := 1;
begin
    while i <= &num1 loop
       DBMS_OUTPUT.PUT_LINE(i); 
       i := i + 1;
    end loop;
end; 
/


-- 16. Program a block that shows us the numbers between a range and a jump. Both the minimum and maximum range and the jump must be asked to the user. Also, keep in mind that the minimum range should always be smaller than the maximum range and the jump should not be negative. Otherwise, the corresponding message must be given and the program finished.

accept rang_minim prompt 'Introduce el rango minimo';
accept rang_maxim prompt 'Introduce el rango maximo';
accept cantidad_salto prompt 'Introduce el salto';

declare 
    minim number := &rang_minim;
    maxim number := &rang_maxim;
    salto number := &cantidad_salto;
    i number := &rang_minim;
begin 
 if i > maxim then
       dbms_output.put_line('El rango mínimo ha de ser menor que el rango máximo');
    elsif salto < 0 then
       dbms_output.put_line('La frecuencia de salto no puede ser negativa');
    else
    while i < maxim loop
       DBMS_OUTPUT.PUT_LINE(i); 
       i := i + salto;
    end loop;
end if;
end;
/

LOOP

accept minim prompt 'Dime el rango minimo';
accept maxim prompt 'Dime el rango maximo';
accept salto prompt 'Dime la frequencia de salto';
declare
v_salto NUMBER := &salto;
v_maxim number := &maxim;
i number := &minim;
    begin
     if i >= v_maxim then
         dbms_output.put_line('El rango mínimo ha de ser menor que el rango máximo');
    elsif v_salto <= 0 then
            dbms_output.put_line('El rango mínimo ha de ser mayor que el rango máximo');
    else
        loop
          dbms_output.put_line(i);
           i := i + v_salto;
          if i >= v_maxim then
           exit;
          end if;
    
    end loop;


    end if;
end;
/
