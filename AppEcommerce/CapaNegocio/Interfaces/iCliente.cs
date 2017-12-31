using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using CapaEntidades;
namespace CapaNegocio.Interfaces
{
    interface iCliente
    {
        DataSet Listar();
        bool Agregar(ClienteEntidad cliente);
        bool Eliminar(String codCliente);
        bool Actualizar(ClienteEntidad cliente);
        DataSet Buscar(String codCliente);
        bool ValidarUsuario();
    }
}
