# crear usuario
# CREATE USER nombre_usuario IDENTIFIED BY 'password' [opciones]

    create user ana identified by '1234';


# los usuarios pueden verse en la base de datos mysql, tabla user
# select * from mysql.user;


# si abrimos la tabla mysql.user vemos que nos lo ha creado en el host comodín (%). Es decir, funciona para todos los hosts
# si quieres cambiar esto puedes hacer un update normal y corriente. Por ejemplo:
update mysql.user set host = 'localhost' where user = 'ana';

# eliminar usuario
# DROP USER nombre_usuario
    drop user ana@localhost;


# MODIFICACIÓN DE USUARIOS
# cambiar nombre
# RENAME USER nombre_usuario to nuevo_nombre
    rename user ana@localhost to santa_paciencia@localhost;


# cambiar contraseña
# alter user nombre_usuario@host identified by 'nueva_password';
    alter user santa_paciencia@localhost identified by '6666';


# PRIVILEGIOS

# ver los privilegios (permisos) de un usuario
    show grants for root@localhost;
    show grants for santa_paciencia@localhost;

# para dar privilegios utilizaremos el comando GRANT
# GRANT tipo_privilegio
# ON base_datos.nombre_tabla
    # -> si quieres dar los privilegios en una base de datos en todas las tablas: bose_datos.*
    # -> si queres dar los privilegios en todas las bases de datos *.*
# TO nombre_usuario;


# TIPO_PRIVILEGIO puede ser: ALL PRIVILEGES, ALTER, CREATE, CREATE USER, CREATE VIEW, DELETE, DROP, EXECUTE, INSERT, SELECT, SHOW DATABASES, SHOW VIEW, UPDATE...
grant all privileges
on *.*
to santa_paciencia@localhost;


# ahora puedo crear una conexión con los mismos privilegios que tiene el usuario root

# quitar permisos (privilegios)

/*
REVOKE tipo_privilegio
ON base_de_datos.tabla
FROM nombre_usuario@host;
*/
/*
revoke application_password_admin
on *.*
from santa_paciencia@locahost;
 */
