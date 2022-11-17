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
				IF (pNombrePais != '' AND pNombrePais IS NOT NULL) THEN
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
				IF (pNombreProvincia != ''AND pNombreProvincia IS NOT NULL) THEN
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
				IF (pNombreCiudad != '' AND pNombreCiudad IS NOT NULL) THEN
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
				IF (pNombreSucursal != '' AND pNombreSucursal IS NOT NULL) THEN
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
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodSexo IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM SEXO WHERE Cod_Sexo = pCodSexo) = 0) THEN
				IF (pDescripSexo != '' AND pDescripSexo IS NOT NULL) THEN
					INSERT INTO SEXO(Cod_Sexo, Descrip_Sexo)
					VALUES(pCodSexo, pDescripSexo);
				ELSE
					SET msgError = 'La descripción del sexo está vacía';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de sexo ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM SEXO WHERE Cod_Sexo = pCodSexo) > 0) THEN
				SELECT Cod_Sexo, Descrip_Sexo
				FROM SEXO
				WHERE Cod_Sexo = pCodSexo;
			ELSE
				SET msgError = 'El codigo de sexo no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM SEXO WHERE Cod_Sexo = pCodSexo) > 0) THEN
				UPDATE SEXO
				SET Descrip_Sexo = IFNULL( pDescripSexo, Descrip_Sexo)
				WHERE Cod_Sexo = pCodSexo;
			ELSE
				SET msgError = 'El codigo de sexo no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM SEXO WHERE Cod_Sexo = pCodSexo) > 0) THEN
				IF ((SELECT COUNT(*) FROM PERSONA WHERE Cod_Sexo = pCodSexo) = 0) THEN
					DELETE FROM SEXO
					WHERE Cod_Sexo = pCodSexo;
				ELSE
					SET msgError = 'No se puede eliminar, sexo asociado a persona';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el codigo de sexo no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de sexo es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ PERSONA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PERSONA(pIdentPers INT, pNombre VARCHAR(30), pApellidos VARCHAR(30), 
										pFechaNaci DATE, pDirecResi VARCHAR(20), pCodSexo INT, pCodCiudad INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pIdentPers IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) = 0) THEN
				IF (pNombre != ''  AND pNombre IS NOT NULL) THEN
					IF (pApellidos != ''  AND pApellidos IS NOT NULL) THEN
						IF (pFechaNaci IS NOT NULL) THEN
							IF (pDirecResi != ''  AND pDirecResi IS NOT NULL) THEN
								IF ((SELECT COUNT(*) FROM SEXO WHERE Cod_Sexo = pCodSexo) > 0) THEN
									IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN
										INSERT INTO PERSONA(Identificacion_Per, Nombre, Apellidos, Fecha_Nacimiento, Direccion_Residencia, Cod_Sexo, Cod_Ciudad)
										VALUES(pIdentPers, pNombre, pApellidos, pFechaNaci, pDirecResi, pCodSexo, pCodCiudad);
									ELSE
										SET msgError = 'El codigo de ciudad no existe';
										SELECT msgError;
									END IF;
                                ELSE
									SET msgError = 'El codigo de sexo no existe';
									SELECT msgError;
								END IF;
							ELSE
								SET msgError = 'La direccion de residencia está vacía';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'La fecha de nacimiento está vacía';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'Los apellidos están vacíos';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'El nombre está vacío';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'La identificacion personal ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) > 0) THEN
				SELECT Identificacion_Per, Nombre, Apellidos, Fecha_Nacimiento, Direccion_Residencia, Cod_Sexo, Cod_Ciudad
				FROM PERSONA
				WHERE Identificacion_Per = pIdentPers;
			ELSE
				SET msgError = 'La identificacion personal no existe, no se puede hacer la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) > 0) THEN
				IF ((SELECT COUNT(*) FROM SEXO WHERE Cod_Sexo = pCodSexo) > 0) THEN
					IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN
						UPDATE PERSONA
						SET Nombre=IFNULL(pNombre, Nombre), Apellidos=IFNULL(pApellidos, Apellidos),Direccion_Residencia=IFNULL(pDirecResi,Direccion_Residencia), Cod_Sexo=IFNULL(pCodSexo,Cod_Sexo), Cod_Ciudad=IFNULL(pCodCiudad,Cod_Ciudad)
						WHERE Identificacion_Per = pIdentPers;
					ELSE
						SET msgError = 'El codigo de ciudad no existe, no se puede actualizar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El codigo de sexo no existe, no se puede actualizar';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'La identificacion personal no existe, no se puede actualizar';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) > 0) THEN
				IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Identificacion_Per = pIdentPers) = 0) THEN
					IF ((SELECT COUNT(*) FROM USUARIO WHERE Identificacion_Per = pIdentPers) = 0) THEN
						IF ((SELECT COUNT(*) FROM TELEF_PERSO WHERE Identificacion_Per = pIdentPers) = 0) THEN
							DELETE FROM PERSONA
							WHERE Identificacion_Per = pIdentPers;
						ELSE
							SET msgError = 'No se puede eliminar, persona asociada a telefono personal';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'No se puede eliminar, persona asociada a usuario';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, persona asociada a empleado';
					SELECT msgError;
				END IF;
            ELSE
				SET msgError = 'No se puede eliminar, identificacion personal no existe';
				SELECT msgError;
			END IF;
		END IF;
	
	ELSE
		SET msgError = 'La identificacion personal está vacía';
        SELECT msgError;
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
				IF (pDescPuLaboral != '' AND pDescPuLaboral IS NOT NULL) THEN
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
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodEmpleado IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Empleado = pCodEmpleado) = 0) THEN
				IF (pFechaContr IS NOT NULL) THEN
					IF (pHorasLab IS NOT NULL AND pHorasLab>=0) THEN
						IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Sucursal = pCodSucursal) > 0) THEN
							IF ((SELECT COUNT(*) FROM PUESTO_LABORAL WHERE Cod_Puesto_Laboral = pCodPuLaboral) > 0) THEN
								IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) > 0) THEN
									INSERT INTO EMPLEADO(Cod_Empleado, Fecha_Contratado, Horas_Laborales, Cod_Sucursal, Cod_Puesto_Laboral, Identificacion_Per)
									VALUES(pCodEmpleado,pFechaContr, pHorasLab, pCodSucursal, pCodPuLaboral, pIdentPers);
								ELSE
									SET msgError = 'La identificacion personal no existe';
									SELECT msgError;
								END IF;
							ELSE
								SET msgError = 'El codigo de puesto laboral no existe';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'El codigo de sucursal no existe';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'Las horas laborales ingresadas no son válidas';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'La fecha de contratacion ingresada es vacía';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de empleado ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Empleado = pCodEmpleado) > 0) THEN
				SELECT Cod_Empleado, Fecha_Contratado, Horas_Laborales, Cod_Sucursal, Cod_Puesto_Laboral, Identificacion_Per
				FROM EMPLEADO
				WHERE Cod_Empleado = pCodEmpleado;
			ELSE
				SET msgError = 'El codigo de empleado no existe, no se puede hacer la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Empleado = pCodEmpleado) > 0) THEN
				IF (pHorasLab IS NOT NULL AND pHorasLab>=0) THEN
					IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Sucursal = pCodSucursal) > 0) THEN
						IF ((SELECT COUNT(*) FROM PUESTO_LABORAL WHERE Cod_Puesto_Laboral = pCodPuLaboral) > 0) THEN
							UPDATE EMPLEADO
							SET Horas_Laborales=IFNULL(pHorasLab, Horas_Laborales), Cod_Sucursal=IFNULL(pCodSucursal,Cod_Sucursal), Cod_Puesto_Laboral=IFNULL(pCodPuLaboral,Cod_Puesto_Laboral)
							WHERE Cod_Empleado = pCodEmpleado;
						ELSE
							SET msgError = 'El codigo de puesto laboral no existe, no se puede actualizar';
							SELECT msgError;
						END IF;
                    ELSE
						SET msgError = 'El codigo de sucursal no existe, no se puede actualizar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'Las horas laborales ingresadas no son válidas, no se puede actualizar';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El codigo de empleado no existe, no se puede actualizar';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Empleado = pCodEmpleado) > 0) THEN
				IF ((SELECT COUNT(*) FROM FACTURA WHERE Cod_Empleado = pCodEmpleado) = 0) THEN
					IF ((SELECT COUNT(*) FROM BONOS_EMPLEADO WHERE Cod_Empleado = pCodEmpleado) = 0) THEN
						DELETE FROM EMPLEADO
						WHERE Cod_Empleado = pCodEmpleado;
					ELSE
						SET msgError = 'No se puede eliminar, empleado asociada a bono de empleado';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, empleado asociada a factura';
					SELECT msgError;
				END IF;
            ELSE
				SET msgError = 'No se puede eliminar, codigo de empleado no existe';
				SELECT msgError;
			END IF;
		END IF;
	
	ELSE
		SET msgError = 'El codigo de empleado está vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ TIPO_USUARIO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TIPUSUARIO(pCodTipUsu INT, pDescTipUsu VARCHAR(30), pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodTipUsu IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM TIPO_USUARIO WHERE Cod_Tipo_Usuario = pCodTipUsu) = 0) THEN
				IF (pDescTipUsu != '' AND pDescTipUsu IS NOT NULL) THEN
					INSERT INTO TIPO_USUARIO(Cod_Tipo_Usuario, Descrip_TipUsu)
					VALUES(pCodTipUsu, pDescTipUsu);
				ELSE
					SET msgError = 'La descripción del tipo de usuario está vacía';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de tipo de usuario ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM TIPO_USUARIO WHERE Cod_Tipo_Usuario = pCodTipUsu) > 0) THEN
				SELECT Cod_Tipo_Usuario, Descrip_TipUsu
				FROM TIPO_USUARIO
				WHERE Cod_Tipo_Usuario = pCodTipUsu;
			ELSE
				SET msgError = 'El codigo de tipo usuario no existe, imposible realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM TIPO_USUARIO WHERE Cod_Tipo_Usuario = pCodTipUsu) > 0) THEN
				UPDATE TIPO_USUARIO
				SET Descrip_TipUsu = IFNULL( pDescTipUsu, Descrip_TipUsu)
				WHERE Cod_Tipo_Usuario = pCodTipUsu;
			ELSE
				SET msgError = 'El codigo de tipo usuario no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM TIPO_USUARIO WHERE Cod_Tipo_Usuario = pCodTipUsu) > 0) THEN
				IF ((SELECT COUNT(*) FROM USUARIO WHERE Cod_Tipo_Usuario = pCodTipUsu) = 0) THEN
					DELETE FROM TIPO_USUARIO
					WHERE Cod_Tipo_Usuario = pCodTipUsu;
				ELSE
					SET msgError = 'No se puede eliminar, tipo de usuario asociado a usuario';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el codigo de tipo de usuario no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de tipo de usuario es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ USUARIO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_USUARIO(pCodUsu INT,  pNombUsu VARCHAR(20), pContra VARCHAR(20), pCorreoE VARCHAR(30), pCodTipUsu INT, pIdentPers INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodUsu IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM USUARIO WHERE Cod_Usuario = pCodUsu) = 0) THEN
				IF (pNombUsu != ''  AND pNombUsu IS NOT NULL) THEN
					IF (pContra != ''  AND pContra IS NOT NULL) THEN
						IF (pCorreoE != ''  AND pCorreoE IS NOT NULL) THEN
								IF ((SELECT COUNT(*) FROM TIPO_USUARIO WHERE Cod_Tipo_Usuario = pCodTipUsu) > 0) THEN
									IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) > 0) THEN
										INSERT INTO USUARIO(Cod_Usuario, Nombre_Usuario, Contraseña, CorreoElec, Cod_Tipo_Usuario, Identificacion_Per)
										VALUES(pCodUsu, pNombUsu, pContra, pCorreoE, pCodTipUsu, pIdentPers);
									ELSE
										SET msgError = 'La identificacion personal no existe';
										SELECT msgError;
									END IF;
                                ELSE
									SET msgError = 'El codigo de tipo de usuario no existe';
									SELECT msgError;
								END IF;
						ELSE
							SET msgError = 'El correo electrónico está vacío';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'La contraseña está vacía';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'El nombre está vacío';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El nombre de usuario está vacío';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM USUARIO WHERE Cod_Usuario = pCodUsu) > 0) THEN
				SELECT Cod_Usuario, Nombre_Usuario, Contraseña, CorreoElec, Cod_Tipo_Usuario, Identificacion_Per
				FROM USUARIO
				WHERE Cod_Usuario = pCodUsu;
			ELSE
				SET msgError = 'El codigo de usuario no existe, no se puede hacer la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM USUARIO WHERE Cod_Usuario = pCodUsu) > 0) THEN
				IF ((SELECT COUNT(*) FROM TIPO_USUARIO WHERE Cod_Tipo_Usuario = pCodTipUsu) > 0) THEN
					IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) > 0) THEN
						UPDATE USUARIO
						SET Nombre=Nombre_Usuario=IFNULL(pNombUsu,Nombre_Usuario), Contraseña=IFNULL(pContra,Contraseña), Cod_Tipo_Usuario=IFNULL(pCodTipUsu,Cod_Tipo_Usuario), CorreoElec=IFNULL(pCorreoE,CorreoElec)
						WHERE Cod_Usuario = pCodUsu;
					ELSE
						SET msgError = 'La identificacion personal no existe, no se puede actualizar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El codigo de tipo de usuario no existe, no se puede actualizar';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El codigo de usuario no existe, no se puede actualizar';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM USUARIO WHERE Cod_Usuario = pCodUsu) > 0) THEN
				IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Usuario = pCodUsu) = 0) THEN
					DELETE FROM USUARIO
					WHERE Cod_Usuario = pCodUsu;
				ELSE
					SET msgError = 'No se puede eliminar, usuario asociada a cliente';
					SELECT msgError;
				END IF;
            ELSE
				SET msgError = 'No se puede eliminar, codigo de usuario no existe';
				SELECT msgError;
			END IF;
		END IF;
	
	ELSE
		SET msgError = 'El codigo de usuario está vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ CLIENTE ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CLIENTE(pCodCliente INT, pCodUsu INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodCliente IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) = 0) THEN
				IF ((SELECT COUNT(*) FROM USUARIO WHERE Cod_Usuario = pCodUsu) > 0) THEN
					INSERT INTO CLIENTE(Cod_Cliente, Cod_Usuario)
					VALUES(pCodCliente, pCodUsu);
				ELSE
					SET msgError = 'El codigo de usuario no existe';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de cliente ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) > 0) THEN
				SELECT Cod_Cliente, Cod_Usuario
				FROM CLIENTE
				WHERE Cod_Cliente = pCodCliente;
			ELSE
				SET msgError = 'El codigo de cliente, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			SET msgError = 'No está permitido actualizar datos';
			SELECT msgError;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) > 0) THEN
				IF ((SELECT COUNT(*) FROM CRIPTOCARTERA WHERE Cod_Cliente = pCodCliente) = 0) THEN
					IF ((SELECT COUNT(*) FROM TARJETA_CREDITO WHERE Cod_Cliente = pCodCliente) = 0) THEN
						IF ((SELECT COUNT(*) FROM CHEQUE WHERE Cod_Cliente = pCodCliente) = 0) THEN
							IF ((SELECT COUNT(*) FROM PEDIDO WHERE Cod_Cliente = pCodCliente) = 0) THEN
								IF ((SELECT COUNT(*) FROM FACTURA WHERE Cod_Cliente = pCodCliente) = 0) THEN
									DELETE FROM CLIENTE
									WHERE Cod_Cliente = pCodCliente;
                                ELSE
									SET msgError = 'No se puede eliminar, cliente asociado a factura';
									SELECT msgError;
								END IF;
							ELSE
								SET msgError = 'No se puede eliminar, cliente asociado a pedido';
								SELECT msgError;
							END IF;
                        ELSE
							SET msgError = 'No se puede eliminar, cliente asociado a cheque';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'No se puede eliminar, cliente asociado a tarjeta de credito';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, cliente asociado a criptocartera';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el codigo de cliente no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'Error: el codigo de cliente es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ PROVEEDOR ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PROVEEDOR(pCodProveedor INT, pNomProvee VARCHAR(50), pPorcentGan FLOAT, pCodCiudad INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodProveedor IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM PROVEEDOR WHERE Cod_Proveedor = pCodProveedor) = 0) THEN
				IF (pNomProvee != '' AND pNomProvee IS NOT NULL) THEN
					IF (pPorcentGan IS NOT NULL AND pPorcentGan>=0) THEN
						IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN
							INSERT INTO PROVEEDOR(Cod_Proveedor, Nombre_Proveedor, Porcentaje_Ganancia, Cod_Ciudad)
							VALUES(pCodProveedor, pNomProvee, pPorcentGan, pCodCiudad);
						ELSE
							SET msgError = 'El codigo de ciudad no existe';
							SELECT msgError;
						END IF;
                    ELSE
						SET msgError = 'El porcentaje de ganancia ingresado no es válido';
						SELECT msgError;
					END IF;
                ELSE
					SET msgError = 'El nombre de proveedor ingresado no es válido';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de proveedor ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PROVEEDOR WHERE Cod_Proveedor = pCodProveedor) > 0) THEN
				SELECT Cod_Proveedor, Nombre_Proveedor, Porcentaje_Ganancia, Cod_Ciudad
				FROM PROVEEDOR
				WHERE Cod_Proveedor = pCodProveedor;
			ELSE
				SET msgError = 'El codigo proveedor no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PROVEEDOR WHERE Cod_Proveedor = pCodProveedor) > 0) THEN
				IF (pPorcentGan IS NOT NULL AND pPorcentGan>=0) THEN
					IF ((SELECT COUNT(*) FROM CIUDAD WHERE Cod_Ciudad = pCodCiudad) > 0) THEN
						UPDATE PROVEEDOR
						SET Nombre_Proveedor = IFNULL(pNomProvee,Nombre_Proveedor), Porcentaje_Ganancia = IFNULL(pPorcentGan,Porcentaje_Ganancia), Cod_Ciudad = IFNULL(pCodCiudad,Cod_Ciudad)
						WHERE Cod_Proveedor = pCodProveedor;
					ELSE
						SET msgError = 'El codigo de ciudad no existe, no se puede actualizar datos';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El porcentaje de ganancia no es válido, no se puede actualizar datos';
					SELECT msgError;
				END IF;
            ELSE
				SET msgError = 'El codigo de proveedor no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PROVEEDOR WHERE Cod_Proveedor = pCodProveedor) > 0) THEN
				IF ((SELECT COUNT(*) FROM BODEGA_PROVEEDOR_PRODUCTO WHERE Cod_Proveedor = pCodProveedor) = 0) THEN
					IF ((SELECT COUNT(*) FROM BODEGA_SUCURSAL_PRODUCTO WHERE Cod_Proveedor = pCodProveedor) = 0) THEN
						DELETE FROM PROVEEDOR
						WHERE Cod_Proveedor = pCodProveedor;
                    ELSE
						SET msgError = 'No se puede eliminar, proveedor asociado a bodega de sucursal';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, proveedor asociado a bodega de proveedor';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el codigo de proveedor no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de proveedor es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ IMPUESTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_IMPUESTO(pCodImpu INT, pPorcImpu FLOAT, pDescImpu VARCHAR(20),  pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodImpu IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM IMPUESTO WHERE Cod_Impuesto = pCodImpu) = 0) THEN
				IF (pDescImpu != ''  AND pDescImpu IS NOT NULL) THEN
					IF ((pPorcImpu IS NOT NULL) AND (pPorcImpu >= 0 )) THEN
						INSERT INTO IMPUESTO(Cod_Impuesto, Porcentaje_Imp, Descrip_Imp)
						VALUES(pCodImpu, pPorcImpu, pDescImpu);
					ELSE
						SET msgError = 'El porcentaje del impuesto ingresado no es válido';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'La descripción del impuesto está vacía';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de impuesto ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM IMPUESTO WHERE Cod_Impuesto = pCodImpu) > 0) THEN
				SELECT Cod_Impuesto, Porcentaje_Imp, Descrip_Imp
				FROM IMPUESTO
				WHERE Cod_Impuesto = pCodImpu;
			ELSE
				SET msgError = 'El impuesto no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM IMPUESTO WHERE Cod_Impuesto = pCodImpu) > 0) THEN
				IF ((pPorcImpu IS NOT NULL) AND (pPorcImpu >= 0 )) THEN
					UPDATE IMPUESTO
					SET Descrip_Imp = IFNULL( pDescImpu, Descrip_Imp), Porcentaje_Imp = IFNULL( pPorcImpu, Porcentaje_Imp)
					WHERE Cod_Impuesto = pCodImpu;
				ELSE
                SET msgError = 'El porcentaje del impuesto ingresado no es válido';
				SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El impuesto no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM IMPUESTO WHERE Cod_Impuesto = pCodImpu) > 0) THEN
				IF ((SELECT COUNT(*) FROM TIPO_PRODUCTO WHERE Cod_Impuesto = pCodImpu) = 0) THEN
					DELETE FROM IMPUESTO
					WHERE Cod_Impuesto = pCodImpu;
				ELSE
					SET msgError = 'No se puede eliminar, impuesto asociado a tipo producto';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el impuesto no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de impuesto es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ TIPO_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TIPPRODU(pCodTipProdu INT, pNomTipProdu VARCHAR(50), pDescrTipProdu VARCHAR(30),  pCodImpu INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodTipProdu IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM TIPO_PRODUCTO WHERE Cod_Tipo_Producto = pCodTipProdu) = 0) THEN
				IF (pNomTipProdu != ''  AND pNomTipProdu IS NOT NULL) THEN
					IF (pDescrTipProdu != ''  AND pDescrTipProdu IS NOT NULL) THEN
						IF ((SELECT COUNT(*) FROM IMPUESTO WHERE Cod_Impuesto = pCodImpu) > 0) THEN
							INSERT INTO TIPO_PRODUCTO(Cod_Tipo_Producto, Nombre_Tipo_Producto, Descrip_Tipo_Producto, Cod_Impuesto)
							VALUES(pCodTipProdu, pNomTipProdu, pDescrTipProdu, pCodImpu);
						ELSE
							SET msgError = 'El codigo de impuesto no existe';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'La descripción del tipo de producto está vacía';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'El nombre del tipo de producto está vacío';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de tipo de producto ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM TIPO_PRODUCTO WHERE Cod_Tipo_Producto = pCodTipProdu) > 0) THEN
				SELECT Cod_Tipo_Producto, Nombre_Tipo_Producto, Descrip_Tipo_Producto, Cod_Impuesto
				FROM TIPO_PRODUCTO
				WHERE Cod_Tipo_Producto = pCodTipProdu;
			ELSE
				SET msgError = 'El codigo de tipo de producto no existe, no se puede hacer la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM TIPO_PRODUCTO WHERE Cod_Tipo_Producto = pCodTipProdu) > 0) THEN
				IF ((SELECT COUNT(*) FROM IMPUESTO WHERE Cod_Tipo_Producto = pCodTipProdu) > 0) THEN
					UPDATE TIPO_PRODUCTO
					SET Nombre_Tipo_Producto=IFNULL(pNomTipProdu,Nombre_Tipo_Producto), Descrip_Tipo_Producto=IFNULL(pDescrTipProdu,Descrip_Tipo_Producto), Cod_Impuesto=IFNULL(pCodImpu,Cod_Impuesto)
					WHERE Cod_Tipo_Producto = pCodTipProdu;
				ELSE
					SET msgError = 'El codigo de impuesto no existe, no se puede actualizar';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El codigo de tipo de producto, no se puede actualizar';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM TIPO_PRODUCTO WHERE Cod_Tipo_Producto = pCodTipProdu) > 0) THEN
				IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Impuesto = pCodImpu) = 0) THEN
					DELETE FROM TIPO_PRODUCTO
					WHERE Cod_Tipo_Producto = pCodTipProdu;
				ELSE
					SET msgError = 'No se puede eliminar, tipo producto asociado a producto';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el tipo de producto no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El tipo de producto es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ FACTURA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_FACTURA(pNumFact INT, pFechaFact DATE, pCodCliente INT, pCodEmpleado INT, pMetodoPago VARCHAR(15), pNumPedido INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pNumFact IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM FACTURA WHERE Num_Factura = pNumFact) = 0) THEN
				IF (pFechaFact IS NOT NULL) THEN
					IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) > 0) THEN
						IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Empleado = pCodEmpleado) > 0) THEN
							IF (pMetodoPago != '' AND pMetodoPago IS NOT NULL) THEN
								IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
									INSERT INTO FACTURA(Num_Factura, Fecha_Factura, Cod_Cliente, Cod_Empleado, Metodo_Pago, Num_Pedido)
									VALUES(pNumFact, pFechaFact, pCodCliente, pCodEmpleado, pMetodoPago,pNumPedido);
								ELSE
									SET msgError = 'El numero de pedido no existe';
									SELECT msgError;
								END IF;
							ELSE
								SET msgError = 'El metodo de pago ingresado es inválido';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'El codigo de empleado no existe';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'El codigo de cliente no existe';
						SELECT msgError;
                    END IF;
				ELSE
					SET msgError = 'La fecha de la factura es inválida';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El numero de factura ya existe';
				SELECT msgError;
            END IF;
		END IF;
	
		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM FACTURA WHERE Num_Factura = pNumFact) > 0) THEN
				SELECT Num_Factura, Fecha_Factura, Cod_Cliente, Cod_Empleado, Metodo_Pago, Num_Pedido
				FROM FACTURA
				WHERE Num_Factura = pNumFact;
			ELSE
				SET msgError = 'El numero de factura no existe, no se puede hacer la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM FACTURA WHERE Num_Factura = pNumFact) > 0) THEN
				IF (pMetodoPago IS NOT NULL) THEN
					UPDATE FACTURA
					SET Metodo_Pago = IFNULL(pMetodoPago,Metodo_Pago)
					WHERE Num_Factura = pNumFact;
				ELSE
					SET msgError = 'El metodo de pago es inválido, no se puede actualizar';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El numero de factura no existe, no se puede actualizar';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM FACTURA WHERE Num_Factura = pNumFact) > 0) THEN
				DELETE FROM FACTURA
				WHERE Num_Factura = pNumFact;
            ELSE
				SET msgError = 'No se puede eliminar, el numero de factura no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El numero de factura está vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PRODUCTO(pCodProdu INT,  pNombProdu VARCHAR(50), pCodTipProdu INT, pCantMin INT, pCantMax INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodProdu IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) = 0) THEN
				IF (pNombProdu != '' AND pNombProdu IS NOT NULL) THEN
					IF ((SELECT COUNT(*) FROM TIPO_PRODUCTO WHERE Cod_Tipo_Producto = pCodTipProdu) > 0) THEN
						IF (pCantMin IS NOT NULL AND pCantMin>=0) THEN
							IF (pCantMax IS NOT NULL AND pCantMax>pCantMin) THEN
								INSERT INTO PRODUCTO(Cod_Producto, Nombre_Producto, Cod_Tipo_Producto, Cant_Minima, Cant_Maxima)
								VALUES(pCodProdu, pNombProdu, pCodTipProdu, pCantMin, pCantMax);
							ELSE
								SET msgError = 'La cantidad maxima debe ser mayor a la minima';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'La cantidad minima debe ser >= a 0';
							SELECT msgError;
						END IF;
                    ELSE
						SET msgError = 'El codigo de tipo de producto no existe';
						SELECT msgError;
					END IF;
                ELSE
					SET msgError = 'El nombre de producto ingresado no es válido';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El codigo de producto ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
				SELECT Cod_Producto, Nombre_Producto, Cod_Tipo_Producto, Cant_Minima, Cant_Maxima
				FROM PRODUCTO
				WHERE Cod_Producto = pCodProdu;
			ELSE
				SET msgError = 'El codigo producto no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
					IF ((SELECT COUNT(*) FROM TIPO_PRODUCTO WHERE Cod_Tipo_Producto = pCodTipProdu) > 0) THEN
						IF (pCantMin IS NOT NULL AND pCantMin>=0) THEN
							IF (pCantMax IS NOT NULL AND pCantMax>pCantMin) THEN
								UPDATE PRODUCTO
								SET Nombre_Producto=IFNULL(pNombProdu,Nombre_Producto), Cod_Tipo_Producto=IFNULL(pCodTipProdu,Cod_Tipo_Producto), Cant_Minima=IFNULL(pCantMin,Cant_Minima), Cant_Maxima=IFNULL(pCantMax,Cant_Maxima)
								WHERE Cod_Producto = pCodProdu;
							ELSE
								SET msgError = 'La cantidad maxima es invalida, no se puede actualizar datos';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'La cantidad minima es invalida, no se puede actualizar datos';
							SELECT msgError;
						END IF;
				ELSE
					SET msgError = 'El codigo de tipo de producto no existe, no se puede actualizar datos';
					SELECT msgError;
				END IF;
            ELSE
				SET msgError = 'El codigo de producto no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
				IF ((SELECT COUNT(*) FROM BODEGA_PROVEEDOR_PRODUCTO WHERE Cod_Producto = pCodProdu) = 0) THEN
					IF ((SELECT COUNT(*) FROM BODEGA_SUCURSAL_PRODUCTO WHERE Cod_Producto = pCodProdu) = 0) THEN
						IF ((SELECT COUNT(*) FROM PEDIDO_PRODUCTO WHERE Cod_Producto = pCodProdu) = 0) THEN
							DELETE FROM PRODUCTO
							WHERE Cod_Producto = pCodProdu;
						ELSE
							SET msgError = 'No se puede eliminar, proveedor asociado a pedido de producto';
							SELECT msgError;
						END IF;
                    ELSE
						SET msgError = 'No se puede eliminar, producto asociado a bodega de sucursal';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, producto asociado a bodega de proveedor';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el codigo de producto no existe';
				SELECT msgError;
			END IF;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de producto es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ TELEF_PERSO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TELEFPERSO(pIdentPers INT, pNumTel VARCHAR(15), pContTelef INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pIdentPers IS NOT NULL) THEN
		IF ((SELECT COUNT(*) FROM PERSONA WHERE Identificacion_Per = pIdentPers) > 0)THEN
			IF (pOperacion = 'CREATE') THEN
				IF (pNumTel != '' AND pNumTel IS NOT NULL) THEN
					INSERT INTO TELEF_PERSO(Identificacion_Per, Num_Telef)
					VALUES(pIdentPers, pNumTel);
				ELSE
					SET msgError = 'El numero de telefono está vacío';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'READ') THEN
				IF ((SELECT COUNT(*) FROM TELEF_PERSO WHERE Identificacion_Per = pIdentPers) > 0) THEN
					SELECT Identificacion_Per, Num_Telef, Contador_Telef
					FROM TELEF_PERSO
					WHERE Identificacion_Per = pIdentPers;
				ELSE
					SET msgError = 'La persona no tiene numeros de telefono asociados';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'UPDATE')  THEN
				IF ((SELECT COUNT(*) FROM TELEF_PERSO WHERE Identificacion_Per = pIdentPers) > 0) THEN
					IF ((SELECT COUNT(*) FROM TELEF_PERSO WHERE Contador_Telef = pContTelef) > 0) THEN
						UPDATE TELEF_PERSO
						SET Num_Telef = IFNULL(pNumTel, Num_Telef)
						WHERE Identificacion_Per = pIdentPers AND Contador_Telef = pContTelef;
					ELSE
						SET msgError = 'El ID del telefono no existe, imposible actualizar datos';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'La persona no tiene numeros de telefono asociados';
					SELECT msgError;
				END IF;
			END IF;
			
			IF (pOperacion = 'DELETE') THEN
				IF ((SELECT COUNT(*) FROM TELEF_PERSO WHERE Identificacion_Per = pIdentPers) > 0) THEN
					IF ((SELECT COUNT(*) FROM TELEF_PERSO WHERE Contador_Telef = pContTelef) = 0) THEN
						DELETE FROM TELEF_PERSO
						WHERE Identificacion_Per = pIdentPers AND Contador_Telef = pContTelef;
					ELSE
						SET msgError = 'No se puede eliminar, el ID del telefono no existe';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'La persona no tiene numeros de telefono asociados';
					SELECT msgError;
				END IF;
			END IF;
            
        ELSE
			SET msgError = 'El numero de identificacion no existe';
			SELECT msgError;
	END IF;
    
	ELSE
		SET msgError = 'El numero de cedula es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ BODEGA_SUCURSAL_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_BODESUCUPRODU(pCodBodega INT, pCodProdu INT, pCodSucursal INT, 
										pPrecioCompra FLOAT, pCodProveedor INT, pFechaCompra INT, pCantActual INT, pFechaProducc DATE, pFechaVenci DATE, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
    
	IF (pOperacion = 'CREATE') THEN
		IF ((SELECT COUNT(*) FROM SUCURSAL WHERE Cod_Sucursal = pCodSucursal) > 0) THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
				IF ((SELECT COUNT(*) FROM PROVEEDOR WHERE Cod_Proveedor = pCodProveedor) > 0) THEN
					IF (pPrecioCompra IS NOT NULL AND pPrecioCompra >= 0) THEN
						IF (pCantActual IS NOT NULL AND pCantActual >= 0) THEN
							IF (pFechaCompra IS NOT NULL) THEN
								IF (pFechaProducc IS NOT NULL) THEN
									IF (pFechaVenci IS NOT NULL) THEN
										INSERT INTO BODEGA_SUCURSAL_PRODUCTO(Cod_Producto, Cod_Sucursal, Precio_Compra, Cod_Proveedor, Fecha_Compra, Cantidad_Actual, Fecha_Produccion, Fecha_Vencimiento)
										VALUES(pCodProdu, pCodSucursal, pPrecioCompra, pCodProveedor, pFechaCompra, pCantActual, pFechaProduc, pFechaVenci);
									ELSE
										SET msgError = 'La fecha de vencimiento es inválida';
										SELECT msgError;
									END IF;
								ELSE
									SET msgError = 'La fecha de produccion es inválida';
									SELECT msgError;
								END IF;
							ELSE
								SET msgError = 'La fecha de compra es inválida';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'La cantidad comprada es inválida';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'El precio de la compra es inválido';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El código de proveedor no existe';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El código de producto no existe';
				SELECT msgError;
			END IF;
		ELSE
			SET msgError = 'El código de sucursal no existe';
			SELECT msgError;
		END IF;
	END IF;
    
	IF (pCodBodega IS NOT NULL) THEN
    
		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM BODEGA_SUCURSAL_PRODUCTO WHERE Cod_Bode_Sucu_Produ = pCodBodega) > 0) THEN
				SELECT Cod_Bode_Sucu_Produ, Cod_Producto, Cod_Sucursal, Precio_Compra, Cod_Proveedor, Fecha_Compra, Cantidad_Actual, Fecha_Produccion, Fecha_Vencimiento
				FROM BODEGA_SUCURSAL_PRODUCTO
				WHERE Cod_Bode_Sucu_Produ = pCodBodega;
			ELSE
				SET msgError = 'El codigo de bodega de sucursal no existe,imposible hacer la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM BODEGA_SUCURSAL_PRODUCTO WHERE Cod_Bode_Sucu_Produ = pCodBodega) > 0) THEN
				IF (pPrecioCompra IS NOT NULL AND pPrecioCompra >= 0) THEN
					IF (pCantActual IS NOT NULL AND pCantActual >= 0) THEN
						UPDATE BODEGA_SUCURSAL_PRODUCTO
						SET Precio_Compra=IFNULL(pPrecioCompra,Precio_Compra),Fecha_Compra=IFNULL(pFechaCompra,Fecha_Compra), Cantidad_Actual=IFNULL(pCantActual,Cantidad_Actual), Fecha_Produccion=IFNULL(pFechaProduc,Fecha_Produccion), Fecha_Vencimiento=IFNULL(pFechaVenci,Fecha_Vencimiento)
						WHERE Cod_Bode_Sucu_Produ = pCodBodega;
					ELSE
						SET msgError = 'La cantidad  actual es inválida, no se puede actualizar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El precio de compra es inválido, no se puede actualizar';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El código de bodega de sucursal no existe, no se puede actualizar';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM BODEGA_SUCURSAL_PRODUCTO WHERE Cod_Bode_Sucu_Produ = pCodBodega) > 0) THEN
				IF ((SELECT COUNT(*) FROM PRODUCTO_EXPIRADO WHERE Cod_Bode_Sucu_Produ = pCodBodega) = 0) THEN
					DELETE FROM BODEGA_SUCURSAL_PRODUCTO
					WHERE Cod_Bode_Sucu_Produ = pCodBodega;
				ELSE
					SET msgError = 'Imposible eliminar, código de bodega está asociado a producto expirado';
					SELECT msgError;
				END IF;
            ELSE
				SET msgError = 'No se puede eliminar, el código de bodega de sucursal no existe';
				SELECT msgError;
			END IF;
		END IF;
	
    #el codigo de bodega no es solicitado al crear la bodega, así se evita el mensaje
	ELSEIF ((pCodBodega IS NOT NULL) AND (pOperacion!='CREATE')) THEN
		SET msgError = 'El código de bodega de sucursal está vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ CRIPTOCARTERA ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CRIPTOCARTERA(pCodCliente INT, pNumCriptoCart VARCHAR(25), pContCriptoC INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodCliente IS NOT NULL) THEN
		IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) > 0)THEN
        
			IF (pOperacion = 'CREATE') THEN
				IF (pNumCriptoCart != '' AND pNumCriptoCart IS NOT NULL) THEN
					INSERT INTO CRIPTOCARTERA(Cod_Cliente, Num_Cripto_Cartera)
					VALUES(pCodCliente, pNumCriptoCart);
				ELSE
					SET msgError = 'El numero de cripto cartera está vacío';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'READ') THEN
				IF ((SELECT COUNT(*) FROM CRIPTOCARTERA WHERE Cod_Cliente = pCodCliente) > 0) THEN
					SELECT Cod_Cliente, Num_Cripto_Cartera, Contador_CriptoCar
					FROM CRIPTOCARTERA
					WHERE Cod_Cliente = pCodCliente;
				ELSE
					SET msgError = 'El cliente no tiene cripto carteras asociadas';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'UPDATE')  THEN
				IF ((SELECT COUNT(*) FROM CRIPTOCARTERA WHERE Cod_Cliente = pCodCliente) > 0) THEN
					IF ((SELECT COUNT(*) FROM CRIPTOCARTERA WHERE Contador_CriptoCar = pContCriptoC) > 0) THEN
						UPDATE CRIPTOCARTERA
						SET Num_Cripto_Cartera = IFNULL(pNumCriptoCart, Num_Cripto_Cartera)
						WHERE Cod_Cliente = pCodCliente AND Contador_CriptoCar = pContCriptoC;
					ELSE
						SET msgError = 'El ID de cripto cartera no existe, imposible actualizar datos';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El cliente no tiene cripto carteras asociadas';
					SELECT msgError;
				END IF;
			END IF;
			
			IF (pOperacion = 'DELETE') THEN
				IF ((SELECT COUNT(*) FROM CRIPTOCARTERA WHERE Cod_Cliente = pCodCliente) > 0) THEN
					IF ((SELECT COUNT(*) FROM CRIPTOCARTERA WHERE Contador_CriptoCar = pContCriptoC) = 0) THEN
						DELETE FROM CRIPTOCARTERA
						WHERE Cod_Cliente = pCodCliente AND Contador_CriptoCar = pContCriptoC;
					ELSE
						SET msgError = 'El ID de cripto cartera no existe, no se puede eliminar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El cliente no tiene cripto carteras asociadas';
					SELECT msgError;
				END IF;
			END IF;
            
			ELSE
				SET msgError = 'El codigo de cliente no existe';
				SELECT msgError;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de cliente es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ TARJETA_CREDITO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_TARJECREDI(pCodCliente INT, pNumTarjeCredi VARCHAR(20), pContTarjeCre INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodCliente IS NOT NULL) THEN
		IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) > 0)THEN
        
			IF (pOperacion = 'CREATE') THEN
				IF (pNumTarjeCredi != '' AND pNumTarjeCredi IS NOT NULL) THEN
					INSERT INTO TARJETA_CREDITO(Cod_Cliente, Num_Tarjeta_Credito)
					VALUES(pCodCliente, pNumTarjeCredi);
				ELSE
					SET msgError = 'El numero de tarjeta de credito está vacío';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'READ') THEN
				IF ((SELECT COUNT(*) FROM TARJETA_CREDITO WHERE Cod_Cliente = pCodCliente) > 0) THEN
					SELECT Cod_Cliente, Num_Tarjeta_Credito, Contador_TarjCre
					FROM TARJETA_CREDITO
					WHERE Cod_Cliente = pCodCliente;
				ELSE
					SET msgError = 'El cliente no tiene cripto carteras asociadas';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'UPDATE')  THEN
				IF ((SELECT COUNT(*) FROM TARJETA_CREDITO WHERE Cod_Cliente = pCodCliente) > 0) THEN
					IF ((SELECT COUNT(*) FROM TARJETA_CREDITO WHERE Contador_TarjCre = pContTarjeCre) > 0) THEN
						UPDATE TARJETA_CREDITO
						SET Num_Tarjeta_Credito = IFNULL(pNumTarjeCredi, Num_Tarjeta_Credito)
						WHERE Cod_Cliente = pCodCliente AND Contador_TarjCre = pContTarjeCre;
					ELSE
						SET msgError = 'El ID de tarjeta de credito no existe, imposible actualizar datos';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El cliente no tiene tarjetas de credito asociadas';
					SELECT msgError;
				END IF;
			END IF;
			
			IF (pOperacion = 'DELETE') THEN
				IF ((SELECT COUNT(*) FROM TARJETA_CREDITO WHERE Cod_Cliente = pCodCliente) > 0) THEN
					IF ((SELECT COUNT(*) FROM TARJETA_CREDITO WHERE Contador_TarjCre = pContTarjeCre) > 0) THEN
						DELETE FROM TARJETA_CREDITO
						WHERE Cod_Cliente = pCodCliente AND Contador_TarjCre = pContTarjeCre;
					ELSE
						SET msgError = 'El ID de tarjeta de credito no existe, no se puede eliminar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El cliente no tiene tarjetas de credito asociadas';
					SELECT msgError;
				END IF;
			END IF;
            
			ELSE
				SET msgError = 'El codigo de cliente no existe';
				SELECT msgError;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de cliente es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ CHEQUE ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_CHEQUE(pCodCliente INT, pNumCheque VARCHAR(20), pContCheque INT, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pCodCliente IS NOT NULL) THEN
		IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) > 0)THEN
        
			IF (pOperacion = 'CREATE') THEN
				IF (pNumCheque != '' AND pNumCheque IS NOT NULL) THEN
					INSERT INTO CHEQUE(Cod_Cliente, Num_Cheque)
					VALUES(pCodCliente, pNumCheque);
				ELSE
					SET msgError = 'El numero de cheque está vacío';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'READ') THEN
				IF ((SELECT COUNT(*) FROM CHEQUE WHERE Cod_Cliente = pCodCliente) > 0) THEN
					SELECT Cod_Cliente, Num_Cheque, Contador_Cheque
					FROM CHEQUE
					WHERE Cod_Cliente = pCodCliente;
				ELSE
					SET msgError = 'El cliente no tiene cheques asociados';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'UPDATE')  THEN
				IF ((SELECT COUNT(*) FROM CHEQUE WHERE Cod_Cliente = pCodCliente) > 0) THEN
					IF ((SELECT COUNT(*) FROM CHEQUE WHERE Contador_Cheque = pContCheque) > 0) THEN
						UPDATE CHEQUE
						SET Num_Cheque = IFNULL(pNumCheque, Num_Cheque)
						WHERE Cod_Cliente = pCodCliente AND Contador_Cheque = pContCheque;
					ELSE
						SET msgError = 'El ID de cheque no existe, imposible actualizar datos';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El cliente no tiene cheques asociados';
					SELECT msgError;
				END IF;
			END IF;
			
			IF (pOperacion = 'DELETE') THEN
				IF ((SELECT COUNT(*) FROM CHEQUE WHERE Cod_Cliente = pCodCliente) > 0) THEN
					IF ((SELECT COUNT(*) FROM CHEQUE WHERE Contador_Cheque = pContCheque) > 0) THEN
						DELETE FROM CHEQUE
						WHERE Cod_Cliente = pCodCliente AND Contador_Cheque = pContCheque;
					ELSE
						SET msgError = 'El ID de cheque no existe, no se puede eliminar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El cliente no tiene cheques asociados';
					SELECT msgError;
				END IF;
			END IF;
            
			ELSE
				SET msgError = 'El codigo de cliente no existe';
				SELECT msgError;
		END IF;
        
	ELSE
		SET msgError = 'El codigo de cliente es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ BODEGA_PROVEEDOR_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_BODEPROVEPRODU(pCodBodega INT, pCodProvee INT, pCodProdu INT, pPrecioVenta FLOAT, pCantBodega INT, 
															pFechaProducc DATE, pFechaVenci DATE, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
    
	IF (pOperacion = 'CREATE') THEN
		IF ((SELECT COUNT(*) FROM PROVEEDOR WHERE Cod_Proveedor = pCodProvee) > 0) THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
				IF (pPrecioVenta IS NOT NULL AND pPrecioVenta >= 0) THEN
					IF (pCantBodega IS NOT NULL AND pCantBodega >= 0) THEN
						IF (pFechaProducc IS NOT NULL) THEN
							IF (pFechaVenci IS NOT NULL) THEN
								INSERT INTO BODEGA_PROVEEDOR_PRODUCTO(Cod_Proveedor, Cod_Producto, Precio_Venta, Cantidad_En_Bodega, Fecha_Produccion, Fecha_Vencimiento)
								VALUES(pCodProvee, pCodProdu, pPrecioVenta, pCantBodega, pFechaProducc, pFechaVenci);
							ELSE
								SET msgError = 'La fecha de vencimiento es inválida';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'La fecha de producción es inválida';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'La cantidad en bodega es inválida';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El precio de venta es inválido';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El código de producto no existe';
				SELECT msgError;
			END IF;
		ELSE
			SET msgError = 'El código de proveedor no existe';
			SELECT msgError;
		END IF;
	END IF;
    
	IF (pCodBodega IS NOT NULL) THEN
    
		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM BODEGA_PROVEEDOR_PRODUCTO WHERE Cod_Bode_Provee_Produ = pCodBodega) > 0) THEN
				SELECT Cod_Bode_Provee_Produ, Cod_Proveedor, Cod_Producto, Precio_Venta, Cantidad_En_Bodega, Fecha_Produccion, Fecha_Vencimiento
				FROM BODEGA_PROVEEDOR_PRODUCTO
				WHERE Cod_Bode_Provee_Produ = pCodBodega;
			ELSE
				SET msgError = 'El codigo de bodega de proveedor no existe,imposible hacer la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM BODEGA_PROVEEDOR_PRODUCTO WHERE Cod_Bode_Provee_Produ = pCodBodega) > 0) THEN
				IF (pPrecioVenta IS NOT NULL AND pPrecioVenta >= 0) THEN
					IF (pCantBodega IS NOT NULL AND pCantBodega >= 0) THEN
						UPDATE BODEGA_PROVEEDOR_PRODUCTO
						SET Precio_Venta=IFNULL(pPrecioVenta,Precio_Venta), Cantidad_En_Bodega=IFNULL(pCantBodega,Cantidad_En_Bodega), Fecha_Produccion=IFNULL(pFechaProducc,Fecha_Produccion), Fecha_Vencimiento=IFNULL(pFechaVenci,Fecha_Vencimiento)
						WHERE Cod_Bode_Provee_Produ = pCodBodega;
					ELSE
						SET msgError = 'La cantidad en bodega es inválida, no se puede actualizar';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El precio de venta es inválido, no se puede actualizar';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El código de bodega de proveedor no existe, no se puede actualizar';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM BODEGA_PROVEEDOR_PRODUCTO WHERE Cod_Bode_Provee_Produ = pCodBodega) > 0) THEN
				DELETE FROM BODEGA_PROVEEDOR_PRODUCTO
				WHERE Cod_Bode_Provee_Produ = pCodBodega;
            ELSE
				SET msgError = 'No se puede eliminar, el código de bodega de proveedor no existe';
				SELECT msgError;
			END IF;
		END IF;
	
    #el codigo de bodega no es solicitado al crear la bodega, así se evita el mensaje
	ELSEIF ((pCodBodega IS NOT NULL) AND (pOperacion!='CREATE')) THEN
		SET msgError = 'El código de bodega de proveedor está vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ BONOS_EMPLEADO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_BONOSEMP(pNumBono INT,  pCodEmpleado INT, pMontoBono FLOAT, pFechaBono DATE, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';

	IF (pOperacion = 'CREATE') THEN
		IF ((SELECT COUNT(*) FROM EMPLEADO WHERE Cod_Empleado = pCodEmpleado) > 0) THEN
			IF (pMontoBono IS NOT NULL AND pMontoBono>=0) THEN
				IF (pFechaBono IS NOT NULL) THEN
					INSERT INTO BONOS_EMPLEADO(Cod_Empleado, MontoBono, Fecha_Bono)
					VALUES(pCodEmpleado, pMontoBono, pFechaBono);
				ELSE
					SET msgError = 'La fecha ingresada no es valida';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El monto de bono ingresado no es valido';
				SELECT msgError;
			END IF;
		ELSE
			SET msgError = 'El codigo de empleado no existe';
			SELECT msgError;
		END IF;
	END IF;

	IF (pCodEmpleado IS NOT NULL) THEN
		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM BONOS_EMPLEADO WHERE Num_Bono = pNumBono) > 0) THEN
				SELECT Num_Bono, Cod_Empleado, MontoBono, Fecha_Bono
				FROM BONOS_EMPLEADO
				WHERE Num_Bono = pNumBono;
			ELSE
				SET msgError = 'El codigo bono no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM BONOS_EMPLEADO WHERE Num_Bono = pNumBono) > 0) THEN
				IF (pMontoBono IS NOT NULL AND pMontoBono>=0) THEN
					UPDATE BONOS_EMPLEADO
					SET MontoBono=IFNULL(pMontoBono,MontoBono), Fecha_Bono=IFNULL(pFechaBono,Fecha_Bono)
					WHERE Num_Bono = pNumBono;
				ELSE
					SET msgError = 'El monto de bono ingresado no es valido, no se puede actualizar datos';
					SELECT msgError;
				END IF;
            ELSE
				SET msgError = 'El codigo de bono no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM BONOS_EMPLEADO WHERE Num_Bono = pNumBono) > 0) THEN
				DELETE FROM BONOS_EMPLEADO
				WHERE Num_Bono = pNumBono;
			ELSE
				SET msgError = 'No se puede eliminar, el codigo de bono no existe';
				SELECT msgError;
			END IF;
		END IF;
	
    #el codigo de bono no es solicitado al crear el bono, así se evita el mensaje
	ELSEIF ((pCodEmpleado IS NOT NULL) AND (pOperacion!='CREATE')) THEN
		SET msgError = 'El codigo de bono es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ ESTADO_PEDIDO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_ESTADOP(pIDEstadoP INT,  pDescripEstP VARCHAR(15), pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pIDEstadoP IS NOT NULL) THEN
    
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM ESTADO_PEDIDO WHERE ID_EstadoP = pIDEstadoP) = 0) THEN
				IF (pDescripEstP != '' AND pDescripEstP IS NOT NULL) THEN
					INSERT INTO ESTADO_PEDIDO(ID_EstadoP, Descripcion_EstadoP)
					VALUES(pIDEstadoP, pDescripEstP);
				ELSE
					SET msgError = 'La descripción del estado de pedido está vacía';
					SELECT msgError;
                END IF;
			ELSE
				SET msgError = 'El ID de estado de pedido ya existe';
				SELECT msgError;
            END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM ESTADO_PEDIDO WHERE ID_EstadoP = pIDEstadoP) > 0) THEN
				SELECT ID_EstadoP, Descripcion_EstadoP
				FROM ESTADO_PEDIDO
				WHERE ID_EstadoP = pIDEstadoP;
			ELSE
				SET msgError = 'El ID de estado de pedido no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM ESTADO_PEDIDO WHERE ID_EstadoP = pIDEstadoP) > 0) THEN
				UPDATE ESTADO_PEDIDO
				SET Descripcion_EstadoP = IFNULL(pDescripEstP, Descripcion_EstadoP)
				WHERE ID_EstadoP = pIDEstadoP;
			ELSE
				SET msgError = 'El ID de estado de pedido no existe, no se pudo actualizar los datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM ESTADO_PEDIDO WHERE ID_EstadoP = pIDEstadoP) > 0) THEN
				IF ((SELECT COUNT(*) FROM PEDIDO WHERE ID_EstadoP = pIDEstadoP) = 0) THEN
					DELETE FROM ESTADO_PEDIDO
					WHERE ID_EstadoP = pIDEstadoP;
				ELSE
					SET msgError = 'No se puede eliminar, estado de pedido asociado a pedido';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el estado de pedido no existe';
				SELECT msgError;
			END IF;
		END IF;
	
	ELSE
		SET msgError = 'El ID de estado de pedido está vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ PEDIDO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PEDIDO(pNumPedido INT, pFechaPedido DATE, pCodCliente INT, pIDEstadoP INT, pEnvio BOOL, pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pNumPedido IS NOT NULL) THEN
        
		IF (pOperacion = 'CREATE') THEN
			IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) = 0) THEN
				IF (pFechaPedido IS NOT NULL) THEN
					IF ((SELECT COUNT(*) FROM CLIENTE WHERE Cod_Cliente = pCodCliente) > 0) THEN
						IF ((SELECT COUNT(*) FROM ESTADO_PEDIDO WHERE ID_EstadoP = pIDEstadoP) > 0) THEN
							IF (pEnvio IS NOT NULL) THEN
								INSERT INTO PEDIDO(Num_Pedido, Fecha_Pedido, Cod_Cliente, ID_EstadoP, Envio)
								VALUES(pNumPedido, pFechaPedido, pCodCliente, pIDEstadoP, pEnvio);
                            ELSE
								SET msgError = 'El dato del envío es nulo';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'El codigo del estado del pedido no existe';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'El codigo de cliente no existe';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'La fecha de la factura es inválida';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El numero de pedido ya existe';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
				SELECT Num_Pedido, Fecha_Pedido, Cod_Cliente, ID_EstadoP, Envio
				FROM PEDIDO
				WHERE Num_Pedido = pNumPedido;
			ELSE
				SET msgError = 'El numero de pedido no existe, no se puede realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
				IF ((SELECT COUNT(*) FROM ESTADO_PEDIDO WHERE ID_EstadoP = pIDEstadoP) > 0) THEN
					UPDATE PEDIDO
					SET Envio = IFNULL(pEnvio,Envio), ID_EstadoP = IFNULL(pIDEstadoP,ID_EstadoP)
					WHERE Num_Pedido = pNumPedido;
				ELSE
					SET msgError = 'El codigo de estado de pedido no existe, no se puede actualizar datos';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'El numero de pedido no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
		
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
				IF ((SELECT COUNT(*) FROM PEDIDO_PRODUCTO WHERE Num_Pedido = pNumPedido) > 0) THEN
					IF ((SELECT COUNT(*) FROM FACTURA WHERE Num_Pedido = pNumPedido) > 0) THEN
							DELETE FROM PEDIDO
							WHERE Num_Pedido = pNumPedido;
					ELSE
						SET msgError = 'No se puede eliminar, el numero de pedido esta asociado a una factura';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, el pedido esta asociado a una orden de productos';
					SELECT msgError;
				END IF;
			ELSE
				SET msgError = 'No se puede eliminar, el numero de pedido no existe';
				SELECT msgError;
			END IF;
		END IF;
            
	ELSE
		SET msgError = 'El numero de pedido es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ PEDIDO_PRODUCTO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PEDIDOxPRODU(pNumPedido INT, pCodProdu INT, pCantProdu INT, pPorcenDesc FLOAT, pMotivoDesc VARCHAR(15),  pOperacion VARCHAR(10))
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
	IF (pNumPedido IS NOT NULL) THEN
		IF (pCodProdu IS NOT NULL) THEN
        
			IF (pOperacion = 'CREATE') THEN
				IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
					IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
						IF (pPorcenDesc IS NOT NULL AND pPorcenDesc>=0) THEN
							IF (pCantProdu IS NOT NULL AND pCantProdu>0) THEN
								INSERT INTO PEDIDO_PRODUCTO(Num_Pedido, Cod_Producto, Cantidad_Producto, Porcentaje_Desc, Motivo_Desc)
								VALUES(pNumPedido, pCodProdu, pCantProdu, pPorcenDesc, pMotivoDesc);
							ELSE
								SET msgError = 'La cantidad de productos es inválida';
								SELECT msgError;
							END IF;
						ELSE
							SET msgError = 'El porcentaje de descuento es inválido';
							SELECT msgError;
						END IF;
					ELSE
						SET msgError = 'El codigo de producto no existe';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El numero de pedido no existe';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'READ') THEN
				IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
					IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
						SELECT Num_Pedido, Cod_Producto, Cantidad_Producto, Porcentaje_Desc, Motivo_Desc
						FROM PEDIDO_PRODUCTO
						WHERE Num_Pedido = pNumPedido AND Cod_Producto = pCodProdu;
					ELSE
						SET msgError = 'El codigo de producto no existe, no se puede realizar la busqueda';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El numero de pedido no existe, no se puede realizar la busqueda';
					SELECT msgError;
				END IF;
			END IF;

			IF (pOperacion = 'UPDATE')  THEN
				IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
					IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
							IF (pPorcenDesc IS NOT NULL AND pPorcenDesc>=0) THEN
								IF (pCantProdu IS NOT NULL AND pCantProdu>0) THEN
									UPDATE PEDIDO_PRODUCTO
									SET Cantidad_Producto = IFNULL(pCantProdu,Cantidad_Producto), Porcentaje_Desc=IFNULL(pPorcenDesc,Porcentaje_Desc), Motivo_Desc=IFNULL(pMotivoDesc,Motivo_Desc)
									WHERE Num_Pedido = pNumPedido AND Cod_Producto=pCodProdu;
								ELSE
									SET msgError = 'La cantidad de productos es inválida, no se puede actualizar datos';
									SELECT msgError;
								END IF;
							ELSE
								SET msgError = 'El porcentaje de descuento es inválido, no se puede actualizar datos';
								SELECT msgError;
							END IF;
					ELSE
						SET msgError = 'El codigo de producto no existe, no se puede actualizar datos';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El numero de pedido no existe, no se puede actualizar datos';
					SELECT msgError;
				END IF;
			END IF;
			
			IF (pOperacion = 'DELETE') THEN
				IF ((SELECT COUNT(*) FROM PEDIDO WHERE Num_Pedido = pNumPedido) > 0) THEN
					IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) > 0) THEN
							DELETE FROM PEDIDO_PRODUCTO
							WHERE Num_Pedido = pNumPedido AND Cod_Producto=pCodProdu;
					ELSE
						SET msgError = 'No se puede eliminar, el codigo de producto no existe';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'No se puede eliminar, el numero de pedido no existe';
					SELECT msgError;
				END IF;
			END IF;
            
        ELSE
			SET msgError = 'El codigo de producto es vacío';
			SELECT msgError;
		END IF;
	ELSE
		SET msgError = 'El numero de pedido es vacío';
        SELECT msgError;
	END IF;
