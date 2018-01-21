<<<<<<< HEAD
=======
use BDEcommerce
go

--PA PARA AGREGAR PRODUCTO
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
if OBJECT_ID('spAgregarProducto') is not null
drop proc spAgregarProducto
go
create proc spAgregarProducto
<<<<<<< HEAD
@CodProducto varchar(6), @Nombre varchar(35), @Descripcion nvarchar(2000),
@Especificacion varchar(40), @Peso numeric(8,2), @Longitud numeric(8,2),
@Alto numeric(8,2), @Ancho numeric(8,2), @Diametro numeric(8,2),
@Precio money, @CodSubCategoria varchar(4)
as
	if not exists(select * from TProducto where CodProducto=@CodProducto)
		begin
			insert Into TProducto Values(@CodProducto, @Nombre, @Descripcion, @Especificacion, @Peso, @Longitud, @Alto,
		@Ancho, @Diametro, @Precio, @CodSubCategoria);
		Select CodError = 0, Mensaje = 'Se ingreso producto correctamente';
		end
		else
	select CodError = 1 ,Mensaje ='Ya existe el cliente';
go

=======
@CodProd varchar(6),@Nombre varchar(6),@Descripcion nvarchar(2000),@Especificacion varchar(40),
@Peso numeric(8,2),@Longitud numeric(8,2),@Alto numeric(8,2),@Ancho numeric(8,2),@Diametro numeric(8,2),
@Precio money,@CodSUbCategoria varchar(4)
as
	if not exists(select * from TProducto where CodProducto=@CodProd)
begin
	INSERT INTO TProducto VALUES(@CodProd,@Nombre,@Descripcion,@Especificacion,@Peso,@Longitud,@Alto,
	@Ancho,@Diametro,@Precio,@CodSUbCategoria)
select CodError= 0,  Mensaje='Producto Agregado Correctamente'
end
else
	Select CodError=1, Mensaje='Ya existe un producto con ese codigo'
go

--PA PARA LISTAR PRODUCTO
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
if OBJECT_ID('spListarProducto') is not null
drop proc spListarProducto
go
create proc spListarProducto
<<<<<<< HEAD
as 
begin 
=======
as
begin
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
	select*from TProducto
end 
go

<<<<<<< HEAD
if OBJECT_ID('spEliminarProducto') is not null
drop proc spEliminarProducto
go
create proc spEliminarProducto
@CodProducto varchar(6)
as
	if not exists( select * from TDetalleCompras where CodProducto= @CodProducto)
	begin 
		delete from TProducto where CodProducto=@CodProducto
		select CodError = 0,Mensaje='Producto eliminado correctamente';
	end
	else 
		select CodError = 1, Mensaje='Este producto esta en pedido';
go

=======
--PA PARA ELIMINAR PRODUCTO
IF OBJECT_ID('spEliminarProducto') is not null
drop proc spEliminarProducto
go
create proc spEliminarProducto
@CodProd varchar(6)
as
begin
	if  exists(select CodProducto from TProducto where CodProducto=@CodProd)
begin 
	delete from TProducto where CodProducto=CodProducto
select CodError=0, Mensaje='Producto Eliminado'
end
else select CodError= 1, Mensaje = 'El Producto no existe'
end
go

--PA PARA ACTUALIZAR PRODUCTO
if OBJECT_ID('spActualizarProducto') is not null
drop proc spActualizarProducto
go
create proc spActualizarProducto
@CodProd varchar(6),@Nombre varchar(6),@Descripcion nvarchar(2000),@Especificacion varchar(40),
@Peso numeric(8,2),@Longitud numeric(8,2),@Alto numeric(8,2),@Ancho numeric(8,2),@Diametro numeric(8,2),
@Precio money,@CodSUbCategoria varchar(4)
as
	if exists(select CodProducto from TProducto where CodProducto=@CodProd)
		begin 
		update TProducto set Nombre=@Nombre,Descripcion=@Descripcion,Especificacion=@Especificacion,
		Peso=@Peso,Longitud=@Longitud,Alto=@Alto,Ancho=@Ancho,Diametro=@Diametro,Precio=@Precio,
		CodSubCategoria=@CodSUbCategoria
	select CodError=0, Mensaje = 'Producto Actualizado'
		end
	else select CodError=1, Mensaje = 'El producto no existe'
go

--PA PARA BUSCAR PRODUCTO
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
if OBJECT_ID('spBuscarProducto') is not null
drop proc spBuscarProducto
go
create proc spBuscarProducto
<<<<<<< HEAD
@CodProducto varchar(6)
as
	begin
	select*from TProducto where CodProducto=@CodProducto
	end
go
=======
@CodProd varchar(6)
as
	begin
		select*from TProducto where CodProducto=@CodProd
	end
go
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
