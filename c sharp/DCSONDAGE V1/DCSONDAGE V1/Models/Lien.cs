using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class Lien
    {
        public String adresseLien1 { get; set; }
        public String adresseLien2 { get; set; }
        public String adresseLien3 { get; set; }
        public Guid Guidsuppression { get; set; }
        public Int32 numSondage { get; set; }
        public Lien(int numSondage)
        {
            adresseLien1 = string.Format("/Resultat/VoteU/{0}", numSondage);  //vote
            adresseLien2 = string.Format("/Resultat/resultat/{0}", numSondage);            // resultat
            Guid SuppressionGuid = new Guid();
            SuppressionGuid = Guid.NewGuid();
            Guidsuppression = SuppressionGuid;
            adresseLien3 = string.Format("/Resultat/Suppression/{0}", SuppressionGuid);          //  Suppression

        }

    }
}