CREATE DATABASE IF NOT EXISTS SUPERMERCADO;

CREATE TABLE `PAIS` (
  `Cod_Pais` INT NOT NULL UNIQUE,
  `Nombre_Pais` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Cod_Pais`)
);

CREATE TABLE `PROVINCIA` (
  `Cod_Provincia` INT NOT NULL UNIQUE,
  `Nombre_Provincia` VARCHAR(40) NOT NULL,
  `Cod_Pais` INT NOT NULL,
  PRIMARY KEY (`Cod_Provincia`),
  FOREIGN KEY (`Cod_Pais`) REFERENCES `PAIS`(`Cod_Pais`)
);

CREATE TABLE `CIUDAD` (
  `Cod_Ciudad` INT NOT NULL UNIQUE,
  `Nombre_Ciudad` VARCHAR(40) NOT NULL,
  `Cod_Provincia` INT NOT NULL,
  PRIMARY KEY (`Cod_Ciudad`),
  FOREIGN KEY (`Cod_Provincia`) REFERENCES `PROVINCIA`(`Cod_Provincia`)
);

CREATE TABLE `SUCURSAL` (
  `Cod_Sucursal` INT NOT NULL UNIQUE,
  `Nombre_Sucursal` VARCHAR(40) NOT NULL,
  `Cod_Ciudad` INT NOT NULL,
  PRIMARY KEY (`Cod_Sucursal`),
  FOREIGN KEY (`Cod_Ciudad`) REFERENCES `CIUDAD`(`Cod_Ciudad`)
);

CREATE TABLE `SEXO` (
  `Cod_Sexo` INT NOT NULL UNIQUE,
  `Descrip_Sexo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Cod_Sexo`)
);

CREATE TABLE `PERSONA` (
  `Identificacion_Per` INT NOT NULL UNIQUE,
  `Nombre` VARCHAR(30) NOT NULL,
  `Apellidos` VARCHAR(30) NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `Direccion_Residencia` VARCHAR(20) NOT NULL,
  `Cod_Sexo` INT NOT NULL,
  `Cod_Ciudad` INT NOT NULL,
  FOREIGN KEY (`Cod_Sexo`) REFERENCES `SEXO`(`Cod_Sexo`),
  FOREIGN KEY (`Cod_Ciudad`) REFERENCES `CIUDAD`(`Cod_Ciudad`)
);

CREATE TABLE `PUESTO_LABORAL` (
  `Cod_Puesto_Laboral` INT NOT NULL UNIQUE,
  `Descrip_Pues_Lab` VARCHAR(30) NOT NULL,
  `Salario_Mensual` FLOAT  NOT NULL,
  PRIMARY KEY (`Cod_Puesto_Laboral`)
);

CREATE TABLE `EMPLEADO` (
  `Cod_Empleado` INT NOT NULL UNIQUE,
  `Fecha_Contratado` DATE NOT NULL,
  `Horas_Laborales` FLOAT NOT NULL,
  `Cod_Sucursal` INT NOT NULL,
  `Cod_Puesto_Laboral` INT NOT NULL,
  `Identificacion_Per` INT NOT NULL UNIQUE,
  PRIMARY KEY (`Cod_Empleado`),
  FOREIGN KEY (`Cod_Puesto_Laboral`) REFERENCES `PUESTO_LABORAL`(`Cod_Puesto_Laboral`),
  FOREIGN KEY (`Cod_Sucursal`) REFERENCES `SUCURSAL`(`Cod_Sucursal`)
);

CREATE TABLE `TIPO_USUARIO` (
  `Cod_Tipo_Usuario` INT NOT NULL UNIQUE,
  `Descrip_TipUsu` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Cod_Tipo_Usuario`)
);

CREATE TABLE `USUARIO` (
  `Cod_Usuario` INT NOT NULL UNIQUE,
  `Nombre_Usuario` VARCHAR(20) NOT NULL,
  `Contraseña` VARCHAR(20) NOT NULL,
  `Cod_Tipo_Usuario` INT NOT NULL,
  `Identificacion_Per` INT NOT NULL UNIQUE,
  PRIMARY KEY (`Cod_Usuario`),
  FOREIGN KEY (`Cod_Tipo_Usuario`) REFERENCES `TIPO_USUARIO`(`Cod_Tipo_Usuario`)
);

