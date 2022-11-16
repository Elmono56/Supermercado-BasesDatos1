CREATE DATABASE IF NOT EXISTS SUPERMERCADO;

use supermercado;

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

CREATE TABLE `PRODUCTO` (
  `Cod_Producto` INT NOT NULL UNIQUE,
  `Nombre_Producto` VARCHAR(50) NOT NULL,
  `Cod_Tipo_Producto` INT NOT NULL,
  `Cant_Minima` INT NOT NULL,
  `Cant_Maxima` INT NOT NULL,
  PRIMARY KEY (`Cod_Producto`),
  FOREIGN KEY (`Cod_Tipo_Producto`) REFERENCES `TIPO_PRODUCTO`(`Cod_Tipo_Producto`)
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
  `Cantidad_Actual` INT NOT NULL,
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
  PRIMARY KEY (`Contador_CriptoCar`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`)
);

CREATE TABLE `TARJETA_CREDITO` (
  `Cod_Cliente` INT NOT NULL,
  `Num_Tarjeta_Credito` VARCHAR(20) NOT NULL,
  `Contador_TarjCre` INT AUTO_INCREMENT NOT NULL,
  PRIMARY KEY (`Contador_TarjCre`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`)
);

CREATE TABLE `CHEQUE` (
  `Cod_Cliente` INT NOT NULL,
  `Num_Cheque` VARCHAR(20) NOT NULL,
  `Contador_Cheque` INT AUTO_INCREMENT NOT NULL,
  PRIMARY KEY (`Contador_Cheque`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`)
);

CREATE TABLE `BODEGA_PROVEEDOR_PRODUCTO` (
  `Cod_Bode_Provee_Produ` INT  NOT NULL AUTO_INCREMENT,
  `Cod_Proveedor` INT NOT NULL,
  `Cod_Producto` INT NOT NULL,
  `Precio_Venta` FLOAT NOT NULL,
  `Cantidad_En_Bodega` INT NOT NULL,
  `Fecha_Produccion` DATE NOT NULL,
  `Fecha_Vencimiento` DATE NOT NULL,
  PRIMARY KEY (`Cod_Bode_Provee_Produ`),
  FOREIGN KEY (`Cod_Proveedor`) REFERENCES `PROVEEDOR`(`Cod_Proveedor`),
  FOREIGN KEY (`Cod_Producto`) REFERENCES `PRODUCTO`(`Cod_Producto`)
);

CREATE TABLE `ESTADO_PEDIDO` (
  `ID_EstadoP` INT NOT NULL AUTO_INCREMENT,
  `Descripcion_EstadoP` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`ID_EstadoP`)
);

CREATE TABLE `PEDIDO` (
  `Num_Pedido` INT NOT NULL UNIQUE,
  `Fecha_Pedido` DATE NOT NULL,
  `Cod_Cliente` INT NOT NULL,
  `ID_EstadoP` INT NOT NULL,
  `Envio` BOOL NOT NULL,
  PRIMARY KEY (`Num_Pedido`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`),
  FOREIGN KEY (`ID_EstadoP`) REFERENCES `ESTADO_PEDIDO`(`ID_EstadoP`)
);

CREATE TABLE `PEDIDO_PRODUCTO` (
  `Num_Pedido` INT NOT NULL,
  `Cod_Producto` INT NOT NULL,
  `Cantidad_Producto` INT NOT NULL,
  `Porcentaje_Desc`  FLOAT NOT NULL,
  `Motivo_Desc` VARCHAR(15),
  FOREIGN KEY (`Num_Pedido`) REFERENCES `PEDIDO`(`Num_Pedido`),
  FOREIGN KEY (`Cod_Producto`) REFERENCES `PRODUCTO`(`Cod_Producto`)
);

CREATE TABLE `FACTURA` (
  `Num_Factura` INT NOT NULL UNIQUE,
  `Fecha_Factura` DATE NOT NULL,
  `Cod_Cliente` INT NOT NULL,
  `Cod_Empleado` INT NOT NULL,
  `Metodo_Pago` VARCHAR(15) NOT NULL,
  `Num_Pedido` INT NOT NULL,
  PRIMARY KEY (`Num_Factura`),
  FOREIGN KEY (`Cod_Cliente`) REFERENCES `CLIENTE`(`Cod_Cliente`),
  FOREIGN KEY (`Cod_Empleado`) REFERENCES `EMPLEADO`(`Cod_Empleado`),
   FOREIGN KEY (`Num_Pedido`) REFERENCES `PEDIDO`(`Num_Pedido`)
);

CREATE TABLE `BONOS_EMPLEADO` (
  `Num_Bono` INT NOT NULL AUTO_INCREMENT,
  `Cod_Empleado` INT NOT NULL,
  `Num_Factura` INT NOT NULL,
  `MontoBono` FLOAT NOT NULL,
  `Fecha_Bono` DATE NOT NULL,
  PRIMARY KEY (`Num_Bono`),
  FOREIGN KEY (`Cod_Empleado`) REFERENCES `EMPLEADO`(`Cod_Empleado`),
  FOREIGN KEY (`Num_Factura`) REFERENCES `FACTURA`(`Num_Factura`)
);


