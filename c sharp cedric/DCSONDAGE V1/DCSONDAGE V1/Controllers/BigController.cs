using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DCSONDAGE_V1.Models;

namespace DCSONDAGE_V1.Controllers
{
    public class BigController : Controller
    {
        // GET: BigBrother
        /// <summary>
        /// Permet d'instancier la classe AfficheBigBrother
        /// Affiche une liste des ip et des votes que les utilisateurs ont fait, en envoyant la vue Big/AffichageResultat
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Brother(Int32 id=0)
        {
            if (id < 1)
            {
                return View("Erreur", (object)"adresse non complete");
            }
                AfficheBigBrother Affichage = BDD.BigBrotherIP(id);
                return View("AffichageResultat", Affichage);
        }
    }
}