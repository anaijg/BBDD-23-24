# 1.1.4 Ejemplo de un procedimiento con parámetros de entrada
# Escriba un procedimiento llamado listar_productos
# que reciba como entrada el nombre de la gama
# y muestre un listado de todos los productos que existen dentro de esa gama.
# Este procedimiento no devuelve ningún parámetro de salida, lo que hace es mostrar el listado de los productos.
USE jardineria;

DELIMITER $$;
CREATE PROCEDURE listar_productos(IN gama_prod VARCHAR(50))
BEGIN
    SELECT *
     FROM producto
         WHERE gama = gama_prod;
end $$;

# PROBAMOS EL PROCEDIMIENTO
DELIMITER ;
CALL listar_productos('Herramientas');

# 1.1.6 Ejemplos de procedimientos con parámetros de salida
# Ejemplo 1:
# Escriba un procedimiento llamado contar_productos que reciba como entrada el nombre de la gama y devuelva el número de productos que existen dentro de esa gama. Resuelva el ejercicio de dos formas distintas, utilizando SET y SELECT ... INTO.
DELIMITER $$;
CREATE PROCEDURE contar_productos(IN gama_prod VARCHAR(50), OUT numero_productos INT)
BEGIN
    -- DECLARAMOS LA VARIABLE numero_productos Y GUARDAMOS EN ELLA EL RESULTADO DE LA CONSULTA
    SET numero_productos = (SELECT COUNT(*)
                            FROM producto
                            WHERE gama = gama_prod);
end $$;

# PARA LLAMAR A ESE PROCEDIMIENTO Y VER LO QUE GUARDA LA VARIABLE numero_productos:
DELIMITER ;
CALL contar_productos('Herramientas', @numero_productos);
SELECT @numero_productos;


# Ejemplo 2:
# Escribe un procedimiento que se llame calcular_max_min_media,
# que reciba como parámetro de entrada el nombre de la gama de un producto y
# devuelva como salida tres parámetros.
#   El precio máximo,
#   el precio mínimo
#   y la media de los productos que existen en esa gama.

DELIMITER $$;
DROP PROCEDURE IF EXISTS calcular_max_min_media;
CREATE PROCEDURE calcular_max_min_media(IN gama_prod VARCHAR(50),
                                            OUT precio_max double,
                                            OUT precio_min double,
                                            OUT precio_medio double)
BEGIN
    SET precio_max = (SELECT MAX(precio_venta)
                      FROM producto
                      WHERE gama = gama_prod);

    SET precio_min = (SELECT MIN(precio_venta)
                      FROM producto
                      WHERE gama = gama_prod);

    SET precio_medio = (SELECT AVG(precio_venta)
                      FROM producto
                      WHERE gama = gama_prod);
end $$;

# AHORA VAMOS A LLAMAR AL PROCEDIMIENTO
DELIMITER ;
CALL calcular_max_min_media('Herramientas', @maximo, @minimo, @medio);
SELECT @maximo AS maximo, @minimo AS minimo, @medio AS medio;

