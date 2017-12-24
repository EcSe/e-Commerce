use master
go
-- Creación de la Base de Datos
begin
if  db_id('BDEcommerce') is not null   
 drop database BDEcommerce
end
create database BDEcommerce
go
 
use BDEcommerce
go
  
--Creación de Tablas :
--Creación de la tabla TPais :
if OBJECT_ID('TPais','U') is not null
 drop table TPais
go 
create table TPais
(
 CodPais varchar(3) not null constraint pk_CodPais primary key(CodPais),
 Nombre varchar(20)
)
 
--Creación de la tabla TCategoria:
if OBJECT_ID('TCategoria','U') is not null
 drop table TCategoria
go 
create table TCategoria
(
 CodCategoria  varchar(2) not null constraint pk_CodCategoria primary key(CodCategoria),
 Nombre varchar(20)
)
 
go
--Creación de la tabla TSubCategoria:
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
 
--Creación de la tabla TProducto:
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
--Creación de la tabla TCliente:
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
 
 
--Creación de la tabla TCompra:
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
 
 
--Creación de la tabla TDetalleCompra:
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
--Creación de la tabla TDireccionEnvio:
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
 
--Creación de Tablas Pasarela:
--Creación de la tabla TClientePasarela:
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
 
--Creación de la tabla TCuentaAhorroPasarela
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
 
--Creación de la tabla TTarjetaPasarela
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
 
 
--Creación de la tabla TMovimientoPasarela
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
 
insert into TPais values('001','Perú')
insert into TPais values('002','Bolivia')
insert into TPais values('003','Ecuador')
insert into TPais values('004','Colombia')
insert into TPais values('005','Argentina')
insert into TPais values('006','Uruguay')
insert into TPais values('007','México')
insert into TPais values('008','Estados Unidos')
insert into TPais values('009','España')
 
 
go
 
--Insertar Registros en la tabla TCategoria:
 
insert into TCategoria values('C1','Accesorios')
insert into TCategoria values('C2','Cerámica')
insert into TCategoria values('C3','Espejos')
insert into TCategoria values('C4','Tapicería ')
insert into TCategoria values('C5','Tejidos') 
 
go
 
 
--Insertar Registros en la tabla TSubCategoria:
 
insert into TSubCategoria values('C100','Accesorios','C1')
insert into TSubCategoria values('C201','Cerámica Ayacucho','C2')
insert into TSubCategoria values('C202','Cerámica Chulucanas','C2')
insert into TSubCategoria values('C203','Cerámica Cuzco','C2')
insert into TSubCategoria values('C204','Huacos','C2')
insert into TSubCategoria values('C301','Espejos Cajamarca','C3')
insert into TSubCategoria values('C302','Espejos Colonial','C3')
insert into TSubCategoria values('C303','Espejos Contemporáneos','C3')
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
 
