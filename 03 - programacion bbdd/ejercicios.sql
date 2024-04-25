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




# EJERCICIO 23
# Escribe una función que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.

# EJERCICIO 24
# Escribe una función que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.

# EJERCICIO 25
# Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.

# EJERCICIO 26
# Escribe una función que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.
# Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona MySQL:
# DATEDIFF
# TRUNCATE


# EJERCICIO 27
# Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.


# 1.8.4 Funciones con sentencias SQL READS SQL DATA / MODIFIES SQL DATA

# EJERCICIO 28
# Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.

# EJERCICIO 29
# Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.

# EJERCICIO 30
# Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.

# EJERCICIO 31
# Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado fabricante que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.



