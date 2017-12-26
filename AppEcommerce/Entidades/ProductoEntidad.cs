using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidades
{
    public class ProductoEntidad
    {
        public string CodProducto { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Especificacion { get; set; }
        public double Peso { get; set; }
        public double Longitud { get; set; }
        public double Alto { get; set; }
        public double Ancho { get; set; }
        public double Diametro { get; set; }
        public double Precio { get; set; }
        public SubCategoriaEntidad SubCategoria { get; set; }
    }
}
