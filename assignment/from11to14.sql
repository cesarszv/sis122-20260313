/*
INSERTS
*/


-- 11. Insertar un estudiante nuevo.
-- INSERT INTO Estudiantes VALUES ( 1, 'Ana Lopez', 'Informática', 20 );
INSERT INTO estudiantes
(
    id_estudiante, 
    nombre, 
    carrera, 
    edad    
)
VALUES
(1, 'Ana Lopez', 'Informatica', 20);


-- 12. Insertar un nuevo profesor.
INSERT INTO profesores
(
    id_profesor,
    nombre,
    departamento
)
VALUES
(1, 'Ismael Antonio Delgado Huanca', 'Informatica');


-- 13. Insertar un curso nuevo.
INSERT INTO cursos
(
    id_curso,
    nombre,
    id_profesor
)
VALUES
(1, 'Base de datos', 1);


-- 14. Insertar una inscripción de un estudiante en un curso.
INSERT INTO inscripciones
(
    id_inscripcion,
    id_estudiante,
    id_curso    
)
VALUES
(1, 1, 1);
