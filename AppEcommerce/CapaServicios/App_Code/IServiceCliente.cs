using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

using System.Data;
using CapaEntidades;
// NOTA: puede usar el comando "Cambiar nombre" del menú "Refactorizar" para cambiar el nombre de interfaz "IServiceCliente" en el código y en el archivo de configuración a la vez.
[ServiceContract]
public interface IServiceCliente
{
	[OperationContract]
	DataSet Listar();

    [OperationContract]
    List<String> Agregar(ClienteEntidad cliente);

    [OperationContract]
    List<String> Eliminar(String codCliente);

    [OperationContract]
    String Login(string user, string contrasena);
}
