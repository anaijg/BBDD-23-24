use ciclos;
# 01.- Insertar un nuevo alumno con código de matrícula 9 y nombre Alberto
INSERT INTO alumnos VALUES (9, 'Alberto', 666666);

# 02.	Insertar un nuevo ciclo de código 3, nombre INF, grado medio, y duración 3.
INSERT INTO ciclos VALUES (3, 'INF', 'MEDIO', 3);
# 03.	Insertar un nuevo módulo para el ciclo 1, de código 7, nombre 'Programacion' y cuyo número de horas semanales coincida con las del módulo "SGBD".
INSERT INTO modulos VALUES (7, 'Programacion', 0, 1);
UPDATE modulos
SET horas = (SELECT horas
             FROM (SELECT *                         # en el FROM no podemos volver a poner la tabla modulos,
                  FROM modulos                      # así que en vez de módulos hacemos un select con lo que queremos y
                  WHERE nombre = 'SGBD' ) as tmp)   # le decimos que es una tabla temporal
WHERE cod_m = 7;

# 04.	Insertar un nuevo profesor de código 10 y nombre 'Angeles Lorenzo' cuya titulación coincida con la titulación de "Alicia Martínez". Ponlo en el departamento que quieras.
INSERT INTO profesores (cod_p, dni, nombre, cod_dpto)
VALUES (10, '101010', 'Angeles Lorenzo',3);
UPDATE profesores
SET titulacion = (SELECT titulacion
                  FROM (SELECT *
                        FROM profesores
                        WHERE nombre = 'Alicia Martinez') AS tmp)
WHERE nombre = 'Angeles Lorenzo';


# 05.	Insertar un nuevo módulo para el ciclo 2, cuyo código sea el siguiente (máximo más 1), de nombre   y cuyo número de horas coincida con las horas del módulo más largo.


# 06.	Matricular en el ciclo 3 a todos los alumnos del DAI (usando una única sentencia).

# 07.	Matricular al alumno 9 en el ciclo que tenga menos alumnos matriculados.

# 08.	Modificar la duración del ciclo 'INF' al 33% menos.

# 09.	Modificar el número de horas que el profesor 4 imparte al módulo 1, y asignarle 1 más de las que tiene.

# 10.	Asignarle al ciclo INF el mismo grado y duración que el ciclo 'ASI'.

# 11.	Restar 1 hora en la tabla impartición a los módulos impartidos por el profesor/es Jefes de Departamento.

# 12.	Incluir al profesoren el departamento en el que más profesores hay. 13. Para los módulos que no son impartidos por ningún profesor, modificar las horas de dichos módulos al número de horas del módulo más corto.

# 14.	Intentar eliminar el ciclo DAI. ¿por qué no se puede?. No eliminarlo.

# 15.	Eliminar de la tabla de modulos, aquellos que no son impartidos por ningún profesor.

# 16.	Eliminar los departamento que no tienen profesores.

# 17.	Eliminar de la tabla de Imparticion las lineas que hacen referencia a módulos cuyo número de horas (horas de los módulos, no de imparticion) es inferior a la media.
# A continuación, eliminar los mismos módulos de la tabla de módulos.

# 18.	Eliminar de la tabla de profesores a aquellos que no impartan módulos, a no ser que sean jefes de departamento.
