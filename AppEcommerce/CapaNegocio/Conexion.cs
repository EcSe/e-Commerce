using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
namespace CapaNegocio
{
    public class Conexion
    {
        public string CadenaConexion { get; set; }

        public Conexion()
        {
            CadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
        }
    }
}
