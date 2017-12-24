use master
go
-- Creaci�n de la Base de Datos
begin
if  db_id('BDEcommerce') is not null   
 drop database BDEcommerce
end
create database BDEcommerce
go
 
use BDEcommerce
go
  
--Creaci�n de Tablas :
--Creaci�n de la tabla TPais :
if OBJECT_ID('TPais','U') is not null
 drop table TPais
go 
create table TPais
(
 CodPais varchar(3) not null constraint pk_CodPais primary key(CodPais),
 Nombre varchar(20)
)
 
--Creaci�n de la tabla TCategoria:
if OBJECT_ID('TCategoria','U') is not null
 drop table TCategoria
go 
create table TCategoria
(
 CodCategoria  varchar(2) not null constraint pk_CodCategoria primary key(CodCategoria),
 Nombre varchar(20)
)
 
go
--Creaci�n de la tabla TSubCategoria:
if OBJECT_ID('TSubCategoria','U') is not null
 drop table TSubCategoria
go 
create table TSubCategoria
(
 CodSubCategoria  varchar(4) not null constraint pk_CodSubCategoria primary key(CodSubCategoria),
 Nombre varchar(25),
 CodCategoria varchar(2) not null constraint fk_CodCategoria foreign key references TCategoria(CodCategoria)
)
 
go
 
--Creaci�n de la tabla TProducto:
if OBJECT_ID('TProducto','U') is not null
 drop table TProducto
go 
create table TProducto
(
 CodProducto varchar(6) not null constraint pk_CodProducto primary key (CodProducto),
 Nombre  varchar(35),
 Descripcion nvarchar(2000),
 Especificacion varchar(40),
 Peso numeric(8,2),
 Longitud numeric(8,2),
 Alto numeric(8,2),
 Ancho numeric(8,2),
 Diametro numeric(8,2),
 Precio money CONSTRAINT prod_precio DEFAULT (0),
 CodSubCategoria  varchar(4) not null constraint fk_CodSubCategoria foreign key references TSubCategoria(CodSubCategoria)
)
go
--Creaci�n de la tabla TCliente:
if OBJECT_ID('TCliente','U') is not null
 drop table TCliente
go 
create table TCliente
(
 CodCliente int not null constraint pk_CodCliente primary key(CodCliente) IDENTITY (1, 1),
 Nombres varchar(25),
 Apellidos varchar(40),
 Sexo  char(1),
 TipoDocumento  varchar(20),
 NroDocumento varchar(20),
 Email  varchar(30)not null constraint uq_Email unique nonclustered, 
 Provincia varchar(30),
 Ciudad varchar(30),
 Distrito  varchar(25),
 Direccion  varchar(30),
 Usuario  varchar(50)not null constraint uq_Usuario unique nonclustered,
 Contrasena varchar(40),
 RazonSocial varchar(30),
 RUC varchar(15),
 FechaNac datetime, 
 EstadoCivil  varchar(15),
 Ocupacion  varchar(20),
 Telefono varchar(10),
 CodPais varchar(3) constraint fk_CodPais foreign key references TPais(CodPais)
)
go
 
 
--Creaci�n de la tabla TCompra:
if OBJECT_ID('TCompra','U') is not null
 drop table TCompra
go 
create table TCompra
(
 CodCompra varchar(10) not null constraint pk_CodCompra primary key (CodCompra),
 CodCliente int constraint fk_CodCliente foreign key references TCliente(CodCliente),
 Total money,
 FechaCompra datetime default getdate(),
 FechaEntrega  datetime
)
go
 
 
--Creaci�n de la tabla TDetalleCompra:
if OBJECT_ID('TDetalleCompras','U') is not null
 drop table TDetalleCompras
go 
create table TDetalleCompras
(
 CodCompra varchar(10) constraint fk_CodCompra foreign key references TCompra(CodCompra),
 CodProducto varchar(6) constraint fk_CodProducto foreign key references TProducto(CodProducto),
 Cantidad integer,
 Precio money
 constraint pk_CodDetalleCompras primary key (CodCompra,CodProducto)
)
--
go
--Creaci�n de la tabla TDireccionEnvio:
if OBJECT_ID('TDireccionEnvio','U') is not null
 drop table TDireccionEnvio
go 
create table  TDireccionEnvio
(
 CodDireccionEnvio int not null constraint pk_CodDireccionEnvio primary key (CodDireccionEnvio) IDENTITY (1, 1),
 Nombre varchar (30), 
 Provincia varchar(30),
 Ciudad varchar(30),
 Distrito  varchar(20),
 Direccion  varchar(30),
 Telefono  varchar(10),
 NombreDestinatario  varchar(20),
 ApellidoDestinatario varchar(30),
 CodCliente int constraint fk_CodDireccionEnvio foreign  key references TCliente (CodCliente)
)
go
 
--Creaci�n de Tablas Pasarela:
--Creaci�n de la tabla TClientePasarela:
if OBJECT_ID('TClientePasarela','U') is not null
 drop table TClientePasarela
go 
 
create table TClientePasarela
(
 CodCliente int not null primary key,
 Nombres varchar(30),
 Apellidos varchar(50),
 Cuidad varchar(20),
 Provincia varchar(20),
 Distrito varchar(20),
 Sexo varchar(10),
 Estado varchar(20),
 TipoDocumento varchar(10),
 DNI char(8)
)
go
 
--Creaci�n de la tabla TCuentaAhorroPasarela
if OBJECT_ID('TCuentaAhorroPasarela','U') is not null
 drop table TCuentaAhorroPasarela
go 
create table TCuentaAhorroPasarela
(
 NroCuenta  varchar(16)not null primary key,
 TipoDeCuenta varchar(40),
 Banco varchar(40),
 CodCliente int,
 foreign key (CodCliente) references TClientePasarela(CodCliente)
)
go
 
--Creaci�n de la tabla TTarjetaPasarela
if OBJECT_ID('TTarjetaPasarela','U') is not null
 drop table TTarjetaPasarela
go 
create table TTarjetaPasarela
(
 NroTarjeta varchar(16)not null primary key,
 TipoTarjeta varchar(40),
 Contrasena char(40),
 NroCuenta  varchar(16),
 foreign key (NroCuenta) references TCuentaAhorroPasarela(NroCuenta)
)
go 
 
 
--Creaci�n de la tabla TMovimientoPasarela
if OBJECT_ID('TMovimientoPasarela','U') is not null
 drop table TMovimientoPasarela
