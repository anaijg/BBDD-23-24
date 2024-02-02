# 1.- Calcula el número total de productos que hay en la tabla productos.
    use tienda;
    select count(id)
    from producto;

# 2.- Calcula el número total de fabricantes que hay en la tabla fabricante.
    select count(id)
    from fabricante;

# 3.- Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.
    select count(distinct id_fabricante)
    from producto;

# 4.-Calcula la media del precio de todos los productos.
    select avg(precio) # si queremos mostrar sólo 2 decimales escribiríamos truncate(avg(precio), 2)
    from producto;

# 5.- Calcula el precio más barato de todos los productos.
    select min(precio)
    from producto;

# 6.- Calcula el precio más caro de todos los productos.
    select max(precio)
    from producto;

# 7.- Lista el nombre y el precio del producto más barato.

    # select nombre, min(precio) -> no sale porque tendríamos que añadir group by y having -> buscamos una forma alternativa
    # from producto;

    select nombre, precio
    from producto
    order by precio asc
    limit 1;

# 8.- Lista el nombre y el precio del producto más caro.
    select nombre, precio
    from producto
    order by precio desc
    limit 1;

# 9.-Calcula la suma de los precios de todos los productos.
    select sum(precio)
    from producto;

# 10.- Calcula el número de productos que tiene el fabricante Asus.
    select count(*) # también valdría count(p.nombre) o count(p.id_fabricante)
    from producto as p join fabricante as f
    on p.id_fabricante = f.id
    where f.nombre = 'Asus';

# 11.- Calcula la media del precio de todos los productos del fabricante Asus.
    select avg(precio)
    from producto as p join fabricante as f
    on p.id_fabricante = f.id
    where f.nombre = 'Asus';

# 12.- Calcula el precio más barato de todos los productos del fabricante Asus.
    select min(precio)
    from producto as p join fabricante as f
    on p.id_fabricante = f.id
    where f.nombre = 'Asus';

# 13.- Calcula el precio más caro de todos los productos del fabricante Asus.
    select max(precio)
    from producto as p join fabricante as f
    on p.id_fabricante = f.id
    where f.nombre = 'Asus';

# 14.- Calcula la suma de todos los productos del fabricante Asus.
    select sum(precio)
    from producto as p join fabricante as f
    on p.id_fabricante = f.id
    where f.nombre = 'Asus';

# 15.- Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
    select max(precio), min(precio), avg(precio), count(*)
    from producto as p join fabricante as f
    on p.id_fabricante = f.id
    where f.nombre = 'Crucial';

# 16.- Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir los fabricantes que no tienen ningún producto. El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.
    select f.nombre, count(p.id)
    from producto as p right join fabricante as f # quiero todos los fabricantes, tanto si tienen productos como si no
    on  p.id_fabricante = f.id
    group by f.nombre                                               # de cada uno de los fabricantes
    order by count(p.id) desc;      # ordeno descendentemente por el número de productos

# 17.- Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
select f.nombre, max(p.precio), min(p.precio), avg(p.precio)     # Muestra el precio máximo, precio mínimo y precio medio de los productos
from fabricante as f join producto as p                         # como no me dice que tenga que mostrar productos sin fabricante ni fabricante sin productos, es un join normal
on f.id = p.id_fabricante
group by f.nombre;                                               # de cada uno de los fabricantes

# 18.- Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente.
select f.id, max(p.precio), min(p.precio), avg(p.precio), count(*)    # Muestra el precio máximo, precio mínimo, precio medio y el número total de productos - No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente.
from fabricante as f join producto as p
on f.id = p.id_fabricante
group by f.id
having avg(p.precio) > 200;
    # de los fabricantes que tienen un precio medio superior a 200€.  -> HAVING

# 19.- Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.

# 20.- Calcula el número de productos que tienen un precio mayor o igual a 180€.

# 21.- Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.

# 22.- Lista el precio medio los productos de cada fabricante, mostrando solamente el identificador del fabricante.

# 23.- Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.

# 24.- Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.

# 25.- Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.

# 26.- Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.

# 27.- Ejemplo del resultado esperado:

# nombre	total
# Lenovo	2
# Asus	1
# Crucial	1
# Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los fabricantes, es decir, si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos.
# Ejemplo del resultado esperado:
#
# nombre	total
# Lenovo	2
# Crucial	1
# Asus	1
# Huawei	0
# Samsung	0
# Gigabyte	0
# Hewlett-Packard	0
# Xiaomi	0
# Seagate	0

# 28.- Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.
