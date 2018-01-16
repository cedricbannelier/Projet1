using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DCSONDAGE_V1.Models;

namespace DCSONDAGE_V1.Controllers
{
    public class ResultatController : Controller
    {
        // GET: Resultat
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult VoteU(Int32 id)
        {
            AfficheVote Affiche = BDD.requeteSqlRecupListeChoixetId(id);
            Affiche.ajoutNomsondage(BDD.requeteSqlRecupNomSondage(id));

            return View("VoteU",Affiche);
        }
        public ActionResult VoteM(Int32 idSondage)
        {
            return View("VoteM");
        }


        public ActionResult Submit(Int32 radioname)
        {

            int idduVotant=BDD.requeteSqlDepotvotant(Request.UserHostAddress.ToString());
            BDD.requeteSqlDepotDesVotes(radioname, idduVotant);
            return Redirect("/Resultat/Affichage");
        }

    }
}