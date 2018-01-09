using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class Lien
    {
        public String AdresseLien1 { get; set; }
        public String AdresseLien2 { get; set; }
        public String AdresseLien3 { get; set; }
        public Lien(String Adresse1, String Adresse2, String Adresse3)
        {
            AdresseLien1 = Adresse1;
            AdresseLien2 = Adresse2;
            AdresseLien3 = Adresse3;
        }
    }
}