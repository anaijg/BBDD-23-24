# 1.8.1 Procedimientos sin sentencias SQL
# 01.- Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.
use jardineria;

DELIMITER $$;
DROP PROCEDURE IF EXISTS hola_mundo;
CREATE PROCEDURE hola_mundo()
BEGIN
    SELECT '¡Hola, mundo!';
end $$;

DELIMITER ;
CALL hola_mundo();

# 02.- Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.
# IF search_condition THEN statement_list
#     [ELSEIF search_condition THEN statement_list] ...
#     [ELSE statement_list]
# END IF

DELIMITER $$;
DROP PROCEDURE IF EXISTS ejercicio_2;
CREATE PROCEDURE ejercicio_2(IN numero double)
BEGIN

    IF  numero > 0 THEN SELECT 'POSITIVO';
    ELSEIF numero < 0 THEN SELECT 'NEGATIVO';
    ELSE SELECT 'CERO';
    END IF;

end $$;

# LO LLAMAMOS
DELIMITER ;
CALL ejercicio_2(-10000.53);
CALL ejercicio_2(10000.53);
CALL ejercicio_2(0);



# 03.- Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor un número real,
# y un parámetro de salida, con una cadena de caracteres indicando si el número es positivo, negativo o cero.
DELIMITER $$;
DROP PROCEDURE IF EXISTS ejercicio_3;
CREATE PROCEDURE ejercicio_3(IN numero double, OUT resultado varchar(10))
BEGIN

    IF  numero > 0    THEN SET resultado = 'POSITIVO';
    ELSEIF numero < 0 THEN SET resultado = 'NEGATIVO';
    ELSE SET resultado = 'CERO';
    END IF;

end $$;

# llamamos al método
DELIMITER ;
CALL ejercicio_3(-10000.53, @resultado);
SELECT @resultado;

CALL ejercicio_3(10000.53, @resultado);
SELECT @resultado;

CALL ejercicio_3(0, @resultado);
SELECT @resultado;

# 04.- Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
# [0,5) = Insuficiente
# [5,6) = Aprobado
# [6, 7) = Bien
# [7, 9) = Notable
# [9, 10] = Sobresaliente
# En cualquier otro caso la nota no será válida.

 DELIMITER $$;
 DROP PROCEDURE IF EXISTS ejercicio_4;
CREATE PROCEDURE ejercicio_4(IN nota double)
BEGIN
    IF  nota >= 0 AND nota < 5 THEN SELECT 'Insuficiente';
    ELSEIF nota >= 5 AND nota < 6 THEN SELECT 'Aprobado';
    ELSEIF nota >= 6 AND nota < 7 THEN SELECT 'Bien';
    ELSEIF nota >= 7 AND nota < 9 THEN SELECT 'Notable';
    ELSEIF nota >= 9 AND nota <= 10 THEN SELECT 'Notable';
    ELSE SELECT 'Nota no válida';
    END IF;

end $$;

# AHORA LO LLAMAMOS
DELIMITER ;
CALL ejercicio_4(4.99);

# 05.- Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor de la nota en formato numérico
# y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.

 DELIMITER $$;
 DROP PROCEDURE IF EXISTS ejercicio_5;
CREATE PROCEDURE ejercicio_5(IN nota double, OUT resultado varchar(20))
BEGIN
    IF  nota >= 0 AND nota < 5 THEN SET resultado =  'Insuficiente';
    ELSEIF nota >= 5 AND nota < 6 THEN SET resultado = 'Aprobado';
    ELSEIF nota >= 6 AND nota < 7 THEN SET resultado = 'Bien';
    ELSEIF nota >= 7 AND nota < 9 THEN SET resultado = 'Notable';
    ELSEIF nota >= 9 AND nota <= 10 THEN SET resultado = 'Sobresaliente';
    ELSE SET resultado = 'Nota no válida';
    END IF;
end $$;

# lo llamamos
DELIMITER ;
CALL ejercicio_5(8.99, @nota);
SELECT @nota;


# 06.- Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.
    # Como esto puede ser un if else if.... utilizamos esta forma de case
# CASE
#     WHEN search_condition THEN statement_list
#     [WHEN search_condition THEN statement_list] ...
#     [ELSE statement_list]
# END CASE

 DELIMITER $$;
 DROP PROCEDURE IF EXISTS ejercicio_6;
