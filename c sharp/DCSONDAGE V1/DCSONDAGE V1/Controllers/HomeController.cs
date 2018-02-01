using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Helpers;
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
                creationChoix.RemoveAll(ligne => (string.IsNullOrWhiteSpace(ligne)));

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
        public ActionResult Vote(Int32 id = 0)
        {
            {
                if (Methodes.IsBiggerQueMaxId(id))
                {
                    return View("Erreur", (object)"ce sondage n'existe pas");
                }
                if (id < 1)
                {
                    return View("Erreur", (object)"adresse non complete");
                }
                if ((BDD.GetTypeSondage(id) == Constantes.COOKIEMULTIPLE) || (BDD.GetTypeSondage(id) == Constantes.COOKIEUNIQUE))
                {
                    String cookiename = String.Format("Vote{0}", id);
                    if (Request.Cookies[cookiename] != null)
                    {
                        ErreurTemporaire cookiePresent = new ErreurTemporaire(id, "Vous avez deja voté!\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", cookiePresent);
                    }

                    if (BDD.testSiVoteDesactive(id))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(id, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }

                    AfficheVote Affiche = BDD.requeteSqlRecupListeChoixetId(id);
                    Affiche.ajoutNomsondage(BDD.requeteSqlRecupNomSondage(id));
                    Affiche.ajoutNbVotant(BDD.requeteSqlRecupNbVotant(id));
                    return View("Vote", Affiche);

                }
                else
                {
                    List<String> ipEnBDD = BDD.GetIp(id);
                    if (ipEnBDD.Contains(Request.UserHostAddress.ToString()))
                    {
                        ErreurTemporaire ipPresente = new ErreurTemporaire(id, "Vous avez deja voté!\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", ipPresente);
                    }

                    if (BDD.testSiVoteDesactive(id))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(id, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }

                    AfficheVote Affiche = BDD.requeteSqlRecupListeChoixetId(id);
                    Affiche.ajoutNomsondage(BDD.requeteSqlRecupNomSondage(id));
                    Affiche.ajoutNbVotant(BDD.requeteSqlRecupNbVotant(id));
                    return View("Vote", Affiche);
                }
            }
        }
        public ActionResult AffichageResultat(Int32 id = 0)
        {
            if (Methodes.IsBiggerQueMaxId(id))
            {
                return View("Erreur", (object)"ce sondage n'existe pas");
            }
            if (id < 1)
            {
                return View("Erreur", (object)"adresse non complete");
            }
            AfficheResultat affiche2 = BDD.requeteSqlRecupListeChoixetIdetNbVote(id);
            CreationCammembert cammembert = BDD.requeteSqlPourCammebert(id);

            Chart diagrammeEnSecteurs = new Chart(width: 400, height: 400, theme: ChartTheme.Yellow).AddTitle("Diagramme en secteurs")
                                                                                          .AddSeries("Default",

                                                                                            chartType: "Pie",// pas changé

                                                                                            xValue: cammembert.listeChoixVote,
                                                                                            xField: "listeChoixVote", // a changer par nomChoix

                                                                                            yValues: cammembert.listePourcentage,
                                                                                            yFields: "ListePourcentage")

                                                                                          .Save("~/Content/DiagrammeEnSecteurs.jpeg"); //  a changer par la sum des votes de chaque choix

            Chart histogramme = new Chart(width: 400, height: 400, theme: ChartTheme.Yellow).AddTitle("Histogramme")
                                                                                           .AddSeries("Default", // pas changé

                                                                                                xValue: affiche2.listeNomChoixPourModel,
                                                                                                xField: "listeNomChoixPourModel", // a changer par nomChoix

                                                                                                yValues: affiche2.pourcentageParChoixPourModel,
                                                                                                yFields: "pourcentageParChoixPourModel")

                                                                                            .Save("~/Content/Histogramme.jpeg"); //  a changer par la sum des votes de chaque choix

            return View("AffichageResultat", affiche2);
        }
        public ActionResult SubmitVote(List<Int32> choix, Int32 idSondage = 0)
        {
            if ((idSondage < 1) || (choix == null))
            {
                return View("Erreur", (object)"vous avez oublié de voter");
            }
            int typesondage;
            typesondage = BDD.GetTypeSondage(idSondage);
            if ((typesondage == Constantes.COOKIEMULTIPLE) || (typesondage == Constantes.COOKIEUNIQUE))
            {
                String cookiename = String.Format("Vote{0}", idSondage);
                if (Request.Cookies[cookiename] != null)
                {
                    ErreurTemporaire cookiePresent = new ErreurTemporaire(idSondage, "Vous avez deja voté!\nVous serez redirigé vers la page de resultat dans 3 secondes");
                    return View("ErreurTemporaire", cookiePresent);
                }
                else
                {
                    Methodes.AjoutCookie(idSondage, cookiename);

                    if (BDD.testSiVoteDesactive(idSondage))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(idSondage, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }
                    else
                    {
                        int idduVotant = BDD.requeteSqlDepotvotant(Request.UserHostAddress.ToString());
                        BDD.requeteSqlDepotDesVotesMultiple(choix, idduVotant);
                        return Redirect(string.Format("/Home/AffichageResultat/{0}", idSondage));
                    }
                }
            }
            else
            {
                List<String> ipEnBDD = BDD.GetIp(idSondage);
                if (ipEnBDD.Contains(Request.UserHostAddress.ToString()))
                {
                    ErreurTemporaire ipPresente = new ErreurTemporaire(idSondage, "Vous avez deja voté!\nVous serez redirigé vers la page de resultat dans 3 secondes");
                    return View("ErreurTemporaire", ipPresente);
                }
                else
                {
                    if (BDD.testSiVoteDesactive(idSondage))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(idSondage, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }
                    else
                    {
                        int idduVotant = BDD.requeteSqlDepotvotant(Request.UserHostAddress.ToString());
                        BDD.requeteSqlDepotDesVotesMultiple(choix, idduVotant);
                        return Redirect(string.Format("/Home/AffichageResultat/{0}", idSondage));
                    }
                }
            }
        }
        public ActionResult Suppression(String id)
        {
            Int32 idSondage = BDD.rechercheEtDesactivationSondage(id);
            if (idSondage == -1)
            {
                return View("Erreur", (object)"Mauvais lien de supression");
            }
            return View("Supression", (object)Convert.ToString(idSondage));
        }
    }
}



    
