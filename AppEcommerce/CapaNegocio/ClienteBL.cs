using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using CapaDatos;
using System.Data;
using CapaEntidades;
namespace CapaNegocio
{
    
    
    public class ClienteBL:Interfaces.iCliente
    {
        
        Datos datos = new DatosSQL();
        private String mensaje;
        public String Mensaje
        {
            get { return mensaje; }
            set { mensaje = value; }
        }

        public DataSet Listar()
        {
            return datos.TraerDataSet("spListarCliente");
        }

        public bool Agregar(CapaEntidades.ClienteEntidad cliente)
        {
           /* PaisEntidad paises = new PaisEntidad();
            cliente.pais = paises;*/

           DataRow fila = datos.TraerDataRow("spAgregarCliente",cliente.Nombres,
               cliente.Apellidos,cliente.Sexo,cliente.TipoDocumento,cliente.NroDocumento,cliente.Email,
               cliente.Provincia,cliente.Ciudad,cliente.Distrito,cliente.Direccion,cliente.Usuario,
             cliente.Contrasena,cliente.RazonSocial,cliente.RUC,cliente.FechaNac,cliente.EstadoCivil,
               cliente.Ocupacion,cliente.Telefono,cliente.pais.CodPais);
           mensaje = fila["Mensaje"].ToString();
           byte codError = Convert.ToByte(fila["CodError"]);
           if (codError == 0) return true;
           else return false;
        }

        public bool Eliminar(string codCliente)
        {
            DataRow fila = datos.TraerDataRow("spEliminarCliente", codCliente);
            mensaje = fila["Mensaje"].ToString();
            byte codError = Convert.ToByte(fila["codError"]);
            if (codError == 0) return true;
            else return false;
        }

        public bool Actualizar(CapaEntidades.ClienteEntidad cliente)
        {
            throw new NotImplementedException();
        }

        public DataSet Buscar(string codCliente)
        {
            throw new NotImplementedException();
        }


        public bool ValidarUsuario()
        {
            ClienteEntidad cli = new ClienteEntidad();
        

            DataRow fila = datos.TraerDataRow("spLoginUser", cli.Usuario,cli.Contrasena);
            mensaje = fila["Mensaje"].ToString();
            byte codError = Convert.ToByte(fila["codError"]);
            if (codError == 0) return true;
            else return false;
        }
    }
}
