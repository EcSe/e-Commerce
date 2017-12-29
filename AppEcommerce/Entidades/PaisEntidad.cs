using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.Serialization;

namespace CapaEntidades
{
   [DataContract]
   public  class PaisEntidad
    {
       [DataMember]
       public string CodPais { get; set; }
      [DataMember]
       public string Nombre { get; set; }
    }
}
