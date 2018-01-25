using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Helpers;
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
            if (BDD.testSiVoteDesactive(id))
            {
                return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
            }
            else
            {
                AfficheVote Affiche = BDD.requeteSqlRecupListeChoixetId(id);
                Affiche.ajoutNomsondage(BDD.requeteSqlRecupNomSondage(id));
                Affiche.ajoutNbVotant(BDD.requeteSqlRecupNbVotant(id));
                return View("VoteU", Affiche);
            }
        }
        public ActionResult VoteM(Int32 id)
        {
            if (BDD.testSiVoteDesactive(id))
            {
                return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
            }
            else
            {
                AfficheVote Affiche = BDD.requeteSqlRecupListeChoixetId(id);
                Affiche.ajoutNomsondage(BDD.requeteSqlRecupNomSondage(id));
                Affiche.ajoutNbVotant(BDD.requeteSqlRecupNbVotant(id));
                return View("VoteM", Affiche);
            }
        }
        public ActionResult Submit(Int32 radioname, Int32 numSondage)
        {
            if (BDD.testSiVoteDesactive(numSondage))
            {
                return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
            }
            else
            {
                int idduVotant = BDD.requeteSqlDepotvotant(Request.UserHostAddress.ToString());
                BDD.requeteSqlDepotDesVotes(radioname, idduVotant);
                return Redirect(string.Format("/Resultat/AffichageResultat/{0}", numSondage));
            }
        }
        public ActionResult AffichageResultat(Int32 id)

        {

            AfficheResultat affiche2 = BDD.requeteSqlRecupListeChoixetIdetNbVote(id);
            CreationCammembert cammembert = BDD.requeteSqlPourCammebert(id);

            Chart graphique = new Chart(width: 400, height: 400, theme: ChartTheme.Yellow)

             .AddTitle("Diagramme en secteurs")

             .AddSeries("Default", chartType: "Pie",// pas changé

            xValue: cammembert.listeChoixVote  , xField: "listeChoixVote", // a changer par nomChoix

            yValues: cammembert.listePourcentage, yFields: "ListePourcentage").Save("~/Content/dessin.jpeg"); //  a changer par la sum des votes de chaque choix

            Chart graphique2 = new Chart(width: 400, height: 400, theme: ChartTheme.Yellow)

             .AddTitle("Histogramme")

             .AddSeries("Default", // pas changé

            xValue: affiche2.listeNomChoixPourModel, xField: "listeNomChoixPourModel", // a changer par nomChoix

            yValues: affiche2.pourcentageParChoixPourModel, yFields: "pourcentageParChoixPourModel").Save("~/Content/dessin2.jpeg"); //  a changer par la sum des votes de chaque choix

            return View("AffichageResultat",affiche2);

        }

        
        public ActionResult Submit2(Int32? choix0, Int32? choix1, Int32? choix2, Int32? choix3, Int32? choix4, Int32 idSondage)
        {
            if (BDD.testSiVoteDesactive(idSondage))
            {
                return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
            }
            else
            {
                List<Int32> ListeDesChoixValidesParLeVotant = new List<Int32>();
                if (choix0 != null)
                {
                    ListeDesChoixValidesParLeVotant.Add((Int32)choix0);
                }
                if (choix1 != null)
                {
                    ListeDesChoixValidesParLeVotant.Add((Int32)choix1);
                }
                if (choix2 != null)
                {
                    ListeDesChoixValidesParLeVotant.Add((Int32)choix2);
                }
                if (choix3 != null)
                {
                    ListeDesChoixValidesParLeVotant.Add((Int32)choix3);
                }
                if (choix4 != null)
                {
                    ListeDesChoixValidesParLeVotant.Add((Int32)choix4);
                }

                int idduVotant = BDD.requeteSqlDepotvotant(Request.UserHostAddress.ToString());
                BDD.requeteSqlDepotDesVotesMultiple(ListeDesChoixValidesParLeVotant, idduVotant);
                return Redirect(string.Format("/Resultat/AffichageResultat/{0}", idSondage));
            }
        }
        public ActionResult Suppression(String id)
        {
            
            int idSondage=BDD.rechercheEtDesactivationSondage(id);

            if (idSondage==-1)
            {
                return View("Erreur",(object)"Mauvais lien de supression");
            }

           
            return View("Supression");
        }

    }
}