go 
create table TMovimientoPasarela
(
 RegistroMovimiento int not null primary key,
 FechaMovimiento DateTime,
 MontoRetiro Decimal,
 SaldoDisponible Decimal,
 NroTarjeta varchar(16),
    Activo varchar(1),
 foreign key (NroTarjeta) references TTarjetaPasarela(NroTarjeta)
)
go
 
 
 
--Insertar Registros en la tabla TPais
 
insert into TPais values('001','Per�')
insert into TPais values('002','Bolivia')
insert into TPais values('003','Ecuador')
insert into TPais values('004','Colombia')
insert into TPais values('005','Argentina')
insert into TPais values('006','Uruguay')
insert into TPais values('007','M�xico')
insert into TPais values('008','Estados Unidos')
insert into TPais values('009','Espa�a')
 
 
go
 
--Insertar Registros en la tabla TCategoria:
 
insert into TCategoria values('C1','Accesorios')
insert into TCategoria values('C2','Cer�mica')
insert into TCategoria values('C3','Espejos')
insert into TCategoria values('C4','Tapicer�a ')
insert into TCategoria values('C5','Tejidos') 
 
go
 
 
--Insertar Registros en la tabla TSubCategoria:
 
insert into TSubCategoria values('C100','Accesorios','C1')
insert into TSubCategoria values('C201','Cer�mica Ayacucho','C2')
insert into TSubCategoria values('C202','Cer�mica Chulucanas','C2')
insert into TSubCategoria values('C203','Cer�mica Cuzco','C2')
insert into TSubCategoria values('C204','Huacos','C2')
insert into TSubCategoria values('C301','Espejos Cajamarca','C3')
insert into TSubCategoria values('C302','Espejos Colonial','C3')
insert into TSubCategoria values('C303','Espejos Contempor�neos','C3')
insert into TSubCategoria values('C304','Espejos Cuzco','C3')
insert into TSubCategoria values('C401','San Pedro de Cajas','C4')
insert into TSubCategoria values('C402','Ayacucho','C4')
insert into TSubCategoria values('C403','Cusco','C4')
insert into TSubCategoria values('C501','Chalecos','C5')
insert into TSubCategoria values('C502','Chullos y Medias ','C5')
insert into TSubCategoria values('C503','Guantes','C5')
insert into TSubCategoria values('C504','Mantones y Ponchos','C5')
insert into TSubCategoria values('C505','Bufandas','C5')
insert into TSubCategoria values('C506','Sueters','C5')
 
go
 
 
 
--Insertar Registros en la tabla TProducto:
 
