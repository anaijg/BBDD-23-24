use tienda;
# 30 .- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
    select nombre
    from fabricante
    where nombre LIKE 'S%';
# 31 .- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
    select nombre
    from fabricante
    where nombre like '%e';
# 32 .- Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
    select nombre
    from fabricante
    where nombre like '%w%';
# 33 .- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
    select nombre
    from fabricante
    where nombre like '____';
# 34 .- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
    select nombre
    from producto
    where nombre like '%Portátil%';
# 35 .- Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
    select nombre
    from producto
    where nombre like '%Monitor%' and precio < 215;
# 36 .- Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
    select nombre, precio
    from producto
    where precio >= 180
    order by precio desc, nombre asc;