END;
//

/*------------------------------------------------------------ PRODUCTO_EXPIRADO ------------------------------------------------------------*/
delimiter //
CREATE PROCEDURE CRUD_PRODUCTO_EXPIRADO(pCodProduExp INT, pCodProdu INT, pCantProExp INT, pBodeSucuProdu INT, pOperacion VARCHAR(10)) 
BEGIN
DECLARE msgError VARCHAR(70) DEFAULT '';
    
	IF (pOperacion = 'CREATE') THEN
		IF ((SELECT COUNT(*) FROM PRODUCTO WHERE Cod_Producto = pCodProdu) = 0) THEN
				IF ((SELECT COUNT(*) FROM BODEGA_SUCURSAL_PRODUCTO WHERE Cod_Bode_Sucu_Produ = pBodeSucuProdu) > 0) THEN
					IF (pCantProExp IS NOT NULL AND pCantProExp>=0) THEN
							INSERT INTO PRODUCTO_EXPIRADO (Cod_Producto, Cantidad_Productos, Cod_Bode_Sucu_Produ) 
							VALUES (pCodProdu, pCantProExp, pBodeSucuProdu);
					ELSE
						SET msgError = 'La cantidad de productos expirados no es válida';
						SELECT msgError;
					END IF;
				ELSE
					SET msgError = 'El código de bodega sucursal no existe';
					SELECT msgError;
				END IF;
		ELSE
			SET msgError = 'El código de producto no existe';
			SELECT msgError;
		END IF;
	END IF;
    
	IF (pCodProdu IS NOT NULL) THEN
    
		IF (pOperacion = 'READ') THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO_EXPIRADO WHERE Cod_Producto_Exp = pCodProduExp) > 0) THEN
				SELECT Cod_Producto, Cantidad_Productos, Cod_Bode_Sucu_Produ
				FROM PRODUCTO_EXPIRADO
				WHERE Cod_Producto_Exp = pCodProduExp;
			ELSE
				SET msgError = 'El codigo producto expirado no existe, imposible realizar la busqueda';
				SELECT msgError;
			END IF;
		END IF;

		IF (pOperacion = 'UPDATE')  THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO_EXPIRADO WHERE Cod_Producto_Exp = pCodProduExp) > 0) THEN
				IF (pCantProExp IS NOT NULL AND pCantProExp>=0) THEN
						UPDATE PRODUCTO_EXPIRADO
						SET Cantidad_Productos=IFNULL(pCantProExp,Cantidad_Productos)
						WHERE Cod_Producto_Exp = pCodProduExp;
					ELSE
						SET msgError = 'Cantidad de productos expirados es inválida,imposible actualizar datos';
						SELECT msgError;
					END IF;
            ELSE
				SET msgError = 'El codigo de producto expirado no existe, no se puede actualizar datos';
				SELECT msgError;
			END IF;
		END IF;
        
		IF (pOperacion = 'DELETE') THEN
			IF ((SELECT COUNT(*) FROM PRODUCTO_EXPIRADO WHERE Cod_Producto_Exp = pCodProduExp) > 0) THEN
				DELETE FROM PRODUCTO_EXPIRADO
				WHERE Cod_Producto_Exp = pCodProduExp;
			 ELSE
				SET msgError = 'El codigo de producto expirado no existe, no se puede eliminar datos';
				SELECT msgError;
			END IF;
		END IF;
        
    #el codigo de producto expirado no es solicitado al crear el registro, así se evita el mensaje
	ELSEIF ((pCodEmpleado IS NOT NULL) AND (pOperacion!='CREATE')) THEN
		SET msgError = 'El codigo de producto expirado es vacío';
        SELECT msgError;
	END IF;
END;
//