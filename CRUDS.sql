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
		SET Nombre_Pais = pNombrePais
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
		SET Nombre_Provincia = pNombreProvincia
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
		SET Nombre_Ciudad = pNombreCiudad
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
		SET Nombre_Sucursal = pNombreSucursal
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
		SET Descrip_Sexo = pDescripSexo
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
		INSERT INTO PERSONA(Identificacion_Per, Nombre, Apellidos, Fecha_Nacimiento, Direccion_Nacimiento, Cod_Sexo, Cod_Ciudad)
		VALUES(pIdentPers, pNombre, pApellidos, pFechaNaci, pDirecNaci, pCodSexo, pCodCiudad);
	END IF;

	IF (pOperacion = 'READ') THEN
		SELECT Identificacion_Per, Nombre, Apellidos, Fecha_Nacimiento, Direccion_Nacimiento, Cod_Sexo, Cod_Ciudad
		FROM PERSONA
		WHERE Identificacion_Per = pIdentPers;
  END IF;

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE SEXO
		SET Nombre=pNombre, Apellidos=pApellidos, Fecha_Nacimiento=pFechaNaci, Direccion_Nacimiento=pDirecNaci, Cod_Sexo=pCodSexo, Cod_Ciudad=pCodCiudad
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
		SET  Descrip_Pues_Lab=pDescPuLaboral, Salario_Mensual=pSalarioMe
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
CREATE PROCEDURE CRUD_EMPLEADO(pCodEmpleado INT, pFechaContr DATE, pHorasLab INT, pCodSucursal INT, pCodPuLaboral INT, pIdentPers INT , pOperacion VARCHAR(10))
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
		SET  Fecha_Contratado=pFechaContr, Horas_Laborales=pHorasLab, Cod_Sucursal=pCodSucursal, Cod_Puesto_Laboral=pCodPuLaboral, Identificacion_Per=pIdentPers
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
		SET  Descrip_TipUsu=pDescTipUsu
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
		SET  Nombre_Usuario=pNombUsu, Contraseña=pContra, Cod_Tipo_Usuario=pCodTipUsu, Identificacion_Per=pIdentPers
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

	IF (pOperacion = 'UPDATE')  THEN
		UPDATE CLIENTE
		SET Descrip_Sexo = pDescripSexo
		WHERE Cod_Usuario = pCodUsu;
	END IF;
    
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
		SET Nombre_Proveedor = pNomProvee, Porcentaje_Ganancia = pPorcentGan, Cod_Ciudad = pCodCiudad
		WHERE Cod_Proveedor = pCodProveedor;
	END IF;
    
	IF (pOperacion = 'DELETE') THEN
		DELETE FROM PROVEEDOR
		WHERE Cod_Proveedor = pCodProveedor;
	END IF;
END;
//