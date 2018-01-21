using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using CapaEntidades;
namespace CapaNegocio.Interfaces
{
    interface iProducto
    {
        DataSet Listar();
        bool Agregar(ProductoEntidad producto);
        bool Eliminar(String codProducto);
        bool Actualizar(ProductoEntidad producto);
        DataSet Buscar(String codCliente);
       
    }
}
