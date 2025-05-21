-- ============================================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS
-- Autores: Dennis Serrano Barquero
--          Adrián Alvarado Zumbado
--          Alexis David Sandoval Calvo
--          Stheven Andrés Bolaños Bolaños
-- Proyecto: Sumo Sushi – Gestión de Pedidos
-- Entorno: MySQL 8.0, MySQL Workbench
-- ============================================================================

-- 1) Eliminamos la base de datos si ya existe y la volvemos a crear
DROP DATABASE IF EXISTS SumoSushiDB;
CREATE DATABASE SumoSushiDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
USE SumoSushiDB;

-- ============================================================================ 
-- 2) Tablas de configuración y catálogos básicos
-- ============================================================================

-- 2.1) Tipos de Entidad (para auditoría y estados generales)
CREATE TABLE TipoEntidad (
  IdTipoEntidad SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(50)       NOT NULL,
  CONSTRAINT PK_TipoEntidad PRIMARY KEY (IdTipoEntidad)
) ENGINE=InnoDB;

-- 2.2) Estados genéricos
CREATE TABLE Estados (
  IdEstado    SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(50)       NOT NULL,
  CONSTRAINT PK_Estados PRIMARY KEY (IdEstado)
) ENGINE=InnoDB;

-- 2.3) Estados que puede tener una entidad
CREATE TABLE EstadosEntidades (
  IdEstado       SMALLINT UNSIGNED NOT NULL,
  IdTipoEntidad  SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (IdEstado, IdTipoEntidad),
  FOREIGN KEY (IdEstado)      REFERENCES Estados(IdEstado)      ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoEntidad) REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 2.4) Distritos (para direcciones de usuario)
CREATE TABLE Distritos (
  IdDistrito SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre     VARCHAR(50)       NOT NULL,
  PRIMARY KEY (IdDistrito)
) ENGINE=InnoDB;

-- 2.5) Días de la semana (para horarios de restaurante)
CREATE TABLE Dias (
  IdDia TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(20)       NOT NULL,
  PRIMARY KEY (IdDia)
) ENGINE=InnoDB;

-- 2.6) Roles de usuario
CREATE TABLE Roles (
  IdRol      SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(50)      NOT NULL,
  PRIMARY KEY (IdRol)
) ENGINE=InnoDB;

-- 2.7) Tipos de pedido (recogida o exprés)
CREATE TABLE TiposPedidos (
  IdTipoPedido TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion  VARCHAR(50)      NOT NULL,
  PRIMARY KEY (IdTipoPedido)
) ENGINE=InnoDB;

-- 2.8) Métodos de pago
CREATE TABLE MetodoPago (
  IdMetodoPago TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion   VARCHAR(50)     NOT NULL,
  PRIMARY KEY (IdMetodoPago)
) ENGINE=InnoDB;

-- 2.9) Gestión de puntos (configuración global)
CREATE TABLE GestionPuntos (
  IdGestionPuntos         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PuntosMinimosCompra     INT          NOT NULL,
  PuntosMaximosCompra     INT          NOT NULL,
  FactorPuntos            DECIMAL(5,2) NOT NULL COMMENT 'Factor de conversión dinero→puntos',
  PRIMARY KEY (IdGestionPuntos)
) ENGINE=InnoDB;

-- ============================================================================ 
-- 3) Datos de negocio principales
-- ============================================================================

-- 3.1) Restaurante
CREATE TABLE Restaurante (
  IdRestaurante   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre           VARCHAR(100)      NOT NULL,
  Direccion        VARCHAR(200)      NOT NULL,
  Telefono         VARCHAR(20)       NOT NULL,
  Correo           VARCHAR(100)      NOT NULL,
  LogoUrl          VARCHAR(255)      DEFAULT NULL,
  PRIMARY KEY (IdRestaurante)
) ENGINE=InnoDB;

-- 3.2) Horarios del Restaurante
CREATE TABLE HorarioRestaurante (
  IdHorario    INT UNSIGNED NOT NULL AUTO_INCREMENT,
  HoraApertura TIME         NOT NULL,
  HoraCierre   TIME         NOT NULL,
  IdDia        TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (IdHorario),
  FOREIGN KEY (IdDia) REFERENCES Dias(IdDia) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================ 
-- 4) Gestión de usuarios
-- ============================================================================