/*----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------CRUDs----------------------------------------------------
-----------------------------------------------------------------------------------------------------------------*/

/*------------------------------------------------------------ PAIS ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PAIS(pCodPais INT, pNombrePais VARCHAR(40), pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodPais IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM PAIS WHERE Cod_Pais = pCodPais) = 0) THEN
				IF (pNombrePais != '') THEN
					INSERT INTO PAIS(Cod_Pais,Nombre_Pais)
					VALUES(pCodPais,pNombrePais);
				ELSE
					SET msgError = 'El nombre del pais está vacío';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de pais ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PAIS WHERE Cod_Pais = pCodPais) > 0) THEN
				SELECT Cod_Pais, Nombre_Pais
				FROM PAIS
				WHERE Cod_Pais = pCodPais;
			ELSE
				SET msgError = 'El pais no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PAIS WHERE Cod_Pais = pCodPais) > 0) THEN
				UPDATE PAIS
				SET Nombre_Pais = IFNULL( pNombrePais, Nombre_Pais)
				WHERE Cod_Pais = pCodPais;
			ELSE
				SET msgError = 'El pais no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PAIS WHERE Cod_Pais = pCodPais) > 0) THEN
				IF ((SELECT COUNT(*) FROM PROVINCIA WHERE Cod_Pais = pCodPais) = 0) THEN
					DELETE FROM PAIS
					WHERE Cod_Pais = pCodPais;
				ELSE
					SET msgError = 'No se puede eliminar, pais asociado a provincias';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el pais no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de pais es vacío';
        SELECT msgError;
	END IF;
END;
//


/*------------------------------------------------------------ PROVINCIA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PROVINCIA(pCodProvincia INT, pNombreProvincia VARCHAR(40), pCodPais INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodProvincia IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM PROVINCIA WHERE Cod_Provincia = pCodProvincia) = 0) THEN
				IF (pNombreProvincia != '') THEN
					IF ((SELECT COUNT(*) FROM PAIS WHERE Cod_Pais = pCodPais) > 0) THEN 
						INSERT INTO PROVINCIA(Cod_Provincia, Nombre_Provincia, Cod_Pais)
						VALUES(pCodProvincia, pNombreProvincia, pCodPais);
					ELSE
						SET msgError = 'El codigo de pais no existe';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'El nombre de la provincia está vacía';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El codigo de provincia ya existe';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PROVINCIA WHERE Cod_Provincia = pCodProvincia) > 0) THEN
				SELECT Cod_Provincia, Nombre_Provincia, Cod_Pais
				FROM PROVINCIA
				WHERE Cod_Provincia = pCodProvincia;
			ELSE
				SET msgError = 'La provincia no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PROVINCIA WHERE Cod_Provincia = pCodProvincia) > 0) THEN
				UPDATE PROVINCIA
				SET Nombre_Provincia = IFNULL( pNombreProvincia, Nombre_Provincia)
				WHERE Cod_Provincia = pCodProvincia;
			ELSE
				SET msgError = 'La provincia no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
		
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PROVINCIA WHERE Cod_Provincia = pCodProvincia) > 0) THEN
				IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Provincia = pCodProvincia) = 0) THEN
					DELETE FROM PROVINCIA
					WHERE Cod_Provincia = pCodProvincia;
				ELSE
					SET msgError = 'No se puede eliminar, provincia asociada a ciudad';
					SELECT msgError;
				END IF;
			ELSE
					SET msgError = 'No se puede eliminar, la provincia no existe';
					SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de provincia esta vacio';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ CIUDAD ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CIUDAD(pCodCiudad INT, pNombreCiudad VARCHAR(40), pCodProvincia INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodCiudad IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) = 0) THEN
				IF (pNombreCiudad != '') THEN
					IF ((SELECT COUNT(*) FROM PROVINCIA WHERE Cod_Provincia = pCodProvincia) > 0) THEN 
						INSERT INTO CIUDAD(Cod_Ciudad, Nombre_Ciudad, Cod_Provincia)
						VALUES(pCodCiudad, pNombreCiudad, pCodProvincia);
					ELSE
						SET msgError = 'El codigo de provincia no existe';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'El nombre de la ciudad está vacía';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El codigo de ciudad ya existe';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN
				SELECT Cod_Ciudad, Nombre_Ciudad, Cod_Provincia
				FROM CIUDAD
				WHERE Cod_Ciudad = pCodCiudad;
			ELSE
				SET msgError = 'La ciudad no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN
				UPDATE CIUDAD
				SET Nombre_Ciudad = IFNULL( pNombreCiudad, Nombre_Ciudad)
				WHERE Cod_Ciudad = pCodCiudad;
			ELSE
				SET msgError = 'La ciudad no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN
				IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Ciudad = pCodCiudad) = 0) THEN
					IF ((SELECT COUNT(*) FROM PERSONA WHERE Cod_Ciudad = pCodCiudad) = 0) THEN
						IF ((SELECT COUNT(*) FROM PROVEEDOR WHERE Cod_Ciudad = pCodCiudad) = 0) THEN
							DELETE FROM CIUDAD
							WHERE Cod_Ciudad = pCodCiudad;
                        ELSE
							SET msgError = 'No se puede eliminar, ciudad asocidada a proveedor';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'No se puede eliminar, ciudad asociada a persona';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, ciudad asociada a sucursal';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, la ciudad no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de ciudad esta vacio';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ SUCURSAL ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_SUCURSAL(pCodSucursal INT, pNombreSucursal VARCHAR(40), pCodCiudad INT, pOperacion VARCHAR(10))
BEGIN
	DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodSucursal IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Sucursal = pCodSucursal) = 0) THEN
				IF (pNombreSucursal != '') THEN
					IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN 
						INSERT INTO SUCURSAL(Cod_Sucursal, Nombre_Sucursal, Cod_Ciudad)
						VALUES(pCodSucursal, pNombreSucursal, pCodCiudad);
					ELSE
						SET msgError = 'El codigo de ciudad no existe';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'El nombre de la sucursal está vacía';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El codigo de sucursal ya existe';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Sucursal = pCodSucursal) > 0) THEN
				SELECT Cod_Sucursal, Nombre_Sucursal, Cod_Ciudad
				FROM SUCURSAL
				WHERE Cod_Sucursal = pCodSucursal;
			ELSE
				SET msgError = 'La sucursal no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Sucursal = pCodSucursal) > 0) THEN
				UPDATE SUCURSAL
				SET Nombre_Sucursal = IFNULL( pNombreSucursal, Nombre_Sucursal)
				WHERE Cod_Sucursal = pCodSucursal;
			ELSE
				SET msgError = 'La sucursal no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
		
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Sucursal = pCodSucursal) > 0) THEN
				IF ((SELECT COUNT(*) FROM BODEGA_SUCURSAL_PRODUCTO WHERE Cod_Sucursal = pCodSucursal) = 0) THEN
					IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Sucursal = pCodSucursal) = 0) THEN
						DELETE FROM SUCURSAL
						WHERE Cod_Sucursal = pCodSucursal;
					ELSE
						SET msgError = 'No se puede eliminar, sucursal asociada a empleado';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, sucursal asociada a bodega_sucursal';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, la sucursal no existe';
				SELECT msgError;
			END IF;
		END IF;
	
	ELSE
		SET msgError = 'El codigo de sucursal esta vacio';
        SELECT msgError;
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
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodPuLaboral IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM PUESTO_LABORAL WHERE Cod_Puesto_Laboral = pCodPuLaboral) = 0) THEN
				IF (pDescPuLaboral != '') THEN
					IF ((pSalarioMe IS NOT NULL) AND (pSalarioMe >= 0 )) THEN
						INSERT INTO PUESTO_LABORAL(Cod_Puesto_Laboral, Descrip_Pues_Lab, Salario_Mensual)
						VALUES(pCodPuLaboral, pDescPuLaboral, pSalarioMe);
					ELSE
						SET msgError = 'El salario ingresado no es válido';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'La descripción del puesto laboral está vacía';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de puesto laboral ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PUESTO_LABORAL WHERE Cod_Puesto_Laboral = pCodPuLaboral) > 0) THEN
				SELECT Cod_Puesto_Laboral, Descrip_Pues_Lab, Salario_Mensual
				FROM PUESTO_LABORAL
				WHERE Cod_Puesto_Laboral = pCodPuLaboral;
			ELSE
				SET msgError = 'Codigo de puesto laboral no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PUESTO_LABORAL WHERE Cod_Puesto_Laboral = pCodPuLaboral) > 0) THEN
				IF ((pSalarioMe IS NOT NULL) AND (pSalarioMe >= 0 )) THEN
					UPDATE PUESTO_LABORAL
					SET Descrip_Pues_Lab = IFNULL( pDescPuLaboral, Descrip_Pues_Lab), Salario_Mensual = IFNULL( pSalarioMe, Salario_Mensual)
					WHERE Cod_Puesto_Laboral = pCodPuLaboral;
				ELSE
                SET msgError = 'El salario ingresado no es válido';
				SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de puesto laboral no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PUESTO_LABORAL WHERE Cod_Puesto_Laboral = pCodPuLaboral) > 0) THEN
				IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Puesto_Laboral = pCodPuLaboral) = 0) THEN
					DELETE FROM PUESTO_LABORAL
					WHERE Cod_Puesto_Laboral = pCodPuLaboral;
				ELSE
					SET msgError = 'No se puede eliminar, puesto laboral asociado a empleado';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el codigo de puesto laboral no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de puesto laboral es vacío';
        SELECT msgError;
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
CREATE PROCEDURE CRUD_CLIENTE(pCodCliente INT, pCodUsu INT, pOperacion VARCHAR(10))
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
CREATE PROCEDURE CRUD_FACTURA(pNumFact INT, pFecFact DATE, pCodCliente INT, pCodEmpleado INT, pMetodoPago VARCHAR(15), pNumPedido INT, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO FACTURA(Num_Factura, Fecha_Factura, Cod_Cliente, Cod_Empleado, Metodo_Pago, Num_Pedido)
		VALUES(pNumFact, pFecFact, pCodCliente, pCodEmpleado, pMetodoPago,pNumPedido);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Num_Factura, Fecha_Factura, Cod_Cliente, Cod_Empleado, Metodo_Pago, Num_Pedido
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
		INSERT INTO BODEGA_SUCURSAL_PRODUCTO(Cod_Bode_Sucu_Produ, Cod_Producto, Cod_Sucursal, Precio_Compra, Cod_Proveedor, Fecha_Compra, Cantidad_Actual, Fecha_Produccion, Fecha_Vencimiento)
        VALUES(pCodBodega, pCodProdu, pCodSucursal, pPrecioCompra, pCodProveedor, pFechaCompra, pCantCompra, pFechaProduc, pFechaVenci);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Bode_Sucu_Produ, Cod_Producto, Cod_Sucursal, Precio_Compra, Cod_Proveedor, Fecha_Compra, Cantidad_Actual, Fecha_Produccion, Fecha_Vencimiento
		FROM BODEGA_SUCURSAL_PRODUCTO
		WHERE Cod_Bode_Sucu_Produ = pCodBodega;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE BODEGA_SUCURSAL_PRODUCTO
		SET Cod_Producto=IFNULL(pCodProdu,Cod_Producto), Cod_Sucursal=IFNULL(pCodSucursal,Cod_Sucursal), Precio_Compra=IFNULL(pPrecioCompra,Precio_Compra), Cod_Proveedor=IFNULL(pCodProveedor,Cod_Proveedor), 
				Fecha_Compra=IFNULL(pFechaCompra,Fecha_Compra), Cantidad_Actual=IFNULL(pCantCompra,Cantidad_Actual), Fecha_Produccion=IFNULL(pFechaProduc,Fecha_Produccion), Fecha_Vencimiento=IFNULL(pFechaVenci,Fecha_Vencimiento)
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

/*------------------------------------------------------------ BODEGA_PROVEEDOR_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_BODEPROVEPRODU(pCodBodega INT, pCodProvee INT, pCodProdu INT, pPrecioVenta FLOAT, pCantBodega INT, 
															pFechaProducc DATE, pFechaVenci DATE, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO BODEGA_PROVEEDOR_PRODUCTO(Cod_Proveedor, Cod_Producto, Precio_Venta, Cantidad_En_Bodega, Fecha_Produccion, Fecha_Vencimiento)
        VALUES(pCodProvee, pCodProdu, pPrecioVenta, pCantBodega, pFechaProducc, pFechaVenci);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Cod_Bode_Provee_Produ, Cod_Proveedor, Cod_Producto, Precio_Venta, Cantidad_En_Bodega, Fecha_Produccion, Fecha_Vencimiento
		FROM BODEGA_PROVEEDOR_PRODUCTO
		WHERE Cod_Bode_Provee_Produ = pCodBodega;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE BODEGA_PROVEEDOR_PRODUCTO
		SET Cod_Proveedor=IFNULL(pCodProvee,Cod_Proveedor), Cod_Producto=IFNULL(pCodProdu,Cod_Producto), Precio_Venta=IFNULL(pPrecioVenta,Precio_Venta),
					Cantidad_En_Bodega=IFNULL(pCantBodega,Cantidad_En_Bodega), Fecha_Produccion=IFNULL(pFechaProducc,Fecha_Produccion), Fecha_Vencimiento=IFNULL(pFechaVenci,Fecha_Vencimiento)
		WHERE Cod_Bode_Provee_Produ = pCodBodega;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM BODEGA_PROVEEDOR_PRODUCTO
		WHERE Cod_Bode_Provee_Produ = pCodBodega;
	END IF;
END;
//

/*------------------------------------------------------------ BONOS_EMPLEADO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_BONOSEMP(pNumBono INT,  pCodEmpleado INT, pNumFact INT, pMontoBono FLOAT, pFechaBono DATE, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO BONOS_EMPLEADO(Cod_Empleado, Num_Factura, MontoBono, Fecha_Bono)
		VALUES(pCodEmpleado, pNumFact, pMontoBono, pFechaBono);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Num_Bono, Cod_Empleado, Num_Factura, MontoBono, Fecha_Bono
		FROM BONOS_EMPLEADO
		WHERE Num_Bono = pNumBono;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE BONOS_EMPLEADO
		SET  MontoBono=IFNULL(pMontoBono,MontoBono), Fecha_Bono=IFNULL(pFechaBono,Fecha_Bono)
		WHERE Num_Bono = pNumBono;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM BONOS_EMPLEADO
		WHERE Num_Bono = pNumBono;
	END IF;
END;
//

/*------------------------------------------------------------ ESTADO_PEDIDO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_ESTADOP(pIDEstadoP INT,  pDescripEstP VARCHAR(15), pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO ESTADO_PEDIDO(ID_EstadoP, Descripcion_EstadoP)
		VALUES(pIDEstadoP, pDescripEstP);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT ID_EstadoP, Descripcion_EstadoP
		FROM ESTADO_PEDIDO
		WHERE ID_EstadoP = pIDEstadoP;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE ESTADO_PEDIDO
		SET  ID_EstadoP=IFNULL(pDescripEstP,ID_EstadoP)
		WHERE ID_EstadoP = pIDEstadoP;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM ESTADO_PEDIDO
		WHERE ID_EstadoP = pIDEstadoP;
	END IF;
END;
//

/*------------------------------------------------------------ PEDIDO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PEDIDO(pNumPedido INT, pFecPedido DATE, pCodCliente INT, ID_EstadoP INT, pEnvio BOOL, pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PEDIDO(Num_Pedido, Fecha_Pedido, Cod_Cliente, ID_EstadoP, Envio)
		VALUES(pNumPedido, pFecPedido, pCodCliente, ID_EstadoP, pEnvio);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Num_Pedido, Fecha_Pedido, Cod_Cliente, ID_EstadoP, Envio
		FROM PEDIDO
		WHERE Num_Pedido = pNumPedido;
  END IF;
  
 IF (pOperacion = 'UPDATE')  THEN
		UPDATE PEDIDO
		SET Envio = IFNULL(pEnvio,Envio)
		WHERE Num_Pedido = pNumPedido;
	END IF;
  
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PEDIDO
		WHERE Num_Pedido = pNumPedido;
	END IF;
END;
//

/*------------------------------------------------------------ PEDIDO_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PEDIDOxPRODU(pNumPedido INT, pCodProdu INT, pCantProdu INT, pPorcenDesc FLOAT, pMotivoDesc VARCHAR(15),  pOperacion VARCHAR(10))
BEGIN
	IF (pOperacion = 'CREATE') THEN
		INSERT INTO PEDIDO_PRODUCTO(Num_Pedido, Cod_Producto, Cantidad_Producto, Porcentaje_Desc, Motivo_Desc)
		VALUES(pNumPedido, pCodProdu, pCantProdu, pPorcenDesc, pMotivoDesc);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Num_Pedido, Cod_Producto, Cantidad_Producto, Porcentaje_Desc, Motivo_Desc
		FROM PEDIDO_PRODUCTO
		WHERE Num_Pedido = pNumPedido AND Cod_Producto=pCodProdu;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE PEDIDO_PRODUCTO
		SET Cantidad_Producto = IFNULL(pCantProdu,Cantidad_Producto), Porcentaje_Desc=IFNULL(pPorcenDesc,Porcentaje_Desc), Motivo_Desc=IFNULL(pMotivoDesc,Motivo_Desc)
		WHERE Num_Pedido = pNumPedido AND Cod_Producto=pCodProdu;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PEDIDO_PRODUCTO
		WHERE Num_Pedido = pNumPedido AND Cod_Producto=pCodProdu;
	END IF;
END;
//

/*-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------PROCEDURES----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
/*------------------------------------------------------------ CANTIDAD DE TIEMPO QUE LLEVA TRABAJANDO UN EMPLEADO ------------------------------------------------------------*/
CREATE PROCEDURE TIEMPO_LABORAL_EMPLEADO (pCodEmpleado INT)
BEGIN
#FUNCTION supermercado.GETDATE does not exist	
    DECLARE Fecha_Actual DATE;
    SET Fecha_Actual = NOW();
    SELECT DATEDIFF(Fecha_Actual, EMPLEADO.Fecha_Contratado)
    FROM EMPLEADO
    WHERE pCodEmpleado = EMPLEADO.Cod_Empleado;
