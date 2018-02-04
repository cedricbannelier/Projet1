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
        public ActionResult VoteU(Int32 id=0)
        {
            if (Methodes.IsBiggerQueMaxId(id))
            {
                return View("Erreur", (object)"ce sondage n'existe pas");
            }
            if (id < 1)
            {
                return View("Erreur", (object)"adresse non complete");
            }
            if (BDD.GetTypeSondage(id) != Constantes.IPUNIQUE)
            {
                String cookiename = String.Format("Vote{0}", id);

                if (Request.Cookies[cookiename] != null)
                {
                    return Redirect(string.Format("/Resultat/AffichageResultat/{0}", id));
                }
                else
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
            }
            else
            {
                if (BDD.testSiVoteDesactive(id))
                {
                    return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
                }
                else
                {
                    List<String> ipEnBDD = BDD.GetIp(id);
                    if(ipEnBDD.Contains(Request.UserHostAddress.ToString()))
                    {
                        return Redirect(string.Format("/Resultat/AffichageResultat/{0}", id));
                    }
                    else
                    {
                        AfficheVote Affiche = BDD.requeteSqlRecupListeChoixetId(id);
                        Affiche.ajoutNomsondage(BDD.requeteSqlRecupNomSondage(id));
                        Affiche.ajoutNbVotant(BDD.requeteSqlRecupNbVotant(id));
                        return View("VoteU", Affiche);
                    }

                }
            }
        }

        public ActionResult VoteM(Int32 id=0)
        {
            if (Methodes.IsBiggerQueMaxId(id))
            {
                return View("Erreur", (object)"ce sondage n'existe pas");
            }
            if (id < 1)
            {
                return View("Erreur", (object)"adresse non complete");
            }
            if (BDD.GetTypeSondage(id) != Constantes.IPMULTIPLE)
            {
                String cookiename = String.Format("Vote{0}", id);
                if (Request.Cookies[cookiename] != null)
                {
                    return Redirect(string.Format("/Resultat/AffichageResultat/{0}", id));
                }
                else
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
            }
            else
            {
                List<String> ipEnBDD = BDD.GetIp(id);
                if (ipEnBDD.Contains(Request.UserHostAddress.ToString()))
                {
                    return Redirect(string.Format("/Resultat/AffichageResultat/{0}", id));
                }
                else
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
            }
        }


        public ActionResult Submit(Int32 radioname = 0, Int32 numSondage = 0)
        {

            if ((numSondage < 1) || (radioname < 1))
            {
                return View("Erreur", (object)"vous avez oublié de voter");
            }
            int typesondage;
            typesondage = BDD.GetTypeSondage(numSondage);
            if (typesondage != Constantes.IPUNIQUE)
            {
                String cookiename = String.Format("Vote{0}", numSondage);

                if (Request.Cookies[cookiename] != null)
                {
                    return Redirect(string.Format("/Resultat/AffichageResultat/{0}", numSondage));
                }
                else
                {
                    Methodes.AjoutCookie(numSondage, cookiename);

                    if (BDD.testSiVoteDesactive(numSondage))
                    {
                        return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
                    }
                    else
                    {
                        Methodes.DepotVoteEtVotantPourChoixUnique(radioname);
                        return Redirect(string.Format("/Resultat/AffichageResultat/{0}", numSondage));
                    }
                }
            }
            else
            {
                List<String> ipEnBDD = BDD.GetIp(numSondage);
                bool test= ipEnBDD.Contains(Request.UserHostAddress.ToString());
                if (test)
                {
                    return Redirect(string.Format("/Resultat/AffichageResultat/{0}", numSondage));
                }
                else
                {
                    if (BDD.testSiVoteDesactive(numSondage))
                    {
                        return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
                    }
                    else
                    {
                        Methodes.DepotVoteEtVotantPourChoixUnique(radioname);
                        return Redirect(string.Format("/Resultat/AffichageResultat/{0}", numSondage));
                    }
                }
            }
        }
        public ActionResult AffichageResultat(Int32 id=0)
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

        public ActionResult Submit2(List<Int32> choix, Int32 idSondage=0)
        {
            if ((idSondage < 1) || (choix == null))
            {
                return View("Erreur", (object)"vous avez oublié de voter");
            }
            int typesondage;
            typesondage = BDD.GetTypeSondage(idSondage);
            if (typesondage != Constantes.IPMULTIPLE)
            {
                String cookiename = String.Format("Vote{0}", idSondage);
                if (Request.Cookies[cookiename] != null)
                {
                    return Redirect(string.Format("/Resultat/AffichageResultat/{0}", idSondage));
                }
                else
                {
                    Methodes.AjoutCookie(idSondage, cookiename);

                    if (BDD.testSiVoteDesactive(idSondage))
                    {
                        return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
                    }
                    else
                    {
                        int idduVotant = BDD.requeteSqlDepotvotant(Request.UserHostAddress.ToString());
                        BDD.requeteSqlDepotDesVotesMultiple(choix, idduVotant);
                        return Redirect(string.Format("/Resultat/AffichageResultat/{0}", idSondage));
                    }
                }
            }
            else
            {
                List<String> ipEnBDD = BDD.GetIp(idSondage);
                if (ipEnBDD.Contains(Request.UserHostAddress.ToString()))
                {
                    return Redirect(string.Format("/Resultat/AffichageResultat/{0}", idSondage));
                }
                else
                {
                    if (BDD.testSiVoteDesactive(idSondage))
                    {
                        return View("Erreur", (Object)"Impossible de prendre votre vote en compte le sondage a été desactivé !");
                    }
                    else
                    {
                        int idduVotant = BDD.requeteSqlDepotvotant(Request.UserHostAddress.ToString());
                        BDD.requeteSqlDepotDesVotesMultiple(choix, idduVotant);
                        return Redirect(string.Format("/Resultat/AffichageResultat/{0}", idSondage));
                    }
                }
            }
        }
        public ActionResult Suppression(String id)
        {
            int idSondage = BDD.rechercheEtDesactivationSondage(id);

            if (idSondage == -1)
            {
                return View("Erreur", (object)"Mauvais lien de supression");
            }
            return View("Supression");
        }
    }
}