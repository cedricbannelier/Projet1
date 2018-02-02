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
        public String nomSondage { get; set; }
        public Int32 TypeSondage { get; set; }
        public Lien(Int32 numSondage,Int32 typeSondage)
        {
            nomSondage = BDD.GetNomSondage(numSondage);
            adresseLien1 = string.Format("/Home/Vote/{0}", numSondage);  
            adresseLien2 = string.Format("/Home/AffichageResultat/{0}", numSondage);            // resultat
            Guid SuppressionGuid = new Guid();
            SuppressionGuid = Guid.NewGuid();
            Guidsuppression = SuppressionGuid;
            adresseLien3 = string.Format("/Home/Suppression/{0}", SuppressionGuid);          //  Suppression
        }
        public Lien(Int32 numSondage, Int32 typeSondage, String stringGuid)
        {
            nomSondage = BDD.GetNomSondage(numSondage);
            adresseLien1 = string.Format("/Home/Vote/{0}", numSondage);  //vote
            adresseLien2 = string.Format("/Home/AffichageResultat/{0}", numSondage);            // resultat
            adresseLien3 = string.Format("/Home/Suppression/{0}", stringGuid);          //  Suppression
        }
    }
}