# EJEMPLOS DE PROCEDIMIENTOS EN LA BASE DE DATOS TIENDA
USE tienda;

# 1) Procedimiento sin parámetros: muestra el contenido de la tabla fabricante
    DELIMITER $$
    DROP PROCEDURE IF EXISTS proc_fabricantes;
    -- creamos el procedimiento:
    CREATE PROCEDURE proc_fabricantes()
    BEGIN
        -- AQUÍ PONGO EL CONTENIDO DEL PROCEDIMIENTO
        SELECT * FROM fabricante;
    end $$;

# PARA LLAMAR A UN PROCEDIMIENTO SE HACE ASÍ:
    DELIMITER ;
    CALL proc_fabricantes();

# 2) Procedimiento con un parámetro: buscar el nombre de un fabricante pasándole el código
    DELIMITER $$;
    DROP PROCEDURE IF EXISTS proc_buscar_fabricante;
    CREATE PROCEDURE proc_buscar_fabricante(codigo int unsigned)
    BEGIN
        SELECT nombre FROM fabricante
            WHERE id = codigo;
    end $$;

# buscamos al fabricante con id 5
    DELIMITER ;
    CALL proc_buscar_fabricante(5);

# 3) Procedimiento: inserta un fabricante pasándo el nombre. Ejemplo: Dell, Apple
    DELIMITER $$;
    DROP PROCEDURE IF EXISTS proc_insertar_fabricante;
    CREATE PROCEDURE proc_insertar_fabricante(nombre_fabricante varchar(100))
    BEGIN
        INSERT INTO fabricante (nombre) VALUES (nombre_fabricante);
    end $$;

    # INSERTAMOS DOS FABRICANTES
    DELIMITER ;
    CALL proc_insertar_fabricante('Dell');
    CALL proc_insertar_fabricante('Apple');
