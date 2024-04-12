# Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
use tienda;
select p.nombre, p.precio, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id;

# Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
select p.nombre, p.precio, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
order by f.nombre;

# Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select p.id, p.nombre, f.id, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id;

# Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.nombre, p.precio, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
order by p.precio
limit 1;

# Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select p.nombre, p.precio, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
order by p.precio desc
limit 1;

# Devuelve una lista de todos los productos del fabricante Lenovo.
select p.nombre, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
where f.nombre = 'Lenovo';
# Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
select p.nombre, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
where f.nombre = 'Crucial' and p.precio > 200;
# Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
select p.nombre, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
where f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate';
# Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
select p.nombre, f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
where f.nombre in ('Asus', 'Hewlett-Packard', 'Seagate');
# Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
select p.nombre, p.precio,  f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
where f.nombre like '%e';
# Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
select p.nombre, p.precio,  f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
where f.nombre like '%w%';
# Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
select p.nombre, p.precio,  f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id
where p.precio >= 180
order by p.precio desc , p.nombre;

# Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
select distinct f.id , f.nombre
from producto as p join fabricante as f
on p.id_fabricante = f.id;
# 1.1.5 Consultas multitabla (Composición externa)
# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

# Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
select f.nombre, p.nombre
from producto as p right join fabricante as f
on p.id_fabricante = f.id;
# Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select f.nombre, p.nombre
from producto as p right join fabricante as f
on p.id_fabricante = f.id
where p.nombre is null;
# ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.
