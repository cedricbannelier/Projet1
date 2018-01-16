using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class Votant
    {
        public String adresseIp { get; set; }

        public Int32 numVotant { get; set; }

        public Votant(string addIp)
        {
            adresseIp = addIp;
        }
    }
}