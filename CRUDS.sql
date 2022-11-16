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