END
//

DELIMITER //
/*------------------------------------------------------------ CANTIDAD DE FACTURAS QUE REALIZA UN EMPLEADO ------------------------------------------------------------*/
CREATE PROCEDURE CANTIDAD_FACTURAS_EMPLEADO (pCodEmpleado INT)
BEGIN
    SELECT COUNT(FACTURA.Num_Factura)
	FROM FACTURA
	WHERE pCodEmpleado = FACTURA.Cod_Empleado;
END
//

DELIMITER //
/*------------------------------------------------------------ CANTIDAD DE EMPLEADOS DE UNA SUCURSAL ------------------------------------------------------------*/
CREATE PROCEDURE EMPLEADOS_SUCURSAL (pCodSucursal INT)
BEGIN
	SELECT COUNT(EMPLEADO.Cod_Empleado)
	FROM EMPLEADO
	INNER JOIN SUCURSAL ON EMPLEADO.Cod_Sucursal = SUCURSAL.Cod_Sucursal	
	WHERE pCodSucursal = SUCURSAL.Cod_Sucursal;
END
//

DELIMITER //
/*------------------------------------------------------------ CANTIDAD DE PRODUCTOS EN UNA SUCURSAL ------------------------------------------------------------*/
#¿productos totales o de uno en específico?
#arreglar el inner join
CREATE PROCEDURE PRODUCTOS_SUCURSAL(pCodSucursal INT)
BEGIN
    SELECT SUM(BODEGA_SUCURSAL_PRODUCTO.Cantidad_Actual)
	FROM BODEGA_SUCURSAL_PRODUCTO
	WHERE pCodSucursal = BODEGA_SUCURSAL_PRODUCTO.Cod_Sucursal;
