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
        bool Actualizar(ProductoEntidad producto);
        bool Eliminar(String codProd);
        DataSet Buscar(String codProd);
    }
}
