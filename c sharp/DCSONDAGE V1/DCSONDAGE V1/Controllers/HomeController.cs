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
        public ActionResult Submit(string titreSondage, Int32 RadioB, string Choix1, string Choix2, string Choix3, string Choix4, string Choix5)
        {
            // insert into sondage(questionSondage,typeSondage) values (titreSondage,RadioB)
            Int32 idsondage = BDD.RequeteAjoutSqlSondage(titreSondage, RadioB);
            BDD.requetteAjoutSqlChoix(idsondage, Choix1, Choix2, Choix3, Choix4, Choix5);
            Lien Liencourrant = new Lien(idsondage);
            BDD.requetteAjoutSqlLienSuppr(idsondage,Liencourrant.Guidsuppression);
            return View("Liens",Liencourrant);
        }
        public ActionResult Vote(Int32 numSondage)
        {
            Boolean typeVote = BDD.requeteSqlTypeVote(numSondage);
            if (typeVote)
            {
                return Redirect(string.Format("/Resultat/VoteU/{0}", numSondage));
            }
            else
            {
                return Redirect(string.Format("/Resultat/VoteM/{0}", numSondage));
            }


        }
    }
}