END
//

DELIMITER //
/*------------------------------------------------------------ CANTIDAD DE SUCURSALES EN UN PAIS ------------------------------------------------------------*/
CREATE PROCEDURE SUCURSALES_PAIS (pCodPais INT)
BEGIN
    SELECT COUNT(SUCURSAL.Cod_Sucursal)
	FROM SUCURSAL
	INNER JOIN CIUDAD ON SUCURSAL.Cod_Ciudad = CIUDAD.Cod_Ciudad
	INNER JOIN PROVINCIA ON CIUDAD.Cod_Provincia = PROVINCIA.Cod_Provincia
	INNER JOIN PAIS ON PROVINCIA.Cod_Pais = PAIS.Cod_Pais
    WHERE pCodPais = PAIS.Cod_Pais;
END
//

DELIMITER //
/*------------------------------------------------------------ DINERO GANADO POR HORA DE UN EMPLEADO ------------------------------------------------------------*/
CREATE PROCEDURE EMPLEADO_DINERO_HORA (pCodEmpleado INT)
BEGIN
	SELECT PUESTO_LABORAL.Salario_Mensual/(EMPLEADO.Horas_Laborales*4) #horas_laborales son semanales *4 =mensuales
	FROM EMPLEADO
	INNER JOIN PUESTO_LABORAL ON EMPLEADO.Cod_Puesto_Laboral = PUESTO_LABORAL.Cod_Puesto_Laboral
	WHERE pCodEmpleado = EMPLEADO.Cod_Empleado;
