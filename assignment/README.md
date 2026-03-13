# Assignment: Consultas SQL

Guía de ejercicios para practicar `SELECT`, filtros, `INSERT`, `UPDATE`, `JOIN`, `GROUP BY` y consultas avanzadas sobre el esquema de la tarea.

## Esquema base

Tablas usadas en esta práctica:

- `estudiantes(id_estudiante, nombre, carrera, edad)`
- `profesores(id_profesor, nombre, departamento)`
- `cursos(id_curso, nombre, id_profesor)`
- `inscripciones(id_inscripcion, id_estudiante, id_curso, nota)`

Archivo de referencia del esquema: [`defineTables.sql`](/home/cszv/cesarszv/resources/ucb-lia/[1-2026] [SIS-122] databases 1 (1)/assignments/20260313/assignment/defineTables.sql)

## Progreso

### 1. SELECT básicos

- [x] 1. Mostrar todos los estudiantes.
- [x] 2. Mostrar nombre y carrera de los estudiantes.
- [x] 3. Mostrar estudiantes mayores de 20 años.
- [x] 4. Mostrar cursos ordenados alfabéticamente.
- [x] 5. Mostrar profesores del departamento `"Informática"`.

Referencia: [`from1to5.sql`](/home/cszv/cesarszv/resources/ucb-lia/[1-2026] [SIS-122] databases 1 (1)/assignments/20260313/assignment/from1to5.sql)

### 2. Filtros

- [x] 6. Mostrar estudiantes de la carrera `"Ingeniería"`.
- [x] 7. Mostrar estudiantes entre 18 y 22 años.
- [x] 8. Mostrar cursos cuyo nombre empiece con `"B"`.
- [x] 9. Mostrar profesores cuyo nombre contenga `"a"`.
- [x] 10. Mostrar estudiantes ordenados por edad descendente.

Referencia: [`from6to10.sql`](/home/cszv/cesarszv/resources/ucb-lia/[1-2026] [SIS-122] databases 1 (1)/assignments/20260313/assignment/from6to10.sql)

### 3. INSERT

- [x] 11. Insertar un estudiante nuevo.
- [x] 12. Insertar un nuevo profesor.
- [x] 13. Insertar un curso nuevo.
- [x] 14. Insertar una inscripción de un estudiante en un curso.

Referencia: [`from11to14.sql`](/home/cszv/cesarszv/resources/ucb-lia/[1-2026] [SIS-122] databases 1 (1)/assignments/20260313/assignment/from11to14.sql)

### 4. UPDATE

- [ ] 15. Actualizar la edad de un estudiante.
- [ ] 16. Cambiar la carrera de un estudiante.
- [ ] 17. Cambiar el departamento de un profesor.
- [ ] 18. Actualizar la nota de una inscripción.

### 5. JOIN

- [ ] 19. Mostrar cursos con el nombre del profesor.
- [ ] 20. Mostrar estudiantes y cursos en los que están inscritos.
- [ ] 21. Mostrar estudiante, curso y nota obtenida.
- [ ] 22. Mostrar todos los cursos con el número de estudiantes inscritos.

### 6. GROUP BY

- [ ] 23. Mostrar el promedio de notas por curso.
- [ ] 24. Mostrar la cantidad de estudiantes por carrera.
- [ ] 25. Mostrar la nota máxima por curso.

### 7. Consultas avanzadas

- [ ] 26. Mostrar el estudiante con la nota más alta en cada curso.
- [ ] 27. Mostrar el curso con el mayor promedio de notas.
- [ ] 28. Mostrar el estudiante con la nota más alta de toda la universidad.
- [ ] 29. Mostrar el profesor cuyo curso tiene más estudiantes inscritos.
- [ ] 30. Mostrar el estudiante que tiene el promedio de notas más alto.

## Ejemplos de referencia

### INSERT de estudiante

```sql
INSERT INTO estudiantes (id_estudiante, nombre, carrera, edad)
VALUES (1, 'Ana Lopez', 'Informatica', 20);
```

### UPDATE de edad

```sql
UPDATE estudiantes
SET edad = 23
WHERE id_estudiante = 1;
```

### JOIN entre cursos y profesores

```sql
SELECT c.nombre, p.nombre
FROM cursos c
JOIN profesores p
  ON c.id_profesor = p.id_profesor;
```

### Promedio por curso

```sql
SELECT id_curso, AVG(nota)
FROM inscripciones
GROUP BY id_curso;
```

## Pistas

- `22.` Usa `COUNT()` para contar estudiantes por curso.
- `25.` Usa `MAX()` para obtener la nota más alta por curso.
- `26.` Combina `MAX(nota)` con `GROUP BY` o una subconsulta.
- `28.` Usa una subconsulta con `MAX()`.
- `30.` Usa `AVG(nota)` con `GROUP BY`.
