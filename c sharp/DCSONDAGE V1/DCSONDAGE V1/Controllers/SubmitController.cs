using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DCSONDAGE_V1.Models;

namespace DCSONDAGE_V1.Controllers
{
    public class SubmitController : Controller
    {
        // GET: Submit
        public ActionResult Index(string titreSondage,Int32 RadioB, string Choix1,string Choix2,string Choix3,string Choix4,string Choix5)
        {
            // insert into sondage(questionSondage,typeSondage) values (titreSondage,RadioB)
            BDD.RequeteAjoutSqlSondage(titreSondage, RadioB);
            Response.Redirect("http://google.com");
            return View();
        }
    }
}