END
//

DELIMITER //
/*------------------------------------------------------------ CANTIDAD DE EMPLEADOS POR PUESTO ------------------------------------------------------------*/
CREATE PROCEDURE EMPLEADO_CATEGORIA (pCodPuestoLabo INT)
BEGIN
    SELECT COUNT(EMPLEADO.Cod_Empleado)
	FROM EMPLEADO
	WHERE pCodPuestoLabo = EMPLEADO.Cod_Puesto_Laboral;
END
//

DELIMITER //
/*------------------------------------------------------------ CANTIDAD DE VECES QUE UN CLIENTE HA COMPRADO ------------------------------------------------------------*/
CREATE PROCEDURE COMPRAS_CLIENTE (pCodCliente INT)
BEGIN
    SELECT
		COUNT(FACTURA.Num_Factura)
	FROM
		FACTURA
	WHERE
		pCodCliente = FACTURA.Cod_Cliente;
END
//

DELIMITER ;
;
/*---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------PRUEBAS----------------------------------------------------
----------------------------------------------------------------------------------------------------------------------*/

call CRUD_PAIS(507,'Panama', 'CREATE');
call CRUD_PROVINCIA(5071,'Chiriqui',507,'CREATE');
call CRUD_PROVINCIA(5072,'Ciudad de Panama',507,'CREATE');

