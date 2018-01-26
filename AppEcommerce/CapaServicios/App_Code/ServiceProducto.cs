using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

// NOTA: puede usar el comando "Cambiar nombre" del menú "Refactorizar" para cambiar el nombre de clase "ServiceProducto" en el código, en svc y en el archivo de configuración a la vez.
public class ServiceProducto : IServiceProducto
{
	

    public System.Data.DataSet Listar()
    {
        throw new NotImplementedException();
    }

    public List<string> Agregar(CapaEntidades.ProductoEntidad producto)
    {
        throw new NotImplementedException();
    }

    public List<string> Eliminar(string codProd)
    {
        throw new NotImplementedException();
    }
}
