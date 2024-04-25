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