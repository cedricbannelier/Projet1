using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace DCSONDAGE_V1.Models
{
    public class Sondage
    {
        public String QuestionSondage { get; set; }
        public Boolean ChoixUniqueSondage { get; set; }

        public Sondage(string question, Boolean choix)
        {
            QuestionSondage = question;
            ChoixUniqueSondage = choix;
        }
        public static void AjoutSondage()
        {
            
        }
    }
}