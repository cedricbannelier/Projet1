using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace DCSONDAGE_V1.Models
{
    public class Sondage
    {
        public String questionSondage { get; set; }
        public Boolean choixUniqueSondage { get; set; }
        public Int32 numSondage { get; set; }

        public Sondage(string question, Boolean choix)
        {
            questionSondage = question;
            choixUniqueSondage = choix;
        }
        public Sondage(Int32 numC, String question, Boolean choix)
        {
            questionSondage = question;
            choixUniqueSondage = choix;
            numSondage = numC;
        }
    }
}