CREATE PROCEDURE ejercicio_6(IN nota double, OUT resultado varchar(20))
BEGIN
    CASE
        WHEN nota >= 0 AND nota < 5 THEN SET resultado = 'Insuficiente';
        WHEN nota >= 5 AND nota < 6 THEN SET resultado = 'Aprobado';
        WHEN nota >= 6 AND nota < 7 THEN SET resultado = 'Bien';
        WHEN nota >= 7 AND nota < 9 THEN SET resultado = 'Notable';
        WHEN nota >= 9 AND nota <= 10 THEN SET resultado = '';
        ELSE SET resultado = 'Nota no válida';
    END CASE;
end $$;

# lo llamamos
DELIMITER ;
CALL ejercicio_6(4.99, @nota);
SELECT @nota;

# 07.- Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes. Resuelva el procedimiento haciendo uso de la estructura de control IF.
    DELIMITER $$;
    DROP PROCEDURE IF EXISTS ejercicio_7;
    CREATE PROCEDURE ejercicio_7(IN numero_dia int unsigned, OUT nombre_dia varchar(10))
    BEGIN
        IF      numero_dia = 1 THEN SET nombre_dia = 'lunes';
        ELSEIF numero_dia = 2 THEN SET nombre_dia = 'martes';
        ELSEIF numero_dia = 3 THEN SET nombre_dia = 'miércoles';
        ELSEIF numero_dia = 4 THEN SET nombre_dia = 'jueves';
        ELSEIF numero_dia = 5 THEN SET nombre_dia = 'viernes';
        ELSEIF numero_dia = 6 THEN SET nombre_dia = 'sábado';
        ELSEIF numero_dia = 7 THEN SET nombre_dia = 'domingo';
        ELSE SET nombre_dia = 'día no válido';
        END IF;
    end $$;

# LO LLAMO
    CALL ejercicio_7(6, @dia);
    SELECT @dia;

# 08.- Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.
# en este caso, podríamos hacerlo con un switch de java: switch(numero_dia) {case 1: nombre_dia= 'lunes} etc. Es decir, es mirar una variable y hacer cosas según valga esto o lo otro
# pues para estos casos nos vale la segunda forma de CASE
# CASE nombre_de_la_variable
#     WHEN valor1 THEN haz_esto
#     [WHEN valor2 THEN haz_lo_otro] ...
#     [ELSE esto_es_como_el_defauult]
# END CASE

DELIMITER $$;
DROP PROCEDURE IF EXISTS ejercicio_8;
CREATE PROCEDURE ejercicio_8(IN numero_dia int unsigned, OUT nombre_dia varchar(10))
BEGIN
    CASE numero_dia
        WHEN 1 THEN SET nombre_dia = 'lunes';
        WHEN 2 THEN SET nombre_dia = 'martes';
        WHEN 3 THEN SET nombre_dia = 'miércoles';
        WHEN 4 THEN SET nombre_dia = 'jueves';
        WHEN 5 THEN SET nombre_dia = 'viernes';
        WHEN 6 THEN SET nombre_dia = 'sábado';
        WHEN 7 THEN SET nombre_dia = 'domingo';
        ELSE SET nombre_dia = 'día no válido';
    END CASE ;
end $$;

# LO LLAMO
    CALL ejercicio_8(6, @dia);
    SELECT @dia;

# 1.8.2 Procedimientos con sentencias SQL
# Ejercicio 9
# Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país.
DELIMITER $$;
DROP PROCEDURE IF EXISTS ejercicio_9;
CREATE PROCEDURE ejercicio_9(IN pais_cliente varchar(50))
BEGIN
    SELECT *
    FROM cliente
    WHERE pais = pais_cliente;
end $$;

DELIMITER ;
CALL ejercicio_9('USA');


# Ejercicio 10
# Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardineria.
DELIMITER $$;
DROP PROCEDURE IF EXISTS ejercicio_10;
CREATE PROCEDURE ejercicio_10(IN forma_de_pago varchar(20), OUT pago_maximo double)
BEGIN
    SET pago_maximo = (SELECT MAX(total)
                       FROM pago
                       WHERE forma_pago = forma_de_pago);
end $$;

DELIMITER ;
CALL ejercicio_10('Transferencia', @maximo);
SELECT @maximo AS max_transferencia;
CALL ejercicio_10('Cheque', @maximo);
SELECT @maximo AS max_cheque;
CALL ejercicio_10('PayPal', @maximo);
SELECT @maximo AS max_PayPal;



# Ejercicio 11
# Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
# el pago de máximo valor,
# el pago de mínimo valor,
# el valor medio de los pagos realizados,
# la suma de todos los pagos,
# el número de pagos realizados para esa forma de pago

