/*
=====================================
SIS-122 BASES DE DATOS
Profesor: 
    - Ismael Antonio Delgado Huanca

Estudiante:
    - Cesar Sebastian Zambrana Ventura
=====================================
*/

---

Estudiantes ( 
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(50),
    carrera VARCHAR(50),
    edad INT 
);


Profesores (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(50),
    departamento VARCHAR(50)
);


Cursos ( 
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(50),
    idProfesor INT
);

Inscripciones (
    id_inscripcion INT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    nota Decimal(10,2)
);


