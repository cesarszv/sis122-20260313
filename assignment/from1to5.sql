-- SELECT BASICOS

-- 1. Mostrar todos los estudiantes.
SELECT * FROM estudiantes;

-- 2. Mostrar nombre y carrera de los estudiantes.
SELECT nombre, carrera
FROM estudiantes;

-- 3. Mostrar estudiantes mayores de 20 años.
SELECT nombre, edad
FROM estudiantes
WHERE edad > 20;    

-- 4. Mostrar cursos ordenados alfabéticamente.
SELECT *
FROM cursos
ORDER BY nombre ASC;

-- 5. Mostrar profesores del departamento "Informática".
SELECT nombre,departamento
FROM profesores
WHERE departamento = 'Informatica';
