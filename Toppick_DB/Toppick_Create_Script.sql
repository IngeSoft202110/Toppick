-- MySQL Script generated by MySQL Workbench
-- Fri May 14 18:13:38 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET FOREIGN_KEY_CHECKS = "ON";

-- -----------------------------------------------------
-- Schema Toppick_Schema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Toppick_Schema` ;

-- -----------------------------------------------------
-- Schema Toppick_Schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Toppick_Schema` DEFAULT CHARACTER SET utf8 ;
USE `Toppick_Schema` ;

-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Usuario` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombreUsuario` VARCHAR(50) NOT NULL,
  `contraseña` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE INDEX `nombreUsuario_UNIQUE` (`nombreUsuario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Cliente` (
  `IdCliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCompleto` VARCHAR(30) NOT NULL,
  `tipoDocumento` VARCHAR(2) NOT NULL,
  `idDocumento` BIGINT(11) NOT NULL,
  `celular` BIGINT(11) NOT NULL,
  `token` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`IdCliente`),
  UNIQUE INDEX `IdCliente_UNIQUE` (`IdCliente` ASC),
  UNIQUE INDEX `celular_UNIQUE` (`celular` ASC),
  CONSTRAINT `fk_Cliente_Usuario`
    FOREIGN KEY (`IdCliente`)
    REFERENCES `Toppick_Schema`.`Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 25;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`MétodoDePago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`MétodoDePago` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`MétodoDePago` (
  `idMetodo` INT NOT NULL AUTO_INCREMENT,
  `Cliente_IdCliente` INT NOT NULL,
  `saldoTotal` INT(8) NOT NULL,
  PRIMARY KEY (`idMetodo`, `Cliente_IdCliente`),
  INDEX `fk_MétodoDePago_Cliente` (`Cliente_IdCliente` ASC),
  CONSTRAINT `fk_MétodoDePago_Cliente`
    FOREIGN KEY (`Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Nequi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Nequi` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Nequi` (
  `MétodoDePago_Cliente_IdCliente` INT NOT NULL,
  `numeroCelular` BIGINT(11) NOT NULL,
  PRIMARY KEY (`numeroCelular`),
  INDEX `fk_Nequi_MétodoDePago_idx` (`MétodoDePago_Cliente_IdCliente` ASC),
  CONSTRAINT `fk_Nequi_MétodoDePago`
    FOREIGN KEY (`MétodoDePago_Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`MétodoDePago` (`Cliente_IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`PSE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`PSE` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`PSE` (
  `MétodoDePago_Cliente_IdCliente` INT NOT NULL,
  `numeroCuenta` BIGINT(12) NOT NULL,
  PRIMARY KEY (`numeroCuenta`),
  INDEX `fk_PSE_MétodoDePago_idx` (`MétodoDePago_Cliente_IdCliente` ASC),
  CONSTRAINT `fk_PSE_MétodoDePago`
    FOREIGN KEY (`MétodoDePago_Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`MétodoDePago` (`Cliente_IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Daviplata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Daviplata` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Daviplata` (
  `MétodoDePago_Cliente_IdCliente` INT NOT NULL,
  `numeroCelular` BIGINT(11) NOT NULL,
  PRIMARY KEY (`numeroCelular`),
  INDEX `fk_Daviplata_MétodoDePago_idx` (`MétodoDePago_Cliente_IdCliente` ASC),
  CONSTRAINT `fk_Daviplata_MétodoDePago`
    FOREIGN KEY (`MétodoDePago_Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`MétodoDePago` (`Cliente_IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Producto` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(60) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `precio` INT(6) NOT NULL,
  `tiempoPreparacion` INT(2) NOT NULL,
  `calificacion` FLOAT NULL,
  `urlImagen` VARCHAR(100) NULL DEFAULT NULL,
  `categoria` VARCHAR(18) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProducto`),
  UNIQUE INDEX `idProducto_UNIQUE` (`idProducto` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Combo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Combo` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Combo` (
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`Producto_idProducto`),
  INDEX `fk_Combo_Producto_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_Combo_Producto`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`ProductoXCombo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`ProductoXCombo` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`ProductoXCombo` (
  `Combo_Producto_idProducto` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`Combo_Producto_idProducto`, `Producto_idProducto`),
  INDEX `fk_Producto_X_Combo_Producto_idProducto_idx` (`Combo_Producto_idProducto` ASC),
  INDEX `fk_Producto_X_Combo_Producto_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_Producto_X_Combo_Producto`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_X_Combo_Combo`
    FOREIGN KEY (`Combo_Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Combo` (`Producto_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`PuntoDeVenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`PuntoDeVenta` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`PuntoDeVenta` (
  `idPuntodeVenta` INT NOT NULL AUTO_INCREMENT,
  `nombrePuntoDeVenta` VARCHAR(18) NOT NULL,
  `tipoPuntoVenta` VARCHAR(15) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `urlUbicacion` VARCHAR(100) NOT NULL,
  `Estado` VARCHAR(12) NOT NULL,
  `calificacion` FLOAT NULL,
  `urlImagen` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idPuntodeVenta`),
  UNIQUE INDEX `idPuntodeVenta_UNIQUE` (`idPuntodeVenta` ASC),
  CONSTRAINT `fk_PuntoDeVenta_Usuario`
    FOREIGN KEY (`idPuntodeVenta`)
    REFERENCES `Toppick_Schema`.`Usuario` (`IdUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Pedido` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `PuntoDeVenta_idPuntodeVenta` INT NOT NULL,
  `Cliente_IdCliente` INT NOT NULL,
  `fechaCreacion` DATETIME NOT NULL,
  `costoTotal` INT(6) NOT NULL,
  `fechaReclamo` DATETIME NOT NULL,
  `estadoPedido` VARCHAR(10) NOT NULL,
  `razonRechazo` VARCHAR(200) NULL,
  PRIMARY KEY (`idPedido`, `PuntoDeVenta_idPuntodeVenta`, `Cliente_IdCliente`),
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC),
  INDEX `fk_Pedido_Cliente_idx` (`Cliente_IdCliente` ASC),
  INDEX `fk_Pedido_PuntoDeVenta_idx` (`PuntoDeVenta_idPuntodeVenta` ASC),
  CONSTRAINT `fk_Pedido_Cliente`
    FOREIGN KEY (`Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_PuntoDeVenta`
    FOREIGN KEY (`PuntoDeVenta_idPuntodeVenta`)
    REFERENCES `Toppick_Schema`.`PuntoDeVenta` (`idPuntodeVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Carrito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Carrito` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Carrito` (
  `Producto_idProducto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `CantidadProducto` INT(2) NOT NULL,
  `comentario` VARCHAR(500) NULL,
  PRIMARY KEY (`Producto_idProducto`, `Pedido_idPedido`),
  INDEX `fk_Carrito_Producto_idx` (`Producto_idProducto` ASC),
  INDEX `fk_Carrito_Pedido_idx` (`Pedido_idPedido` ASC),
  CONSTRAINT `fk_Carrito_Producto`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carrito_Pedido`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Toppick_Schema`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Catalogo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Catalogo` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Catalogo` (
  `PuntoDeVenta_idPuntodeVenta` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `inventario` INT(3) NOT NULL,
  PRIMARY KEY (`Producto_idProducto`, `PuntoDeVenta_idPuntodeVenta`),
  INDEX `fk_Catalogo_PuntoDeVenta_idx` (`PuntoDeVenta_idPuntodeVenta` ASC),
  INDEX `fk_Catalogo_Producto_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_Catalogo_PuntoDeVenta`
    FOREIGN KEY (`PuntoDeVenta_idPuntodeVenta`)
    REFERENCES `Toppick_Schema`.`PuntoDeVenta` (`idPuntodeVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Catalogo_Producto`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Día`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Día` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Día` (
  `idDía` INT NOT NULL AUTO_INCREMENT,
  `nombreDia` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idDía`),
  UNIQUE INDEX `idDía_UNIQUE` (`idDía` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`HoraApertura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`HoraApertura` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`HoraApertura` (
  `idHoraApertura` INT NOT NULL AUTO_INCREMENT,
  `horaApertura` TIME NOT NULL,
  PRIMARY KEY (`idHoraApertura`),
  UNIQUE INDEX `idHoraApertura_UNIQUE` (`idHoraApertura` ASC),
  UNIQUE INDEX `horaApertura_UNIQUE` (`horaApertura` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`HoraCierre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`HoraCierre` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`HoraCierre` (
  `idHoraCierre` INT NOT NULL AUTO_INCREMENT,
  `horaCierre` TIME NOT NULL,
  PRIMARY KEY (`idHoraCierre`),
  UNIQUE INDEX `idHoraApertura_UNIQUE` (`idHoraCierre` ASC),
  UNIQUE INDEX `horaApertura_UNIQUE` (`horaCierre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Horario` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Horario` (
  `idHorario` INT NOT NULL AUTO_INCREMENT,
  `HoraApertura_idHoraApertura` INT NOT NULL,
  `HoraCierre_idHoraCierre` INT NOT NULL,
  PRIMARY KEY (`idHorario`, `HoraApertura_idHoraApertura`, `HoraCierre_idHoraCierre`),
  INDEX `fk_Horario_HoraApertura1_idx` (`HoraApertura_idHoraApertura` ASC),
  INDEX `fk_Horario_HoraCierre1_idx` (`HoraCierre_idHoraCierre` ASC),
  UNIQUE INDEX `idHorario_UNIQUE` (`idHorario` ASC),
  CONSTRAINT `fk_Horario_HoraApertura1`
    FOREIGN KEY (`HoraApertura_idHoraApertura`)
    REFERENCES `Toppick_Schema`.`HoraApertura` (`idHoraApertura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Horario_HoraCierre1`
    FOREIGN KEY (`HoraCierre_idHoraCierre`)
    REFERENCES `Toppick_Schema`.`HoraCierre` (`idHoraCierre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`CierredeCaja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`CierredeCaja` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`CierredeCaja` (
  `idCierredeCaja` INT NOT NULL AUTO_INCREMENT,
  `PuntoDeVenta_idPuntodeVenta` INT NOT NULL,
  `fehaCierre` DATETIME NOT NULL,
  `totalVentasDia` BIGINT(9) NOT NULL,
  PRIMARY KEY (`idCierredeCaja`, `PuntoDeVenta_idPuntodeVenta`),
  INDEX `fk_CierredeCaja_PuntoDeVenta_idx` (`PuntoDeVenta_idPuntodeVenta` ASC),
  UNIQUE INDEX `idCierredeCaja_UNIQUE` (`idCierredeCaja` ASC),
  CONSTRAINT `fk_CierredeCaja_PuntoDeVenta`
    FOREIGN KEY (`PuntoDeVenta_idPuntodeVenta`)
    REFERENCES `Toppick_Schema`.`PuntoDeVenta` (`idPuntodeVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`ProductosMasVendidosXDia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`ProductosMasVendidosXDia` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`ProductosMasVendidosXDia` (
  `CierredeCaja_idCierredeCaja` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `Unidades` INT(4) NOT NULL,
  PRIMARY KEY (`CierredeCaja_idCierredeCaja`, `Producto_idProducto`),
  INDEX `fk_ProductosMasVendidosXDia_Producto_idx` (`Producto_idProducto` ASC),
  INDEX `fk_ProductosMasVendidosXDia_CierredeCaja_idx` (`CierredeCaja_idCierredeCaja` ASC),
  CONSTRAINT `fk_ProductosMasVendidosXDia_CierredeCaja`
    FOREIGN KEY (`CierredeCaja_idCierredeCaja`)
    REFERENCES `Toppick_Schema`.`CierredeCaja` (`idCierredeCaja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductosMasVendidosXDia_Producto`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`ProductosMasIngresosXDia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`ProductosMasIngresosXDia` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`ProductosMasIngresosXDia` (
  `CierredeCaja_idCierredeCaja` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `totalIngresosProducto` INT(8) NOT NULL,
  PRIMARY KEY (`CierredeCaja_idCierredeCaja`, `Producto_idProducto`),
  INDEX `fk_ProductosMasIngresosXDia_Producto_idx` (`Producto_idProducto` ASC),
  INDEX `fk_ProductosMasIngresosXDia_CierredeCaja_idx` (`CierredeCaja_idCierredeCaja` ASC),
  CONSTRAINT `fk_ProductosMasIngresosXDia_CierredeCaja`
    FOREIGN KEY (`CierredeCaja_idCierredeCaja`)
    REFERENCES `Toppick_Schema`.`CierredeCaja` (`idCierredeCaja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductosMasIngresosXDia_Producto`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`ReseñaPuntoDeVenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`ReseñaPuntoDeVenta` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`ReseñaPuntoDeVenta` (
  `idReseña` INT NOT NULL AUTO_INCREMENT,
  `Cliente_IdCliente` INT NOT NULL,
  `PuntoDeVenta_idPuntodeVenta` INT NOT NULL,
  `calificacion` INT(1) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idReseña`),
  INDEX `fk_Reseña_Cliente_idx` (`Cliente_IdCliente` ASC),
  INDEX `fk_Reseña_PuntoDeVenta_idx` (`PuntoDeVenta_idPuntodeVenta` ASC),
  CONSTRAINT `fk_Reseña_Cliente`
    FOREIGN KEY (`Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reseña_PuntoDeVenta`
    FOREIGN KEY (`PuntoDeVenta_idPuntodeVenta`)
    REFERENCES `Toppick_Schema`.`PuntoDeVenta` (`idPuntodeVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`PuntoDeVentaXHorario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`PuntoDeVentaXHorario` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`PuntoDeVentaXHorario` (
  `PuntoDeVenta_idPuntodeVenta` INT NOT NULL,
  `Horario_idHorario` INT NOT NULL,
  `Día_idDía` INT NOT NULL,
  PRIMARY KEY (`PuntoDeVenta_idPuntodeVenta`, `Horario_idHorario`, `Día_idDía`),
  INDEX `fk_PuntoDeVentaXHorario_PuntoDeVenta_idx` (`PuntoDeVenta_idPuntodeVenta` ASC),
  INDEX `fk_PuntoDeVentaXHorario_Horario_idx` (`Horario_idHorario` ASC),
  INDEX `fk_PuntoDeVentaXHorario_Día1_idx` (`Día_idDía` ASC),
  CONSTRAINT `fk_PuntoDeVentaXHorario_PuntoDeVenta`
    FOREIGN KEY (`PuntoDeVenta_idPuntodeVenta`)
    REFERENCES `Toppick_Schema`.`PuntoDeVenta` (`idPuntodeVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PuntoDeVentaXHorario_Horario1`
    FOREIGN KEY (`Horario_idHorario`)
    REFERENCES `Toppick_Schema`.`Horario` (`idHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PuntoDeVentaXHorario_Día1`
    FOREIGN KEY (`Día_idDía`)
    REFERENCES `Toppick_Schema`.`Día` (`idDía`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Especialidad` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Especialidad` (
  `Producto_idProducto` INT NOT NULL,
  `horaInicioDisponibilidad` TIME NOT NULL,
  `horaFinDisponibilidad` TIME NOT NULL,
  PRIMARY KEY (`Producto_idProducto`),
  INDEX `fk_Especialidad_Producto1_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_Especialidad_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`Acompañamiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`Acompañamiento` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`Acompañamiento` (
  `idAcompañamiento` INT NOT NULL AUTO_INCREMENT,
  `nombreAcompañamiento` VARCHAR(20) NOT NULL,
  `tipo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idAcompañamiento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`AcompañamientoXEspecialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`AcompañamientoXEspecialidad` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`AcompañamientoXEspecialidad` (
  `Especialidad_Producto_idProducto` INT NOT NULL,
  `Acompañamiento_idAcompañamiento` INT NOT NULL,
  PRIMARY KEY (`Especialidad_Producto_idProducto`, `Acompañamiento_idAcompañamiento`),
  INDEX `fk_AcompañamientoXEspecialidad_Acompañamiento1_idx` (`Acompañamiento_idAcompañamiento` ASC),
  INDEX `fk_AcompañamientoXEspecialidad_Especialidad1_idx` (`Especialidad_Producto_idProducto` ASC),
  CONSTRAINT `fk_AcompañamientoXEspecialidad_Acompañamiento1`
    FOREIGN KEY (`Acompañamiento_idAcompañamiento`)
    REFERENCES `Toppick_Schema`.`Acompañamiento` (`idAcompañamiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AcompañamientoXEspecialidad_Especialidad1`
    FOREIGN KEY (`Especialidad_Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Especialidad` (`Producto_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`AcompañamientoXSeleccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`AcompañamientoXSeleccion` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`AcompañamientoXSeleccion` (
  `Especialidad_Producto_idProducto` INT NOT NULL,
  `Acompañamiento_idAcompañamiento` INT NOT NULL,
  `Carrito_Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`Especialidad_Producto_idProducto`, `Acompañamiento_idAcompañamiento`, `Carrito_Pedido_idPedido`),
  INDEX `fk_AcompañamientoXSeleccion_Acompañamiento1_idx` (`Acompañamiento_idAcompañamiento` ASC),
  INDEX `fk_AcompañamientoXSeleccion_Carrito1_idx` (`Carrito_Pedido_idPedido` ASC),
  CONSTRAINT `fk_AcompañamientoXSeleccion_Especialidad1`
    FOREIGN KEY (`Especialidad_Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Especialidad` (`Producto_idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AcompañamientoXSeleccion_Acompañamiento1`
    FOREIGN KEY (`Acompañamiento_idAcompañamiento`)
    REFERENCES `Toppick_Schema`.`Acompañamiento` (`idAcompañamiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AcompañamientoXSeleccion_Carrito1`
    FOREIGN KEY (`Carrito_Pedido_idPedido`)
    REFERENCES `Toppick_Schema`.`Carrito` (`Pedido_idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`ReseñaProducto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`ReseñaProducto` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`ReseñaProducto` (
  `idReseña` INT NOT NULL AUTO_INCREMENT,
  `Cliente_IdCliente` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `calificacion` INT(1) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idReseña`, `Cliente_IdCliente`),
  INDEX `fk_Reseña_Cliente_idx` (`Cliente_IdCliente` ASC),
  INDEX `fk_Reseña_Producto_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_Reseña_Cliente0`
    FOREIGN KEY (`Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reseña_Producto0`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Toppick_Schema`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toppick_Schema`.`PedidoFavorito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Toppick_Schema`.`PedidoFavorito` ;

CREATE TABLE IF NOT EXISTS `Toppick_Schema`.`PedidoFavorito` (
  `Cliente_IdCliente` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `nombrePedido` VARCHAR(20) NOT NULL,
  INDEX `fk_PedidoFavorito_Cliente1_idx` (`Cliente_IdCliente` ASC),
  INDEX `fk_PedidoFavorito_Pedido1_idx` (`Pedido_idPedido` ASC),
  PRIMARY KEY (`Cliente_IdCliente`, `Pedido_idPedido`),
  CONSTRAINT `fk_PedidoFavorito_Cliente1`
    FOREIGN KEY (`Cliente_IdCliente`)
    REFERENCES `Toppick_Schema`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PedidoFavorito_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Toppick_Schema`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;