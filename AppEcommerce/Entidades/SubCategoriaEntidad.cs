using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidades
{
    public class SubCategoriaEntidad
    {
        public string CodSubCategoria { get; set; }
        public string Nombre { get; set; }
        public CategoriaEntidad Categoria { get; set; }
    }
}
