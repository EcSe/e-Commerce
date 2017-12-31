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
        public String Nombres { get; set; }
        [DataMember]
        public String Apellidos { get; set; }
        [DataMember]
        public String Sexo { get; set; }
        [DataMember]
        public String TipoDocumento { get; set; }
        [DataMember]
        public String NroDocumento { get; set; }
        [DataMember]
        public String Email { get; set; }
        [DataMember]
        public String Provincia { get; set; }
        [DataMember]
        public String Ciudad { get; set; }
        [DataMember]
        public String Distrito { get; set; }
        [DataMember]
        public String Direccion { get; set; }
        [DataMember]
        public String Usuario { get; set; }
        [DataMember]
        public String Contrasena { get; set; }
        [DataMember]
        public String RazonSocial { get; set; }
        [DataMember]
        public String RUC { get; set; }
        [DataMember]
        public DateTime FechaNac { get; set; }
        [DataMember]
        public String EstadoCivil { get; set; }
        [DataMember]
        public String Ocupacion { get; set; }
        [DataMember]
        public String Telefono { get; set; }
        [DataMember]
        public PaisEntidad pais { get; set; }
    }
}
