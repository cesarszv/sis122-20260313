-- FILTROS

-- 6. Mostrar estudiantes de la carrera "Ingenieria"
SELECT nombre, carrera
FROM Estudiantes
WHERE carrera = `Ingenieria`;

-- 7. Mostrar estudiantes entre 18 y 22 años.
SELECT nombre, edad
FROM Estudiantes
WHERE edad BETWEEN 18 AND 22;

-- 8. Mostrar cuyos nombres comienzan con "B".
SELECT nombre
FROM Estudiantes
WHERE nombre LIKE 'B%'
UNION 
SELECT nombre
From Profesores;
WHERE nombre = 'B%';

-- 9. Mostrar profesores cuyo nombre contenga "a"
SELECT nombre
FROM Profesores
WHERE nombre LIKE '%a%';

-- 10. Mostrar estudiantes ordenados por edad descendente.
SELECT nombre, edad
FROM Estudiantes
ORDER BY edad DESC 