insert into TProducto values('C10001','Cofre',' Cofre de madera cubierto con la hoja de oro, con las figuras geom�tricas variables tallando en la base de relevaci�n y la alta relevaci�n, con el acolchado rojo en la base interior.  Es ideal para almacenar pertenencia personales.',' ',0.73,20,10,13,0,35.00,'C100')
insert into TProducto values('C10002','Taz�n de fuente de Ensalada','Ensaladera trabajada en madera de olivo, de acabado fino y natural. terminado este proceso, a continuaci�n, se dise�a mediante gr�ficos en su superficie la forma que adoptar� la madera',' ',1.03,26,9.5,23.5,0,35.00,'C100')
insert into TProducto values('C10003','Recipiente Artesanal',' Hecho de madera y de revestido con el cristal en su exterior.  Para la pintura del cristal el artesano utiliza colores diversos de  pintura acr�lica.','',0.22,8,8,10,0,15.00,'C100')  
insert into TProducto values('C10004','Recipiente de Galletas con Manijas ','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricaci�n los cortes del artesano del tronco para hacer a los tableros, a que �l acepilla con cuidado, para mantener la relevaci�n y la textura de la vena.  M�s adelante, a trav�s de lugar de los gr�ficos en el tablero �l dise�a la forma que el pedazo tomar�.  Luego, �l corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible.Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores h�medos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitir� durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.','',0.24,28,28,3,0,35.00,'C100')
insert into TProducto values('C10005','Hoja de Palmas para Galletas','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricaci�n los cortes del artesano del tronco para hacer a los tableros, a que �l acepilla con cuidado, para mantener la relevaci�n y la textura de la vena.  M�s adelante, a trav�s de lugar de los gr�ficos en el tablero �l dise�a la forma que el pedazo tomar�.  Luego, �l corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible.Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores h�medos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitir� durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.  ','',0.39,28.5,4.5,20,0,40.00,'C100')
insert into TProducto values('C10006','Recipiente Hoja Aserrada De Galleta ','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricaci�n los cortes del artesano del tronco para hacer a los tableros, a que �l acepilla con cuidado, para mantener la relevaci�n y la textura de la vena.  M�s adelante, a trav�s de lugar de los gr�ficos en el tablero �l dise�a la forma que el pedazo tomar�.  Luego, �l corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible. Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores h�medos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitir� durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.','',0.43,35,5,14.5,0,42.00,'C100')
insert into TProducto values('C10007','Hoja Media Receptora de Galleta','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricaci�n los cortes del artesano del tronco para hacer a los tableros, a que �l acepilla con cuidado, para mantener la relevaci�n y la textura de la vena.  M�s adelante, a trav�s de lugar de los gr�ficos en el tablero �l dise�a la forma que el pedazo tomar�.  Luego, �l corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible. Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores h�medos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitir� durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.',' ',0.54,38.5,4.5,20,0,45.00,'C100')
insert into TProducto values('C10008','Hoja de Manzana para Galleta',' Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricaci�n los cortes del artesano del tronco para hacer a los tableros, a que �l acepilla con cuidado, para mantener la relevaci�n y la textura de la vena.  M�s adelante, a trav�s de lugar de los gr�ficos en el tablero �l dise�a la forma que el pedazo tomar�.  Luego, �l corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible.Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores h�medos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitir� durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.',' ',0.46,27,3.5,21,0,46.00,'C100')
insert into TProducto values('C20101','Cholita Cocinando',' Es hecho a mano con la arcilla de Ayacucho sacada enteramente (Gama central de la monta�a de Per�).  En esta cer�mica se demuestra la diversidad de actividades de la gente de esta regi�n, tal como h�bitos, preparaci�n y creencia.','',0.37,0,10.5,0,10,35.00,'C201')
insert into TProducto values('C20102','Festejo campesino',' Es hecho a mano con la arcilla de Ayacucho sacada enteramente (gama central de la monta�a de Per�). En esta cer�mica se demuestra la diversidad de actividades de la gente de esta regi�n, tal como h�bitos, preparaci�n y creencia.  .','',0.34,0,11,0,12.5,35.00,'C201')
insert into TProducto values('C20103','Iglesias','Cer�mica de Ayacucho (gama central de la monta�a de Per�) hecho de la arcilla sujeto a los hornos de alta temperatura que le da una superficie endurecida.  Demuestra los naturales de Ayacucho que cantan y las comidas de ofrecimiento a su compa�ero paisano.',' ',0.25,10.5,16,6,0,35.00,'C201')
insert into TProducto values('C20104','Kid Ayacucho','Cer�mica art�stica hecha de la arcilla en el estilo de Ayacucho (gama central de la monta�a de Per�).  Es distinguido para presentar la poblaci�n ind�gena de Ayacucho en sus actividades de base, trajes y vestir h�bitos. ',' ',0.46,0,16,0,14,35.00,'C201')
insert into TProducto values('C20105','Madre Coraje','Cer�mica art�stica hecha de la arcilla en el estilo de Ayacucho (gama central de la monta�a de Per�).  Es distinguido para presentar la poblaci�n ind�gena de Ayacucho en sus actividades de base, trajes y vestir h�bitos. ',' ',0.49,0,17,0,12.5,35.00,'C201')
insert into TProducto values('C20201','Amantes I','Cer�mica de la ciudad de Chulucanas (Per� norte�o).  Es hecho de la arcilla cocida al horno, demuestra un par que se besa. ','',0.14,0,8,0,8,18.00,'C202')
insert into TProducto values('C20202','Amantes II','Cer�mica de la ciudad de Chulucanas (Per� norte�o).  Este pedazo, hecho de la arcilla cocida al horno, demuestra un par que se besa.','',0.14,0,8,0,7.5,18.00,'C202')
insert into TProducto values('C20203','Cholitas Chicheras','Cer�mica hecha de la arcilla cocida al horno.  En este pedazo usted puede apreciar a una mujer que vende "chicha de jora", una bebida tradicional en muchas regiones peruanas.  Se hace del ma�z, cebada, agua, clavo y az�car, entre otros ingredientes.  Tambi�n se conoce como cerveza andina puesto que tiene que ser dejado muchos d�as para la fermentaci�n despu�s de su preparaci�n.  Este producto es ideal para su decoraci�n de la cocina. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, del principio al extremo.',' ',0.47,0,16.5,0,15,30.00,'C202')
insert into TProducto values('C20204','Florero Chulucanas','Florero Hecho de la arcilla cocida al horno, sujetado a las altas temperaturas en hornos dom�sticos con el fuego natural (palillos de la le�a).  Con colores para darle la brillantez y de la luz, con un elegante cord�n de la paja en la parte superior.  Es ideal para la decoraci�n interior. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, del principio al extremo.',' ',0.12,0,8,0,8,15.00,'C202')
insert into TProducto values('C20205','Kero','El Kero de la cultura Inca fueron hechos de la madera y hab�an grabado en ellos dise�os geom�tricos.  En la �poca colonial tambi�n fueron hechos de la madera pero con las representaciones de la vida de cada d�a.  Al d�a, en la ciudad de Chulucanas, en Per� norte�o, los artesanos hacen Vasos Keros con la arcilla cocida al horno que les da un acabamiento presentable art�stico.  Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, del principio al extremo.',' ',0.26,0,10,0,7,18.00,'C202')
insert into TProducto values('C20301','Tablero de Ajedrez','Sistema del juego del ajedrez. La tabla se hace de la madera adornada con colores diversos en tonos del terracotta y los pedazos se hacen de la arcilla cocida al horno y cada tiene una caracterizaci�n de la cultura de Inca.',' ',0.58,26,0,26,0,35.00,'C503')
insert into TProducto values('C20302','Placa Decorativa del C�ndor Real ','Placa hecha de la arcilla de la ciudad imperial de Cuzco.  Distingue para tener figuras geom�tricas diversas del estilo de Inca.  En su centro se puede ver un c�ndor con las caracterizaciones apropiadas de la cultura de Inca.  Debido a su aspecto majestuoso e imponente este p�jaro inspir� a artistas de la civilizaci�n de Inca.  En cuanto a su color, es polychromatic, aunque el rojo indio es su color excepcional.  Es reparto para la decoraci�n interior. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos producen un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',1.15,0,0,0,31.4,35.00,'C203')
insert into TProducto values('C20303','Florero Caminos del Inca','Es un florero de origen  Cuzque�o.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000� C) en hornos industriales.  Antes de la pintura, el artesano pule el de cer�mica para corregir las imperfecciones que pueden tener su superficie.  Luego, �l hunde el florero en el agua por cinco minutos, seg�n el artesano, para darle consistencia a la cer�mica y a las calidades compactas, que la har�n menos propensa para frenar.  El artista, con el l�piz dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco as� como de su arquitectura, trajes, caracter�sticas geogr�ficas, etc.  M�s adelante, coloca una diversidad de colores, le da vida y notoriedad a este adorno.  Finalmente al acabar ese pedazo, el artesano principal aplica una capa de laca en toda la superficie del florero, d�ndole una brillantez sus el propios. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos pueden producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',2.22,0,29,0,20.5,42.00,'C203')
insert into TProducto values('C20304','Chalet Cuzque�o ','Es un florero de origen Cuzque�o.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000� C) en hornos industriales.  Antes de la pintura, el artesano pule el de cer�mica para corregir las imperfecciones que pueden tener su superficie.  Luego, se hunde el florero en el agua por cinco minutos, para dar consistencia de cer�mica y las calidades compactas, que la har�n menos propensa para frenar.  El artista, con el l�piz dibuja diversos acontecimientos del sabor regional fuerte de los naturales del Cuzco as� como de su arquitectura, trajes, caracter�sticas geogr�ficas, etc.  M�s adelante, coloca una diversidad de colores, le da vida y notoriedad a este adorno.  Finalmente al acabar este pedazo, se aplica una capa de laca en toda la superficie del florero, d�ndole una brillantez sus el propios. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano. ',' ',2.05,0,29.5,0,21,42.00,'C203')
insert into TProducto values('C20305','Mercado Cuzque�o ','Es un florero del origen Cuzque�o. Es hecho de la arcilla y  cocido al horno a las altas temperaturas (1000� C) en hornos industriales.  Antes de la pintura, se pule la cer�mica para corregir las imperfecciones que pueden tener su superficie. Luego, se hunde el florero en el agua por cinco minutos, seg�n el artesano, para darle consistencia de cer�mica y las calidades compactas, que la har�n menos propensa para frenar. Con el l�piz dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco as� como de su arquitectura, trajes, caracter�sticas geogr�ficas, etc.  M�s adelante, coloca una diversidad de colores, �l da vida y notoriedad a este adorno.  Finalmente al acabar, el artesano principal aplica una capa de laca en toda la superficie del florero, d�ndole  brillantez. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',2.09,0,28,0,20.5,42.00,'C203')
insert into TProducto values('C20306','Mercado Indio.','Es un florero del origen Cuzque�o.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000� C) en hornos industriales.  Antes de la pintura, el artesano pule el de cer�mica para corregir las imperfecciones que pueden tener su superficie.  Luego, �l hunde el florero en el agua por cinco minutos,  para darle consistencia de cer�mica y las calidades compactas, que la har�n menos propensa para frenar.  El artista, con el l�piz dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco as� como de su arquitectura, trajes, caracter�sticas geogr�ficas, etc.  M�s adelante, se coloca una diversidad de colores, se le da vida y notoriedad a este adorno.  Finalmente al acabarse  aplica una capa de laca en toda la superficie del florero, d�ndole una brillantez.  Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, de comenzar a terminar.',' ',1.94,0,30,0,21.5,42.00,'C203')
insert into TProducto values('C20307','Se�oras Floristas','Es un florero del origen Cuzque�o.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000� C) en hornos industriales.  Antes de la pintura, el artesano pule el de cer�mica para corregir las imperfecciones que pueden tener su superficie. Luego, �l hunde el florero en el agua por cinco minutos, seg�n el artesano, para darle consistencia de cer�mica y las calidades compactas, que la har�n menos propensa para frenar.  El artista, con el l�piz dibuja diversos acontecimientos del sabor regional fuerte de los naturales Cuzque�os, as� como de su arquitectura, trajes, caracter�sticas geogr�ficas, etc.  M�s adelante, se coloca una diversidad de colores, se le da vida y notoriedad a este adorno. Al acabar , se aplica una capa de laca en toda la superficie del florero, d�ndole una brillantez. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',1.89,0,29.5,0,20,42.00,'C203')
insert into TProducto values('C20308','Vida del Paisaje','Es un florero del origen Cuzque�o. Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000� C) en hornos industriales.  Antes de la pintura, el artesano pule la cer�mica para corregir las imperfecciones que pueden tener su superficie.  Luego, �l hunde el florero en el agua por cinco minutos, para darle consistencia de cer�mica y las calidades compactas, que la har�n menos propensa para frenar. Con el l�piz se dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco as� como de su arquitectura, trajes, caracter�sticas geogr�ficas, etc.  M�s adelante, se coloca una diversidad de colores, se da vida y notoriedad a este adorno.  Al acabar se aplica una capa de laca en toda la superficie del florero, d�ndole una brillantez sus el propios. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',2,0,29,0,21,42.00,'C203')
insert into TProducto values('C20309','Jarro Cuzque�o','El florero Cuzque�o hecho de  arcilla cocida al horno sujet� a las altas temperaturas, que permite resistencia y dureza al de cer�mica.  En su superficie tiene una variedad de figuras geom�tricas y en su color con un oro opaco.  Es ideal para la decoraci�n interior. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',0.52,0,21,0,14,45.00,'C203')
insert into TProducto values('C20310','Placa Decorativa Inti Raymi','Placa hecha  de arcilla de la ciudad imperial de Cuzco.  Distingue para tener figuras geom�tricas diversas del estilo de Inca.  Es, aunque el rojo indio es su color excepcional, el ser polychromatic ideal para la decoraci�n interior. Nota:  Certificamos que el de cer�mica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',1.27,0,0,0,32,35.00,'C203')
insert into TProducto values('C20311','Recipiente para Pan','Recipiente del pan hecho de la arcilla cocida al horno.  Distingue para tener un es�fago ancho.  Tambi�n tiene representaciones andinas nativas tales como guerreros de Inca y los animales de la carga como la llama, entre otras, que le da una decoraci�n t�pica de la regi�n andina.',' ',4.2,0,14,0,40,53.00,'C203')
insert into TProducto values('C20401','Huaco1','En este pedazo podemos ver a un guerrero con alas que usa una m�scara y una corona con dos cuchillos que eran uso para los sacrificios.',' ',1.02,0,26,0,20,45.00,'C204')
insert into TProducto values('C20402','Huaco 2','Florero hecho de los colores binarios donde est�n prevaleciendo los tonos rojos y poner indios.  Distingue para tener manijas de un puente y un embotellamiento cil�ndrico, un cord�n principal blanco como el gato con las cabezas unidas al frente y o�dos de los animales estilizados, representaciones gr�ficas de las marcas de la bruja en una manera esculpida de la adoraci�n divina de los animales.',' ',0.68,0,30,0,24,45.00,'C204')
insert into TProducto values('C20403','Huaco 3','Florero Esculpido  hecho de la arcilla cocida al horno con la configuraci�n binaria del color como los tonos rojos y crema-coloreados indios.  Puede ser opini�n sobre �l una lucha entre los guerreros.',' ',0.74,0,20.5,0,21,40.00,'C204')
insert into TProducto values('C20404','Huaco 4','Florero hecho de los colores binarios donde est�n prevaleciendo los tonos rojos y poner indios.  Tiene una manija, un embotellamiento cil�ndrico, vestido principal con las decoraciones al estilo de la cultura de Mochica.  Se representa con el rostro con el sentido de la risa y del humor de la gente de Moche.',' ',0.50,0,26,0,15,45.00,'C204')
insert into TProducto values('C20405','Huaco 5','Florero esculpido hecho de la arcilla cocida al horno con la configuraci�n binaria del color como los tonos rojos y crema-coloreados indios.  Tiene una manija del tipo del estribo y un es�fago cil�ndrico y usos adornados con tonos rojos en la forma de puntos y de cuadrados.  Este pedazo demuestra la representaci�n de un guerrero con un club en sus manos como una arma ofensiva, un protector en su antebrazo y corona adornada con la cabeza de un animal felino.',' ',0.99,0,23,0,0,50.00,'C204')
insert into TProducto values('C20406','Huaco 6','Florero hecho de la arcilla cocida al horno con configuraciones binarias del color tales como los tonos coloreados rojos y batidos indios.  Tiene una manija del tipo del estribo y un es�fago cil�ndrico.  Este pedazo demuestra a guerrero de Moche vestido con trajes ceremoniales que incluyen a club como una arma defensiva,  traje, aletas del o�do y el mascaypacha.',' ',0.89,0,23,0,15,50.00,'C204')
insert into TProducto values('C30101','Espejo Amanecer del Resorte','Espejo adornado con las plantas ornamentales y los p�jaros hechos de la madera en la parte posterior y del cristal en el frente.  Un artesano principal pint� las figuras con la pintura de acr�lico de tonos diversos y en sus bordes estaba la pintura met�lica coloreada de oro aplicada.',' ',0.90,0,40,2.7,0,25.00,'C301')
insert into TProducto values('C30102','Espejo Primavera','Espejo adornado con las plantas ornamentales y los p�jaros hechos de la madera en la parte posterior y del cristal en el frente.  Un artesano principal pint� las figuras con la pintura de acr�lico de tonos diversos y en sus bordes estaba la pintura met�lica coloreada de oro aplicada.',' ',0.04,15,20,1.3,0,25.00,'C301')  
insert into TProducto values('C30103','Set de Espejos','Set de espejo adornado con las plantas ornamentales y los p�jaros hechos de la madera en la parte posterior y del cristal en el frente.  Un artesano principal pint� las figuras con la pintura de acr�lico de tonos diversos y en sus bordes estaba la pintura met�lica coloreada de oro aplicada.',' ',0,12,0,9,0,18.00,'C301')
insert into TProducto values('C30201','Espejo Aviente','Espejo contempor�neo del estilo  hecho de  madera por los artesanos principales de la ciudad de Lima - Per�.  En este pedazo el artesano alcanza formas diversas debido a su artesan�a manual.  En esta ocasi�n usted puede opini�n un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el l�tex blanco y, para terminar su trabajo, aplica colores diversos de la colada.  En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',1.14,27,43,5.5,0,55.00,'C302')
insert into TProducto values('C30202','Espejo Dan�s','Espejo contempor�neo hecho de  madera por los artesanos principales de la ciudad de Lima - Per�.  En este pedazo el artesano alcanza formas diversas debido a su artesan�a manual.  En esta ocasi�n usted puede opini�n un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella. Una vez que se acabe este proceso, el artesano pinta el marco con el l�tex blanco y, para terminar su trabajo, aplica colores diversos.  En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.80,31.5,44,2,0,45.00,'C302')
insert into TProducto values('C30203','Espejo Altarpiece','Espejo contempor�neo hecho de la madera por los artesanos principales de la ciudad de Lima - Per�.  En este pedazo el artesano alcanza formas diversas debido a su artesan�a manual.  En esta ocasi�n usted puede opini�n un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el l�tex blanco y, para terminar su trabajo, aplica colores diversos. Se alcanza un producto de la calidad indiscutible y presencia.',' ',1.53,38,56,6.5,0,60.00,'C302')
insert into TProducto values('C30301','Espejo Brillante','Espejo contempor�neo hecho de la madera por los artesanos principales de la ciudad de Lima - Per�.  En este pedazo el artesano alcanza formas diversas debido a su artesan�a manual.  En esta ocasi�n usted puede opini�n un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el l�tex blanco y, para terminar su trabajo, aplica diversos colores.  En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.82,30,43,0,0,40.00,'C303')
insert into TProducto values('C30302','Espejo de Rosas','Espejo contempor�neo hecho de madera por los artesanos principales de la ciudad de Lima - Per�.  En este pedazo el artesano alcanza formas diversas debido a su artesan�a manual.  En esta ocasi�n usted puede opini�n un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el l�tex blanco y, para terminar su trabajo, aplica colores diversos. En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.99,30,44,2,0,40.00,'C303')
insert into TProducto values('C30303','Espejo de la Luna','Espejo del estilo Lime�o ,hecho de la madera por los artesanos principales de la ciudad de Lima - Per�.  En este pedazo el artesano alcanza formas diversas debido a su artesan�a manual.  En esta ocasi�n usted puede opini�n un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el l�tex blanco y, para terminar su trabajo, aplica colores diversos. En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.56,2,0,0,30,35.00,'C303')
insert into TProducto values('C30401','Espejo Girasol','Es un espejo de Cuzco (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesan�a.',' ',0.57,0,5,0,30.5,45.00,'C304')
insert into TProducto values('C30402','Espejo Estrella del Sol','Espejo del Cuzco (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesan�a.',' ',0.54,0,5,0,30.5,60.00,'C304')
insert into TProducto values('C30403','Flor Andina','Este es un espejo Cuzque�o (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesan�a.',' ',0.26,16,20.5,5,0,35.00,'C304')
insert into TProducto values('C30404','Espejo Sol Radiante','Esto es un espejo de Cuzco (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesan�a.',' ',0.54,0,5,0,30.5,45.00,'C304')
insert into TProducto values('C40101','Entrada Principal','Es una tapicer�a de las lanas de los b�vidos tejida por los artesanos principales de la ciudad de San Pedro de Cajas (sierra central de Per�).  Este textil est� de elaboraci�n r�stica con las t�cnicas y los procesos heredados de la civilizaci�n de Inca, que es la raz�n por la que en este trabajo est�n las m�quinas que tejen de madera r�sticas usadas similares a las que usaban los Incas.  Este pedazo demuestra una artesan�a muy fina del dise�o original del cr�tico especializado como expresi�n del arte primitivo andino.  Este pedazo demuestra una entrada, que es la entrada principal de peque�as ciudades en el sierra peruana.',' ',0.25,0,80,50,0,110.00,'C401')
insert into TProducto values('C40102','Tapiz de Hogar','Decoraciones hechas con marcos hechas de lanas de los b�vidos tejidas a las im�genes t�picas de la regi�n andina peruana.  Tambi�n tiene colores diversos que le dan buen realce al encanto del tapiz.  Es ideal para la decoraci�n interior.  Peso:  0,098 kilogramos.  Altura:  56 cent�metros.  Anchura:  40 cent�metros.',' ',0.1,0,56,40,0,36.00,'C401')
insert into TProducto values('C40103','Mi Ciudad','Es una tapicer�a de las lanas de los b�vidos tejida por los artesanos principales de la ciudad de San Pedro de Cajas (sierra central de Per�).  Este textil est� de elaboraci�n r�stica con las t�cnicas y los procesos heredados de la civilizaci�n de Inca, que es la raz�n por la que en este trabajo est�n las m�quinas que tejen de madera r�sticas usadas similares a las que esta usadas por el Incas.  Este pedazo demuestra una artesan�a muy fina del renovaci�n dise�o original del cr�tico especializado como expresi�n del arte primitivo andino.  En �l usted puede ver una ciudad peque�a t�pica del sierra central peruano en donde las muchachas venden sus granos y cereales sembrados y cosechados por ellos',' ',0.26,0,63,68,0,145.00,'C401')
insert into TProducto values('C40201','Pieza Chaupi','Entrada principal central de la ciudad de Ayacucho (sierra central - Per� meridional) hecha de las lanas de los b�vidos, el 80% de colores naturales extra�dos de la flora de la regi�n y el 20% de colores artificiales.  Tejedores principales de la ciudad de t�cnicas antiguas heredadas Ayacucho de sus antepasados de Inca, que permitieron que hicieran los textiles que armadura y colores tienen gran durabilidad - la raz�n por la que tienen gran demanda mundial. ',' ',0.38,0,176,30.5,0,65.00,'C402')
insert into TProducto values('C40202','Set Campesino Ayacucho','El set de  individuales tejido en la ciudad de Ayacucho (sierra central - Per� meridional) hecha de las lanas de los b�vidos, el 80% de colores naturales extra�dos de la flora de la regi�n y el 20% de colores artificiales.  Los tejedores principales de la ciudad de Ayacucho utilizaron las t�cnicas ancestrales heredadas de sus antepasados de Inca, que es la raz�n por la que estos textiles y sus colores tienen gran durabilidad, que hace le comprensible su gran demanda mundial.',' ',0.32,0,38,31,0,60.00,'C402')
insert into TProducto values('C40203','Set Individuales Huayta','Estos Individuales son tejidos en la ciudad de Ayacucho (sierra central - Per� meridional) hecha de las lanas de los b�vidos, el 80% de colores naturales extra�dos de la flora de la regi�n y el 20% de colores artificiales.  Los tejedores principales de la ciudad de Ayacucho utilizaron las t�cnicas ancestrales heredadas de sus antepasados de Inca, que es la raz�n por la que estos textiles y sus colores tienen gran durabilidad, que hace le comprensible su gran demanda mundial.',' ',0.40,0,41,30,0,60.00,'C402')
insert into TProducto values('C40301','Alfombra XXI ','Hecha de las lanas de los b�vidos, tejido por los artesanos de Cuzco que han alcanzado un final sobrio debido a el uso de t�cnicas ancestrales hered� a trav�s de las generaciones.  Los colores se obtienen de los pigmentos naturales con los cuales el tejedor ha alcanzado una gran variedad de tonos del color.  En esta alfombra usted �l puede ser visto un m�sico andino que toca una flauta india en el pie de Machupicchu.',' ',0.60,0,104,91,0,130.00,'C403')
insert into TProducto values('C40302','Alfombra XXII','La alfombra hecha de las lanas de los b�vidos, tejido por los artesanos de Cuzco que han alcanzado un final sobrio debido a el uso de t�cnicas ancestrales hered� a trav�s de las generaciones.  Los colores se obtienen de los pigmentos naturales con los cuales el tejedor ha alcanzado una gran variedad de tonos del color.  En esta alfombra usted  puede ver un grupo de campesinos que caminan hacia un canto bajo.',' ',0.47,0,90,74.5,0,120.00,'C403')
insert into TProducto values('C40303','Alfombra XXIII','La alfombra hecha de las lanas de los b�vidos, tejido por los artesanos de Cuzco que han alcanzado un final sobrio debido a el uso de t�cnicas ancestrales hered� a trav�s de las generaciones.  Los colores se obtienen de los pigmentos naturales con los cuales el tejedor ha alcanzado una gran variedad de tonos del color.  En esta alfombra usted  puede ver un grupo de los campesinos asentados (gossipers) que miran torres el horizonte.',' ',0.40,0,90,74.5,0,120.00,'C403')
insert into TProducto values('C50101','Chaleco 1 ','Chaleco hecho de las lanas de los b�vidos por los tejedores de la se�ora de la ciudad de Huancayo (sierra central de Per�) de la gran capacidad manual.  Hist�ricamente y mirando en retrospectivo, la cultura de Inca pod�a estar parada hacia fuera en el arte del textil.  Como prueba de eso podemos mencionar la cultura de Paracas, mundial para sus textiles y para su te�ir de la grandes durabilidad y variedad.  En cuanto a su dise�o, en el frente de esta ropa usted puede ver las figuras diversas tales como floreros ornamentales, una variedad de figuras geom�tricas y de figuras animales como la alpaca, que es un mam�fero del rumiante del sierra peruano.  En cuanto a los colores, usted puede ver blanco marr�n, negro y plomo;  en su parte posterior el negro es el color predominante.',' ',0.22,0,59,49.5,0,50.00,'C501')
insert into TProducto values('C50102','Chaleco 2','Chaleco hecho de las lanas de los b�vidos por los tejedores de la se�ora de la ciudad de Huancayo (sierra central de Per�) de la gran capacidad manual.  Hist�ricamente y mirando en retrospectivo, la cultura de Inca pod�a estar parada hacia fuera en el arte del textil.  Como prueba de eso podemos mencionar la cultura de Paracas, mundial para sus textiles y para su te�ir de la grandes durabilidad y variedad.  En cuanto a su dise�o, en el frente de esta ropa usted puede ver las figuras diversas tales como floreros ornamentales, una variedad de figuras geom�tricas y de figuras animales como la alpaca, que es un mam�fero del rumiante del sierra peruano.  En cuanto a los colores, usted puede ver blanco rojo, negro y plomo;  en su parte posterior el negro es el color predominante.',' ',0.25,0,61,49,0,50.00,'C501')
insert into TProducto values('C50103','Chaleco 3','Chaleco para las se�oras hechas de la alpaca y del alpaca, se elabora parcialmente con las m�quinas industriales.  Los detalles que se pueden observar en su contorno entero tan bien como en los bolsillos son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual.  En todo su dise�o puede ser apreciado un acabamiento fino y delicado.  No utilice un lavado y m�quinas de sequ�a.  Puede tambi�n seco-ser limpiado.',' ',0.23,0,62,47,0,50.00,'C501')
insert into TProducto values('C50201','Chullo 1','Chullo hecho de las lanas de los b�vidos.  En ellos usted puede apreciar a gente que baila y de figuras geom�tricas variables tama�o y forma.  Tambi�n tiene colores t�picos de la regi�n andina peruana debido a los pigmentos naturales e industriales usados.  Es ideal para el tiempo fr�o.',' ',0.08,0,32,23,0,25.00,'C502')
insert into TProducto values('C50202','Chullo 2','Chullo hecho de las lanas de los b�vidos, en muchos colores y figuras geom�tricas cl�sicas que pertenecen a la civilizaci�n de Inca, ideal para los climas fr�os.',' ',0.10,0,40,29.5,0,25.00,'C502')
insert into TProducto values('C50203','Chullo 3','Chullo hecho de las lanas de la alpaca, en muchos colores y figuras geom�tricas cl�sicas que pertenecen a la civilizaci�n de Inca, ideal para los climas fr�os.',' ',0.05,0,32,21,0,25.00,'C502')
insert into TProducto values('C50204','Calcetines 1','Calcetines hechos de las lanas de los b�vidos, ideal para los climas fr�os porque su capacidad para conservar calor del cuerpo.  En la parte media de esta ropa pueden estar las figuras geom�tricas vistas apropiadas de la civilizaci�n de Inca y las figuras de los animales t�picos de la regi�n como la alpaca.',' ',0.06,0,48,10,0,29.00,'C502')
insert into TProducto values('C50205','Calcetines 2','Calcetines hechos de las lanas de los b�vidos, ideal para los climas fr�os porque su capacidad para conservar calor del cuerpo.  En la parte media de este pedazo puede ser figuras geom�tricas vistas apropiadas de la civilizaci�n de Inca y figuras de los animales t�picos de la regi�n como la alpaca.',' ',0.06,0,48,10,0,26.00,'C502')
insert into TProducto values('C50206','Calcetines 3','Calcetines hechos de las lanas de los b�vidos, ideal para los climas fr�os porque su capacidad para conservar calor del cuerpo.  En la parte media de este pedazo puede ser figuras geom�tricas vistas apropiadas de la civilizaci�n de Inca y figuras de los animales t�picos de la regi�n como la alpaca.',' ',0.06,0,48,10,0,29.00,'C502')
insert into TProducto values('C50301','Guantes 1',' Guante elegante  hecho de las lanas de colores diversos, mismo uso de los b�vidos en los Andes peruanos donde est�n comunes las bajas temperaturas.  El tejedor artesano alcanza un acabado magn�fico debido a las t�cnicas heredadas de sus antepasados, las t�cnicas que fueron perfeccionadas sin embargo muchas generaciones.',' ',0.04,0,26,12,0,30.00,'C503')
insert into TProducto values('C50302','Guantes 2',' Guante elegante  hecho de las lanas de colores diversos, mismo uso de los b�vidos en los Andes peruanos donde est�n comunes las bajas temperaturas.  El tejedor artesano alcanza un acabado magn�fico debido a las t�cnicas heredadas de sus antepasados, las t�cnicas que fueron perfeccionadas sin embargo muchas generaciones.',' ',0.04,0,26,12,0,30.00,'C503')
insert into TProducto values('C50303','Guantes 3',' Guante elegante hecho de las lanas de los b�vidos de colores diversos, muy usadas en los Andes peruanos debido a el clima fr�o.  El tejedor artesano alcanza un acabado magn�fico debido a las t�cnicas heredadas de sus antepasados, las t�cnicas que fueron perfeccionadas sin embargo muchas generaciones.',' ',0.04,0,26,12,0,30.00,'C503')
insert into TProducto values('C50401','Manton I',' El textil elaborado con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son mano tejida (crochet) por los artesanos de las mujeres de la gran capacidad manual.  En cuanto a su dise�o, usted puede apreciar un acabamiento fino y delicado en el pedazo entero. Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a.  Puede tambi�n ser lavado al seco.','',0.90,0,102,148,0,250.00,'C504')
insert into TProducto values('C50402','Manton II','El textil elabor� con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son mano tejida (crochet) por los artesanos de las mujeres de la gran capacidad manual.  En cuanto a su dise�o, usted puede apreciar la costura que demuestra las flores y las figuras geom�tricas acompa�adas por las franjas as� como un acabamiento fino y delicado en el pedazo entero.  Debido a su elegancia se cabe para ser utilizado en ocasiones especiales. Precauci�n:  l�vela a mano con champ�.  No utilice una lavadora.  Puede tambi�n lavar a seco.','',0.86,0,98,142,0,200.00,'C504')
insert into TProducto values('C50403','Manton III',' El textil es elaborado con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual.  En su dise�o usted puede apreciar borlas en sus lados as� como un acabamiento fino y delicado en la ropa entera.  Debido a su elegancia es ideal para las ocasiones muy especiales.  Viene con una boina. Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a.  Puede lavarse  al seco.','',0.39,0,240,52,0,50.00,'C504')
insert into TProducto values('C50404','Poncho I',' Elaborado con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual.  Debido a su tama�o esta ropa es ideal para los ni�os.  Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a.  Puede ser tambi�n lavado al seco.','',0.21,0,45,82,0,70.00,'C504')
insert into TProducto values('C50405','Poncho II',' El textil elaborado con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son tejida a mano (crochet) por las mujeres artesanas de la gran capacidad manual.  En su dise�o que usted puede apreciar teje en la forma de rosas, de figuras y de borlas geom�tricas as� como un acabamiento fino y delicado.  Debido a su elegancia es ideal para las ocasiones muy especiales. Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a.  Puede tambi�n lavar al seco.','',0.68,0,88,128,0,150.00,'C504')
insert into TProducto values('C50406','Poncho con Bufanda I',' Textil elaborado con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son mano tejida (crochet) por los artesanos de las mujeres de la gran capacidad manual.  En su dise�o usted puede apreciarlos, los botones alineados con lanas as� como un acabamiento fino y delicado en la ropa entera.  Debido a su elegancia es ideal para las ocasiones muy especiales.  Viene con una boina. Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y las m�quinas de sequ�a. Tambi�n puede lavar al seco.','',0.85,0,106,140,0,140.00,'C504')
insert into TProducto values('C50407',' Poncho con Bufanda  II',' Textil elabor� con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual as� como demostrar un acabamiento fino y delicado en el pedazo entero.  Debido a su elegancia puede ser utilizado en ocasiones especiales.  Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a. Tambien puede lavar al seco.','',0.77,0,79,148,0,230.00,'C504')
insert into TProducto values('C50501','Bufanda I',' Textil elaborado con alpaca y alpamix, se hace parcialmente con las m�quinas industriales y sus detalles de la frontera son tejidas a mano (crochet) por los artesanos de las mujeres de la gran capacidad manual.  Se cabe para ser utilizada con ropas formales.  Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a.  Puede tambi�n lavar al seco. ','',0.99,30,44,2,0,55.00,'C505')
insert into TProducto values('C50502','Bufanda II',' Bufanda hecha de las lanas de alpaca, debido a su elegancia que se recomienda se utilice con los juegos formales.','',0.99,30,44,2,0,55.00,'C505')
insert into TProducto values('C50503','Bufanda III',' La bufanda es hecha de lanas de la alpaca, debido a su elegancia que se recomienda se utilice con los juegos formales.','',0.99,30,44,2,0,50.00,'C505')
insert into TProducto values('C50601','Su�ter 1','El su�ter es hecho por los tejedores de Cuzco con lanas puras de la alpaca, resorte-como de colores diversos, �l tiene botones con representaciones Incaicas.  Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a.  Puede tambi�n lavarlo al seco.','',0.85,0,65,52.5,0,70.00,'C506')
insert into TProducto values('C50602','Su�ter 2','Su�ter para damas hechas por los tejedores de Cuzco con las lanas puras de la alpaca colores diversos y terracotta colorea tonos.  Tambi�n tiene adornos gr�ficos de la regi�n andina. Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y las m�quinas de sequ�a.  Puede tambi�n lavarlos al seco.','',0.47,0,61,52,0,75.00,'C506')
insert into TProducto values('C50603','Su�ter 3','Su�ter hecho de alpaca, se hace parcialmente con las m�quinas industriales.  Los detalles que se pueden observar en el collar, las mu�ecas y el contorno de la ropa son mano tejida (crochet) por los mujeres artesanas con gran capacidad manual.  En todo su dise�o puede ser apreciado un acabamiento fino y delicado.  Precauci�n:  l�vela a mano con champ�.  No utilice un lavado y m�quinas de sequ�a.  Puede tambi�n lavarla al seco.','',0.48,0,78,63.5,0,70.00,'C506')
go
 
--Registro de Cliente
insert into TCliente values('Ruben','Pozo Cornejo','M','DNI','23897514','ruben@hotmail.com','Lima','Lima','Surco','Jr. Bolognesi 275','ruben@hotmail.com','C24783BA96A35464632A624D9F829136EDC0175E','Ruben Pozo S.A','2389758500','04-12-1977','Soltero','Comerciante','5019965','001')
insert into TCliente values('Alba','Molina Herrera','F','DNI','45877114','alba@hotmail.com','Lima','Lima','La Molina','Av. Raul Ferrero R. 1205','alba@hotmail.com','F9F4FA2C73D392E3E8BF15428537799140B9DDA9','','','16-12-1985','Soltero','Comerciante','5028914','001')
insert into TCliente values('Susana','Torres Farf�n','F','DNI','23857124','susana@hotmail.com','Arequipa','Arequipa','Yanahuara','Ca. Los Naranjos 543','susana@hotmail.com','F925D420627F3DB470E17FC2A289A4DD103722F2','Arequipa Artesanos S.A.C','2385967250','05-10-1962','Casado','Artesano','288561','001')
insert into TCliente values('Esteban','Camargo Gonz�les','F','DNI','24425810','esteban@hotmail.com','Ayacucho','Ayacucho','Ayacucho','Jr. 28 de Julio 393 ','esteban@hotmail.com','431EF4C5DA9A59CBBE78DF77A53FCC737A3B78FA','Artesanias Esteban S.A','2448521032','29-08-1967','Casado','Artesano','358196','001')
insert into TCliente values('Maria In�s','Zegarra Sullca','F','DNI','23850184','mariaines@hotmail.com','Puno','Puno','Puno','Ca. Bolognesi 190','mariaines@hotmail.com','DB73596290086F399454C7F537BBEFF2FD331B89','Artesanos Puno S.A.C','2380019822','11-07-1973','Casado','Artesano','298715','001')
insert into TCliente values('Juan Manuel','Ch�vez Vera','F','DNI','45609663','juanmanuel@hotmail.com','Lima','Lima','Ate','Av. Urubamba 449','juanmanuel@hotmail.com','EA40FB18915C9F75C7643496AA24B126389769A7','','','04-02-1989','Soltero','Estudiante','5185964','001')
insert into TCliente values('Victor','Choque P�rez','F','DNI','23694625','victor@hotmail.com','Lima','Lima','La Victoria','Av. Arequipa 980','victor@hotmail.com','88FA846E5F8AA198848BE76E1ABDCB7D7A42D292','Per� Artesanias S.A','2585987401','12-12-1969','Casado','Empresario','5225896','001')
insert into TCliente values('Carolina','Rojas Santos','F','C�dula de Identidad','28 986 528 5','carolina@hotmail.com','La Paz','La Paz','La Paz','Av. 6 de Agosto N� 2464','carolina@hotmail.com','C33873C987BC9D5BC6A51E095311D747B85A78E1','','','31-12-1981','Soltero','Recepcionista','2225734','002')
 
 
insert into TCompra values ('001','1','35.00','12-04-2011','15-04-2011')
insert into TCompra values ('002','1','40.00','10-04-2011','13-04-2011')
insert into TCompra values ('003','1','60.00','11-04-2011','16-04-2011')
 
insert into TDireccionEnvio values ('Mi casa','Cusco','Cusco','Cusco','Larapa D-12-2','237856','Jos�','Guill�n','1')
insert into TDireccionEnvio values ('Casa Mam�','Cusco','Cusco','Cusco','Av. Sol 562','289856','Mar�a','Cornejo','1')