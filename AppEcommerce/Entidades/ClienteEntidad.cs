using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;


namespace CapaEntidades
{
    [DataContract]
    public class ClienteEntidad
    {
        [DataMember]
        public string Nombres { get; set; }
        [DataMember]
        public string Apellidos { get; set; }
        [DataMember]
        public string Sexo { get; set; }
        [DataMember]
        public string TipoDocumento { get; set; }
        [DataMember]
        public string NroDocumento { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Provincia { get; set; }
        [DataMember]
        public string Ciudad { get; set; }
        [DataMember]
        public string Distrito { get; set; }
        [DataMember]
        public string Direccion { get; set; }
        [DataMember]
        public string Usuario { get; set; }
        [DataMember]
        public string Contrasena { get; set; }
        [DataMember]
        public string RazonSocial { get; set; }
        [DataMember]
        public string RUC { get; set; }
        [DataMember]
        public DateTime FechaNac { get; set; }
        [DataMember]
        public string EstadoCivil { get; set; }
        [DataMember]
        public string Ocupacion { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public PaisEntidad pais { get; set; }
    }
}
