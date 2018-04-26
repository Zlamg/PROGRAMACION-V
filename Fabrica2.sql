create database fabrica
go

use fabrica 
go

create table proveedor(
cod_proveedor int primary key,
nombre_proveedor varchar(30),
apellido_proveedor varchar(30),
direccion_proveedor varchar (50),
celular_proveedor varchar(10)
)
create table entrega(
cod_entrega int primary key,
cod_proveedor int not null references proveedor(cod_proveedor),
fecha_entrega date, 
cantida_entrega int,
precioU float,
deud float
)

create table pagos(
cod_pagos int primary key,
cod_entrega int not null references entrega(cod_entrega),
fecha_pagos date,
pago float
)
--create table compra(
--cod_compra int primary key,
--cod_proveedor int not null references proveedor(cod_proveedor),
--cantidad_lunes int,
--cantidad_martes int,
--cantidad_miercoles int,
--cantidad_jueves int,
--cantidad_viernes int,
--cantidad_sabado int,
--cantidad_domingo int,
--precioU_compra money,
--precioT_compra money
--)


create table producto(
cod_producto int primary key,
nombre_producto varchar(30),
precioU_producto money,
stock_producto int
)
create table cliente(
cod_cliente int primary key,
nombre_cliente varchar(30),
direccion_cliente varchar(50),
telefono_cliente varchar(10)
)
create table factura(
cod_factura int primary key,
cod_cliente int references cliente(cod_cliente),
fecha_factura date default getdate()
iva_factura float,

valor_factura money default 0,
)
create table detalle(
cod_detalle int primary key,
cod_factura int not null references factura(cod_factura),
cod_producto int not null references producto(cod_producto),
cantidadVendida int,
precioUnitario money
)

insert into proveedor(cod_proveedor,nombre_proveedor,direccion_proveedor,celular_proveedor) values (1,'Cecilia','Ibarra','098142622')
insert into proveedor(cod_proveedor,nombre_proveedor,direccion_proveedor,celular_proveedor) values (2,'Mauricio','Ibarra','098142622')
insert into proveedor(cod_proveedor,nombre_proveedor,direccion_proveedor,celular_proveedor) values (3,'Arcos','Ibarra','098142622')

insert into compra(cod_compra,cod_proveedor,cantidad_lunes,cantidad_martes,cantidad_miercoles,cantidad_jueves,cantidad_viernes,cantidad_sabado,cantidad_domingo,precioU_compra,precioT_compra) values (1,1,56,45,35,34,34,23,32,0.36,101.52)
insert into compra(cod_compra,cod_proveedor,cantidad_lunes,cantidad_martes,cantidad_miercoles,cantidad_jueves,cantidad_viernes,cantidad_sabado,cantidad_domingo,precioU_compra,precioT_compra) values (2,1,56,45,35,34,34,23,32,0.36,101.52)
insert into compra(cod_compra,cod_proveedor,cantidad_lunes,cantidad_martes,cantidad_miercoles,cantidad_jueves,cantidad_viernes,cantidad_sabado,cantidad_domingo,precioU_compra,precioT_compra) values (3,1,56,45,35,34,34,23,32,0.36,101.52)

insert into producto(cod_producto,nombre_producto,precioU_producto,stock_producto) values (1,'Prensado',1.8,200)
insert into producto(cod_producto,nombre_producto,precioU_producto,stock_producto) values (2,'Amasado',1.2,150)
insert into producto(cod_producto,nombre_producto,precioU_producto,stock_producto) values (3,'Picado',1.8,300)

insert into cliente(cod_cliente,nombre_cliente,direccion_cliente,telefono_cliente) values (1,'Saus','Ibarra','0993654812')
insert into cliente(cod_cliente,nombre_cliente,direccion_cliente,telefono_cliente) values (2,'Salo','Ibarra','0993654812')
insert into cliente(cod_cliente,nombre_cliente,direccion_cliente,telefono_cliente) values (3,'Luis','Ibarra','0993654812')

insert into factura(cod_factura,cod_cliente,valor_factura,fecha_factura) values (1,1,360,'01-04-2016')
insert into factura(cod_factura,cod_cliente,valor_factura,fecha_factura) values (2,1,380,'07-04-2016')
insert into factura(cod_factura,cod_cliente,valor_factura,fecha_factura) values (3,2,24,'13-04-2016')

insert into detalle(cod_detalle,cod_factura,cod_producto,cantidadVendida,precioUnitario) values (1,1,1,200,1.8)
insert into detalle(cod_detalle,cod_factura,cod_producto,cantidadVendida,precioUnitario) values (2,2,1,200,1.9)
insert into detalle(cod_detalle,cod_factura,cod_producto,cantidadVendida,precioUnitario) values (3,3,2,20,1.2)

select *from detalle
select *from proveedor
select * from factura order by cod_factura desc
select * from factura


--Imprimir todos los nombres de los proveedores que entregaron la semana del 19 al 25 de junio del 2016



--Trigger que cada ve que se inserte una fila en la tabla Detalles, incremente el valor 
--del producto vendido en la factura correspondiente.
create trigger tr_insert_producto
on detalle  after insert
as 
declare @producto int;
declare @cantidad int;
select @producto=inserted.cod_producto,  @cantidad=inserted.cantidadVendida from inserted
update producto set stock_producto=stock_producto-@cantidad where cod_producto=@producto
select * from  producto
