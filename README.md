# Supermercado-BasesDatos1
 
Una cadena de supermercados los ha contratado para que le realicen el sistema para poder administrar todo el supermercado.

La cadena cuenta con varias sucursales en todo Centroamérica; en cada una de las sucursales se cuenta con una planilla (empleados) donde se 
mantienen un grupo de personas que son facturadores, jefe de piso, acomodadores, carniceros, verduleros, secretaria, gerente, conserjes, etc. 
Cada empleado tiene un salario base, y cada 3 meses se les da bonos dependiendo de su “performance”. Cada sucursal es administrada por una persona que le 
genera reportes al gerente general. Los empleados se pueden ingresar y consultar ya sea por sucursal, por puesto o por fechas de contratación.

La empresa cuenta con una red de proveedores quienes son los que le abastecen cada uno de los productos a la venta; el precio de venta en el 
supermercado tiene un porcentaje que se le aplica para manejar la ganancia, este porcentaje puede ser diferente para cada proveedor. 
Los proveedores se pueden buscar también por nombre de producto, nombre de proveedor. 

Cada uno de los productos a la venta tienen una fecha de producción y una de expiración, cada semana un acomodador debe revisar todos los productos 
para determinar si van a expirar en una semana y se pone en descuento, si un producto ya ha expirado debe de sacarlo del exhibidor.

Para cada producto se maneja un mínimo y un máximo, cuando las existencias llegan al mínimo, es cuando ha alcanzado el punto de reorden, por 
lo que se debe de entonces hacer el pedido del producto a los proveedores para poder llenar la cantidad de productos para que alcance el máximo. 
La forma en que se realiza el pedido es que debe de buscar el proveedor que ofrezca el producto más barato, que tenga existencias.

Existen productos que tienen impuesto y otros que son exentos, los impuestos son variables dependiendo de la categoría del producto.

Los clientes del supermercado se manejan de manera digital, de forma que un cliente puede ir y realizar sus compras físicamente, o por medio de la 
aplicación WEB, cada cliente puede solicitar que le envíen sus compras a su domicilio. El envío tiene un costo de un 0.1% del monto pagado. En todo 
momento para pagar física o virtualmente, el cliente debe de tener un usuario, y con base en eso es que se le factura. Se debe poder consultar luego los montos 
recolectados por envíos, por fechas, sucursal y/o cliente.

El cliente puede realizar el pago por medio de diferentes métodos, criptomonedas, tarjetas de crédito, cheque, efectivo, etc.

La empresa otorga un bono a los facturadores que hayan facturado más de 1000 productos en una semana.

Se deben realizar reportes donde el gerente general pueda sacar estadísticas de ventas por país, producto y/o por fechas tanto a nivel de cada 
sucursal como de todas las sucursales y/o proveedores, , en ellas se debe poder ver cosas productos más vendidos, clientes más frecuentes, productos que han 
expirado. 

Se debe poder obtener información sobre ganancias netas igualmente por fechas, país, sucursales y/o categoría de productos.
Se debe poder obtener información sobre los bonos recibidos por empleado, fechas, sucursal y/o país.
Se debe poder obtener información sobre precios de productos, productos por proveedor.

Se debe entregar todos los puntos que se encuentran en la carta del estudiante, debe generar tablas, CRUD, procedimientos/funciones para el 
problema descrito.
