using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

using  System.Data;
using CapaEntidades;
// NOTA: puede usar el comando "Cambiar nombre" del menú "Refactorizar" para cambiar el nombre de interfaz "IServiceProducto" en el código y en el archivo de configuración a la vez.
[ServiceContract]
public interface IServiceProducto
{
    [OperationContract]
    DataSet Listar();

    [OperationContract]
    List<String> Agregar(ProductoEntidad producto);

    [OperationContract]
    List<String> Eliminar(String codProd);
}
