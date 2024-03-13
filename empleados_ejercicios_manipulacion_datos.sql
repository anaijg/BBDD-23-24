DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  id_departamento INT UNSIGNED,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);



# 7.2 Empleados
# Realice las siguientes operaciones sobre la base de datos empleados.
#
# 01.- Inserta un nuevo departamento indicando su código, nombre y presupuesto.
use empleados;
insert into departamento (id, nombre, presupuesto, gastos) values (8, 'Seguridad', 0, 0);

# 02.- Inserta un nuevo departamento indicando su nombre y presupuesto.
insert into departamento ( nombre, presupuesto, gastos) values ('El ministerio del tiempo', 0, 0);
#
# 03.- Inserta un nuevo departamento indicando su código, nombre, presupuesto y gastos.
insert into departamento ( id, nombre, presupuesto, gastos) values (10, 'Pepito', 100000, 0);
# 04.- Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción debe incluir: código, nif, nombre, apellido1, apellido2 y codigo_departamento.
insert into empleado (id, nif, nombre, apellido1, apellido2, id_departamento) values (14, '01234567B', 'Maria', 'de las Mercedes', 'Reina', 10);

# 05.- Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción debe incluir: nif, nombre, apellido1, apellido2 y codigo_departamento.
insert into empleado (nif, nombre, apellido1, apellido2, id_departamento) values ('01234567C', 'Maria', 'de las Mercedes', 'Reina', 10);
# 06.- Crea una nueva tabla con el nombre departamento_backup que tenga las mismas columnas que la tabla departamento.
create table departamento_backup(
      id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

# Una vez creada copia todos las filas de tabla departamento en departamento_backup.
insert into departamento_backup (id, nombre, presupuesto, gastos) select * from departamento;

# 07.- Elimina el departamento Proyectos. ¿Es posible eliminarlo? SI. Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
delete from departamento
where nombre = 'Proyectos';
# 08.- Elimina el departamento Desarrollo. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
    delete from departamento
    where nombre = 'Desarrollo'; # no nos deja eliminarlo porque en este departamento (id = 1) trabajan 3 empleados; la integridad referencial se rompería y se corrompería la base de datos
    # La solución sería modificar el esquema de la base de datos:
 # CREATE TABLE empleado (
 #  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 #  nif VARCHAR(9) NOT NULL UNIQUE,
 #  nombre VARCHAR(100) NOT NULL,
 #  apellido1 VARCHAR(100) NOT NULL,
 #  apellido2 VARCHAR(100),
 #  id_departamento INT UNSIGNED,
 #  FOREIGN KEY (id_departamento) REFERENCES departamento(id) on delete cascade
# );
#
# 09.- Actualiza el código del departamento Recursos Humanos y asígnale el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
#
# 10.- Actualiza el código del departamento Publicidad y asígnale el valor 40. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
#
# 11.- Actualiza el presupuesto de los departamentos sumándole 50000 € al valor del presupuesto actual, solamente a aquellos departamentos que tienen un presupuesto menor que 20000 €.
#
# 12.- Realiza una transacción que elimine todas los empleados que no tienen un departamento asociado.