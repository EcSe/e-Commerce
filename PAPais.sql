-- PA de mantenimiento de TPais
use BDEcommerce
go 

if OBJECT_ID('uspListarPais') is not null
	drop proc uspListarPais
go
create proc uspListarPais
as
begin
	select * from TPais
end
go

exec uspListarPais
go	

-- Agregar Pais
if OBJECT_ID('uspAgregarPais') is not null
	drop proc uspAgregarPais
go
create proc uspAgregarPais
@CodPais varchar(3), @Nombre varchar(20)
as
begin
	if not exists(select CodPais from TPais where CodPais=@CodPais)
		if not exists(select Nombre from TPais where Nombre= @Nombre)
			begin
				insert into TPais values(@CodPais,@Nombre)
				select CodError= 0, Mensaje = 'Pais insertado correctamente'
			end			
		else select CodError=1, Mensaje = 'Error: Nombre de pais duplicado'
	else select CodError = 1, Mensaje = 'Error: CodPais duplicado'
end
go

exec uspAgregarPais '010','Suiza'
go	

-- Eliminar Pais
if OBJECT_ID('uspEliminarPais') is not null
	drop proc uspEliminarPais
go
create proc uspEliminarPais
@CodPais varchar(3)
as
begin
	if exists(select CodPais from TPais where CodPais=@CodPais)
		if not exists(select CodPais from TCliente where CodPais=@CodPais)
			begin
				delete from TPais where CodPais=@CodPais
				select CodError= 0, Mensaje = 'Pais eliminado correctamente'
			end			
		else select CodError=1, Mensaje = 'Error: CodPais en tabla TCliente'
	else select CodError = 1, Mensaje = 'Error: CodPais no existe'
end
go

exec uspEliminarPais '010'
go	