call CRUD_PAIS(506,'Costa Rica', 'CREATE');
call CRUD_PROVINCIA(1,'San Jose',506,'CREATE');
call CRUD_PROVINCIA(2,'Alajuela',506,'CREATE');
call CRUD_PROVINCIA(3,'Cartago',506,'CREATE');

call CRUD_CIUDAD(11,'San Jose Centro',1,'CREATE');
call CRUD_CIUDAD(12,'Perez Zeledon',1,'CREATE');
call CRUD_CIUDAD(13,'Desamparados',1,'CREATE');

call CRUD_SUCURSAL(111,'PZ TOWN',11,'CREATE');

call CRUD_SEXO(1,'Masculino','CREATE');
call CRUD_SEXO(2,'Femenino','CREATE');
call CRUD_SEXO(3,'Otro','CREATE');

call CRUD_PERSONA(118440792,'Jose Pablo','Hidalgo Navarro',"2002-06-05",'Barrio Lourdes',1,12,'CREATE');
call CRUD_PERSONA(111111111,'Maria del Mar','Fernandez Vega',"1998-04-15",'Barrio Bloque K',2,11,'CREATE');
call CRUD_PERSONA(122222222,'Kevin','Nuñez Cruz',"1995-01-21",'Barrio Escalante',1,11,'CREATE');
call CRUD_PERSONA(133333333,'Estefanny','Gamboa Jimenez',"2003-12-01",'Curridabat',2,11,'CREATE');
call CRUD_PERSONA(155555555,'Javier Ernaldo','Benabidez Cruz',"2001-10-11",'Daniel Flores',1,12,'CREATE');
call CRUD_PERSONA(166666666,'Alonso','Zegheline Ovierira',"2001-07-15",'Zapote',1,11,'CREATE');
call CRUD_PERSONA(177777777,'Fabian Josué','Solano Rojas',"1993-08-17",'Daniel Flores',1,12,'CREATE');