DELIMITER $$;
DROP PROCEDURE IF EXISTS ejercicio_11;
CREATE PROCEDURE ejercicio_11(IN forma_de_pago varchar(20),
                              OUT pago_maximo double,
                              OUT pago_minimo double,
                              OUT pago_medio double,
                              OUT suma_pagos double,
                              OUT numero_pagos int)
BEGIN
    SET pago_maximo = (SELECT MAX(total)
                       FROM pago
                       WHERE forma_pago = forma_de_pago);

    SET pago_minimo = (SELECT MIN(total)
                       FROM pago
                       WHERE forma_pago = forma_de_pago);

    SET pago_medio = (SELECT AVG(total)
                       FROM pago
                       WHERE forma_pago = forma_de_pago);

    SET suma_pagos = (SELECT SUM(total)
                       FROM pago
                       WHERE forma_pago = forma_de_pago);

    SET numero_pagos = (SELECT COUNT(total)
                       FROM pago
                       WHERE forma_pago = forma_de_pago);
end $$;

DELIMITER ;
CALL ejercicio_11('Transferencia', @maximo, @minimo, @medio, @suma, @cuenta);
SELECT @maximo, @minimo, @medio, @suma, @cuenta;

CALL ejercicio_11('Cheque', @maximo, @minimo, @medio, @suma, @cuenta);
SELECT @maximo, @minimo, @medio, @suma, @cuenta;

CALL ejercicio_11('PayPal', @maximo, @minimo, @medio, @suma, @cuenta);
SELECT @maximo, @minimo, @medio, @suma, @cuenta;

# EJERCICIO 12
# Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados.
# La tabla cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado.
    DROP DATABASE IF EXISTS procedimientos;
    CREATE DATABASE procedimientos;
    USE procedimientos;
    CREATE TABLE cuadrados(
        numero INT UNSIGNED,
        cuadrado INT UNSIGNED
    );


# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados con las siguientes características.
# El procedimiento recibe un parámetro de entrada llamado n de tipo INT UNSIGNED y calculará el valor de los cuadrados de los primeros números naturales hasta el valor introducido como parámetro.
# El valor del número y de su cuadrado deberá ser almacenados en la tabla cuadrados que hemos creado previamente.
# Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados que va a calcular.
# Utilice un bucle WHILE para resolver el procedimiento.

    USE procedimientos;
DELIMITER $$;
DROP PROCEDURE  IF EXISTS calcular_cuadrados;
CREATE PROCEDURE calcular_cuadrados(IN n INT UNSIGNED)
BEGIN
    # DECLARAMOS VARIABLES
    DECLARE cuadrado INT;
    DECLARE i INT;

    # INICIALIZAMOS LO QUE HAGA FALTA
    SET i = 1;

    # SI HUBIERA ALGO EN LA TABLA, LO ELIMINO
    TRUNCATE cuadrados;

    # y ahora el while
    WHILE i <= n DO
        SET cuadrado = i * i;

        INSERT INTO cuadrados VALUES (i, cuadrado);

        SET i = i + 1;
    end while;
end $$;

DELIMITER ;
CALL calcular_cuadrados(4);

# Ejercicio 13
# Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.

USE procedimientos;
DELIMITER $$;
DROP PROCEDURE  IF EXISTS calcular_cuadrados_repeat_until;
CREATE PROCEDURE calcular_cuadrados_repeat_until(IN n INT UNSIGNED)
BEGIN
    # DECLARAMOS VARIABLES
    DECLARE cuadrado INT;
    DECLARE i INT;

    # INICIALIZAMOS LO QUE HAGA FALTA
    SET i = 1;

    # SI HUBIERA ALGO EN LA TABLA, LO ELIMINO
    TRUNCATE cuadrados;

    # y ahora el repeat.. until
    REPEAT -- REPETIR
        SET cuadrado = i * i;

        INSERT INTO cuadrados VALUES (i, cuadrado);

        SET i = i + 1;
    until i > n -- HASTA QUE i SEA MAYOR QUE n; es decir, que si n = 5, salimos cuando i = 6 (6 >5 )
    end repeat;

end $$;

DELIMITER ;
CALL calcular_cuadrados_repeat_until(25);


