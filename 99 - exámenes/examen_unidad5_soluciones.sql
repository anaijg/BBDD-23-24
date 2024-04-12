#######################################################################################################
####                    EXAMEN UNIDAD 5 3ª EVALUACIÓN                                              ####
####                                                                                               ####
####     La base de datos a utilizar se carga con el script examen_unidad5_esquema_y_datos.sql     ####
####                                                                                               ####
####    La puntuación de cada pregunta aparece en su enunciado.                                    ####
####    La puntuación en el examen es la suma de lo obtenido en cada pregunta.                     ####
####    Se puede obtener 10 puntos como máximo.                                                    ####
####    La consultas no contestadas o resueltas incorrecta o parcialmente suman 0 puntos.          ####
####    Se permite consultar cualquier tipo de material, sin conexión a internet.                  ####
####    Tiempo de realización del examen: 2 horas                                                  ####
####                                                                                               ####
####    Cuando finalices, añade este fichero a la tarea correspondiente en el Aula Virtual         ####
####                                                                                               ####
#######################################################################################################

# NOMBRE:
#######################################################################################################

# 01.- (0,5 puntos) Inserta un registro nuevo en la tabla PROFESORADO. Los
# datos deben ser los siguientes:
# o Codigo: 1
# o Nombre: NURIA
# o Apellidos: ANERO GONZALEZ
# o DNI: 58328033X
# o Especialidad: MATEMATICAS
# o Fecha_Nac: 22/02/1972
# o Antiguedad: 9

USE instituto;
INSERT INTO profesorado VALUES (1, 'NURIA', 'ANERO GONZALEZ', '58328033X', 'MATEMATICAS', '1972-02-22', 9);

# 02.- (1 punto)Inserta varios registros más en la tabla PROFESORADO utilizando instrucciones SQL. Los datos que aparecen en blanco no deben añadirse en las instrucciones.
# Codigo    Nombre          Apellidos           DNI             Especialidad        Fecha_Nac   Antigüedad
#   2       MARÍA LUISA     FABRE BERDÚN        51083099F       TECNOLOGÍA          31/03/1975      4
#   3       JAVIER          JIMÉNEZ HERNANDO                    LENGUA              04/05/1969      10
#   4       ESTEFANÍA       FERNÁNDEZ MARTÍNEZ  19964324W       INGLÉS              22/06/1973      5
#           JOSÉ M.         ANERO PAYÁN
INSERT INTO profesorado
VALUES (2, 'MARÍA LUISA', 'FABRE BERDÚN', '51083099F', 'TECNOLOGÍA', '1975-03-31', 4);

INSERT INTO profesorado (Codigo, Nombre, Apellidos, Especialidad, Fecha_Nac, Antiguedad)
VALUES (3, 'JAVIER', 'JIMÉNEZ HERNANDO', 'LENGUA', '1969-05-04', 10);

INSERT INTO profesorado VALUES (4, 'ESTEFANÍA', 'FERNÁNDEZ MARTÍNEZ', '19964324W ', 'INGLÉS', '1973-06-22', 5);

INSERT INTO profesorado (Nombre, Apellidos)
VALUES ('JOSÉ M.', 'ANERO PAYÁN');

# 03.- (0,5 puntos) Modifica los registros de la tabla CURSOS para asignar a cada curso un profesor o
# profesora. El profesorado que debes asignar a cada curso es:
# Tabla CURSOS
# Codigo Cod_Profe
# 1         4
# 2         2
# 3         2
# 4         1
# 5         1
# 6         3

UPDATE cursos SET Cod_Profe = 4 WHERE Codigo = 1;
UPDATE cursos SET Cod_Profe = 2 WHERE Codigo = 2;
UPDATE cursos SET Cod_Profe = 2 WHERE Codigo = 3;
UPDATE cursos SET Cod_Profe = 1 WHERE Codigo = 4;
UPDATE cursos SET Cod_Profe = 1 WHERE Codigo = 5;
UPDATE cursos SET Cod_Profe = 3 WHERE Codigo = 6;

#4.- (0,5 puntos)Realiza una vista llamada 'profesores_cursos', en la que se pueda ver:
    # nombre del curso
    # nombre y apellido de los profesores (concatenados en un único campo) que imparten ese curso
use instituto;
create view profesores_cursos as
select cursos.nombre, concat_ws(' ', profesorado.nombre, profesorado.Apellidos) as profesor
    from cursos join profesorado
on profesorado.Codigo = cursos.Cod_Profe;

# 05.- (0,5 puntos) Modifica el registro de la profesora 'ESTEFANÍA': cambia su fecha de nacimiento a 22 de junio de 1974 y su antigüedad a 4. Ambas cosas en una única instrucción SQL.
UPDATE profesorado SET Fecha_Nac = '1974-06-22', Antiguedad = 4 WHERE Nombre = 'ESTEFANÍA';

# 06.- (0,5 puntos) Modifica las antigüedades de todos los profesores y profesoras incrementándolas en 1 en todos los registros. Debes hacerlo usando una sola instrucción SQL.
UPDATE profesorado SET Antiguedad = Antiguedad + 1;

# 07.- (0,5 puntos) Elimina de la tabla CURSOS el registro del curso que tiene el código 6.
DELETE FROM cursos WHERE Codigo = 6;

# 08.- (0,5 punto). Elimina de la tabla ALUMNADO aquellos registros asociados al curso con código 3 utilizando una sola instrucción SQL.
    DELETE FROM alumnado WHERE Cod_Curso = 3;

# 09.- (0,5 punto). Inserta los registros de la tabla ALUMNADO_NUEVO en la tabla ALUMNADO usando una única instrucción SQL.
INSERT INTO alumnado (nombre, apellidos, sexo, fecha_nac)  SELECT Nombre, Apellidos, Sexo, Fecha_Nac FROM alumnado_nuevo;

#10.- (1,25 puntos). En la tabla CURSOS actualiza el campo Max_Alumn del registro del curso con código 2, asignándole el valor correspondiente al número total de alumnos y alumnas que hay en la tabla ALUMNADO y que tienen asignado ese mismo curso.
    UPDATE cursos
    SET Max_Alumn = (SELECT COUNT(*)
                     FROM alumnado
                     WHERE Cod_Curso = 2)
    WHERE Codigo = 2;


#11.- (1,5 puntos) Elimina de la tabla ALUMNADO todos los registros asociados a los cursos que imparte la profesora cuyo nombre es 'NURIA'
    DELETE FROM alumnado
           where Cod_Curso IN (select Codigo
                               from cursos
                               where Cod_Profe in (select Codigo
                                                   from profesorado
                                                   where Nombre = 'Nuria'));

#12.-(1,25 punto) Elimina el profesor que imparte el curso 2. Haz lo necesario para que pueda realizarse esta operación.
    delete from profesorado
           where Codigo = (SELECT Cod_Profe
                                            FROM cursos
                                            WHERE Codigo = 2);
alter table cursos
    drop constraint fk_profe;

alter table cursos
add (CONSTRAINT fk_profe FOREIGN KEY (Cod_Profe) REFERENCES profesorado (Codigo) on delete cascade);

#11.- (1 punto) Crea un usuario de nombre operador24 y contraseña operador24 que opere en localhost y tenga todos los privilegios en todas las tablas de la base de datos instituto.
    create user 'operador24' identified by 'operador24';
    update mysql.user set Host = 'localhost' where User = 'operador24';
    grant all privileges on instituto.* to operador24@localhost;
    show grants for operador24@localhost;










