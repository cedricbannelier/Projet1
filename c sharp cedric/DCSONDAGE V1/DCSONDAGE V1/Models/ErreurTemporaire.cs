using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class ErreurTemporaire
    {
        public Int32 IdSondage { get; set; }
        public String MessageDErreur { get; set; }
        public String Redirectionresultat { get; set; }
        public ErreurTemporaire(Int32 id, String message)
        {
            IdSondage = id;
            MessageDErreur = message;
            Redirectionresultat = "AffichageResultat";
        }
        public ErreurTemporaire(Int32 id, string message, String redirectionVote)
        {
            IdSondage = id;
            MessageDErreur = message;
            Redirectionresultat = redirectionVote;
        }
    }
}