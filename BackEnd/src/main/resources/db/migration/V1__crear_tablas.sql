
-- Enum para estados
CREATE TYPE estado_enum AS ENUM ('activo', 'inactivo', 'suspendido');

-- Tabla de Estudiantes
CREATE TABLE estudiantes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    direccion TEXT,
    clave VARCHAR(255) NOT NULL,
    estado estado_enum NOT NULL DEFAULT 'activo',
    fecha_registro TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Profesores
CREATE TABLE profesores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    especialidad VARCHAR(100),
    clave VARCHAR(255) NOT NULL,
    estado estado_enum NOT NULL DEFAULT 'activo',
    fecha_contratacion DATE NOT NULL
);

-- Tabla de Cursos
CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    creditos INT NOT NULL,
    profesor_id INT,
    FOREIGN KEY (profesor_id) REFERENCES profesores(id) ON DELETE SET NULL
);

-- Tabla de Matrículas
CREATE TABLE matriculas (
    id SERIAL PRIMARY KEY,
    estudiante_id INT NOT NULL,
    curso_id INT NOT NULL,
    fecha_matricula TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE CASCADE
);

-- Tabla de Calificaciones
CREATE TABLE calificaciones (
    id SERIAL PRIMARY KEY,
    estudiante_id INT NOT NULL,
    curso_id INT NOT NULL,
    nota DECIMAL(5,2) CHECK (nota BETWEEN 0 AND 10),
    fecha_registro TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE CASCADE
);
