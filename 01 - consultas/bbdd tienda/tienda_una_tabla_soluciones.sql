-- https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html
###################################################
#### Ejercicios. Realización de consultas SQL  ####
###################################################
-- 1.1 Tienda de informática
-- 1.1.3 Consultas sobre una tabla
-- 01. Lista el nombre de todos los productos que hay en la tabla producto.
use tienda;
select nombre
from tienda.producto;
-- 02. Lista los nombres y los precios de todos los productos de la tabla producto.
    select nombre, producto.precio
    from producto;
-- 03. Lista todas las columnas de la tabla producto.
    select *
    from producto;
-- 04. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
    select nombre, producto.precio, producto.precio * 1.1
    from producto;
-- 05. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
    select nombre, producto.precio as euros, producto.precio * 1.1 as dólares
    from producto;
-- 06. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
    select upper(producto.nombre), producto.precio
    from producto;
-- 07. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
    select lower(producto.nombre), producto.precio
    from producto;
-- 08. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select nombre, upper(substr(nombre, 1, 2))
from fabricante;
-- 09. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select producto.nombre, round(producto.precio)
from producto;
-- 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select producto.nombre, TRUNCATE(producto.precio, 0)
from producto;
-- 11. Lista el identificador de los fabricantes que tienen productos en la tabla producto.
SELECT producto.id_fabricante
FROM producto;
-- 12. Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.
SELECT DISTINCT producto.id_fabricante
FROM producto;
-- 13. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT fabricante.nombre
FROM fabricante
ORDER BY fabricante.nombre;
-- 14. Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT fabricante.nombre
FROM fabricante
ORDER BY fabricante.nombre DESC ;
-- 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT producto.nombre
FROM producto
ORDER BY nombre ASC , precio DESC;

-- 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
    SELECT *
    FROM fabricante
    LIMIT 5;
-- 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
    SELECT *
    FROM fabricante
    LIMIT 3, 2;
-- 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
    SELECT producto.nombre, producto.precio
    FROM producto
    ORDER BY precio
    LIMIT 1;
-- 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
    SELECT producto.nombre, producto.precio
    FROM producto
    ORDER BY precio ASC
    LIMIT 1;
-- 20. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.
    SELECT producto.nombre-- , producto.id_fabricante
    FROM producto
    WHERE id_fabricante = 2;
-- 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
    SELECT producto.nombre-- , producto.precio
    FROM producto
    WHERE precio <= 120;
-- 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
    SELECT producto.nombre-- , producto.precio
    FROM producto
    WHERE precio >= 400;
-- 23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
    SELECT producto.nombre-- , precio
    FROM producto
    WHERE NOT precio >= 400; -- también: where precio < 400;
-- 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
  SELECT producto.nombre#, producto.precio
  FROM producto
  WHERE precio >= 80 AND precio <= 300;
-- 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
    SELECT producto.nombre#, producto.precio
    FROM producto
    WHERE precio BETWEEN 60 AND 200;
-- 26. Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.
    SELECT producto.nombre#, precio, id_fabricante
    FROM producto
    WHERE precio > 200 AND id_fabricante = 6
-- 27. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
    SELECT producto.nombre#, producto.id_fabricante
    FROM producto
    WHERE id_fabricante = 1 OR id_fabricante = 3 OR id_fabricante = 5;

-- 28. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.
    SELECT producto.nombre#, producto.id_fabricante
    FROM producto
    WHERE id_fabricante IN (1, 3, 5);
-- 29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
    SELECT producto.nombre, producto.precio * 100 AS centimos
    FROM producto;

-- 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
    SELECT fabricante.nombre
    FROM fabricante
    WHERE nombre LIKE 'S%';
-- 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
    SELECT fabricante.nombre
    FROM fabricante
    WHERE nombre LIKE '%e';
-- 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
    SELECT fabricante.nombre
    FROM fabricante
    WHERE nombre LIKE '%W%';
-- 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
    SELECT fabricante.nombre
    FROM fabricante
    WHERE nombre LIKE '____';
-- 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
    SELECT producto.nombre
    FROM producto
    WHERE nombre LIKE '%PORTÁTIL%';
-- 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
    SELECT producto.nombre
    FROM producto
    WHERE nombre LIKE '%MONITOR%' AND precio < 215;
-- 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
    SELECT producto.nombre, producto.precio
    FROM producto
    WHERE precio >= 190
    ORDER BY precio DESC, nombre ASC ;
