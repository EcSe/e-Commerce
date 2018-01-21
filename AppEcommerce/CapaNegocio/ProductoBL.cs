using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using CapaDatos;
<<<<<<< HEAD
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
=======
using CapaEntidades;
using System.Data;

namespace CapaNegocio
{
     public class ProductoBL:Interfaces.iProducto
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
            return  datos.TraerDataSet("spListarProducto");
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
        }

        public bool Agregar(CapaEntidades.ProductoEntidad producto)
        {
<<<<<<< HEAD
            throw new NotImplementedException();
        }

        public bool Eliminar(string codProducto)
=======
            DataRow fila = datos.TraerDataRow("spAgregarProducto",producto.CodProducto,producto.Nombre,producto.Descripcion,
                producto.Especificacion,producto.Peso,producto.Longitud,producto.Alto,producto.Ancho,producto.Diametro,
                producto.Precio,producto.SubCategoria.CodSubCategoria);
            mensaje = fila["Mensaje"].ToString();
            byte CodError = Convert.ToByte(fila["CodError"]);
            if (CodError == 0) return true;
            else return false;

        }

        public bool Actualizar(CapaEntidades.ProductoEntidad producto)
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
        {
            throw new NotImplementedException();
        }

<<<<<<< HEAD
        public bool Actualizar(CapaEntidades.ProductoEntidad producto)
=======
        public bool Eliminar(string codProd)
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
        {
            throw new NotImplementedException();
        }

<<<<<<< HEAD
        public System.Data.DataSet Buscar(string codCliente)
=======
        public System.Data.DataSet Buscar(string codProd)
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
        {
            throw new NotImplementedException();
        }
    }
}
