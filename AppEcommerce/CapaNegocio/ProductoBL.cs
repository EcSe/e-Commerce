using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using CapaDatos;

using System.Data;
using CapaEntidades;
namespace CapaNegocio
{
    public class ProductoBL : Interfaces.iProducto
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
            return datos.TraerDataSet("spListarProducto");
        }

        public bool Agregar(CapaEntidades.ProductoEntidad producto)
        {
            DataRow fila = datos.TraerDataRow("spAgregarProducto", producto.CodProducto, producto.Nombre, producto.Descripcion,
           producto.Especificacion, producto.Peso, producto.Longitud, producto.Alto, producto.Ancho, producto.Diametro,
           producto.Precio, producto.SubCategoria.CodSubCategoria);
            mensaje = fila["Mensaje"].ToString();
            byte CodError = Convert.ToByte(fila["CodError"]);
            if (CodError == 0) return true;
            else return false;
        }

        public bool Eliminar(string codProducto)
        {

            DataRow fila = datos.TraerDataRow("spEliminarProducto", codProducto);
            mensaje = fila["Mensaje"].ToString();
            byte codError = Convert.ToByte(fila["CodError"]);
            if (codError == 0) return true;
            else return false;
        }

        public bool Actualizar(CapaEntidades.ProductoEntidad producto)
        {
            throw new NotImplementedException();
        }


       

        public System.Data.DataSet Buscar(string codProd)
        {
            throw new NotImplementedException();
        }
    }   
}
