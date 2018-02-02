using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Helpers;
using System.Text.RegularExpressions;
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
        /// <summary>
        /// en cas d'oublie renvoi vers des pages d'erreurs
        /// enregistre les parametres en bases de donnes
        /// et redirige vers la page /Home/Liens
        /// </summary>
        /// <param name="titreSondage"></param>
        /// <param name="creationChoix"></param>
        /// <param name="restrictionSondage"></param>
        /// <param name="RadioB"></param>
        /// <returns></returns>
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
                BDD.RequetteAjoutSqlChoix(idsondage, creationChoix);
                Lien Liencourrant = new Lien(idsondage, RadioB+ restrictionSondage);
                BDD.RequetteAjoutSqlLienSuppr(idsondage, Liencourrant.Guidsuppression);

                return Redirect(string.Format("/Home/Liens/{0}", Liencourrant.Guidsuppression.ToString()));
            }
        }
        /// <summary>
        /// affiche la vue des liens en utilisant une instance anonyme de Lien
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
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
        /// <summary>
        /// test si le parametre d'entrée est correct
        /// Empeche de voter si il y a un cookie qui porte le nom: Vote+idSondage et que le type du sondages est de type cookie
        /// Empeche de voter si il y a la même IP en BDD et que le type du sondages est de type IP
        /// Cree une instance d'AfficheVote qui est envoyer avec la vue vote
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
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

                    if (BDD.TestSiVoteDesactive(id))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(id, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }

                    AfficheVote Affiche = BDD.GetListeChoixetId(id);
                    Affiche.ajoutNomsondage(BDD.GetNomSondage(id));
                    Affiche.ajoutNbVotant(BDD.RequeteSqlRecupNbVotant(id));
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

                    if (BDD.TestSiVoteDesactive(id))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(id, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }

                    AfficheVote Affiche = BDD.GetListeChoixetId(id);
                    Affiche.ajoutNomsondage(BDD.GetNomSondage(id));
                    Affiche.ajoutNbVotant(BDD.RequeteSqlRecupNbVotant(id));
                    return View("Vote", Affiche);
                }
            }
        }
        /// <summary>
        /// test si le parametre d'entrée est correct
        /// creer une instance de classe AfficheResultat pour avec les infomartions necessaire a la creation d'un histogramme grace a la classe chart puis le sauvegarde dans ~/Content/Histogramme.jpeg
        /// creer une instance de classe CreationCammembert pour avec les infomartions necessaire a la creation d'un diagramme en secteurs grace a la classe chart puis le sauvegarde dans ~/Content/DiagrammeEnSecteurs.jpeg
        /// Afin d'importer l'image dans la vue
        /// et affiche la vue AffichageResultat
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
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
            AfficheResultat affiche2 = BDD.RequeteSqlRecupListeChoixetIdetNbVote(id);
            CreationCammembert cammembert = BDD.RequeteSqlPourCammebert(id);

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
        /// <summary>
        /// test si les parametres d'entrée est correct
        /// ne sauvegarde pas en bdd les votes si il y a un cookie qui porte le nom: Vote+idSondage et que le type du sondages est de type cookie
        /// Si il n'y a pas de cookie il est alors cree afin d'empecher de revoter et envoyer au client
        /// Ne sauvegarde pas en bdd les votes si il y a la même IP en BDD et que le type du sondages est de type IP
        /// Si il n'y a pasl'ip n'est pas presente en bdd pour se sondage elle est stocké
        /// redirige vers Afficheresultat
        /// </summary>
        /// <param name="choix"></param>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public ActionResult SubmitVote(List<Int32> choix, Int32 idSondage = 0)
        {
            if ((idSondage < 1) || (choix == null))
            {
                ErreurTemporaire oublieVote = new ErreurTemporaire(idSondage, "Vous n'avez pas voté!\nVous serez redirigé vers la page de vote dans 3 secondes", "Vote");
                return View("ErreurTemporaire", oublieVote);
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

                    if (BDD.TestSiVoteDesactive(idSondage))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(idSondage, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }
                    else
                    {
                        int idduVotant = BDD.RequeteSqlDepotvotant(Request.UserHostAddress.ToString());
                        BDD.RequeteSqlDepotDesVotesMultiple(choix, idduVotant);
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
                    if (BDD.TestSiVoteDesactive(idSondage))
                    {
                        ErreurTemporaire voteDesactive = new ErreurTemporaire(idSondage, "Le sondage a été desactivé\nVous serez redirigé vers la page de resultat dans 3 secondes");
                        return View("ErreurTemporaire", voteDesactive);
                    }
                    else
                    {
                        int idduVotant = BDD.RequeteSqlDepotvotant(Request.UserHostAddress.ToString());
                        BDD.RequeteSqlDepotDesVotesMultiple(choix, idduVotant);
                        return Redirect(string.Format("/Home/AffichageResultat/{0}", idSondage));
                    }
                }
            }
        }
        /// <summary>
        /// test si le parametre d'entrée est correct
        /// desactive le sondage le cas echeant
        /// renvoi la vue supression
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Suppression(String id)
        {
            Int32 idSondage = BDD.RechercheEtDesactivationSondage(id);
            if (idSondage == -1)
            {
                return View("Erreur", (object)"Mauvais lien de supression");
            }
            return View("Supression", (object)Convert.ToString(idSondage));
        }
        /// <summary>
        /// renvoi vers la vue erreur car la fonctionnalité n'est pas implementé
        /// </summary>
        /// <returns></returns>
        public ActionResult Rechercher()
        {
            return View("Erreur", (object)"En cours de devellopement !");
        }

        //public ActionResult Rechercher(string entreeUtilisateur)
        //{
        //    Regex monDecoupeur = new Regex(@"\s+");
        //    string[] tableauDeRecherche = monDecoupeur.Split(entreeUtilisateur);
        //    List<Int32> liste = new List<Int32>();
        //    foreach (var mot in tableauDeRecherche)   
        //    {
        //        liste=BDD.GetSondageParNom(mot, liste);
        //    }
        //    var frequence = liste.GroupBy(x => x).ToDictionary(x => x.Key, x => x.Count());
        //    var top3 = frequence.OrderByDescending(pair => pair.Value).Take(3);
        //    return View("Recherche", top3);
        //}
    }
}



    
