using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

using System.Data;
using CapaEntidades;
using CapaNegocio;

// NOTA: puede usar el comando "Cambiar nombre" del menú "Refactorizar" para cambiar el nombre de clase "ServicePais" en el código, en svc y en el archivo de configuración a la vez.
public class ServicePais : IServicePais
{
    private PaisBL paisBL = new PaisBL();
    private PaisEntidad pais = new PaisEntidad();

    public System.Data.DataSet Listar()
    {
        return paisBL.Listar();
    }

    public List<string> Agregar(CapaEntidades.PaisEntidad pais)
    {
        List<String> Resultados = new List<string>();

        String Estado = Convert.ToString(paisBL.Agregar(pais));
        String Mensaje = paisBL.Mensaje;
        Resultados.Add(Estado);
        Resultados.Add(Mensaje);
        return Resultados;
    }

    public List<string> Eliminar(string codPais)
    {
        List<String> Resultados = new List<string>();

        String Estado = Convert.ToString(paisBL.Eliminar(codPais));
        String Mensaje = paisBL.Mensaje;
        Resultados.Add(Estado);
        Resultados.Add(Mensaje);
        return Resultados;
    }
}