# Ejercicio 14
# Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
USE procedimientos;
DELIMITER $$;
DROP PROCEDURE  IF EXISTS calcular_cuadrados_repeat_loop;
CREATE PROCEDURE calcular_cuadrados_repeat_loop(IN n INT UNSIGNED)
BEGIN
    # DECLARAMOS VARIABLES
    DECLARE cuadrado INT;
    DECLARE i INT;

    # INICIALIZAMOS LO QUE HAGA FALTA
    SET i = 1;

    # SI HUBIERA ALGO EN LA TABLA, LO ELIMINO
    TRUNCATE cuadrados;

    # y ahora el loop
    bucle: LOOP
        IF i > n THEN -- HASTA QUE i SEA MAYOR QUE n; es decir, que si n = 5, salimos cuando i = 6 (6 >5 )
            LEAVE bucle;
        end if;

        SET cuadrado = i * i;
        INSERT INTO cuadrados VALUES (i, cuadrado);
        SET i = i + 1;

    end loop;
end $$;

DELIMITER ;
CALL calcular_cuadrados_repeat_loop(18);


# Ejercicio 15
# Crea una base de datos llamada procedimientos -> NONONONONO. Añade una tabla a la que tienes.
# que contenga una tabla llamada ejercicio. La tabla debe tener una única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.
    USE procedimientos;
    CREATE TABLE ejercicio(
        numero INT UNSIGNED
    );

# Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números_while con las siguientes características.
# Utilice un bucle WHILE para resolver el procedimiento.
    DELIMITER $$;
    DROP PROCEDURE IF EXISTS calcular_números_while;
    CREATE PROCEDURE calcular_números_while(IN valor_inicial INT UNSIGNED) # El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED
    BEGIN
        DECLARE i INT;
        SET i = valor_inicial;
        # Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores.
        TRUNCATE ejercicio;
        # y deberá almacenar en la tabla ejercicio toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.
        # ejemplo: valor_inicial = 5 entonces tiene que guardar, en este orden: 5, 4, 3, 2, 1
        WHILE i >= 1 DO
            INSERT INTO ejercicio VALUES (i);
            SET i = i - 1;
        end while ;
    end $$;

DELIMITER ;
CALL calcular_números_while(15);

# # Ejercicio 16
# # Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
    DELIMITER $$;
    DROP PROCEDURE IF EXISTS calcular_números_repeat;
    CREATE PROCEDURE calcular_números_repeat(IN valor_inicial INT UNSIGNED) # El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED
    BEGIN
        DECLARE i INT;
        SET i = valor_inicial;
        # Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores.
        TRUNCATE ejercicio;
        # y deberá almacenar en la tabla ejercicio toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.
        # ejemplo: valor_inicial = 5 entonces tiene que guardar, en este orden: 5, 4, 3, 2, 1
        REPEAT
          -- instrucciones  a repetir (una de las cuales siempre es cambiar la i)
            INSERT INTO ejercicio VALUES (i);
            SET i = i - 1;
        until  i < 1 -- lo contrario de la condición while, esto es, el primer valor en "el que te sales"
            end repeat;
    end $$;

DELIMITER ;
CALL calcular_números_repeat(9);


# # Ejercicio 17
# # Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.

    DELIMITER $$;
    DROP PROCEDURE IF EXISTS calcular_números_loop;
    CREATE PROCEDURE calcular_números_loop(IN valor_inicial INT UNSIGNED) # El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED
    BEGIN
        DECLARE i INT;
        SET i = valor_inicial;
        # Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores.
        TRUNCATE ejercicio;
        # y deberá almacenar en la tabla ejercicio toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.
        # ejemplo: valor_inicial = 5 entonces tiene que guardar, en este orden: 5, 4, 3, 2, 1
        bucle: LOOP
            IF i < 1 THEN
                LEAVE bucle;
            end if ;

        -- instrucciones  a repetir (una de las cuales siempre es cambiar la i)
            INSERT INTO ejercicio VALUES (i);
            SET i = i - 1;

        end loop ;
    end $$;

DELIMITER ;
CALL calcular_números_loop(5);


# Ejercicio 18
# Crea una base de datos llamada procedimientos ->  NONONONONO. Añade una tabla a la que tienes.
# que contenga una tabla llamada pares y otra tabla llamada impares.
# Las dos tablas deben tener única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.
    USE procedimientos;
    CREATE TABLE pares(
        numero INT UNSIGNED
    );
    CREATE TABLE impares(
        numero INT UNSIGNED
    );

# Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares_while con las siguientes características.
# Utilice un bucle WHILE para resolver el procedimiento.

    DELIMITER $$;
    DROP PROCEDURE IF EXISTS calcular_pares_impares_while;
    CREATE PROCEDURE calcular_pares_impares_while(IN tope INT UNSIGNED) #  El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED
    BEGIN
        DECLARE i INT;
        SET i = 1;
        # Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
        TRUNCATE pares;
        TRUNCATE impares;
        # y deberá almacenar en la tabla pares aquellos números pares que existan entre el número 1 el valor introducido como parámetro.
# Habrá que realizar la misma operación para almacenar los números impares en la tabla impares.

# Ejemplo: 15 -> 1 va a impares, 2 va a pares, 3 -> impares,...., 15 -> impares
        WHILE i <= tope DO

            IF i % 2 = 0 THEN INSERT INTO pares VALUES (i);
            ELSE insert into impares values (i);
            end if;

            SET i = i + 1;
        end while;

    end $$;

DELIMITER ;
CALL calcular_pares_impares_while(15);

# # Ejercicio 19
# # Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
DELIMITER $$;
    DROP PROCEDURE IF EXISTS calcular_pares_impares_repeat;
    CREATE PROCEDURE calcular_pares_impares_repeat(IN tope INT UNSIGNED) #  El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED
    BEGIN
        DECLARE i INT;
        SET i = 1;
        # Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
        TRUNCATE pares;
        TRUNCATE impares;
        # y deberá almacenar en la tabla pares aquellos números pares que existan entre el número 1 el valor introducido como parámetro.
# Habrá que realizar la misma operación para almacenar los números impares en la tabla impares.

# Ejemplo: 15 -> 1 va a impares, 2 va a pares, 3 -> impares,...., 15 -> impares
        REPEAT
            IF i % 2 = 0 THEN INSERT INTO pares VALUES (i);
            ELSE insert into impares values (i);
            end if;

            SET i = i + 1;
        until i > tope
            end repeat;
end $$;

DELIMITER ;
CALL calcular_pares_impares_repeat(34);



# # Ejercicio 20
# # Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.

DELIMITER $$;
    DROP PROCEDURE IF EXISTS calcular_pares_impares_loop;
    CREATE PROCEDURE calcular_pares_impares_loop(IN tope INT UNSIGNED) #  El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED
    BEGIN
        DECLARE i INT;
        SET i = 1;
        # Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
        TRUNCATE pares;
        TRUNCATE impares;
        # y deberá almacenar en la tabla pares aquellos números pares que existan entre el número 1 el valor introducido como parámetro.
# Habrá que realizar la misma operación para almacenar los números impares en la tabla impares.

# Ejemplo: 15 -> 1 va a impares, 2 va a pares, 3 -> impares,...., 15 -> impares
            bucle: LOOP
                IF i > tope THEN
                    LEAVE bucle;
                end if;

            IF i % 2 = 0 THEN INSERT INTO pares VALUES (i);
            ELSE insert into impares values (i);
            end if;

            SET i = i + 1;

            end loop;

end $$;

DELIMITER ;
CALL calcular_pares_impares_loop(13);

# 1.8.3 Funciones sin sentencias SQL -> NO SQL
# EJERCICIO 21
# Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número es par o FALSE en caso contrario.
DELIMITER $$;
DROP FUNCTION IF EXISTS es_par;
CREATE FUNCTION es_par(numero INT)
RETURNS BOOLEAN
NO SQL
BEGIN

    IF numero % 2 = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    end if;

end $$;

SELECT es_par(20);
SELECT es_par(21);

# EJERCICIO 22
# Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.

DELIMITER $$;
DROP FUNCTION IF EXISTS calcular_hipotenusa;
CREATE FUNCTION calcular_hipotenusa(cateto1 DOUBLE, cateto2 DOUBLE)
    RETURNS DOUBLE
    NO SQL
    BEGIN
        DECLARE hipotenusa DOUBLE;
        SET hipotenusa = SQRT(POW(cateto1, 2) + POW(cateto2, 2));
        RETURN hipotenusa;
    end $$;

SELECT calcular_hipotenusa(3, 4);

# EJERCICIO 23
# Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.
DELIMITER $$;
DROP FUNCTION IF EXISTS dia_semana;
CREATE FUNCTION dia_semana(dia INT)
RETURNS VARCHAR(10)
NO SQL
    BEGIN
        DECLARE nombre_dia VARCHAR(10);
        SET nombre_dia = CASE dia
            WHEN 1 THEN 'lunes'
            WHEN 2 THEN 'martes'
            WHEN 3 THEN 'miércoles'
            WHEN 4 THEN 'jueves'
            WHEN 5 THEN 'viernes'
            WHEN 6 THEN 'sábado'
            WHEN 7 THEN 'domingo'
            ELSE 'día no válido'
        END;
        RETURN nombre_dia;