call CRUD_PULABORAL(10,'Manager Sucursal',300000,'CREATE');
call CRUD_PULABORAL(20,'Cajero',150000,'CREATE');
call CRUD_PULABORAL(30,'Limpieza', 150000,'CREATE');

call CRUD_EMPLEADO(1000,"2020-05-30",40,111,10,118440792,'CREATE');
call CRUD_EMPLEADO(2000,"2019-07-04",20,111,20,111111111,'CREATE');
call CRUD_EMPLEADO(3000,"2022-09-25",40,111,30,122222222,'CREATE');
call CRUD_EMPLEADO(4000,"2021-04-15",50,111,20,133333333,'CREATE');
call CRUD_EMPLEADO(5000,"2020-03-06",40,111,30,144444444,'CREATE');

call CRUD_TIPUSUARIO(1,'Basico','CREATE');
call CRUD_TIPUSUARIO(2,'Starter','CREATE');
call CRUD_TIPUSUARIO(3,'Premiun','CREATE');

call CRUD_USUARIO(250, 'Javezuela1','1234',1,155555555,'CREATE');
call CRUD_USUARIO(260, 'AloOvi','abcd',2,166666666,'CREATE');
call CRUD_USUARIO(270, 'SoloJosueF','Fabi15',3,177777777,'CREATE');

call CRUD_CLIENTE(250,250,'CREATE');
call CRUD_CLIENTE(260,260,'CREATE');
call CRUD_CLIENTE(270,270,'CREATE');

call CRUD_PROVEEDOR(1000, 'Dos Pinos', 24.5, 13, 'CREATE');
call CRUD_PROVEEDOR(2000, 'Verdulería Feliz', 35.7, 12, 'CREATE');
call CRUD_PROVEEDOR(3000, 'Electrodomesticos KSA', 50.0, 11, 'CREATE');

call CRUD_IMPUESTO(13, 13.0, 'IVA',  'CREATE');
call CRUD_IMPUESTO(1, 0.0, 'Excento',  'CREATE');
call CRUD_IMPUESTO(2, 2.0, 'Canasta Basica',  'CREATE');

call CRUD_TIPPRODU(110, 'Fruta', 'Fruta', 13, 'CREATE');
call CRUD_TIPPRODU(220, 'Verdura', 'Verdura', 13, 'CREATE');
call CRUD_TIPPRODU(330, 'Legumbre', 'Legumbre', 13, 'CREATE');
call CRUD_TIPPRODU(410, 'Lacteo', 'Leche', 13, 'CREATE');
call CRUD_TIPPRODU(420, 'Lacteo', 'Queso', 13, 'CREATE');
call CRUD_TIPPRODU(430, 'Lacteo', 'Yogurth', 13, 'CREATE');
call CRUD_TIPPRODU(440, 'Lacteo', 'Helado', 13, 'CREATE');
call CRUD_TIPPRODU(510, 'Electrodomestico', 'Televisores', 13, 'CREATE');
call CRUD_TIPPRODU(520, 'Electrodomestico', 'Celulares', 13, 'CREATE');
call CRUD_TIPPRODU(530, 'Electrodomestico', 'Microondas', 13, 'CREATE');
call CRUD_TIPPRODU(540, 'Electrodomestico', 'Olla Arrocera', 13, 'CREATE');
call CRUD_TIPPRODU(550, 'Electrodomestico', 'Laptop', 13, 'CREATE');

