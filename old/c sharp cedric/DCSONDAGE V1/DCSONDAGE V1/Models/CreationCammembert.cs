using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class CreationCamembert
    {
        public List<String> listeChoixVote { get; set; }
        public List<Double> listePourcentage { get; set; }

        public CreationCamembert(List<String> ChoixVote, List<Double> Pourcentage)
        {
            listeChoixVote = ChoixVote;
            listePourcentage = Pourcentage;
        }
    }
}