END $$;

SELECT dia_semana(6);

# EJERCICIO 24
# Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.

 DELIMITER $$;
    DROP FUNCTION IF EXISTS mayor_de_tres;
    CREATE FUNCTION mayor_de_tres(a DOUBLE, b DOUBLE, c DOUBLE)
        RETURNS DOUBLE
        NO SQL
        BEGIN
            DECLARE mayor DOUBLE;
            SET mayor = a;
            IF b > mayor THEN
                SET mayor = b;
            END IF;
            IF c > mayor THEN
                SET mayor = c;
            END IF;
            RETURN mayor;
        end $$;

SELECT mayor_de_tres(3, 4, 5);
SELECT mayor_de_tres(4, 3, 5);
SELECT mayor_de_tres(5, 4, 3);

# EJERCICIO 25
# Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.
DELIMITER $$;
DROP FUNCTION IF EXISTS calcular_area_circulo;
CREATE FUNCTION calcular_area_circulo(radio DOUBLE)
    RETURNS DOUBLE
    NO SQL
    BEGIN
        DECLARE area DOUBLE;
        SET area = PI() * POW(radio, 2);
        RETURN area;
    end $$;

SELECT calcular_area_circulo(3);

# EJERCICIO 26
# Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.
# Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona MySQL:
# DATEDIFF
# TRUNCATE
DELIMITER $$;
DROP FUNCTION IF EXISTS calcular_años;
CREATE FUNCTION calcular_años(fecha1 DATE, fecha2 DATE)
    RETURNS INT
    NO SQL
    BEGIN
        DECLARE años INT;
        SET años = TRUNCATE(DATEDIFF(fecha1, fecha2) / 365, 0); -- la función DATEDIFF calcula la diferencia, en días, entre dos fechas
        RETURN años;                                            -- la función TRUNCATE redondea el resultado a los decimales que le indiquemos
    end $$;

SELECT calcular_años('2018-01-01', '2008-01-01');

# EJERCICIO 27
# Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.
DELIMITER $$;
DROP FUNCTION IF EXISTS quitar_acentos;
    CREATE FUNCTION quitar_acentos(cadena VARCHAR(100))
        RETURNS VARCHAR(100)
        NO SQL
        BEGIN
            DECLARE cadena_sin_acentos VARCHAR(100);
            SET cadena_sin_acentos = REPLACE(cadena, 'á', 'a');
            SET cadena_sin_acentos = REPLACE(cadena_sin_acentos, 'é', 'e');
            SET cadena_sin_acentos = REPLACE(cadena_sin_acentos, 'í', 'i');
            SET cadena_sin_acentos = REPLACE(cadena_sin_acentos, 'ó', 'o');
            SET cadena_sin_acentos = REPLACE(cadena_sin_acentos, 'ú', 'u');
            RETURN cadena_sin_acentos;
        end $$;

# 1.8.4 Funciones con sentencias SQL READS SQL DATA / MODIFIES SQL DATA

# EJERCICIO 28
# Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.
USE jardineria;
DELIMITER $$;
DROP FUNCTION IF EXISTS total_productos;
CREATE FUNCTION total_productos()
    RETURNS INT
    READS SQL DATA
    BEGIN
        DECLARE total INT;
        SET total = (SELECT COUNT(*) FROM jardineria.producto);
        RETURN total;
    end $$;

SELECT total_productos();

# EJERCICIO 29
# Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
USE tienda;
DELIMITER $$;
DROP FUNCTION IF EXISTS precio_medio_fabricante;
CREATE FUNCTION precio_medio_fabricante(fabricante_buscado VARCHAR(100))
    RETURNS DECIMAL(10,2)
    READS SQL DATA
    BEGIN
        DECLARE precio_medio DECIMAL(10,2);
        SET precio_medio = (SELECT AVG(precio)
                            FROM producto p JOIN tienda.fabricante f on f.id = p.id_fabricante
                            WHERE f.nombre = fabricante_buscado);
        RETURN precio_medio;
    end $$;

SELECT precio_medio_fabricante('Asus');

