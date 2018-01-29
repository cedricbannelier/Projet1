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

                return Redirect(string.Format("/Home/Liens/{0}", Liencourrant.Guidsuppression.ToString()));
            }


        }
        public ActionResult Liens(String id)
        {
            String listeGuid = id;
            Int32 idSondage=BDD.GetIdSondageParGuid(id);
            if (idSondage < 0)
            {
                return View("Erreur", (object)"C'est pas bien de fouille pour tenté d'avoir des liens de suppressions");
            }
            else
            {
                Int32 typeSondage = BDD.GetTypeSondage(idSondage);
                Lien LiensCourant = new Lien(idSondage, typeSondage, listeGuid);
                return View("Liens", LiensCourant);
            }
            
                
            
            
        }
    }
}