CREATE TABLE `CLIENTE` (
  `Cod_Cliente` INT NOT NULL UNIQUE,
  `Cod_Usuario` INT NOT NULL UNIQUE,
  PRIMARY KEY (`Cod_Cliente`),
  FOREIGN KEY (`Cod_Usuario`) REFERENCES `USUARIO`(`Cod_Usuario`)
);

CREATE TABLE `PROVEEDOR` (
  `Cod_Proveedor` INT NOT NULL UNIQUE,
  `Nombre_Proveedor` VARCHAR(50) NOT NULL,
  `Porcentaje_Ganancia` FLOAT NOT NULL,
  `Cod_Ciudad` INT NOT NULL,
  PRIMARY KEY (`Cod_Proveedor`),
  FOREIGN KEY (`Cod_Ciudad`) REFERENCES `CIUDAD`(`Cod_Ciudad`)
);

CREATE TABLE `IMPUESTO` (
  `Cod_Impuesto` INT NOT NULL UNIQUE,
  `Porcentaje_Imp` FLOAT NOT NULL,
  `Descrip_Imp` VARCHAR(20) NOT NULL,
  KEY `ID` (`Cod_Impuesto`)
);

CREATE TABLE `TIPO_PRODUCTO` (
  `Cod_Tipo_Producto` INT NOT NULL UNIQUE,
  `Nombre_Tipo_Producto` VARCHAR(50) NOT NULL,
  `Descrip_Tipo_Producto` VARCHAR(30) NOT NULL,
  `Cod_Impuesto` INT NOT NULL,
  PRIMARY KEY (`Cod_Tipo_Producto`),
  FOREIGN KEY (`Cod_Impuesto`) REFERENCES `IMPUESTO`(`Cod_Impuesto`)
);

CREATE TABLE `FACTURA` (
  `Num_Factura` INT NOT NULL UNIQUE,
  `Fecha_Factura` DATE NOT NULL,
  `Cod_Cliente` INT NOT NULL,
  `Cod_Empleado` INT NOT NULL,
  `Metodo_Pago` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Num_Factura`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`),
  FOREIGN KEY (`Cod_Empleado`) REFERENCES `EMPLEADO`(`Cod_Empleado`)
);

CREATE TABLE `PRODUCTO` (
  `Cod_Producto` INT NOT NULL UNIQUE,
  `Nombre_Producto` VARCHAR(50) NOT NULL,
  `Cod_Tipo_Producto` INT NOT NULL,
  `Cant_Minima` INT NOT NULL,
  `Cant_Maxima` INT NOT NULL,
  PRIMARY KEY (`Cod_Producto`),
  FOREIGN KEY (`Cod_Tipo_Producto`) REFERENCES `TIPO_PRODUCTO`(`Cod_Tipo_Producto`)
);

CREATE TABLE `FACTURA_PRODUCTO` (
  `Num_Factura` INT NOT NULL,
  `Cod_Producto` INT NOT NULL,
  `Cantidad_Producto` INT NOT NULL,
  `Porcentaje_Desc`  FLOAT NOT NULL,
  `Motivo_Desc` VARCHAR(15),
  FOREIGN KEY (`Num_Factura`) REFERENCES `FACTURA`(`Num_Factura`),
  FOREIGN KEY (`Cod_Producto`) REFERENCES `PRODUCTO`(`Cod_Producto`)
);

CREATE TABLE `TELEF_PERSO` (
  `Identificacion_Per` INT NOT NULL,
  `Num_Telef` VARCHAR(15)  NOT NULL,
  `Contador_Telef` INT AUTO_INCREMENT NOT NULL,
  PRIMARY KEY ( `Contador_Telef`),
  FOREIGN KEY (`Identificacion_Per`) REFERENCES `PERSONA`(`Identificacion_Per`)
);