-- 4.1) Usuarios
CREATE TABLE Usuarios (
  IdUsuario           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Correo               VARCHAR(100)      NOT NULL UNIQUE,
  Nombre               VARCHAR(50)       NOT NULL,
  Apellidos            VARCHAR(50)       NOT NULL,
  PuntosAcumulados     BIGINT UNSIGNED   NOT NULL DEFAULT 0,
  DireccionPrincipal   BIGINT UNSIGNED   DEFAULT NULL,
  IdRol                SMALLINT UNSIGNED NOT NULL,
  IdEstado             SMALLINT UNSIGNED NOT NULL,
  IdTipoEntidad        SMALLINT UNSIGNED NOT NULL,
  FechaCreacion        DATETIME          NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (IdUsuario),
  FOREIGN KEY (DireccionPrincipal) REFERENCES Direcciones(IdDireccion) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (IdRol)         REFERENCES Roles(IdRol)         ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdEstado)      REFERENCES Estados(IdEstado)    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoEntidad) REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4.2) Direcciones de Usuario
CREATE TABLE Direcciones (
  IdDireccion   BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Detalle        VARCHAR(200)      NOT NULL,
  FechaRegistro  DATETIME          NOT NULL DEFAULT CURRENT_TIMESTAMP,
  IdUsuario      BIGINT UNSIGNED   NOT NULL,
  IdDistrito     SMALLINT UNSIGNED NOT NULL,
  IdEstado       SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (IdDireccion),
  FOREIGN KEY (IdUsuario)  REFERENCES Usuarios(IdUsuario)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdDistrito) REFERENCES Distritos(IdDistrito) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdEstado)   REFERENCES Estados(IdEstado)    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4.3) Teléfonos de Usuario (tabla asociativa)
CREATE TABLE TelefonosUsuarios (
  IdUsuario BIGINT UNSIGNED   NOT NULL,
  Telefono  VARCHAR(20)       NOT NULL,
  PRIMARY KEY (IdUsuario, Telefono),
  FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================ 
-- 5) Catálogo de productos y promociones
-- ============================================================================

-- 5.1) Categorías de Producto
CREATE TABLE CategoriaProductos (
  IdCategoria TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion  VARCHAR(50)      NOT NULL,
  PRIMARY KEY (IdCategoria)
) ENGINE=InnoDB;

-- 5.2) Etiquetas
CREATE TABLE Etiquetas (
  IdEtiqueta TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(50)      NOT NULL,
  PRIMARY KEY (IdEtiqueta)
) ENGINE=InnoDB;

-- 5.3) Productos
CREATE TABLE Productos (
  IdProducto       SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre            VARCHAR(100)      NOT NULL,
  Descripcion       VARCHAR(500)      DEFAULT NULL,
  ImagenUrl         VARCHAR(255)      DEFAULT NULL,
  CanjeablePuntos   BIT               NOT NULL DEFAULT b'0',
  IdEstado          SMALLINT UNSIGNED NOT NULL,
  IdCategoria       TINYINT UNSIGNED  NOT NULL,
  IdTipoEntidad     SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (IdProducto),
  FOREIGN KEY (IdEstado)      REFERENCES Estados(IdEstado)    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdCategoria)   REFERENCES CategoriaProductos(IdCategoria) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoEntidad) REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5.4) Etiquetas por Producto (N:M)
CREATE TABLE EtiquetasProductos (
  IdProducto SMALLINT UNSIGNED NOT NULL,
  IdEtiqueta TINYINT UNSIGNED  NOT NULL,
  PRIMARY KEY (IdProducto, IdEtiqueta),
  FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdEtiqueta) REFERENCES Etiquetas(IdEtiqueta) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5.5) Presentaciones (ej. tamaño, presentación especial)
CREATE TABLE Presentacion (
  IdPresentacion TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Descripcion     VARCHAR(100)     NOT NULL,
  PRIMARY KEY (IdPresentacion)
) ENGINE=InnoDB;

-- 5.6) Presentaciones por Producto
CREATE TABLE PresentacionesProducto (
  IdProducto      SMALLINT UNSIGNED NOT NULL,
  IdPresentacion  TINYINT UNSIGNED  NOT NULL,
  Precio           DECIMAL(10,2)     NOT NULL,
  IdEstado         SMALLINT UNSIGNED NOT NULL,
  IdTipoEntidad    SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (IdProducto, IdPresentacion),
  FOREIGN KEY (IdProducto)     REFERENCES Productos(IdProducto) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdPresentacion) REFERENCES Presentacion(IdPresentacion) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdEstado)       REFERENCES Estados(IdEstado)       ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoEntidad)  REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5.7) Promociones
