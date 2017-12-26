using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidades
{
    public class ClienteEntidad
    {
        public int CodCliente { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Sexo { get; set; }
        public string TipoDocumento { get; set; }
        public string NroDocumento { get; set; }
        public string Email { get; set; }
        public string Provincia { get; set; }
        public string Ciudad { get; set; }
        public string Distrito { get; set; }
        public string Direccion { get; set; }
        public string Usuario { get; set; }
        public string Contrasena { get; set; }
        public string RazonSocial { get; set; }
        public string RUC { get; set; }
        public DateTime FechaNac { get; set; }
        public string EstadoCivil { get; set; }
        public string Ocupacion { get; set; }
        public string Telefono { get; set; }
        public PaisEntidad pais { get; set; }
    }
}
