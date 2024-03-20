# crear usuario
# CREATE USER nombre_usuario IDENTIFIED BY 'password' [opciones]

# los usuarios pueden verse en la base de datos mysql, tabla user
# select * from mysql.user;

# si abrimos la tabla mysql.user vemos que nos lo ha creado en el host comodín (%). Es decir, funciona para todos los hosts
# si quieres cambiar esto puedes hacer un update normal y corriente. Por ejemplo:


# eliminar usuario
# DROP USER nombre_usuario


# MODIFICACIÓN DE USUARIOS
# cambiar nombre
# RENAME USER nombre_usuario to nuevo_nombre


# cambiar contraseña
# alter user nombre_usuario@host identified by 'nueva_password'
# WHERE USER='nombre_usuario' AND HOST='localhost'


# PRIVILEGIOS

# ver los privilegios de un usuario


# para dar privilegios utilizaremos el comando GRANT
# GRANT tipo_privilegio
# ON base_datos.nombre_tabla
    # -> si quieres dar los privilegios en una base de datos en todas las tablas: bose_datos.*
    # -> si queres dar los privilegios en todas las bases de datos *.*
# TO nombre_usuario;


# TIPO_PRIVILEGIO puede ser: ALL PRIVILEGES, ALTER, CREATE, CREATE USER, CREATE VIEW, DELETE, DROP, EXECUTE, INSERT, SELECT, SHOW DATABASES, SHOW VIEW, UPDATE...



# ahora puedo crear una conexión con los mismos privilegios que tiene el usuario root

# quitar permisos (privilegios)
/*
REVOKE tipo_privilegio
ON base_de_datos.tabla
FROM nombre_usuario@host;
*/






