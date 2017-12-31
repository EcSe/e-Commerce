using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

using System.Data;
using CapaEntidades;
using CapaNegocio;

// NOTA: puede usar el comando "Cambiar nombre" del menú "Refactorizar" para cambiar el nombre de clase "ServiceCliente" en el código, en svc y en el archivo de configuración a la vez.
public class ServiceCliente : IServiceCliente
{
    private ClienteBL clienteBL = new ClienteBL();
   // private ClienteEntidad cliente = new ClienteEntidad();

    public System.Data.DataSet Listar()
    {

        return clienteBL.Listar();
    }

    public List<String> Agregar(CapaEntidades.ClienteEntidad cliente)
    {
        List<String> Resultados = new List<String>();

        String Estado = Convert.ToString(clienteBL.Agregar(cliente));
        String Mensaje = clienteBL.Mensaje;
        Resultados.Add(Estado);
        Resultados.Add(Mensaje);
        return Resultados;
    }

    public List<string> Eliminar(string codCliente)
    {
        List<String> Resultados = new List<string>();

        String Estado = Convert.ToString(clienteBL.Eliminar(codCliente));
        String Mensaje = clienteBL.Mensaje;
        Resultados.Add(Estado);
        Resultados.Add(Mensaje);
        return Resultados;
    }


   /* public string Login(string user, string contrasena)
    {
        cliente.Usuario = user;
        cliente.Contrasena = contrasena;

        clienteBL.ValidarUsuario();
        return clienteBL.Mensaje;

    }*/
}
