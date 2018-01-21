using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using CapaDatos;
using System.Data;
using CapaEntidades;
namespace CapaNegocio
{
   public  class ProductoBL:Interfaces.iProducto
    {
        Datos datos = new DatosSQL();
        private String mensaje;
        public String Mensaje
        {
            get { return mensaje; }
            set { mensaje = value; }
        }

        public System.Data.DataSet Listar()
        {
            return datos.TraerDataSet("spListrarProducto");
        }

        public bool Agregar(CapaEntidades.ProductoEntidad producto)
        {
            throw new NotImplementedException();
        }

        public bool Eliminar(string codProducto)
        {
            throw new NotImplementedException();
        }

        public bool Actualizar(CapaEntidades.ProductoEntidad producto)
        {
            throw new NotImplementedException();
        }

        public System.Data.DataSet Buscar(string codCliente)
        {
            throw new NotImplementedException();
        }
    }
}
