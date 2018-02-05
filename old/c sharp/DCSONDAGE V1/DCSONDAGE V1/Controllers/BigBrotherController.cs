using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DCSONDAGE_V1.Models;

namespace DCSONDAGE_V1.Controllers
{
    public class BigBrotherController : Controller
    {
        // GET: BigBrother
        public ActionResult Index(Int32 id=0)
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