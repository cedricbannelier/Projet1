using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class Votant
    {
        public String AdresseIp { get; set; }

        public Votant(string addIp)
        {
            AdresseIp = addIp;
        }
    }
}