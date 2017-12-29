using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using CapaEntidades;

namespace CapaNegocio.Interfaces
{
    interface iPais
    {
        DataSet Listar();
        bool Agregar(PaisEntidad pais);
        bool Eliminar(string codPais);
        bool Actualizar(PaisEntidad pais);
        DataSet Buscar(string codPais);
    }
}
