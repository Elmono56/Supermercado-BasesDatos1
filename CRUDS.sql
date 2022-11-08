/*------------------------------------------------------------ PAIS ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PAIS(pCodPais INT, pNombrePais varchar(40), pOperacion varchar(10))
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
CREATE PROCEDURE CRUD_PROVINCIA(pCodProvincia INT, pNombreProvincia varchar(40), pCodPais INT, pOperacion varchar(10))
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
CREATE PROCEDURE CRUD_CIUDAD(pCodCiudad INT, pNombreCiudad varchar(40), pCodProvincia INT, pOperacion varchar(10))
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
CREATE PROCEDURE CRUD_SUCURSAL(pCodSucursal INT, pNombreSucursal varchar(40), pCodCiudad INT, pOperacion varchar(10))
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