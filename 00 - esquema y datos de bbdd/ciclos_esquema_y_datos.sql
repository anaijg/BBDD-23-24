drop database if exists ciclos;
create database ciclos character set utf8mb4;
use ciclos;

create table alumnos(
    cod_mat int unsigned primary key,
    nombre  varchar(40) not null,
    DNI     varchar(10)  not null unique
);

create table ciclos(
cod_c int unsigned primary key,
nom_c varchar(40) not null,
grado varchar(10) not null,
duracion int unsigned);

create table departamentos(
cod_dpto int unsigned primary key ,
nom_dpto varchar(40) not null,
cod_p_jefe int unsigned);

create table profesores(
cod_p int unsigned primary key,
dni varchar(10) not null unique ,
nombre varchar(40) not null,
titulacion varchar(30),
cod_dpto int unsigned not null,
foreign key (cod_dpto) references departamentos(cod_dpto)
on update cascade on delete cascade );

alter table departamentos add constraint
    foreign key (cod_p_jefe) references profesores(cod_p)
on update cascade on delete cascade ;

create table matricula(
cod_mat int unsigned,
cod_c int unsigned,
PRIMARY KEY (cod_mat, cod_c),
FOREIGN KEY (cod_c) references ciclos(cod_c) on update cascade on delete cascade ,
foreign key (cod_mat) references alumnos(cod_mat) on update cascade on delete cascade);

create table modulos(
cod_m int unsigned auto_increment primary key ,
nombre varchar(15) not null ,
horas int unsigned not null ,
cod_c int unsigned,
foreign key (cod_c) references ciclos(cod_c) on delete cascade on update cascade);

create table imparticion(
cod_m int unsigned not null ,
cod_p int unsigned not null ,
num_horas int unsigned not null,
primary key (cod_m, cod_p),
foreign key (cod_m) references modulos(cod_m) on delete cascade on update cascade,
foreign key (cod_p) references profesores(cod_p) on delete cascade on update cascade
);

insert into ciclos values (1, 'ASI', 'SUPERIOR',2);
insert into ciclos values (2, 'DAI', 'SUPERIOR',2);

insert into alumnos values (1, 'DANIEL', '123456');
insert into alumnos values (2, 'DARIO', '234567');
insert into alumnos values (3, 'DELIO', '345678');
insert into alumnos values (4, 'DUCRUET', '456789');
insert into alumnos values (5, 'ANTONIO', '567890');
insert into alumnos values (6, 'ALEJANDRO', '678901');
insert into alumnos values (7, 'ANA', '789012');
insert into alumnos values (8, 'ANALIA', '890123');

insert into matricula values(1,2);
insert into matricula values(2,2);
insert into matricula values(3,2);
insert into matricula values(4,2);
insert into matricula values(5,1);
insert into matricula values(6,1);
insert into matricula values(7,1);
insert into matricula values(8,1);

insert into modulos values (1,'ENTORNO GRAFICO',12,2);
insert into modulos values (2,'4GL Y CLASE',14,2);
insert into modulos values (3,'FOL',5,2);
insert into modulos values (4,'DFSI',8,1);
insert into modulos values (5,'SGBD',10,1);
insert into modulos values (6,'IAIG',12,1);

insert into departamentos values (1,'INFORMATICA',null);
insert into departamentos values (2,'HISTORIA',null);
insert into departamentos values (3,'FISICA Y QUIMICA',null);
insert into departamentos values (4,'MATEMATICAS',null);

insert into profesores values (1, '111111','MARTA BERMUDEZ','LDO. INFORMATICA',1);
insert into profesores values (2, '222222','NURIA MINYANA','LDO. INFORMATICA',1);
insert into profesores values (3, '333333','CARMEN MARTINEZ','LDO. INFORMATICA',1);
insert into profesores values (4, '444444','TERESA VARO','LDO. INFORMATICA',1);
insert into profesores values (5, '555555','ALICIA MARTINEZ','LDO. INFORMATICA',1);
insert into profesores values (6, '666666','JOSE GONZALEZ','LDO. INFORMATICA',1);
insert into profesores values (7, '777777','LAURA PEREZ','LDO. HISTORIA',2);
insert into profesores values (8, '888888','LUIS GONZALEZ','LDO. HISTORIA',2);
insert into profesores values (9, '999999','RAFAEL RUIZ','LDO. MATEMATICAS',4);

insert into imparticion values (1,4,12);
insert into imparticion values (2,1,14);
insert into imparticion values (3,5,5);
insert into imparticion values (4,6,8);
insert into imparticion values (5,2,8);
insert into imparticion values (5,1,2);
insert into imparticion values (6,3,10);
insert into imparticion values (6,6,2);