CREATE TABLE `BODEGA_SUCURSAL_PRODUCTO` (
  `Cod_Bode_Sucu_Produ` INT AUTO_INCREMENT NOT NULL,
  `Cod_Producto` INT NOT NULL,
  `Cod_Sucursal` INT NOT NULL,
  `Precio_Compra` FLOAT NOT NULL,
  `Cod_Proveedor` INT NOT NULL,
  `Fecha_Compra` DATE NOT NULL,
  `Cantidad_Comprada` INT NOT NULL,
  `Fecha_Produccion` DATE NOT NULL,
  `Fecha_Vencimiento` DATE NOT NULL,
  PRIMARY KEY (`Cod_Bode_Sucu_Produ`),
  FOREIGN KEY (`Cod_Producto`) REFERENCES `PRODUCTO`(`Cod_Producto`),
  FOREIGN KEY (`Cod_Sucursal`) REFERENCES `SUCURSAL`(`Cod_Sucursal`),
  FOREIGN KEY (`Cod_Proveedor`) REFERENCES `PROVEEDOR`(`Cod_Proveedor`)
);

CREATE TABLE `CRIPTOCARTERA` (
  `Cod_Cliente` INT NOT NULL,
  `Num_Cripto_Cartera` VARCHAR(25) NOT NULL,
  `Contador_CriptoCar` INT AUTO_INCREMENT NOT NULL,
  PRIMARY KEY (  `Contador_CriptoCar`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`)
);

CREATE TABLE `TARJETA_CREDITO` (
  `Cod_Cliente` INT NOT NULL,
  `Num_Tarjeta_Credito` VARCHAR(20) NOT NULL,
  `Contador_TarjCre` INT AUTO_INCREMENT NOT NULL,
  PRIMARY KEY ( `Contador_TarjCre`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`)
);

