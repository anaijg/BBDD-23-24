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
# Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país.
#
# Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardineria.
#
# Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
# el pago de máximo valor,
# el pago de mínimo valor,
# el valor medio de los pagos realizados,
# la suma de todos los pagos,
# el número de pagos realizados para esa forma de pago