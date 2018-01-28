using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

using CapaEntidades;
using System.Data;
using CapaNegocio;
// NOTA: puede usar el comando "Cambiar nombre" del menú "Refactorizar" para cambiar el nombre de clase "ServiceProducto" en el código, en svc y en el archivo de configuración a la vez.
public class ServiceProducto : IServiceProducto
{
    ProductoBL productoBL = new ProductoBL();

    public System.Data.DataSet Listar()
    {
        return productoBL.Listar();
    }

    public List<string> Agregar(CapaEntidades.ProductoEntidad producto)
    {
        List<String> Resultados = new List<String>();

        String Estado = Convert.ToString(productoBL.Agregar(producto));
        String Mensaje = productoBL.Mensaje;
        Resultados.Add(Estado);
        Resultados.Add(Mensaje);
        return Resultados;
    }

    public List<string> Eliminar(string codProd)
    {
        List<String> Resultados = new List<String>();

        String Estado = Convert.ToString(productoBL.Eliminar(codProd));
        String Mensaje = productoBL.Mensaje;
        Resultados.Add(Estado);
        Resultados.Add(Mensaje);
        return Resultados;
    }
}
