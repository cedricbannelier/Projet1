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
        public Int32 typeSondage { get; set; }
        public Int32 nombreDeVotant { get; set; }

        public AfficheVote(Int32 idSondage, String nom, List<Int32> listeIdChoix, List<String> listeChoix, Int32 Sondage)
        {
            numSondage = idSondage;
            nomSondage = nom;
            listeNumChoix = listeIdChoix;
            listeNomChoix = listeChoix;
            typeSondage = Sondage;
        }
        public AfficheVote(Int32 idSondage, List<Int32> listeIdChoix, List<String> listeChoix, Int32 Sondage)
        {
            numSondage = idSondage;
            listeNumChoix = listeIdChoix;
            listeNomChoix = listeChoix;
            typeSondage = Sondage;
        }
        public void ajoutNomsondage(string nomduSondage)
        {
            nomSondage = nomduSondage;
        }
        public void ajoutNbVotant(Int32 NbVotant)
        {
            nombreDeVotant = NbVotant;
        }
    }
}