call CRUD_PRODUCTO(111,  'Manzana', 110, 10, 25, 'CREATE');
call CRUD_PRODUCTO(112,  'Banano', 110, 20, 60, 'CREATE');
call CRUD_PRODUCTO(113,  'Sandía', 110, 5, 15, 'CREATE');
call CRUD_PRODUCTO(221,  'Lechuga', 220, 7, 25, 'CREATE');
call CRUD_PRODUCTO(222,  'Brocoli', 220, 5, 20, 'CREATE');
call CRUD_PRODUCTO(223,  'Ayote', 220, 10, 30, 'CREATE');
call CRUD_PRODUCTO(331,  'Papa', 330, 20, 55, 'CREATE');
call CRUD_PRODUCTO(332,  'Zanahoria', 330, 10, 35, 'CREATE');
call CRUD_PRODUCTO(333,  'Camote', 330, 7, 21, 'CREATE');
call CRUD_PRODUCTO(411,  'Leche Entera', 410, 15, 35, 'CREATE');
call CRUD_PRODUCTO(412,  'Leche Semidescremada', 410, 15, 30, 'CREATE');
call CRUD_PRODUCTO(413,  'Leche Condensada', 410, 5, 20, 'CREATE');
call CRUD_PRODUCTO(421,  'Queso Turrialba', 420, 10, 20, 'CREATE');
call CRUD_PRODUCTO(422,  'Queso Amarillo', 420, 10, 25, 'CREATE');
call CRUD_PRODUCTO(431,  'Yogurth Griego', 430, 5, 15, 'CREATE');
call CRUD_PRODUCTO(432,  'Yogurth de Fresa', 430, 10, 20, 'CREATE');
call CRUD_PRODUCTO(441,  'Helado de Vainilla', 440, 7, 23, 'CREATE');
call CRUD_PRODUCTO(442,  'Helado Napolitano', 440, 7, 20, 'CREATE');
call CRUD_PRODUCTO(443,  'Helado de Menta', 440, 5, 19, 'CREATE');
call CRUD_PRODUCTO(511,  'TV 40p Samsung', 510, 5, 10, 'CREATE');
call CRUD_PRODUCTO(512,  'TV 40p TCL', 510, 5, 10, 'CREATE');
call CRUD_PRODUCTO(513,  'TV 30p Samsung', 510, 7, 17, 'CREATE');
call CRUD_PRODUCTO(521,  'Xiaomi  RedMi 10', 520, 4, 13, 'CREATE');
call CRUD_PRODUCTO(522,  'Samsung S10 Pro', 520, 3, 14, 'CREATE');
call CRUD_PRODUCTO(523,  'iPhone 11 Pro Max', 520, 5, 13, 'CREATE');
call CRUD_PRODUCTO(531,  'Microondas BlackDecker', 530, 5, 10, 'CREATE');
call CRUD_PRODUCTO(532,  'Microondas Huawei', 530, 4, 11, 'CREATE');
call CRUD_PRODUCTO(541,  'Olla Arrocera BlackDecker', 540, 5, 13, 'CREATE');
call CRUD_PRODUCTO(542,  'Olla Arrocera Ostrel', 540, 4, 15, 'CREATE');
call CRUD_PRODUCTO(551,  'Laptop Acer Aspire 5', 550, 2, 8, 'CREATE');
call CRUD_PRODUCTO(552,  'Laptop Huawei Pro', 550, 3, 9, 'CREATE');
call CRUD_PRODUCTO(553,  'Laptop iMac 3', 550, 4, 10, 'CREATE');

call CRUD_TELEFPERSO(155555555, '70264789', null, 'CREATE');
call CRUD_TELEFPERSO(155555555, '84578103', null, 'CREATE');
call CRUD_TELEFPERSO(166666666, '65892145', null, 'CREATE');
call CRUD_TELEFPERSO(177777777, '70704156', null, 'CREATE');

call CRUD_CRIPTOCARTERA(250, 'CCBTC778991516684510', null, 'CREATE');
call CRUD_CRIPTOCARTERA(250, 'CCETH871474456711331', null, 'CREATE');

call CRUD_TARJECREDI(260, 'CR78459881045478', null, 'CREATE');
call CRUD_TARJECREDI(260, 'CR78789231520546', null, 'CREATE');
call CRUD_TARJECREDI(270, 'CR25637252897722', null, 'CREATE');

call CRUD_CHEQUE(250, '65274578246710', null, 'CREATE');
call CRUD_CHEQUE(250, '67684100269252', null, 'CREATE');
call CRUD_CHEQUE(260, '21572848104784', null, 'CREATE');

call CRUD_BODEPROVEPRODU(null, 1000, 411, 700, 50, "2022-04-05", "2022-04-30", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 412, 800, 30, "2022-05-05", "2022-05-30", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 413, 900, 20, "2022-05-05", "2022-08-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 421, 1000, 32, "2021-06-10", "2022-08-15", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 422, 900, 15, "2021-04-07", "2022-09-10", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 431, 1500, 40, "2022-04-07", "2022-10-20", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 432, 1300, 25, "2022-06-05", "2022-08-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 441, 2000, 25, "2022-01-27", "2023-09-27", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 442, 1750, 20, "2022-01-25", "2023-09-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 1000, 443, 2500, 16, "2022-01-15", "2023-09-16", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 111, 150, 60, "2022-01-05", "2022-03-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 112, 25, 75, "2022-02-05", "2022-04-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 113, 900, 80, "2022-03-05", "2022-05-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 221, 400, 45, "2022-04-05", "2022-06-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 222, 1300, 36, "2022-02-05", "2022-07-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 223, 560, 19, "2022-06-05", "2022-08-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 331, 650, 29, "2022-07-05", "2022-09-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 332, 430, 37, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 2000, 333, 400, 28, "2022-09-05", "2022-11-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 511, 1450000, 8, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 512, 800000, 10, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 513, 710025, 9, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 521, 201400, 7, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 522, 450000, 9, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 523, 950000, 13, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 531, 25000, 16, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 532, 45000, 13, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 541, 23000, 18, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 542, 35000, 15, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 551, 452000, 8, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 552, 560000, 9, "2022-08-05", "2022-10-25", 'CREATE');
call CRUD_BODEPROVEPRODU(null, 3000, 553, 780000, 5, "2022-08-05", "2022-10-25", 'CREATE');

call CRUD_ESTADOP(1,  'En espera', 'CREATE');
call CRUD_ESTADOP(2,  'Completado', 'CREATE');
call CRUD_ESTADOP(3,  'Cancelado', 'CREATE');