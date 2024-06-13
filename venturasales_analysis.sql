-- Crear tabla de datos sintéticos
CREATE TABLE ContactosVenturaSales (
    ClienteID INTEGER PRIMARY KEY,
    FechaContacto DATE,
    CanalContacto TEXT,
    ProductoInteres TEXT,
    EstadoCliente TEXT
);

INSERT INTO ContactosVenturaSales (ClienteID, FechaContacto, CanalContacto, ProductoInteres, EstadoCliente) VALUES
(1, '2023-05-10', 'Correo electrónico', 'Servicios de Consultoría', 'Cliente potencial'),
(2, '2023-05-15', 'Llamada telefónica', 'Soluciones de Software', 'Cliente activo'),
(3, '2023-06-02', 'Reunión en persona', 'Servicios de Consultoría', 'Cliente potencial'),
(4, '2023-06-20', 'Correo electrónico', 'Soluciones de Software', 'Cliente potencial'),
(5, '2023-07-10', 'Correo electrónico', 'Soluciones de Software', 'Cliente activo'),
(6, '2023-07-15', 'Llamada telefónica', 'Servicios de Consultoría', 'Cliente cerrado'),
(7, '2023-08-01', 'Correo electrónico', 'Servicios de Consultoría', 'Cliente potencial'),
(8, '2023-08-25', 'Reunión en persona', 'Soluciones de Software', 'Cliente activo'),
(9, '2023-09-05', 'Llamada telefónica', 'Servicios de Consultoría', 'Cliente potencial'),
(10, '2023-09-20', 'Correo electrónico', 'Servicios de Consultoría', 'Cliente activo');

-- 1. Canal de contacto más efectivo para conversión
SELECT CanalContacto, COUNT(*) as CantidadContactos, 
       ROUND(CAST(SUM(CASE WHEN EstadoCliente = 'Cliente activo' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS PorcentajeConversion
FROM ContactosVenturaSales
GROUP BY CanalContacto
ORDER BY PorcentajeConversion DESC
LIMIT 1;

-- 2. Productos con mayor interés
SELECT ProductoInteres, COUNT(*) as CantidadInteres
FROM ContactosVenturaSales
GROUP BY ProductoInteres
ORDER BY CantidadInteres DESC
LIMIT 3;

-- 3. Relación entre fecha de contacto y conversión
SELECT FechaContacto, EstadoCliente, COUNT(*) as Cantidad
FROM ContactosVenturaSales
GROUP BY FechaContacto, EstadoCliente
ORDER BY FechaContacto;

-- 4. Estados de cliente más comunes después del contacto
SELECT EstadoCliente, COUNT(*) as Cantidad
FROM ContactosVenturaSales
GROUP BY EstadoCliente
ORDER BY Cantidad DESC;

-- 5. Patrones estacionales en las interacciones
SELECT strftime('%m', FechaContacto) as Mes, COUNT(*) as CantidadInteracciones
FROM ContactosVenturaSales
GROUP BY Mes
ORDER BY Mes;

