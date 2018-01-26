use BDEcommerce
go

if OBJECT_ID('spAgregarCliente') is not null
	drop proc spAgregarCliente
go
create proc spAgregarCliente
@Nombres varchar(25),@Apellidos varchar(40),@Sexo varchar(1),@TipoDocumento varchar(20),
@NroDocumento varchar(20),@Email varchar(30),@Provincia varchar(30),@Ciudad varchar(30),
@Distrito varchar(25),@Direccion varchar(30),@Usuario varchar(50),@Contrasena varchar(40),
@RazonSocial varchar(30),@RUC varchar(15),@FechaNac datetime,@EstadoCivil varchar(15),
@Ocupacion varchar(20),@Telefono varchar(10),@CodPais varchar(3)
as
	If Not Exists(Select * from TCliente Where Nombres = @Nombres And Apellidos = @Apellidos)
begin
	insert into TCliente VALUES (@Nombres,@Apellidos,@Sexo,@TipoDocumento,@NroDocumento,
	@Email,@Provincia ,@Ciudad,@Distrito,@Direccion,@Usuario,@Contrasena,
@RazonSocial,@RUC,@FechaNac,@EstadoCivil,@Ocupacion,@Telefono,@CodPais)
select CodError = 0, Mensaje = 'Cliente registrado'
end
Else
		select CodError = 1, Mensaje = 'Ya existe ese cliente'

go

if OBJECT_ID('spListarCliente') is not null
	drop proc spListarCliente
go
create proc spListarCliente
as
begin
	select*from TCliente
end
go

if OBJECT_ID('spEliminarCliente') is not null
	drop proc spEliminarCliente
go
create proc spEliminarCliente
@CodCliente int
as
 begin
	if exists(select CodCliente from TCliente where CodCliente=@CodCliente)
		
			begin 
			delete from TCliente where CodCliente=@CodCliente
			select CodError =0,Mensaje= 'Cliente Eliminado Correctamente'
			end
	else select CodError=1,Mensaje='Error:Cliente no existe'
end
go

--Actuzalizar Cliente

if OBJECT_ID('spActualizarCliente') is not null
	drop proc spActualizarCliente
go
create proc spActualizarCliente
@Nombres varchar(25),@Apellidos varchar(40),@Sexo varchar(1),@TipoDocumento varchar(20),
@NroDocumento varchar(20),@Email varchar(30),@Provincia varchar(30),@Ciudad varchar(30),
@Distrito varchar(25),@Direccion varchar(30),@Usuario varchar(50),@Contrasena varchar(40),
@RazonSocial varchar(30),@RUC varchar(15),@FechaNac datetime,@EstadoCivil varchar(15),
@Ocupacion varchar(20),@Telefono varchar(10),@CodPais varchar(3)
as
begin
	update TCliente set Nombres=@Nombres,Apellidos=@Apellidos,Sexo=@Sexo,TipoDocumento=@TipoDocumento,
	NroDocumento=@NroDocumento,Email=@Email,Provincia=@Provincia,Ciudad=@Ciudad,Distrito=@Distrito,
	Direccion=@Direccion,Usuario=@Usuario,Contrasena=@Contrasena,RazonSocial=@RazonSocial,RUC=@RUC,
	FechaNac=@FechaNac,EstadoCivil=@EstadoCivil,Ocupacion=@Ocupacion,Telefono=@Telefono,CodPais=@CodPais
	where Usuario=@Usuario
end
go

if OBJECT_ID('spLoginUser') is not null
drop proc spLoginUser
go

create proc spLoginUser
@Usuario varchar(50),@Contrasena varchar(50)
as
begin
		if exists(select Usuario from TCliente
					where Usuario=@Usuario and Contrasena=@Contrasena)
					select CodError=0,Mensaje = 'Usuario Logeado correctamente'
	
	else select CodError=1,Mensaje='No se encuentra el usuario y/o es invalido'
end
go