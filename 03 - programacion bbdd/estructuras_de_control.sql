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
