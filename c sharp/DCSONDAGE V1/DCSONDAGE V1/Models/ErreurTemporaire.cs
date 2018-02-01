using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class ErreurTemporaire
    {
        public Int32 IdSondage { get; set; }
        public String MessageDErreur { get; set; }
        public ErreurTemporaire(Int32 id,string message)
        {
            IdSondage = id;
            MessageDErreur = message; 
        }
    }
}