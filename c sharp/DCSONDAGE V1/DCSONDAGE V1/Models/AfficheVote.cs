using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class AfficheVote
    {
        public List<String> listeNomChoix { get; set; }
        public List<Int32> listeNumChoix { get; set; }
        public String nomSondage { get; set; }
        public Int32 numSondage { get; set; }
        

        public AfficheVote(int idSondage, String nom, List<Int32> listeIdChoix, List<String> listeChoix)
        {
            numSondage = idSondage;
            nomSondage = nom;
            listeNumChoix = listeIdChoix;
            listeNomChoix = listeChoix;
           
        }
        public AfficheVote(int idSondage, List<Int32> listeIdChoix, List<String> listeChoix)
        {
            numSondage = idSondage;
            listeNumChoix = listeIdChoix;
            listeNomChoix = listeChoix;
       
        }
        public void ajoutNomsondage(string nomduSondage)
        {
            nomSondage = nomduSondage;
        }

    }
}