CREATE TABLE Promocion (
  IdPromocion   BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre         VARCHAR(100)      NOT NULL,
  Descripcion    VARCHAR(500)      DEFAULT NULL,
  FechaInicio    DATETIME          NOT NULL,
  FechaFinal     DATETIME          NOT NULL,
  IdProducto     SMALLINT UNSIGNED NOT NULL,
  IdTipoEntidad  SMALLINT UNSIGNED NOT NULL,
  IdEstado       SMALLINT UNSIGNED NOT NULL,
  ImagenUrl      VARCHAR(255)      DEFAULT NULL,
  PRIMARY KEY (IdPromocion),
  FOREIGN KEY (IdProducto)    REFERENCES Productos(IdProducto)   ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoEntidad) REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdEstado)      REFERENCES Estados(IdEstado)      ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================ 
-- 6) Pedidos y detalle de pedidos
-- ============================================================================

-- 6.1) Pedidos (cabecera)
CREATE TABLE Pedidos (
  IdPedido         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  NotaCliente       VARCHAR(500)      DEFAULT NULL,
  PuntosCanjeados   BIGINT UNSIGNED   DEFAULT 0,
  TotalPagado       DECIMAL(10,2)     NOT NULL,
  IdUsuario         BIGINT UNSIGNED   NOT NULL,
  IdTipoPedido      TINYINT UNSIGNED  NOT NULL,
  IdMetodoPago      TINYINT UNSIGNED  NOT NULL,
  IdTipoEntidad     SMALLINT UNSIGNED NOT NULL,
  FechaCreacion     DATETIME          NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (IdPedido),
  FOREIGN KEY (IdUsuario)     REFERENCES Usuarios(IdUsuario)     ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoPedido)  REFERENCES TiposPedidos(IdTipoPedido) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdMetodoPago)  REFERENCES MetodoPago(IdMetodoPago) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoEntidad) REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6.2) Detalles de Pedido (líneas)
CREATE TABLE DetallesPedidos (
  IdPedido        BIGINT UNSIGNED   NOT NULL,
  IdProducto      SMALLINT UNSIGNED NOT NULL,
  IdPresentacion  TINYINT UNSIGNED  NOT NULL,
  IdTipoEntidad   SMALLINT UNSIGNED NOT NULL,
  Precio           DECIMAL(10,2)     NOT NULL,
  NotaCliente      VARCHAR(500)      DEFAULT NULL,
  Cantidad         INT UNSIGNED      NOT NULL DEFAULT 1,
  PRIMARY KEY (IdPedido, IdProducto, IdPresentacion, IdTipoEntidad),
  FOREIGN KEY (IdPedido)       REFERENCES Pedidos(IdPedido)      ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdProducto)     REFERENCES Productos(IdProducto)  ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdPresentacion) REFERENCES Presentacion(IdPresentacion) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (IdTipoEntidad)  REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6.3) Historial de Estados de Pedido
CREATE TABLE HistorialEstadosPedidos (
  IdRegistroEstado BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  IdPedido          BIGINT UNSIGNED NOT NULL,
  IdEstado          SMALLINT UNSIGNED NOT NULL,
  FechaHora         DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (IdRegistroEstado),
  FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdEstado) REFERENCES Estados(IdEstado) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================ 
-- 7) Calificaciones de producto (feedback)
-- ============================================================================

CREATE TABLE CalificacionProducto (
  IdUsuario   BIGINT UNSIGNED   NOT NULL,
  IdProducto  SMALLINT UNSIGNED NOT NULL,
  Calificacion TINYINT UNSIGNED NOT NULL CHECK (Calificacion BETWEEN 1 AND 5),
  Fecha       DATETIME          NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (IdUsuario, IdProducto),
  FOREIGN KEY (IdUsuario)  REFERENCES Usuarios(IdUsuario)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================ 
-- 8) Auditoría de cambios
-- ============================================================================

CREATE TABLE Auditoria (
  IdAuditoria         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  IdTipoEntidad       SMALLINT UNSIGNED NOT NULL,
  IdEntidad           BIGINT UNSIGNED NOT NULL,
  Accion              VARCHAR(20)     NOT NULL COMMENT 'INSERT, UPDATE, DELETE',
  ValorAnterior       VARCHAR(255)    DEFAULT NULL,
  ValorNuevo          VARCHAR(255)    DEFAULT NULL,
  Fecha               DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UsuarioResponsable  VARCHAR(50)     NOT NULL,
  PRIMARY KEY (IdAuditoria),
  FOREIGN KEY (IdTipoEntidad) REFERENCES TipoEntidad(IdTipoEntidad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- FIN DEL SCRIPT
-- ============================================================================