# EJERCICIO 30
# Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
DELIMITER $$;
DROP FUNCTION IF EXISTS precio_maximo_fabricante;
CREATE FUNCTION precio_maximo_fabricante(fabricante_buscado VARCHAR(100))
    RETURNS DECIMAL(10,2)
    READS SQL DATA
    BEGIN
        DECLARE precio_maximo DECIMAL(10,2);
        SET precio_maximo = (SELECT MAX(precio)
                            FROM producto p JOIN tienda.fabricante f on f.id = p.id_fabricante
                            WHERE f.nombre = fabricante_buscado);
        RETURN precio_maximo;
    end $$;

SELECT precio_maximo_fabricante('Asus');

# EJERCICIO 31
# Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
DELIMITER $$;
DROP FUNCTION IF EXISTS precio_minimo_fabricante;
CREATE FUNCTION precio_minimo_fabricante(fabricante_buscado VARCHAR(100))
    RETURNS DECIMAL(10,2)
    READS SQL DATA
    BEGIN
        DECLARE precio_minimo DECIMAL(10,2);
        SET precio_minimo = (SELECT MIN(precio)
                            FROM producto p JOIN tienda.fabricante f on f.id = p.id_fabricante
                            WHERE f.nombre = fabricante_buscado);
        RETURN precio_minimo;
    end $$;

SELECT precio_minimo_fabricante('Asus');

# 1.8.8 Triggers

# EJERCICIO 38
# Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.
# Tabla alumnos:
# id (entero sin signo)
# nombre (cadena de caracteres)
# apellido1 (cadena de caracteres)
# apellido2 (cadena de caracteres)
# nota (número real)
    DROP DATABASE IF EXISTS test;
    CREATE DATABASE test;
    USE test;
    CREATE TABLE alumnos(
        id INT UNSIGNED,
        nombre VARCHAR(100),
        apellido1 VARCHAR(100),
        apellido2 VARCHAR(100),
        nota DECIMAL(4,2)
    );

# Una vez creada la tabla escriba dos triggers con las siguientes características:
# Trigger 1: trigger_check_nota_before_insert
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta antes de una operación de inserción.
# Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
# Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.

DELIMITER $$;
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert;
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN
    IF NEW.nota < 0 THEN
        SET NEW.nota = 0;
    ELSEIF NEW.nota > 10 THEN
        SET NEW.nota = 10;
    end if ;
end $$;



# Trigger2 : trigger_check_nota_before_update
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta antes de una operación de actualización.
# Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
# Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.

DELIMITER $$;
DROP TRIGGER IF EXISTS trigger_check_nota_before_update;
CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE
ON alumnos FOR EACH ROW
BEGIN
        IF NEW.nota < 0 THEN
        SET NEW.nota = 0;
    ELSEIF NEW.nota > 10 THEN
        SET NEW.nota = 10;
    end if ;
end $$;


# Una vez creados los triggers escriba varias sentencias de inserción y actualización sobre la tabla alumnos y verifica que los triggers se están ejecutando correctamente.

    DELIMITER ;
    UPDATE alumnos SET nota = 15    where nombre = 'Robert';

    INSERT INTO alumnos VALUES (1, 'Juan Daniel', 'Delegado', 'Delegadez', -2);
    INSERT INTO alumnos VALUES (2, 'Alejandro', 'Alejandrez', 'Bellingham', 7.2);
    INSERT INTO alumnos VALUES (3, 'Ainara', 'Maligna', 'Reina', 17.2);
    INSERT INTO alumnos VALUES (4, 'Robert', 'Subdelegado', 'Subdelegadez', -0.2);

SELECT * FROM alumnos;


# EJERCICIO 39 ---> NONONONO añade un campo email a la que ya tienes
# Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.
    USE test;
    ALTER TABLE alumnos ADD email VARCHAR(100);
# Tabla alumnos:
# id (entero sin signo)
# nombre (cadena de caracteres)
# apellido1 (cadena de caracteres)
# apellido2 (cadena de caracteres)
# email (cadena de caracteres)

# Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.
# Procedimiento: crear_email
# Entrada:
# nombre (cadena de caracteres)
# apellido1 (cadena de caracteres)
# apellido2 (cadena de caracteres)
# dominio (cadena de caracteres)
# Salida:
# email (cadena de caracteres)
# devuelva una dirección de correo electrónico con el siguiente formato:
# El primer carácter del parámetro nombre.
# Los tres primeros caracteres del parámetro apellido1.
# Los tres primeros caracteres del parámetro apellido2.
# El carácter @.
# El dominio pasado como parámetro.
  DELIMITER $$;
    CREATE PROCEDURE crear_email(
        IN nombre VARCHAR(100),
        IN apellido1 VARCHAR(100),
        IN apellido2 VARCHAR(100),
        IN dominio VARCHAR(100),
        OUT email VARCHAR(100)
    )
    BEGIN
        SET email = CONCAT(SUBSTRING(nombre, 1, 1), SUBSTRING(apellido1, 1, 3), SUBSTRING(apellido2, 1, 3), '@', dominio);
    END $$;

