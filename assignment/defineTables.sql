/*
=====================================
SIS-122 BASES DE DATOS
Profesor: 
    - Ismael Antonio Delgado Huanca

Estudiante:
    - Cesar Sebastian Zambrana Ventura
=====================================
*/

CREATE TABLE IF NOT EXISTS estudiantes
( 
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(50),
    carrera VARCHAR(50),
    edad INT 
);


CREATE TABLE IF NOT EXISTS profesores
(
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(50),
    departamento VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS cursos
( 
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(50),
    id_profesor INT
);

CREATE TABLE IF NOT EXISTS inscripciones
(
    id_inscripcion INT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    nota Decimal(10,2)
);
