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
        public ActionResult Submit(string titreSondage,  List<String> creationChoix,Int32 restrictionSondage, Int32 RadioB)
        {
            if (string.IsNullOrEmpty(titreSondage))
            {
                return View("Erreur", (object)"Vous n'avez pas rempli le libellé du sondage");
            }
            else
            {
                creationChoix.RemoveAll(T => (string.IsNullOrWhiteSpace(T)));

                if (creationChoix.Count < Constantes.MINCHOIX)
                {
                    return View("Erreur", (object)"vous n'avez pas rempli au moins 2 champs de reponses possibles");
                }

                Int32 idsondage = BDD.RequeteAjoutSqlSondage(titreSondage, RadioB+ restrictionSondage);
                BDD.requetteAjoutSqlChoix(idsondage, creationChoix);
                Lien Liencourrant = new Lien(idsondage, RadioB+ restrictionSondage);
                BDD.requetteAjoutSqlLienSuppr(idsondage, Liencourrant.Guidsuppression);

                return Redirect(string.Format("/Home/Liens/{0}", Liencourrant.Guidsuppression.ToString()));
            }


        }
        public ActionResult Liens(String id)
        {
           
            String listeGuid = id;
            Int32 idSondage = BDD.GetIdSondageParGuid(id);
            if (idSondage < 0)
            {
                return View("Erreur", (object)"C'est pas bien de fouille pour tenté d'avoir des liens de suppressions");
            }
            else
            {
                Int32 typeSondage = BDD.GetTypeSondage(idSondage);
                return View("Liens", new Lien(idSondage, typeSondage, listeGuid));
            } 
        }
    }
}