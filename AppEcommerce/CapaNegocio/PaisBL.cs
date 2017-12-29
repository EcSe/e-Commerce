using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using CapaDatos;
using System.Data; 

namespace CapaNegocio
{
  public class PaisBL:Interfaces.iPais
    {
      private Datos datos = new DatosSQL();
      private String mensaje;
      public String Mensaje
      {
          get { return mensaje; }
          set { mensaje = value; }
      }

        public System.Data.DataSet Listar()
        {
            return datos.TraerDataSet("uspListarPais");
        }

        public bool Agregar(CapaEntidades.PaisEntidad pais)
        {
            DataRow fila = datos.TraerDataRow("uspAgregarPais",pais.CodPais,pais.Nombre);
            mensaje = fila["Mensaje"].ToString();
            byte codError = Convert.ToByte(fila["CodError"]);
            if (codError == 0) return true;
            else return false;
        }

        public bool Eliminar(string codPais)
        {
            DataRow fila = datos.TraerDataRow("uspEliminarPais", codPais);
            mensaje = fila["Mensaje"].ToString();
            byte codError = Convert.ToByte(fila["CodError"]);
            if (codError == 0) return true;
            else return false;
        }

        public bool Actualizar(CapaEntidades.PaisEntidad pais)
        {
            throw new NotImplementedException();
        }

        public System.Data.DataSet Buscar(string codPais)
        {
            throw new NotImplementedException();
        }
    }
}
