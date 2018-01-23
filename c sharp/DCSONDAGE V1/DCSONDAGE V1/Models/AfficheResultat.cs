using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class AfficheResultat
    {
        public List<String> listeNomChoixPourModel { get; set; }
        public List<Int32> listeNumChoixPourModel { get; set; }
        public String nomSondagePourModel { get; set; }
        public Int32 numSondagePourModel { get; set; }
        public List <Int32> voteParChoixPourModel { get; set; }
        public List <double> pourcentageParChoixPourModel { get; set; }
        public AfficheResultat(int idSondage, String nomSondage, List<Int32> listeIdChoix, List<String> listeNomChoix, List<Int32> voteParChoix, List<double> pourcentageParChoix)
        {
            listeNomChoixPourModel = listeNomChoix;
            listeNumChoixPourModel = listeIdChoix;
            nomSondagePourModel = nomSondage;
            numSondagePourModel = idSondage;
            voteParChoixPourModel = voteParChoix;
            pourcentageParChoixPourModel = pourcentageParChoix;
        }



    }
}