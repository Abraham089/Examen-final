CREATE TABLE `trabajadores` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `apellido` varchar(255),
  `email` varchar(255) UNIQUE,
  `telefono` varchar(255),
  `puesto` varchar(255)
);

CREATE TABLE `tareas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `descripcion` varchar(255),
  `fecha_limite` date,
  `id_estados` int,
  `id_proyectos` int,
  `id_rack_afectado` int,
  `id_producto_relacionado` int
);

CREATE TABLE `estados` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255)
);

CREATE TABLE `asignaciones` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` int,
  `id_tareas` int,
  `fecha_asignacion` date
);

CREATE TABLE `proyectos` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `fecha_inicio` date,
  `fecha_final` date,
  `descripcion` varchar(255)
);

CREATE TABLE `productos` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `precio_venta` decimal,
  `precio_compra` decimal,
  `stock_total` int
);

CREATE TABLE `racks` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(255) UNIQUE,
  `capacidad_maxima` int,
  `ubicacion_pasillo` varchar(255)
);

CREATE TABLE `producto_racks` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `id_producto` int,
  `id_rack` int,
  `cantidad` int
);

CREATE TABLE `proveedores` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `contacto` varchar(255)
);

CREATE TABLE `compras` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fecha` date,
  `id_proveedor` int,
  `total` decimal
);

CREATE TABLE `detalle_compra` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `id_compra` int,
  `id_producto` int,
  `cantidad` int,
  `precio_unitario` decimal
);

CREATE TABLE `clientes` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `email` varchar(255)
);

CREATE TABLE `ventas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fecha` date,
  `id_cliente` int,
  `total` decimal
);

CREATE TABLE `detalle_venta` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `id_venta` int,
  `id_producto` int,
  `cantidad` int,
  `precio_unitario` decimal
);

ALTER TABLE `tareas` ADD FOREIGN KEY (`id_estados`) REFERENCES `estados` (`id`);

ALTER TABLE `tareas` ADD FOREIGN KEY (`id_proyectos`) REFERENCES `proyectos` (`id`);

ALTER TABLE `tareas` ADD FOREIGN KEY (`id_rack_afectado`) REFERENCES `racks` (`id`);

ALTER TABLE `tareas` ADD FOREIGN KEY (`id_producto_relacionado`) REFERENCES `productos` (`id`);

ALTER TABLE `asignaciones` ADD FOREIGN KEY (`id_usuario`) REFERENCES `trabajadores` (`id`);

ALTER TABLE `asignaciones` ADD FOREIGN KEY (`id_tareas`) REFERENCES `tareas` (`id`);

ALTER TABLE `producto_racks` ADD FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

ALTER TABLE `producto_racks` ADD FOREIGN KEY (`id_rack`) REFERENCES `racks` (`id`);

ALTER TABLE `compras` ADD FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`);

ALTER TABLE `detalle_compra` ADD FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`);

ALTER TABLE `detalle_compra` ADD FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

ALTER TABLE `ventas` ADD FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`);

ALTER TABLE `detalle_venta` ADD FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`);

ALTER TABLE `detalle_venta` ADD FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

-- Roles
CREATE ROLE 'rol_almacenista';
CREATE ROLE 'rol_auditor';

GRANT SELECT, INSERT, UPDATE ON logistore_db.* TO 'rol_almacenista';

GRANT SELECT ON logistore_db.* TO 'rol_auditor';

CREATE USER 'pepe_almacen'@'%' IDENTIFIED BY 'pass_pepe123';
CREATE USER 'ana_auditoria'@'%' IDENTIFIED BY 'pass_ana123';
CREATE USER 'admin_suplente'@'%' IDENTIFIED BY 'pass_admin123';

GRANT 'rol_almacenista' TO 'pepe_almacen'@'%';
GRANT 'rol_auditor' TO 'ana_auditoria'@'%';

GRANT ALL PRIVILEGES ON logistore_db.* TO 'admin_suplente'@'%';

SET DEFAULT ROLE ALL TO 'pepe_almacen'@'%';
SET DEFAULT ROLE ALL TO 'ana_auditoria'@'%';

FLUSH PRIVILEGES;