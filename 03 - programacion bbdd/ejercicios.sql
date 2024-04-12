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
    ELSEIF nota >= 9 AND nota <= 10 THEN SET resultado = 'Notable';
    ELSE SET resultado = 'Nota no válida';
    END IF;
end $$;

# lo llamamos
DELIMITER ;
CALL ejercicio_5(8.99, @nota);
SELECT @nota;