CREATE TABLE `CHEQUE` (
  `Cod_Cliente` INT NOT NULL,
  `Num_Cheque` VARCHAR(20) NOT NULL,
  `Contador_Cheque` INT AUTO_INCREMENT NOT NULL,
  PRIMARY KEY ( `Contador_Cheque`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`)
);

/*----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------CRUDs----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------ PAIS ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PAIS(pCodPais INT, pNombrePais VARCHAR(40), pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PAIS(Cod_Pais,Nombre_Pais)
		VALUES(pCodPais,pNombrePais);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Pais, Nombre_Pais
		FROM PAIS
		WHERE Cod_Pais = pCodPais;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE PAIS
		SET Nombre_Pais = IFNULL( pNombrePais, Nombre_Pais)
		WHERE Cod_Pais = pCodPais;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PAIS
		WHERE Cod_Pais = pCodPais;
	END IF;
END;
//


/*------------------------------------------------------------ PROVINCIA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PROVINCIA(pCodProvincia INT, pNombreProvincia VARCHAR(40), pCodPais INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PROVINCIA(Cod_Provincia, Nombre_Provincia, Cod_Pais)
		VALUES(pCodProvincia, pNombreProvincia, pCodPais);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Provincia, Nombre_Provincia, Cod_Pais
		FROM PROVINCIA
		WHERE Cod_Provincia = pCodProvincia;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE PROVINCIA
		SET Nombre_Provincia = IFNULL(pNombreProvincia, Nombre_Provincia)
		WHERE Cod_Provincia = pCodProvincia;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PROVINCIA
		WHERE Cod_Provincia = pCodProvincia;
	END IF;
END;
//

/*------------------------------------------------------------ CIUDAD ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CIUDAD(pCodCiudad INT, pNombreCiudad VARCHAR(40), pCodProvincia INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO CIUDAD(Cod_Ciudad, Nombre_Ciudad, Cod_Provincia)
		VALUES(pCodCiudad, pNombreCiudad, pCodProvincia);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Ciudad, Nombre_Ciudad, Cod_Provincia
		FROM CIUDAD
		WHERE Cod_Ciudad = pCodCiudad;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE CIUDAD
		SET Nombre_Ciudad = IFNULL(pNombreCiudad, Nombre_Ciudad)
		WHERE Cod_Ciudad = pCodCiudad;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM CIUDAD
		WHERE Cod_Ciudad = pCodCiudad;
	END IF;
END;
//

/*------------------------------------------------------------ SUCURSAL ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_SUCURSAL(pCodSucursal INT, pNombreSucursal VARCHAR(40), pCodCiudad INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO SUCURSAL(Cod_Sucursal, Nombre_Sucursal, Cod_Ciudad)
		VALUES(pCodSucursal, pNombreSucursal, pCodCiudad);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Sucursal, Nombre_Sucursal, Cod_Ciudad
		FROM SUCURSAL
		WHERE Cod_Sucursal = pCodSucursal;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE SUCURSAL
		SET Nombre_Sucursal = IFNULL(pNombreSucursal, Nombre_Sucursal)
		WHERE Cod_Sucursal = pCodSucursal;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM SUCURSAL
		WHERE Cod_Sucursal = pCodSucursal;
	END IF;
END;
//

/*------------------------------------------------------------ SEXO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_SEXO(pCodSexo INT, pDescripSexo VARCHAR(15), pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO SEXO(Cod_Sexo, Descrip_Sexo)
		VALUES(pCodSexo, pDescripSexo);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Sexo, Descrip_Sexo
		FROM SEXO
		WHERE Cod_Sexo = pCodSexo;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE SEXO
		SET Descrip_Sexo = IFNULL(pDescripSexo, Descrip_Sexo)
		WHERE Cod_Sexo = pCodSexo;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM SEXO
		WHERE Cod_Sexo = pCodSexo;
	END IF;
END;
//

/*------------------------------------------------------------ PERSONA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PERSONA(pIdentPers INT, pNombre VARCHAR(30), pApellidos VARCHAR(30), 
										pFechaNaci DATE, pDirecResi VARCHAR(20), pCodSexo INT, pCodCiudad INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PERSONA(Identificacion_Per, Nombre, Apellidos, Fecha_Nacimiento, Direccion_Residencia, Cod_Sexo, Cod_Ciudad)
		VALUES(pIdentPers, pNombre, pApellidos, pFechaNaci, pDirecResi, pCodSexo, pCodCiudad);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Identificacion_Per, Nombre, Apellidos, Fecha_Nacimiento, Direccion_Residencia, Cod_Sexo, Cod_Ciudad
		FROM PERSONA
		WHERE Identificacion_Per = pIdentPers;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE SEXO
		SET Nombre=IFNULL(pNombre, Nombre), Apellidos=IFNULL(pApellidos, Apellidos),Direccion_Residencia=IFNULL(pDirecResi,Direccion_Residencia), Cod_Sexo=IFNULL(pCodSexo,Cod_Sexo), Cod_Ciudad=IFNULL(pCodCiudad,Cod_Ciudad)
		WHERE Identificacion_Per = pIdentPers;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PERSONA
		WHERE Identificacion_Per = pIdentPers;
	END IF;
END;
//

/*------------------------------------------------------------ PUESTO_LABORAL ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PULABORAL(pCodPuLaboral INT, pDescPuLaboral VARCHAR(30), pSalarioMe FLOAT,  pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PUESTO_LABORAL(Cod_Puesto_Laboral, Descrip_Pues_Lab, Salario_Mensual)
		VALUES(pCodPuLaboral, pDescPuLaboral, pSalarioMe);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Puesto_Laboral, Descrip_Pues_Lab, Salario_Mensual
		FROM PUESTO_LABORAL
		WHERE Cod_Puesto_Laboral = pCodPuLaboral;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE PUESTO_LABORAL
		SET  Descrip_Pues_Lab=IFNULL(pDescPuLaboral,Descrip_Pues_Lab), Salario_Mensual=IFNULL(pSalarioMe,Salario_Mensual)
		WHERE Cod_Puesto_Laboral = pCodPuLaboral;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PUESTO_LABORAL
		WHERE Cod_Puesto_Laboral = pCodPuLaboral;
	END IF;
END;
//

/*------------------------------------------------------------ EMPLEADO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_EMPLEADO(pCodEmpleado INT, pFechaContr DATE, pHorasLab FLOAT, pCodSucursal INT, pCodPuLaboral INT, pIdentPers INT , pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO EMPLEADO(Cod_Empleado, Fecha_Contratado, Horas_Laborales, Cod_Sucursal, Cod_Puesto_Laboral, Identificacion_Per)
		VALUES(pCodEmpleado,pFechaContr, pHorasLab, pCodSucursal, pCodPuLaboral, pIdentPers);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Empleado, Fecha_Contratado, Horas_Laborales, Cod_Sucursal, Cod_Puesto_Laboral, Identificacion_Per
		FROM EMPLEADO
		WHERE Cod_Empleado = pCodEmpleado;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE EMPLEADO
		SET  Horas_Laborales=IFNULL(pHorasLab, Horas_Laborales), Cod_Sucursal=IFNULL(pCodSucursal,Cod_Sucursal), Cod_Puesto_Laboral=IFNULL(pCodPuLaboral,Cod_Puesto_Laboral)
		WHERE Cod_Empleado = pCodEmpleado;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM EMPLEADO
		WHERE Cod_Empleado = pCodEmpleado;
	END IF;
END;
//

/*------------------------------------------------------------ TIPO_USUARIO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TIPUSUARIO(pCodTipUsu INT, pDescTipUsu VARCHAR(30), pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO TIPO_USUARIO(Cod_Tipo_Usuario, Descrip_TipUsu)
		VALUES(pCodTipUsu, pDescTipUsu);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Tipo_Usuario, Descrip_TipUsu
		FROM TIPO_USUARIO
		WHERE Cod_Tipo_Usuario = pCodTipUsu;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE TIPO_USUARIO
		SET  Descrip_TipUsu=IFNULL(pDescTipUsu,Descrip_TipUsu)
		WHERE Cod_Tipo_Usuario = pCodTipUsu;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM TIPO_USUARIO
		WHERE Cod_Tipo_Usuario = pCodTipUsu;
	END IF;
END;
//

/*------------------------------------------------------------ USUARIO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_USUARIO(pCodUsu INT,  pNombUsu VARCHAR(20), pContra VARCHAR(20), pCodTipUsu INT, pIdentPers INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO USUARIO(Cod_Usuario, Nombre_Usuario, Contraseña, Cod_Tipo_Usuario, Identificacion_Per)
		VALUES(pCodUsu, pNombUsu, pContra, pCodTipUsu, pIdentPers);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Usuario, Nombre_Usuario, Contraseña, Cod_Tipo_Usuario, Identificacion_Per
		FROM USUARIO
		WHERE Cod_Usuario = pCodUsu;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE USUARIO
		SET  Nombre_Usuario=IFNULL(pNombUsu,Nombre_Usuario), Contraseña=IFNULL(pContra,Contraseña), Cod_Tipo_Usuario=IFNULL(pCodTipUsu,Cod_Tipo_Usuario)
		WHERE Cod_Usuario = pCodUsu;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM USUARIO
		WHERE Cod_Usuario = pCodUsu;
	END IF;
END;
//

/*------------------------------------------------------------ CLIENTE ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CIENTE(pCodCliente INT, pCodUsu INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO CLIENTE(Cod_Cliente, Cod_Usuario)
		VALUES(pCodCliente, pCodUsu);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Cliente, Cod_Usuario
		FROM CLIENTE
		WHERE Cod_Cliente = pCodCliente;
  END IF;
	
    #no tiene nada para actualizar
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM CLIENTE
		WHERE Cod_Cliente = pCodCliente;
	END IF;
END;
//

/*------------------------------------------------------------ PROVEEDOR ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PROVEEDOR(pCodProveedor INT, pNomProvee VARCHAR(50), pPorcentGan FLOAT, pCodCiudad INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PROVEEDOR(Cod_Proveedor, Nombre_Proveedor, Porcentaje_Ganancia, Cod_Ciudad)
		VALUES(pCodProveedor, pNomProvee, pPorcentGan, pCodCiudad);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Proveedor, Nombre_Proveedor, Porcentaje_Ganancia, Cod_Ciudad
		FROM PROVEEDOR
		WHERE Cod_Proveedor = pCodProveedor;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE PROVEEDOR
		SET Nombre_Proveedor = IFNULL(pNomProvee,Nombre_Proveedor), Porcentaje_Ganancia = IFNULL(pPorcentGan,Porcentaje_Ganancia), Cod_Ciudad = IFNULL(pCodCiudad,Cod_Ciudad)
		WHERE Cod_Proveedor = pCodProveedor;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PROVEEDOR
		WHERE Cod_Proveedor = pCodProveedor;
	END IF;
END;
//

/*------------------------------------------------------------ IMPUESTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_IMPUESTO(pCodImpu INT, pPorcImpu FLOAT, pDescImpu VARCHAR(20),  pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO IMPUESTO(Cod_Impuesto, Porcentaje_Imp, Descrip_Imp)
		VALUES(pCodImpu, pPorcImpu, pDescImpu);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Impuesto, Porcentaje_Imp, Descrip_Imp
		FROM IMPUESTO
		WHERE Cod_Impuesto = pCodImpu;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE IMPUESTO
		SET Porcentaje_Imp = IFNULL(pPorcImpu,Porcentaje_Imp), Descrip_Imp=IFNULL(Descrip_Imp,Descrip_Imp)
		WHERE Cod_Impuesto = pCodImpu;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM IMPUESTO
		WHERE Cod_Impuesto = pCodImpu;
	END IF;
END;
//

/*------------------------------------------------------------ TIPO_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TIPPRODU(pCodTipProdu INT, pNomTipProdu VARCHAR(50), pDescrTipProdu VARCHAR(30),  pCodImpu INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO TIPO_PRODUCTO(Cod_Tipo_Producto, Nombre_Tipo_Producto, Descrip_Tipo_Producto, Cod_Impuesto)
		VALUES(pCodTipProdu, pNomTipProdu, pDescrTipProdu, pCodImpu);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Tipo_Producto, Nombre_Tipo_Producto, Descrip_Tipo_Producto, Cod_Impuesto
		FROM TIPO_PRODUCTO
		WHERE Cod_Tipo_Producto = pCodTipProdu;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE TIPO_PRODUCTO
		SET  Nombre_Tipo_Producto=IFNULL(pNomTipProdu,Nombre_Tipo_Producto), Descrip_Tipo_Producto=IFNULL(pDescrTipProdu,Descrip_Tipo_Producto), Cod_Impuesto=IFNULL(pCodImpu,Cod_Impuesto)
		WHERE Cod_Tipo_Producto = pCodTipProdu;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM TIPO_PRODUCTO
		WHERE Cod_Tipo_Producto = pCodTipProdu;
	END IF;
END;
//

/*------------------------------------------------------------ FACTURA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_FACTURA(pNumFact INT, pFecFact DATE, pCodCliente INT, pCodEmpleado INT, pMetodoPago VARCHAR(15), pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO FACTURA(Num_Factura, Fecha_Factura, Cod_Cliente, Cod_Empleado, Metodo_Pago)
		VALUES(pNumFact, pFecFact, pCodCliente, pCodEmpleado, pMetodoPago);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Num_Factura, Fecha_Factura, Cod_Cliente, Cod_Empleado, Metodo_Pago
		FROM FACTURA
		WHERE Num_Factura = pNumFact;
  END IF;
  
 IF (pOperacion = 'UPDATE')  THEN
		UPDATE FACTURA
		SET Metodo_Pago = IFNULL(pMetodoPago,Metodo_Pago)
		WHERE Num_Factura = pNumFact;
	END IF;
  
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM FACTURA
		WHERE Num_Factura = pNumFact;
	END IF;
END;
//

/*------------------------------------------------------------ PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PRODUCTO(pCodProdu INT,  pNombProdu VARCHAR(50), pCodTipProdu INT, pCantMin INT, pCantMax INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PRODUCTO(Cod_Producto, Nombre_Producto, Cod_Tipo_Producto, Cant_Minima, Cant_Maxima)
		VALUES(pCodProdu, pNombProdu, pCodTipProdu, pCantMin, pCantMax);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Producto, Nombre_Producto, Cod_Tipo_Producto, Cant_Minima, Cant_Maxima
		FROM PRODUCTO
		WHERE Cod_Producto = pCodProdu;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE PRODUCTO
		SET  Nombre_Producto=IFNULL(pNombProdu,Nombre_Producto), Cod_Tipo_Producto=IFNULL(pCodTipProdu,Cod_Tipo_Producto), Cant_Minima=IFNULL(pCantMin,Cant_Minima), Cant_Maxima=IFNULL(pCantMax,Cant_Maxima)
		WHERE Cod_Producto = pCodProdu;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PRODUCTO
		WHERE Cod_Producto = pCodProdu;
	END IF;
END;
//

/*------------------------------------------------------------ FACTURA_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_FACTxPRODU(pNumFact INT, pCodProdu INT, pCantProdu INT, pPorcenDesc FLOAT, pMotivoDesc VARCHAR(15),  pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO FACTURA_PRODUCTO(Num_Factura, Cod_Producto, Cantidad_Producto, Porcentaje_Desc, Motivo_Desc)
		VALUES(pNumFact, pCodProdu, pCantProdu, pPorcenDesc, pMotivoDesc);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Num_Factura, Cod_Producto, Cantidad_Producto, Porcentaje_Desc, Motivo_Desc
		FROM FACTURA_PRODUCTO
		WHERE Num_Factura = pNumFact AND Cod_Producto=pCodProdu ;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE FACTURA_PRODUCTO
		SET Cantidad_Producto = IFNULL(pCantProdu,Cantidad_Producto), Porcentaje_Desc=IFNULL(pPorcenDesc,Porcentaje_Desc), Motivo_Desc=IFNULL(pMotivoDesc,Motivo_Desc)
		WHERE Num_Factura = pNumFact AND Cod_Producto=pCodProdu;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM FACTURA_PRODUCTO
		WHERE Num_Factura = pNumFact AND Cod_Producto=pCodProdu;
	END IF;
END;
//

/*------------------------------------------------------------ TELEF_PERSO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TELEFPERSO(pIdentPers INT, pNumTel VARCHAR(15), pContTelef INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO TELEF_PERSO(Identificacion_Per, Num_Telef)
		VALUES(pIdentPers, pNumTel);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Identificacion_Per, Num_Telef, Contador_Telef
		FROM TELEF_PERSO
		WHERE Identificacion_Per = pIdentPers;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE TELEF_PERSO
		SET Num_Telef = IFNULL(pNumTel,Num_Telef)
		WHERE Identificacion_Per = pIdentPers AND Contador_Telef=pContTelef;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM TELEF_PERSO
		WHERE Identificacion_Per = pIdentPers;
	END IF;
END;
//

/*------------------------------------------------------------ BODEGA_SUCURSAL_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_BODESUCUPRODU(pCodBodega INT, pCodProdu INT, pCodSucursal INT, 
										pPrecioCompra FLOAT, pCodProveedor INT, pFechaCompra INT, pCantCompra INT, pFechaProduc DATE, pFechaVenci DATE, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO BODEGA_SUCURSAL_PRODUCTO(Cod_Bode_Sucu_Produ, Cod_Producto, Cod_Sucursal, Precio_Compra, Cod_Proveedor, Fecha_Compra, Cantidad_Comprada, Fecha_Produccion, Fecha_Vencimiento)
        VALUES(pCodBodega, pCodProdu, pCodSucursal, pPrecioCompra, pCodProveedor, pFechaCompra, pCantCompra, pFechaProduc, pFechaVenci);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Bode_Sucu_Produ, Cod_Producto, Cod_Sucursal, Precio_Compra, Cod_Proveedor, Fecha_Compra, Cantidad_Comprada, Fecha_Produccion, Fecha_Vencimiento
		FROM BODEGA_SUCURSAL_PRODUCTO
		WHERE Cod_Bode_Sucu_Produ = pCodBodega;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE BODEGA_SUCURSAL_PRODUCTO
		SET Cod_Producto=IFNULL(pCodProdu,Cod_Producto), Cod_Sucursal=IFNULL(pCodSucursal,Cod_Sucursal), Precio_Compra=IFNULL(pPrecioCompra,Precio_Compra), Cod_Proveedor=IFNULL(pCodProveedor,Cod_Proveedor), 
				Fecha_Compra=IFNULL(pFechaCompra,Fecha_Compra), Cantidad_Comprada=IFNULL(pCantCompra,Cantidad_Comprada), Fecha_Produccion=IFNULL(pFechaProduc,Fecha_Produccion), Fecha_Vencimiento=IFNULL(pFechaVenci,Fecha_Vencimiento)
		WHERE Cod_Bode_Sucu_Produ = pCodBodega;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM BODEGA_SUCURSAL_PRODUCTO
		WHERE Cod_Bode_Sucu_Produ = pCodBodega;
	END IF;
END;
//

/*------------------------------------------------------------ CRIPTOCARTERA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CRIPTOCARTERA(pCodCliente INT, pNumCriptoCart VARCHAR(25), pContCriptoC INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO CRIPTOCARTERA(Cod_Cliente, Num_Cripto_Cartera)
		VALUES(pCodCliente, pNumCriptoCart);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Cliente, Num_Cripto_Cartera, Contador_CriptoCar
		FROM CRIPTOCARTERA
		WHERE Cod_Cliente = pCodCliente;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE CRIPTOCARTERA
		SET Num_Cripto_Cartera = IFNULL(pNumCriptoCart,Num_Cripto_Cartera)
		WHERE Cod_Cliente = pCodCliente AND Contador_CriptoCar = pContCriptoC;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM CRIPTOCARTERA
		WHERE Cod_Cliente = pCodCliente AND Contador_CriptoCar = pContCriptoC;
	END IF;
END;
//

/*------------------------------------------------------------ TARJETA_CREDITO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TARJECREDI(pCodCliente INT, pNumTarjeCredi VARCHAR(20), pContTarjeCre INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO TARJETA_CREDITO(Cod_Cliente, Num_Tarjeta_Credito)
		VALUES(pCodCliente, pNumTarjeCredi);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Cliente, Num_Tarjeta_Credito, Contador_TarjCre
		FROM TARJETA_CREDITO
		WHERE Cod_Cliente = pCodCliente;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE TARJETA_CREDITO
		SET Num_Tarjeta_Credito = IFNULL(pNumTarjeCredi,Num_Tarjeta_Credito)
		WHERE Cod_Cliente = pCodCliente AND Contador_TarjCre = pContTarjeCre;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM TARJETA_CREDITO
		WHERE Cod_Cliente = pCodCliente AND Contador_TarjCre = pContTarjeCre;
	END IF;
END;
//

/*------------------------------------------------------------ CHEQUE ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CHEQUE(pCodCliente INT, pNumCheque VARCHAR(20), pContCheque INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO CHEQUE(Cod_Cliente, Num_Cheque)
		VALUES(pCodCliente, pNumCheque);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Cliente, Num_Cheque, Contador_Cheque
		FROM CHEQUE
		WHERE Cod_Cliente = pCodCliente;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE CHEQUE
		SET Num_Cheque = IFNULL(pNumCheque,Num_Cheque)
		WHERE Cod_Cliente = pCodCliente AND Contador_Cheque = pContCheque;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM CHEQUE
		WHERE Cod_Cliente = pCodCliente AND Contador_Cheque = pContCheque;
	END IF;
END;
//

DELIMITER ;
/*------------------------------------------------------------ PRUEBAS ------------------------------------------------------------*/
use supermercado;
call CRUD_PAIS(506,'Costa Rica', 'CREATE');
call CRUD_PAIS(1,'USA', 'CREATE');
call CRUD_PROVINCIA(1,'San Jose',506,'CREATE');
call CRUD_PROVINCIA(1, null, null, 'READ');