using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DCSONDAGE_V1.Models;

namespace DCSONDAGE_V1.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Creation()
        {
            return View("Creation");
        }
        public ActionResult Submit(string titreSondage, Int32 restrictionSondage, Int32 RadioB, string Choix1, string Choix2, string Choix3, string Choix4, string Choix5)
        {
            // insert into sondage(questionSondage,typeSondage) values (titreSondage,RadioB)

            if (titreSondage == "") 
            {
                return View("Erreur", (object)"Vous n'avez pas rempli le libellé du sondage");
            }
            else
            {
                List<string> listechoix = new List<string>();
                if (Choix1 != "")
                {
                    listechoix.Add(Choix1);
                }
                if (Choix2 != "")
                {
                    listechoix.Add(Choix2);
                }
                if (Choix3 != "")
                {
                    listechoix.Add(Choix3);
                }
                if (Choix4 != "")
                {
                    listechoix.Add(Choix4);
                }
                if (Choix5 != "")
                {
                    listechoix.Add(Choix5);
                }
                if (listechoix.Count < 2)
                {
                    return View("Erreur", (object)"vous n'avez pas rempli au moins 2 champs de reponses possibles");
                }
                
                Int32 idsondage = BDD.RequeteAjoutSqlSondage(titreSondage, RadioB);

                BDD.requetteAjoutSqlChoix(idsondage, listechoix);
                Lien Liencourrant = new Lien(idsondage, RadioB);
                BDD.requetteAjoutSqlLienSuppr(idsondage, Liencourrant.Guidsuppression);
                return View("Liens", Liencourrant);
            }
            
            
        }
       /* public ActionResult Vote(Int32 numSondage)
        {
            Int32 typeVote = BDD.requeteSqlTypeVote(numSondage);
            if (typeVote==1)
            {
                return Redirect(string.Format("/Resultat/VoteU/{0}", numSondage));
            }
            else
            {
                return Redirect(string.Format("/Resultat/VoteM/{0}", numSondage));
            }


        }*/
       
    }
}