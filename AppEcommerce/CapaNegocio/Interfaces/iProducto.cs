using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using CapaEntidades;
<<<<<<< HEAD
=======

>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
namespace CapaNegocio.Interfaces
{
    interface iProducto
    {
        DataSet Listar();
        bool Agregar(ProductoEntidad producto);
<<<<<<< HEAD
        bool Eliminar(String codProducto);
        bool Actualizar(ProductoEntidad producto);
        DataSet Buscar(String codCliente);
       
=======
        bool Actualizar(ProductoEntidad producto);
        bool Eliminar(String codProd);
        DataSet Buscar(String codProd);
>>>>>>> 644f5c032a7fbb4cb9479342495a57ba9ac84c3b
    }
}
