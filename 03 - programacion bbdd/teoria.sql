# BUCLE WHILE
# [begin_label:] WHILE condicion DO
#     statement_list
# END WHILE [end_label]

# Ejemplo: crear un procedimiento que realice la suma de todos los números enteros desde 1 hasta un número introducido por parámetro (inclusive).

# en Java lo haríamos así
#     public static int sumarNumeros(int n) {
#         // ejemplo: n = 5 -> 1 + 2 + 3 + 4 + 5 = 15
#         int i = 1;
#         int suma = 0;
#         while (i <= n) {
#             suma = suma + i;
#             i = i + 1;
#         }
#         return suma;
#     }

USE procedimientos;
DELIMITER $$;

DROP PROCEDURE IF EXISTS ejemplo_while;
CREATE PROCEDURE ejemplo_while(IN n INT, OUT suma INT)
BEGIN
    # tengo que declarar dos variables: i y suma
    DECLARE i INT;
    # DECLARE suma INT; -> COMO YA LO HEMOS PUESTO COMO PARAMETRO DE SALIDA, NO HACE FALTA DECLARARLA

    # ahora las inicializo
    SET i = 1;
    SET suma = 0;

    # ahora es cuando viene el while
    WHILE i <= n DO
        SET suma = suma + i;
        SET i = i + 1;
    end while;

end $$;

DELIMITER ;
CALL ejemplo_while(5, @resultado);
SELECT @resultado;


# BUCLE REPEAT... UNTIL (repetir... hasta  )
#  REPEAT
#     instrucciones_a_repetir (una de ellas, que cambie la variable i)
# UNTIL condicion_de_salida (hasta que se cumpla la condición que se indique)
# END REPEAT
# Ejemplo: crear un procedimiento que realice la suma de todos los números enteros desde 1 hasta un número introducido por parámetro (inclusive).

USE procedimientos;
DELIMITER $$;

DROP PROCEDURE IF EXISTS ejemplo_repeat_until;
CREATE PROCEDURE ejemplo_repeat_until(IN tope INT, OUT suma INT)
BEGIN
    # tengo que declarar dos variables: i y suma
    DECLARE i INT;
    # DECLARE suma INT; -> COMO YA LO HEMOS PUESTO COMO PARAMETRO DE SALIDA, NO HACE FALTA DECLARARLA

    # ahora las inicializo
    SET i = 1;
    SET suma = 0;

     # ahora es cuando viene el repeat until
    REPEAT
        SET suma = suma + i;
        SET i = i + 1;
    until  i > tope   # aquí pones la condición con el primer valor que ya se sale
    end repeat;
end $$;

delimiter ;
call ejemplo_repeat_until(1000, @resultado);
SELECT @resultado





# nombre_bucle: LOOP
# 	IF condicion_de_salida THEN
# 		LEAVE nombre_bucle;
# 	END IF;
# 		instrucciones _a_ repetir
# END LOOP;

# Ejemplo: crear un procedimiento que realice la suma de todos los números enteros desde 1 hasta un número introducido por parámetro (inclusive).
USE procedimientos;
DELIMITER $$;
DROP PROCEDURE IF EXISTS ejemplo_bucle_loop;
CREATE PROCEDURE ejemplo_bucle_loop(IN tope INT, OUT suma INT)
BEGIN
   DECLARE i INT;

   SET i = 1;
   SET suma = 0;

   bucle: LOOP
     IF i > tope THEN -- esto funciona igual que en repeat until; pones el primer valor "en que te sales"
       LEAVE bucle;
     END IF;

    -- instrucciones a repetir
     SET suma = suma + i;
     SET i = i + 1;
   END LOOP;
END $$;

 DELIMITER ;
 CALL ejemplo_bucle_loop(6, @resultado);
 SELECT @resultado;


#### funciones #####
# DELIMITER $$;
# DROP FUNCTION IF EXISTS nombre_funcion;
# CREATE FUNCTION nombre_funcion([nombre_param1 tipo][, nombre_param2 tipo]...)
#   RETURNS tipo_valor_devuelto
    # NO SQL | READS SQL DATA | MODIFIES SQL DATA....

#   ...
# BEGIN
#   … instrucciones…
#
#
#   RETURN valor_devuelto;
# END $$;
# DELIMITER;

# EJEMPLO FUNCION
# Crear una función que devuelva el número de productos que hay en la tabla producto de una gama metida por parámetro
USE jardineria;
DELIMITER $$;
DROP FUNCTION IF EXISTS ejemplo_funcion_contar_productos;
CREATE FUNCTION ejemplo_funcion_contar_productos(gama_producto VARCHAR(50))
RETURNS INT UNSIGNED -- DEVUELVE UN ENTERO NO NEGATIVO
    READS SQL DATA
    BEGIN

        DECLARE numero_productos INT UNSIGNED;

        SET numero_productos = (SELECT COUNT(*)
        FROM producto
        WHERE gama = gama_producto);

        RETURN numero_productos;
end $$;

DELIMITER ;
SELECT ejemplo_funcion_contar_productos('Herramientas');

## TRIGGERS ###
# DELIMITER $$;
# DROP TRIGGER IF EXISTS trigger_name;
# CREATE TRIGGER trigger_name
#     { BEFORE | AFTER } { INSERT | UPDATE | DELETE }
#     ON tbl_name FOR EACH ROW
#     BEGIN
# 	instrucciones, usando NEW para el nuevo dato

#     END $$;
# Un trigger es un objeto de la base de datos que está asociado con una tabla y que se activa cuando ocurre un evento  (insert, update o delete)sobre la tabla.

# Ejemplo:
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

# Se ejecuta antes de una operación de inserción. --> BEFORE INSERT
# Se ejecuta sobre la tabla alumnos. --> ON alumnos FOR EACH ROW
# Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.            -- INSTRUCCIONES
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

# Una vez creados los triggers escriba varias sentencias de inserción y actualización sobre la tabla alumnos y verifica que los triggers se están ejecutando correctamente.
    INSERT INTO alumnos VALUES (1, 'Juan Daniel', 'Delegado', 'Delegadez', -2);
    INSERT INTO alumnos VALUES (2, 'Alejandro', 'Alejandrez', 'Bellingham', 7.2);
    INSERT INTO alumnos VALUES (3, 'Ainara', 'Maligna', 'Reina', 17.2);
    INSERT INTO alumnos VALUES (4, 'Robert', 'Subdelegado', 'Subdelegadez', -0.2);

SELECT * FROM alumnos;


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

DELIMITER ;
UPDATE alumnos SET nota = 15    where nombre = 'Robert';

select * from alumnos;