insert into TProducto values('C10001','Cofre',' Cofre de madera cubierto con la hoja de oro, con las figuras geométricas variables tallando en la base de relevación y la alta relevación, con el acolchado rojo en la base interior.  Es ideal para almacenar pertenencia personales.',' ',0.73,20,10,13,0,35.00,'C100')
insert into TProducto values('C10002','Tazón de fuente de Ensalada','Ensaladera trabajada en madera de olivo, de acabado fino y natural. terminado este proceso, a continuación, se diseña mediante gráficos en su superficie la forma que adoptará la madera',' ',1.03,26,9.5,23.5,0,35.00,'C100')
insert into TProducto values('C10003','Recipiente Artesanal',' Hecho de madera y de revestido con el cristal en su exterior.  Para la pintura del cristal el artesano utiliza colores diversos de  pintura acrílica.','',0.22,8,8,10,0,15.00,'C100')  
insert into TProducto values('C10004','Recipiente de Galletas con Manijas ','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricación los cortes del artesano del tronco para hacer a los tableros, a que él acepilla con cuidado, para mantener la relevación y la textura de la vena.  Más adelante, a través de lugar de los gráficos en el tablero él diseña la forma que el pedazo tomará.  Luego, él corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible.Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores húmedos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitirá durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.','',0.24,28,28,3,0,35.00,'C100')
insert into TProducto values('C10005','Hoja de Palmas para Galletas','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricación los cortes del artesano del tronco para hacer a los tableros, a que él acepilla con cuidado, para mantener la relevación y la textura de la vena.  Más adelante, a través de lugar de los gráficos en el tablero él diseña la forma que el pedazo tomará.  Luego, él corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible.Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores húmedos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitirá durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.  ','',0.39,28.5,4.5,20,0,40.00,'C100')
insert into TProducto values('C10006','Recipiente Hoja Aserrada De Galleta ','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricación los cortes del artesano del tronco para hacer a los tableros, a que él acepilla con cuidado, para mantener la relevación y la textura de la vena.  Más adelante, a través de lugar de los gráficos en el tablero él diseña la forma que el pedazo tomará.  Luego, él corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible. Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores húmedos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitirá durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.','',0.43,35,5,14.5,0,42.00,'C100')
insert into TProducto values('C10007','Hoja Media Receptora de Galleta','Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricación los cortes del artesano del tronco para hacer a los tableros, a que él acepilla con cuidado, para mantener la relevación y la textura de la vena.  Más adelante, a través de lugar de los gráficos en el tablero él diseña la forma que el pedazo tomará.  Luego, él corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible. Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores húmedos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitirá durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.',' ',0.54,38.5,4.5,20,0,45.00,'C100')
insert into TProducto values('C10008','Hoja de Manzana para Galleta',' Este pedazo se trabaja de la madera verde oliva, del acabamiento fino natural.  En su fabricación los cortes del artesano del tronco para hacer a los tableros, a que él acepilla con cuidado, para mantener la relevación y la textura de la vena.  Más adelante, a través de lugar de los gráficos en el tablero él diseña la forma que el pedazo tomará.  Luego, él corta y pule el pedazo y finalmente una laca del lacre se aplica en el pedazo, alcanzando un producto de la calidad indiscutible.Nota:  Para un buen mantenimiento del pedazo debe ser lugar en lugares secos, lejos de alrededores húmedos y, si es posible, puede ser manchado de vez en cuando ligeramente con el aceite de oliva, que permitirá durabilidad de su color y lustre.  Nunca utilice el detergente o cualquier producto abrasivo que puedan contaminar el acabamiento.',' ',0.46,27,3.5,21,0,46.00,'C100')
insert into TProducto values('C20101','Cholita Cocinando',' Es hecho a mano con la arcilla de Ayacucho sacada enteramente (Gama central de la montaña de Perú).  En esta cerámica se demuestra la diversidad de actividades de la gente de esta región, tal como hábitos, preparación y creencia.','',0.37,0,10.5,0,10,35.00,'C201')
insert into TProducto values('C20102','Festejo campesino',' Es hecho a mano con la arcilla de Ayacucho sacada enteramente (gama central de la montaña de Perú). En esta cerámica se demuestra la diversidad de actividades de la gente de esta región, tal como hábitos, preparación y creencia.  .','',0.34,0,11,0,12.5,35.00,'C201')
insert into TProducto values('C20103','Iglesias','Cerámica de Ayacucho (gama central de la montaña de Perú) hecho de la arcilla sujeto a los hornos de alta temperatura que le da una superficie endurecida.  Demuestra los naturales de Ayacucho que cantan y las comidas de ofrecimiento a su compañero paisano.',' ',0.25,10.5,16,6,0,35.00,'C201')
insert into TProducto values('C20104','Kid Ayacucho','Cerámica artística hecha de la arcilla en el estilo de Ayacucho (gama central de la montaña de Perú).  Es distinguido para presentar la población indígena de Ayacucho en sus actividades de base, trajes y vestir hábitos. ',' ',0.46,0,16,0,14,35.00,'C201')
insert into TProducto values('C20105','Madre Coraje','Cerámica artística hecha de la arcilla en el estilo de Ayacucho (gama central de la montaña de Perú).  Es distinguido para presentar la población indígena de Ayacucho en sus actividades de base, trajes y vestir hábitos. ',' ',0.49,0,17,0,12.5,35.00,'C201')
insert into TProducto values('C20201','Amantes I','Cerámica de la ciudad de Chulucanas (Perú norteño).  Es hecho de la arcilla cocida al horno, demuestra un par que se besa. ','',0.14,0,8,0,8,18.00,'C202')
insert into TProducto values('C20202','Amantes II','Cerámica de la ciudad de Chulucanas (Perú norteño).  Este pedazo, hecho de la arcilla cocida al horno, demuestra un par que se besa.','',0.14,0,8,0,7.5,18.00,'C202')
insert into TProducto values('C20203','Cholitas Chicheras','Cerámica hecha de la arcilla cocida al horno.  En este pedazo usted puede apreciar a una mujer que vende "chicha de jora", una bebida tradicional en muchas regiones peruanas.  Se hace del maíz, cebada, agua, clavo y azúcar, entre otros ingredientes.  También se conoce como cerveza andina puesto que tiene que ser dejado muchos días para la fermentación después de su preparación.  Este producto es ideal para su decoración de la cocina. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, del principio al extremo.',' ',0.47,0,16.5,0,15,30.00,'C202')
insert into TProducto values('C20204','Florero Chulucanas','Florero Hecho de la arcilla cocida al horno, sujetado a las altas temperaturas en hornos domésticos con el fuego natural (palillos de la leña).  Con colores para darle la brillantez y de la luz, con un elegante cordón de la paja en la parte superior.  Es ideal para la decoración interior. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, del principio al extremo.',' ',0.12,0,8,0,8,15.00,'C202')
insert into TProducto values('C20205','Kero','El Kero de la cultura Inca fueron hechos de la madera y habían grabado en ellos diseños geométricos.  En la época colonial también fueron hechos de la madera pero con las representaciones de la vida de cada día.  Al día, en la ciudad de Chulucanas, en Perú norteño, los artesanos hacen Vasos Keros con la arcilla cocida al horno que les da un acabamiento presentable artístico.  Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, del principio al extremo.',' ',0.26,0,10,0,7,18.00,'C202')
insert into TProducto values('C20301','Tablero de Ajedrez','Sistema del juego del ajedrez. La tabla se hace de la madera adornada con colores diversos en tonos del terracotta y los pedazos se hacen de la arcilla cocida al horno y cada tiene una caracterización de la cultura de Inca.',' ',0.58,26,0,26,0,35.00,'C503')
insert into TProducto values('C20302','Placa Decorativa del Cóndor Real ','Placa hecha de la arcilla de la ciudad imperial de Cuzco.  Distingue para tener figuras geométricas diversas del estilo de Inca.  En su centro se puede ver un cóndor con las caracterizaciones apropiadas de la cultura de Inca.  Debido a su aspecto majestuoso e imponente este pájaro inspiró a artistas de la civilización de Inca.  En cuanto a su color, es polychromatic, aunque el rojo indio es su color excepcional.  Es reparto para la decoración interior. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos producen un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',1.15,0,0,0,31.4,35.00,'C203')
insert into TProducto values('C20303','Florero Caminos del Inca','Es un florero de origen  Cuzqueño.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000º C) en hornos industriales.  Antes de la pintura, el artesano pule el de cerámica para corregir las imperfecciones que pueden tener su superficie.  Luego, él hunde el florero en el agua por cinco minutos, según el artesano, para darle consistencia a la cerámica y a las calidades compactas, que la harán menos propensa para frenar.  El artista, con el lápiz dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco así como de su arquitectura, trajes, características geográficas, etc.  Más adelante, coloca una diversidad de colores, le da vida y notoriedad a este adorno.  Finalmente al acabar ese pedazo, el artesano principal aplica una capa de laca en toda la superficie del florero, dándole una brillantez sus el propios. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos pueden producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',2.22,0,29,0,20.5,42.00,'C203')
insert into TProducto values('C20304','Chalet Cuzqueño ','Es un florero de origen Cuzqueño.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000º C) en hornos industriales.  Antes de la pintura, el artesano pule el de cerámica para corregir las imperfecciones que pueden tener su superficie.  Luego, se hunde el florero en el agua por cinco minutos, para dar consistencia de cerámica y las calidades compactas, que la harán menos propensa para frenar.  El artista, con el lápiz dibuja diversos acontecimientos del sabor regional fuerte de los naturales del Cuzco así como de su arquitectura, trajes, características geográficas, etc.  Más adelante, coloca una diversidad de colores, le da vida y notoriedad a este adorno.  Finalmente al acabar este pedazo, se aplica una capa de laca en toda la superficie del florero, dándole una brillantez sus el propios. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano. ',' ',2.05,0,29.5,0,21,42.00,'C203')
insert into TProducto values('C20305','Mercado Cuzqueño ','Es un florero del origen Cuzqueño. Es hecho de la arcilla y  cocido al horno a las altas temperaturas (1000º C) en hornos industriales.  Antes de la pintura, se pule la cerámica para corregir las imperfecciones que pueden tener su superficie. Luego, se hunde el florero en el agua por cinco minutos, según el artesano, para darle consistencia de cerámica y las calidades compactas, que la harán menos propensa para frenar. Con el lápiz dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco así como de su arquitectura, trajes, características geográficas, etc.  Más adelante, coloca una diversidad de colores, él da vida y notoriedad a este adorno.  Finalmente al acabar, el artesano principal aplica una capa de laca en toda la superficie del florero, dándole  brillantez. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',2.09,0,28,0,20.5,42.00,'C203')
insert into TProducto values('C20306','Mercado Indio.','Es un florero del origen Cuzqueño.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000º C) en hornos industriales.  Antes de la pintura, el artesano pule el de cerámica para corregir las imperfecciones que pueden tener su superficie.  Luego, él hunde el florero en el agua por cinco minutos,  para darle consistencia de cerámica y las calidades compactas, que la harán menos propensa para frenar.  El artista, con el lápiz dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco así como de su arquitectura, trajes, características geográficas, etc.  Más adelante, se coloca una diversidad de colores, se le da vida y notoriedad a este adorno.  Finalmente al acabarse  aplica una capa de laca en toda la superficie del florero, dándole una brillantez.  Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano, de comenzar a terminar.',' ',1.94,0,30,0,21.5,42.00,'C203')
insert into TProducto values('C20307','Señoras Floristas','Es un florero del origen Cuzqueño.  Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000º C) en hornos industriales.  Antes de la pintura, el artesano pule el de cerámica para corregir las imperfecciones que pueden tener su superficie. Luego, él hunde el florero en el agua por cinco minutos, según el artesano, para darle consistencia de cerámica y las calidades compactas, que la harán menos propensa para frenar.  El artista, con el lápiz dibuja diversos acontecimientos del sabor regional fuerte de los naturales Cuzqueños, así como de su arquitectura, trajes, características geográficas, etc.  Más adelante, se coloca una diversidad de colores, se le da vida y notoriedad a este adorno. Al acabar , se aplica una capa de laca en toda la superficie del florero, dándole una brillantez. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',1.89,0,29.5,0,20,42.00,'C203')
insert into TProducto values('C20308','Vida del Paisaje','Es un florero del origen Cuzqueño. Este pedazo se ha hecho de la arcilla y se ha cocido al horno a las altas temperaturas (1000º C) en hornos industriales.  Antes de la pintura, el artesano pule la cerámica para corregir las imperfecciones que pueden tener su superficie.  Luego, él hunde el florero en el agua por cinco minutos, para darle consistencia de cerámica y las calidades compactas, que la harán menos propensa para frenar. Con el lápiz se dibuja diversos acontecimientos del sabor regional fuerte de los naturales de Cuzco así como de su arquitectura, trajes, características geográficas, etc.  Más adelante, se coloca una diversidad de colores, se da vida y notoriedad a este adorno.  Al acabar se aplica una capa de laca en toda la superficie del florero, dándole una brillantez sus el propios. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',2,0,29,0,21,42.00,'C203')
insert into TProducto values('C20309','Jarro Cuzqueño','El florero Cuzqueño hecho de  arcilla cocida al horno sujetó a las altas temperaturas, que permite resistencia y dureza al de cerámica.  En su superficie tiene una variedad de figuras geométricas y en su color con un oro opaco.  Es ideal para la decoración interior. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',0.52,0,21,0,14,45.00,'C203')
insert into TProducto values('C20310','Placa Decorativa Inti Raymi','Placa hecha  de arcilla de la ciudad imperial de Cuzco.  Distingue para tener figuras geométricas diversas del estilo de Inca.  Es, aunque el rojo indio es su color excepcional, el ser polychromatic ideal para la decoración interior. Nota:  Certificamos que el de cerámica se ha elaborado finalmente para cada cliente y debido a ella, nuestros artesanos podemos producir un producto similar pero no igual, mientras que se ha trabajado enteramente a mano.',' ',1.27,0,0,0,32,35.00,'C203')
insert into TProducto values('C20311','Recipiente para Pan','Recipiente del pan hecho de la arcilla cocida al horno.  Distingue para tener un esófago ancho.  También tiene representaciones andinas nativas tales como guerreros de Inca y los animales de la carga como la llama, entre otras, que le da una decoración típica de la región andina.',' ',4.2,0,14,0,40,53.00,'C203')
insert into TProducto values('C20401','Huaco1','En este pedazo podemos ver a un guerrero con alas que usa una máscara y una corona con dos cuchillos que eran uso para los sacrificios.',' ',1.02,0,26,0,20,45.00,'C204')
insert into TProducto values('C20402','Huaco 2','Florero hecho de los colores binarios donde están prevaleciendo los tonos rojos y poner indios.  Distingue para tener manijas de un puente y un embotellamiento cilíndrico, un cordón principal blanco como el gato con las cabezas unidas al frente y oídos de los animales estilizados, representaciones gráficas de las marcas de la bruja en una manera esculpida de la adoración divina de los animales.',' ',0.68,0,30,0,24,45.00,'C204')
insert into TProducto values('C20403','Huaco 3','Florero Esculpido  hecho de la arcilla cocida al horno con la configuración binaria del color como los tonos rojos y crema-coloreados indios.  Puede ser opinión sobre él una lucha entre los guerreros.',' ',0.74,0,20.5,0,21,40.00,'C204')
insert into TProducto values('C20404','Huaco 4','Florero hecho de los colores binarios donde están prevaleciendo los tonos rojos y poner indios.  Tiene una manija, un embotellamiento cilíndrico, vestido principal con las decoraciones al estilo de la cultura de Mochica.  Se representa con el rostro con el sentido de la risa y del humor de la gente de Moche.',' ',0.50,0,26,0,15,45.00,'C204')
insert into TProducto values('C20405','Huaco 5','Florero esculpido hecho de la arcilla cocida al horno con la configuración binaria del color como los tonos rojos y crema-coloreados indios.  Tiene una manija del tipo del estribo y un esófago cilíndrico y usos adornados con tonos rojos en la forma de puntos y de cuadrados.  Este pedazo demuestra la representación de un guerrero con un club en sus manos como una arma ofensiva, un protector en su antebrazo y corona adornada con la cabeza de un animal felino.',' ',0.99,0,23,0,0,50.00,'C204')
insert into TProducto values('C20406','Huaco 6','Florero hecho de la arcilla cocida al horno con configuraciones binarias del color tales como los tonos coloreados rojos y batidos indios.  Tiene una manija del tipo del estribo y un esófago cilíndrico.  Este pedazo demuestra a guerrero de Moche vestido con trajes ceremoniales que incluyen a club como una arma defensiva,  traje, aletas del oído y el mascaypacha.',' ',0.89,0,23,0,15,50.00,'C204')
insert into TProducto values('C30101','Espejo Amanecer del Resorte','Espejo adornado con las plantas ornamentales y los pájaros hechos de la madera en la parte posterior y del cristal en el frente.  Un artesano principal pintó las figuras con la pintura de acrílico de tonos diversos y en sus bordes estaba la pintura metálica coloreada de oro aplicada.',' ',0.90,0,40,2.7,0,25.00,'C301')
insert into TProducto values('C30102','Espejo Primavera','Espejo adornado con las plantas ornamentales y los pájaros hechos de la madera en la parte posterior y del cristal en el frente.  Un artesano principal pintó las figuras con la pintura de acrílico de tonos diversos y en sus bordes estaba la pintura metálica coloreada de oro aplicada.',' ',0.04,15,20,1.3,0,25.00,'C301')  
insert into TProducto values('C30103','Set de Espejos','Set de espejo adornado con las plantas ornamentales y los pájaros hechos de la madera en la parte posterior y del cristal en el frente.  Un artesano principal pintó las figuras con la pintura de acrílico de tonos diversos y en sus bordes estaba la pintura metálica coloreada de oro aplicada.',' ',0,12,0,9,0,18.00,'C301')
insert into TProducto values('C30201','Espejo Aviente','Espejo contemporáneo del estilo  hecho de  madera por los artesanos principales de la ciudad de Lima - Perú.  En este pedazo el artesano alcanza formas diversas debido a su artesanía manual.  En esta ocasión usted puede opinión un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el látex blanco y, para terminar su trabajo, aplica colores diversos de la colada.  En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',1.14,27,43,5.5,0,55.00,'C302')
insert into TProducto values('C30202','Espejo Danés','Espejo contemporáneo hecho de  madera por los artesanos principales de la ciudad de Lima - Perú.  En este pedazo el artesano alcanza formas diversas debido a su artesanía manual.  En esta ocasión usted puede opinión un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella. Una vez que se acabe este proceso, el artesano pinta el marco con el látex blanco y, para terminar su trabajo, aplica colores diversos.  En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.80,31.5,44,2,0,45.00,'C302')
insert into TProducto values('C30203','Espejo Altarpiece','Espejo contemporáneo hecho de la madera por los artesanos principales de la ciudad de Lima - Perú.  En este pedazo el artesano alcanza formas diversas debido a su artesanía manual.  En esta ocasión usted puede opinión un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el látex blanco y, para terminar su trabajo, aplica colores diversos. Se alcanza un producto de la calidad indiscutible y presencia.',' ',1.53,38,56,6.5,0,60.00,'C302')
insert into TProducto values('C30301','Espejo Brillante','Espejo contemporáneo hecho de la madera por los artesanos principales de la ciudad de Lima - Perú.  En este pedazo el artesano alcanza formas diversas debido a su artesanía manual.  En esta ocasión usted puede opinión un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el látex blanco y, para terminar su trabajo, aplica diversos colores.  En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.82,30,43,0,0,40.00,'C303')
insert into TProducto values('C30302','Espejo de Rosas','Espejo contemporáneo hecho de madera por los artesanos principales de la ciudad de Lima - Perú.  En este pedazo el artesano alcanza formas diversas debido a su artesanía manual.  En esta ocasión usted puede opinión un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el látex blanco y, para terminar su trabajo, aplica colores diversos. En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.99,30,44,2,0,40.00,'C303')
insert into TProducto values('C30303','Espejo de la Luna','Espejo del estilo Limeño ,hecho de la madera por los artesanos principales de la ciudad de Lima - Perú.  En este pedazo el artesano alcanza formas diversas debido a su artesanía manual.  En esta ocasión usted puede opinión un marco oval adornado con la estrella como el sol, la luna y otras estrellas.  La madera se pule para conseguir la superficie lisa requerida para pintar sobre ella.  Una vez que se acabe este proceso, el artesano pinta el marco con el látex blanco y, para terminar su trabajo, aplica colores diversos. En el extremo, un producto de la calidad indiscutible y la presencia se alcanza.',' ',0.56,2,0,0,30,35.00,'C303')
insert into TProducto values('C30401','Espejo Girasol','Es un espejo de Cuzco (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesanía.',' ',0.57,0,5,0,30.5,45.00,'C304')
insert into TProducto values('C30402','Espejo Estrella del Sol','Espejo del Cuzco (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesanía.',' ',0.54,0,5,0,30.5,60.00,'C304')
insert into TProducto values('C30403','Flor Andina','Este es un espejo Cuzqueño (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesanía.',' ',0.26,16,20.5,5,0,35.00,'C304')
insert into TProducto values('C30404','Espejo Sol Radiante','Esto es un espejo de Cuzco (Cuscaja) hecho de la madera y de la hoja del bronce cubiertas.  La ciudad de Cuzco es el lugar de nacimiento del renuevo mundial de los artesanos principales para su abundancia cultural de la diversidad y de la artesanía.',' ',0.54,0,5,0,30.5,45.00,'C304')
insert into TProducto values('C40101','Entrada Principal','Es una tapicería de las lanas de los bóvidos tejida por los artesanos principales de la ciudad de San Pedro de Cajas (sierra central de Perú).  Este textil está de elaboración rústica con las técnicas y los procesos heredados de la civilización de Inca, que es la razón por la que en este trabajo están las máquinas que tejen de madera rústicas usadas similares a las que usaban los Incas.  Este pedazo demuestra una artesanía muy fina del diseño original del crítico especializado como expresión del arte primitivo andino.  Este pedazo demuestra una entrada, que es la entrada principal de pequeñas ciudades en el sierra peruana.',' ',0.25,0,80,50,0,110.00,'C401')
insert into TProducto values('C40102','Tapiz de Hogar','Decoraciones hechas con marcos hechas de lanas de los bóvidos tejidas a las imágenes típicas de la región andina peruana.  También tiene colores diversos que le dan buen realce al encanto del tapiz.  Es ideal para la decoración interior.  Peso:  0,098 kilogramos.  Altura:  56 centímetros.  Anchura:  40 centímetros.',' ',0.1,0,56,40,0,36.00,'C401')
insert into TProducto values('C40103','Mi Ciudad','Es una tapicería de las lanas de los bóvidos tejida por los artesanos principales de la ciudad de San Pedro de Cajas (sierra central de Perú).  Este textil está de elaboración rústica con las técnicas y los procesos heredados de la civilización de Inca, que es la razón por la que en este trabajo están las máquinas que tejen de madera rústicas usadas similares a las que esta usadas por el Incas.  Este pedazo demuestra una artesanía muy fina del renovación diseño original del crítico especializado como expresión del arte primitivo andino.  En él usted puede ver una ciudad pequeña típica del sierra central peruano en donde las muchachas venden sus granos y cereales sembrados y cosechados por ellos',' ',0.26,0,63,68,0,145.00,'C401')
insert into TProducto values('C40201','Pieza Chaupi','Entrada principal central de la ciudad de Ayacucho (sierra central - Perú meridional) hecha de las lanas de los bóvidos, el 80% de colores naturales extraídos de la flora de la región y el 20% de colores artificiales.  Tejedores principales de la ciudad de técnicas antiguas heredadas Ayacucho de sus antepasados de Inca, que permitieron que hicieran los textiles que armadura y colores tienen gran durabilidad - la razón por la que tienen gran demanda mundial. ',' ',0.38,0,176,30.5,0,65.00,'C402')
insert into TProducto values('C40202','Set Campesino Ayacucho','El set de  individuales tejido en la ciudad de Ayacucho (sierra central - Perú meridional) hecha de las lanas de los bóvidos, el 80% de colores naturales extraídos de la flora de la región y el 20% de colores artificiales.  Los tejedores principales de la ciudad de Ayacucho utilizaron las técnicas ancestrales heredadas de sus antepasados de Inca, que es la razón por la que estos textiles y sus colores tienen gran durabilidad, que hace le comprensible su gran demanda mundial.',' ',0.32,0,38,31,0,60.00,'C402')
insert into TProducto values('C40203','Set Individuales Huayta','Estos Individuales son tejidos en la ciudad de Ayacucho (sierra central - Perú meridional) hecha de las lanas de los bóvidos, el 80% de colores naturales extraídos de la flora de la región y el 20% de colores artificiales.  Los tejedores principales de la ciudad de Ayacucho utilizaron las técnicas ancestrales heredadas de sus antepasados de Inca, que es la razón por la que estos textiles y sus colores tienen gran durabilidad, que hace le comprensible su gran demanda mundial.',' ',0.40,0,41,30,0,60.00,'C402')
insert into TProducto values('C40301','Alfombra XXI ','Hecha de las lanas de los bóvidos, tejido por los artesanos de Cuzco que han alcanzado un final sobrio debido a el uso de técnicas ancestrales heredó a través de las generaciones.  Los colores se obtienen de los pigmentos naturales con los cuales el tejedor ha alcanzado una gran variedad de tonos del color.  En esta alfombra usted él puede ser visto un músico andino que toca una flauta india en el pie de Machupicchu.',' ',0.60,0,104,91,0,130.00,'C403')
insert into TProducto values('C40302','Alfombra XXII','La alfombra hecha de las lanas de los bóvidos, tejido por los artesanos de Cuzco que han alcanzado un final sobrio debido a el uso de técnicas ancestrales heredó a través de las generaciones.  Los colores se obtienen de los pigmentos naturales con los cuales el tejedor ha alcanzado una gran variedad de tonos del color.  En esta alfombra usted  puede ver un grupo de campesinos que caminan hacia un canto bajo.',' ',0.47,0,90,74.5,0,120.00,'C403')
insert into TProducto values('C40303','Alfombra XXIII','La alfombra hecha de las lanas de los bóvidos, tejido por los artesanos de Cuzco que han alcanzado un final sobrio debido a el uso de técnicas ancestrales heredó a través de las generaciones.  Los colores se obtienen de los pigmentos naturales con los cuales el tejedor ha alcanzado una gran variedad de tonos del color.  En esta alfombra usted  puede ver un grupo de los campesinos asentados (gossipers) que miran torres el horizonte.',' ',0.40,0,90,74.5,0,120.00,'C403')
insert into TProducto values('C50101','Chaleco 1 ','Chaleco hecho de las lanas de los bóvidos por los tejedores de la señora de la ciudad de Huancayo (sierra central de Perú) de la gran capacidad manual.  Históricamente y mirando en retrospectivo, la cultura de Inca podía estar parada hacia fuera en el arte del textil.  Como prueba de eso podemos mencionar la cultura de Paracas, mundial para sus textiles y para su teñir de la grandes durabilidad y variedad.  En cuanto a su diseño, en el frente de esta ropa usted puede ver las figuras diversas tales como floreros ornamentales, una variedad de figuras geométricas y de figuras animales como la alpaca, que es un mamífero del rumiante del sierra peruano.  En cuanto a los colores, usted puede ver blanco marrón, negro y plomo;  en su parte posterior el negro es el color predominante.',' ',0.22,0,59,49.5,0,50.00,'C501')
insert into TProducto values('C50102','Chaleco 2','Chaleco hecho de las lanas de los bóvidos por los tejedores de la señora de la ciudad de Huancayo (sierra central de Perú) de la gran capacidad manual.  Históricamente y mirando en retrospectivo, la cultura de Inca podía estar parada hacia fuera en el arte del textil.  Como prueba de eso podemos mencionar la cultura de Paracas, mundial para sus textiles y para su teñir de la grandes durabilidad y variedad.  En cuanto a su diseño, en el frente de esta ropa usted puede ver las figuras diversas tales como floreros ornamentales, una variedad de figuras geométricas y de figuras animales como la alpaca, que es un mamífero del rumiante del sierra peruano.  En cuanto a los colores, usted puede ver blanco rojo, negro y plomo;  en su parte posterior el negro es el color predominante.',' ',0.25,0,61,49,0,50.00,'C501')
insert into TProducto values('C50103','Chaleco 3','Chaleco para las señoras hechas de la alpaca y del alpaca, se elabora parcialmente con las máquinas industriales.  Los detalles que se pueden observar en su contorno entero tan bien como en los bolsillos son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual.  En todo su diseño puede ser apreciado un acabamiento fino y delicado.  No utilice un lavado y máquinas de sequía.  Puede también seco-ser limpiado.',' ',0.23,0,62,47,0,50.00,'C501')
insert into TProducto values('C50201','Chullo 1','Chullo hecho de las lanas de los bóvidos.  En ellos usted puede apreciar a gente que baila y de figuras geométricas variables tamaño y forma.  También tiene colores típicos de la región andina peruana debido a los pigmentos naturales e industriales usados.  Es ideal para el tiempo frío.',' ',0.08,0,32,23,0,25.00,'C502')
insert into TProducto values('C50202','Chullo 2','Chullo hecho de las lanas de los bóvidos, en muchos colores y figuras geométricas clásicas que pertenecen a la civilización de Inca, ideal para los climas fríos.',' ',0.10,0,40,29.5,0,25.00,'C502')
insert into TProducto values('C50203','Chullo 3','Chullo hecho de las lanas de la alpaca, en muchos colores y figuras geométricas clásicas que pertenecen a la civilización de Inca, ideal para los climas fríos.',' ',0.05,0,32,21,0,25.00,'C502')
insert into TProducto values('C50204','Calcetines 1','Calcetines hechos de las lanas de los bóvidos, ideal para los climas fríos porque su capacidad para conservar calor del cuerpo.  En la parte media de esta ropa pueden estar las figuras geométricas vistas apropiadas de la civilización de Inca y las figuras de los animales típicos de la región como la alpaca.',' ',0.06,0,48,10,0,29.00,'C502')
insert into TProducto values('C50205','Calcetines 2','Calcetines hechos de las lanas de los bóvidos, ideal para los climas fríos porque su capacidad para conservar calor del cuerpo.  En la parte media de este pedazo puede ser figuras geométricas vistas apropiadas de la civilización de Inca y figuras de los animales típicos de la región como la alpaca.',' ',0.06,0,48,10,0,26.00,'C502')
insert into TProducto values('C50206','Calcetines 3','Calcetines hechos de las lanas de los bóvidos, ideal para los climas fríos porque su capacidad para conservar calor del cuerpo.  En la parte media de este pedazo puede ser figuras geométricas vistas apropiadas de la civilización de Inca y figuras de los animales típicos de la región como la alpaca.',' ',0.06,0,48,10,0,29.00,'C502')
insert into TProducto values('C50301','Guantes 1',' Guante elegante  hecho de las lanas de colores diversos, mismo uso de los bóvidos en los Andes peruanos donde están comunes las bajas temperaturas.  El tejedor artesano alcanza un acabado magnífico debido a las técnicas heredadas de sus antepasados, las técnicas que fueron perfeccionadas sin embargo muchas generaciones.',' ',0.04,0,26,12,0,30.00,'C503')
insert into TProducto values('C50302','Guantes 2',' Guante elegante  hecho de las lanas de colores diversos, mismo uso de los bóvidos en los Andes peruanos donde están comunes las bajas temperaturas.  El tejedor artesano alcanza un acabado magnífico debido a las técnicas heredadas de sus antepasados, las técnicas que fueron perfeccionadas sin embargo muchas generaciones.',' ',0.04,0,26,12,0,30.00,'C503')
insert into TProducto values('C50303','Guantes 3',' Guante elegante hecho de las lanas de los bóvidos de colores diversos, muy usadas en los Andes peruanos debido a el clima frío.  El tejedor artesano alcanza un acabado magnífico debido a las técnicas heredadas de sus antepasados, las técnicas que fueron perfeccionadas sin embargo muchas generaciones.',' ',0.04,0,26,12,0,30.00,'C503')
insert into TProducto values('C50401','Manton I',' El textil elaborado con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son mano tejida (crochet) por los artesanos de las mujeres de la gran capacidad manual.  En cuanto a su diseño, usted puede apreciar un acabamiento fino y delicado en el pedazo entero. Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía.  Puede también ser lavado al seco.','',0.90,0,102,148,0,250.00,'C504')
insert into TProducto values('C50402','Manton II','El textil elaboró con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son mano tejida (crochet) por los artesanos de las mujeres de la gran capacidad manual.  En cuanto a su diseño, usted puede apreciar la costura que demuestra las flores y las figuras geométricas acompañadas por las franjas así como un acabamiento fino y delicado en el pedazo entero.  Debido a su elegancia se cabe para ser utilizado en ocasiones especiales. Precaución:  lávela a mano con champú.  No utilice una lavadora.  Puede también lavar a seco.','',0.86,0,98,142,0,200.00,'C504')
insert into TProducto values('C50403','Manton III',' El textil es elaborado con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual.  En su diseño usted puede apreciar borlas en sus lados así como un acabamiento fino y delicado en la ropa entera.  Debido a su elegancia es ideal para las ocasiones muy especiales.  Viene con una boina. Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía.  Puede lavarse  al seco.','',0.39,0,240,52,0,50.00,'C504')
insert into TProducto values('C50404','Poncho I',' Elaborado con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual.  Debido a su tamaño esta ropa es ideal para los niños.  Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía.  Puede ser también lavado al seco.','',0.21,0,45,82,0,70.00,'C504')
insert into TProducto values('C50405','Poncho II',' El textil elaborado con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son tejida a mano (crochet) por las mujeres artesanas de la gran capacidad manual.  En su diseño que usted puede apreciar teje en la forma de rosas, de figuras y de borlas geométricas así como un acabamiento fino y delicado.  Debido a su elegancia es ideal para las ocasiones muy especiales. Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía.  Puede también lavar al seco.','',0.68,0,88,128,0,150.00,'C504')
insert into TProducto values('C50406','Poncho con Bufanda I',' Textil elaborado con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son mano tejida (crochet) por los artesanos de las mujeres de la gran capacidad manual.  En su diseño usted puede apreciarlos, los botones alineados con lanas así como un acabamiento fino y delicado en la ropa entera.  Debido a su elegancia es ideal para las ocasiones muy especiales.  Viene con una boina. Precaución:  lávela a mano con champú.  No utilice un lavado y las máquinas de sequía. También puede lavar al seco.','',0.85,0,106,140,0,140.00,'C504')
insert into TProducto values('C50407',' Poncho con Bufanda  II',' Textil elaboró con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son mano tejida (crochet) por las mujeres artesanas de la gran capacidad manual así como demostrar un acabamiento fino y delicado en el pedazo entero.  Debido a su elegancia puede ser utilizado en ocasiones especiales.  Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía. Tambien puede lavar al seco.','',0.77,0,79,148,0,230.00,'C504')
insert into TProducto values('C50501','Bufanda I',' Textil elaborado con alpaca y alpamix, se hace parcialmente con las máquinas industriales y sus detalles de la frontera son tejidas a mano (crochet) por los artesanos de las mujeres de la gran capacidad manual.  Se cabe para ser utilizada con ropas formales.  Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía.  Puede también lavar al seco. ','',0.99,30,44,2,0,55.00,'C505')
insert into TProducto values('C50502','Bufanda II',' Bufanda hecha de las lanas de alpaca, debido a su elegancia que se recomienda se utilice con los juegos formales.','',0.99,30,44,2,0,55.00,'C505')
insert into TProducto values('C50503','Bufanda III',' La bufanda es hecha de lanas de la alpaca, debido a su elegancia que se recomienda se utilice con los juegos formales.','',0.99,30,44,2,0,50.00,'C505')
insert into TProducto values('C50601','Suéter 1','El suéter es hecho por los tejedores de Cuzco con lanas puras de la alpaca, resorte-como de colores diversos, él tiene botones con representaciones Incaicas.  Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía.  Puede también lavarlo al seco.','',0.85,0,65,52.5,0,70.00,'C506')
insert into TProducto values('C50602','Suéter 2','Suéter para damas hechas por los tejedores de Cuzco con las lanas puras de la alpaca colores diversos y terracotta colorea tonos.  También tiene adornos gráficos de la región andina. Precaución:  lávela a mano con champú.  No utilice un lavado y las máquinas de sequía.  Puede también lavarlos al seco.','',0.47,0,61,52,0,75.00,'C506')
insert into TProducto values('C50603','Suéter 3','Suéter hecho de alpaca, se hace parcialmente con las máquinas industriales.  Los detalles que se pueden observar en el collar, las muñecas y el contorno de la ropa son mano tejida (crochet) por los mujeres artesanas con gran capacidad manual.  En todo su diseño puede ser apreciado un acabamiento fino y delicado.  Precaución:  lávela a mano con champú.  No utilice un lavado y máquinas de sequía.  Puede también lavarla al seco.','',0.48,0,78,63.5,0,70.00,'C506')
go
 
--Registro de Cliente
insert into TCliente values('Ruben','Pozo Cornejo','M','DNI','23897514','ruben@hotmail.com','Lima','Lima','Surco','Jr. Bolognesi 275','ruben@hotmail.com','C24783BA96A35464632A624D9F829136EDC0175E','Ruben Pozo S.A','2389758500','04-12-1977','Soltero','Comerciante','5019965','001')
insert into TCliente values('Alba','Molina Herrera','F','DNI','45877114','alba@hotmail.com','Lima','Lima','La Molina','Av. Raul Ferrero R. 1205','alba@hotmail.com','F9F4FA2C73D392E3E8BF15428537799140B9DDA9','','','16-12-1985','Soltero','Comerciante','5028914','001')
insert into TCliente values('Susana','Torres Farfán','F','DNI','23857124','susana@hotmail.com','Arequipa','Arequipa','Yanahuara','Ca. Los Naranjos 543','susana@hotmail.com','F925D420627F3DB470E17FC2A289A4DD103722F2','Arequipa Artesanos S.A.C','2385967250','05-10-1962','Casado','Artesano','288561','001')
insert into TCliente values('Esteban','Camargo Gonzáles','F','DNI','24425810','esteban@hotmail.com','Ayacucho','Ayacucho','Ayacucho','Jr. 28 de Julio 393 ','esteban@hotmail.com','431EF4C5DA9A59CBBE78DF77A53FCC737A3B78FA','Artesanias Esteban S.A','2448521032','29-08-1967','Casado','Artesano','358196','001')
insert into TCliente values('Maria Inés','Zegarra Sullca','F','DNI','23850184','mariaines@hotmail.com','Puno','Puno','Puno','Ca. Bolognesi 190','mariaines@hotmail.com','DB73596290086F399454C7F537BBEFF2FD331B89','Artesanos Puno S.A.C','2380019822','11-07-1973','Casado','Artesano','298715','001')
insert into TCliente values('Juan Manuel','Chávez Vera','F','DNI','45609663','juanmanuel@hotmail.com','Lima','Lima','Ate','Av. Urubamba 449','juanmanuel@hotmail.com','EA40FB18915C9F75C7643496AA24B126389769A7','','','04-02-1989','Soltero','Estudiante','5185964','001')
insert into TCliente values('Victor','Choque Pérez','F','DNI','23694625','victor@hotmail.com','Lima','Lima','La Victoria','Av. Arequipa 980','victor@hotmail.com','88FA846E5F8AA198848BE76E1ABDCB7D7A42D292','Perú Artesanias S.A','2585987401','12-12-1969','Casado','Empresario','5225896','001')
insert into TCliente values('Carolina','Rojas Santos','F','Cédula de Identidad','28 986 528 5','carolina@hotmail.com','La Paz','La Paz','La Paz','Av. 6 de Agosto N° 2464','carolina@hotmail.com','C33873C987BC9D5BC6A51E095311D747B85A78E1','','','31-12-1981','Soltero','Recepcionista','2225734','002')
 
 
insert into TCompra values ('001','1','35.00','12-04-2011','15-04-2011')
insert into TCompra values ('002','1','40.00','10-04-2011','13-04-2011')
insert into TCompra values ('003','1','60.00','11-04-2011','16-04-2011')
 
insert into TDireccionEnvio values ('Mi casa','Cusco','Cusco','Cusco','Larapa D-12-2','237856','José','Guillén','1')
insert into TDireccionEnvio values ('Casa Mamá','Cusco','Cusco','Cusco','Av. Sol 562','289856','María','Cornejo','1')