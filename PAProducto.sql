if OBJECT_ID('spAgregarProducto') is not null
drop proc spAgregarProducto
go
create proc spAgregarProducto
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

if OBJECT_ID('spListarProducto') is not null
drop proc spListarProducto
go
create proc spListarProducto
as 
begin 
	select*from TProducto
end 
go

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

if OBJECT_ID('spBuscarProducto') is not null
drop proc spBuscarProducto
go
create proc spBuscarProducto
@CodProducto varchar(6)
as
	begin
	select*from TProducto where CodProducto=@CodProducto
	end
go