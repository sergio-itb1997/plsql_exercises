1. crea un bloc anònim amb variables no PL/SQL que mostri el nom del departament al que pertany l’empleada Pat Fay.




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


2. Crea un bloc anònim amb variables no PL/SQL que demani a l’usuari el seu id, i que retorni a quina regió pertany. 


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




3. Crea un bloc anònim amb una variable de tipus alfanumèric. EL resultat és que ha de printar per pantalla :           
HOLA MUNDO           
FIN DEL PROGRAMA*/






________________






4. Crea un bloc anònim amb dos variables de tipus NUMBER. Aquestes variables s’ha de tenir un valor inicial de 10.2 i 20.1 respectivament. El bloc ha de sumar aquestes dues variables i mostrar per pantalla ‘LA SUMA TOTAL ÉS: 30.3’ 




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






5. Crea un bloc anònim que ha de llistar tots el noms (FIRST_NAME) dels empleats de la taula (EMPLOYEES) en majúscules , on has de declarar una variable de tipus first_name. 


no se puede almacenar ya que una variable no puede contener mas de un valor


6. Crea un bloc anònim que contingui una variable constant anomenada Percentatge amb  un  valor  de  10  Aquest  valor  és  un  10%  .        Aquest  bloc  ha  de  contenir  una variable de tipus rowtype, de la taula employees. Dins aquest bloc, augmentaràs el sou a l’empleat que introdueixi un usuari i mostrarà per pantalla el següent:  “ S’ha realitzat un augment de sou a: L’usuari amb id: “id_usuari” L’usuari amb Nom: “first_name” i cognom “last_name” que pertany al departament  “id_department””
________________


 
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












7. Programar un bloc que ens pregunti pel nom, cognom i edat d’una persona. Posteriorment s’ha d’imprimir les dades corresponents a la persona. No s’ha de d’oblidar de netejar les variables quan s’acabi el bloc PL/SQL, fent ús de la comanda UNDEFINE <nom_variable>). 


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








8. Calcular el 18% d’un preu que introdueix per teclat. Mostrar el resultat amb una variable de HOST o no PL/SQL. Printar el resultat arrodonit fent ús d’aquesta variable no PL/SQL i no declarar cap variable de programa. Esborrar les variables no PL/SQL. 




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










9. Calcular el 18% d’un preu que introdueix per teclat. Imprimir el resultat ARRODONIT  dins del programa.


accept cifra prompt 'Calcularé el 18% de la cifra que me dirás ahora'
declare 
  var_total number;
begin
  var_total := &cifra*0.18;
  dbms_output.put_line('El 18% de '||&cifra||' es: '||round(var_total));
end;
/






________________






10. Preguntar a l’usuari el salari i la comissió que guanya. I si salari:
   1. és menor que 100 ? la comissió serà el salari aplicant un 10%
   2. està entre 100 i 500 ? la comissió serà el salari aplicant un 15%.
   3. és major que 1000 ? la comissió serà el salari aplicant un 20%.
Al  final imprimir el salari i la nova comissió. 


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








11. Preguntar a l’usuari la seva edat i donar el missatge corresponent, si:
   1. Menor de 18 ? ets menor de edat!
   2.  = 18 ? casi ets major de edat!
   3.  >18 ?ja ets major de edat!
   4.  >40 ? ja ets més major …
   5.  Si és negatiu => error edat no pot ser negativa.


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






________________






12. Programar un bloc que demani un número i el programa ha de realitzar les següents operacions amb aquest número. Les operacions han de ser independents i són:
   1. sumar-li 4.
   2. Restar-li 3.
   3. Multiplicar-li 8.
S’ha de tenir en compte que per a programar aquest exercici:
* utilitzar una constant i assignar-li el número introduït per teclat.
* fer ús d’una variable per a cada operació
* imprimir per pantalla els resultats corresponents a cada operació, posant el literal al davant de Suma, Resta i Multiplicació respectivament




accept v_numero prompt 'Introduce un numero y haré magia'


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


























13. Programar un bloc en PL/SQL que demani a l’usuari el valor de dos números. Aquest dos números se li assigna dos variables PL/SQL (en el moment de la declaració). Els dos números han de ser positius, en cas contrari s’ha de donar a l’usuari el missatge corresponent. S’ha de realitzar una operació amb aquest números: dividir entre ells i sumar-li el segon. El resultat s’ha d’assignar a una variable NO PL/SQL i després imprimir-la (fora del bloc PL/SQL) per a comprovar que la operació ha estat correcta.




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
















14. Mateix exercici que l’exercici 13, però ara també s’ha de controlar que el número primer sigui més gran que el segon. En cas contrari ha de donar el següent missatge: Error! el primer número ha de ser més gran que el segon.








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


























15. Programar un bloc que ens mostri els números entre un rang. El rang mínim és 1 i el màxim se li ha de preguntar a l’usuari.
   1. Programar el bloc utilitzant l’estructura FOR.
   2. Programar el bloc utilitzant l’estructura WHILE.






modo for


accept numero1 prompt 'Introduce un número';
begin
for i in 1..&numero1 loop
    dbms_output.put_line(i);
  end loop;
end;
/
 






modo while


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


16. Programar un bloc que ens mostri els números entre un rang amb un salt. Tant el rang mínim, com el màxim i el salt se li ha de preguntar a l’usuari. A més, s’ha de tenir en compte que el rang mínim sempre ha de ser més petit que el rang màxim i que el salt no ha de ser negatiu. En cas contrari s’ha de donar el missatge corresponent i acabar el programa.






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