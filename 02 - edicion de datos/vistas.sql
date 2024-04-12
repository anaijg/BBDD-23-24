use jardineria;
# para recuperar la consulta con la que se creó una vista:
# SHOW CREATE VIEW view_name
show create view jardineria.clientes_madrid;


# creamos una vista
create view clientes_madrid as
select * from cliente
where ciudad = 'Madrid';

# realizamos un cambio en la tabla contra la que va la vista clientes_madrid
update cliente
set ciudad = 'Fuenlabrada', region = 'Fuenlabrada'
where codigo_cliente = '36';
# se actualiza la tabla y también la vista que contiene estos datos