# CALL crear_email('Juan', 'Delegado', 'Delegadez', 'gmail.com', @email);

# Una vez creada la tabla escriba un trigger con las siguientes características:
# Trigger: trigger_crear_email_before_insert
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta antes de una operación de inserción.
# Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.
# Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.
# Nota: Para crear la nueva dirección de email se deberá hacer uso del procedimiento crear_email.
DELIMITER $$;
DROP TRIGGER IF EXISTS trigger_crear_email_before_insert;
CREATE TRIGGER trigger_crear_email_before_insert
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN
    IF NEW.email IS NULL THEN
        CALL crear_email(NEW.nombre, NEW.apellido1, NEW.apellido2, 'gmail.com', @email);
        SET NEW.email = @email;
    ELSE
        SET NEW.email = NEW.email;
    END IF;

END $$;

-- LO PROBAMOS
    INSERT INTO alumnos VALUES (4, 'Juan Daniel', 'Delegado', 'Delegadez', 10, NULL);
    INSERT INTO alumnos VALUES (5, 'Alejandro', 'Alejandrez', 'Bellingham', 7.2, 'ale@gmail.com');

# EJERCICIO 40
# Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:
# Trigger: trigger_guardar_email_after_update:
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta después de una operación de actualización.
# Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro en una tabla llamada log_cambios_email.
# La tabla log_cambios_email contiene los siguientes campos:
# id: clave primaria (entero autonumérico)
# id_alumno: id del alumno (entero)
# fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
# old_email: valor anterior dedl email (cadena de caracteres)
# new_email: nuevo valor con el que se ha actualizado
        CREATE TABLE log_cambios_email(
        id INT AUTO_INCREMENT PRIMARY KEY,
        id_alumno INT,
        fecha_hora DATETIME,
        old_email VARCHAR(100),
        new_email VARCHAR(100)
    );
DELIMITER $$;
DROP TRIGGER IF EXISTS trigger_guardar_email_after_update;
CREATE TRIGGER trigger_guardar_email_after_update
AFTER UPDATE
ON alumnos FOR EACH ROW
BEGIN
    IF OLD.email != NEW.email THEN
        INSERT INTO log_cambios_email (id_alumno, fecha_hora, old_email, new_email)
        VALUES (NEW.id, NOW(), OLD.email, NEW.email);
    END IF;
END $$;

-- LO PROBAMOS
    UPDATE alumnos SET email = 'otroemail@gmail.com' WHERE id = 4;

# EJERCICIO 41
# Modifica el ejercicio anterior y añade un nuevo trigger que tenga las siguientes características:
# Trigger: trigger_guardar_alumnos_eliminados:
# Se ejecuta sobre la tabla alumnos.
# Se ejecuta después de una operación de borrado.
# Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una tabla llamada log_alumnos_eliminados.
# La tabla log_alumnos_eliminados contiene los siguientes campos:
# id: clave primaria (entero autonumérico)
# id_alumno: id del alumno (entero)
# fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
# nombre: nombre del alumno eliminado (cadena de caracteres)
# apellido1: primer apellido del alumno eliminado (cadena de caracteres)
# apellido2: segundo apellido del alumno eliminado (cadena de caracteres)
# email: email del alumno eliminado (cadena de caracteres)
CREATE TABLE log_alumnos_eliminados(
  id INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT,
    fecha_hora DATETIME,
    nombre VARCHAR(100),
    apellido1 VARCHAR(100),
    apellido2 VARCHAR(100),
    email VARCHAR(100)
);

DELIMITER $$;
DROP TRIGGER IF EXISTS trigger_guardar_alumnos_eliminados;
CREATE TRIGGER trigger_guardar_alumnos_eliminados
AFTER DELETE
ON alumnos FOR EACH ROW
BEGIN
    INSERT INTO log_alumnos_eliminados (id_alumno, fecha_hora, nombre, apellido1, apellido2, email)
    VALUES (OLD.id, NOW(), OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email);
END $$;

-- LO PROBAMOS
    DELETE FROM alumnos WHERE id = 4;

