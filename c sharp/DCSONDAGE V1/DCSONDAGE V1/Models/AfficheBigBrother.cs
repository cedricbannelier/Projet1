using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class AfficheBigBrother
    {

        public List<String> listeDesVotant { get; set; }
        public List<String> listeDesNomChoix { get; set; }

        public AfficheBigBrother(List<String> listeIP, List<String> listeNomChoix)
         {
            List<String> listeVotant = new List<string>();
            foreach (var ligne in listeIP)
            {
                switch (ligne)
                {
                    case "172.19.240.1":
                        listeVotant.Add("Damien");
                        break;
                    case "172.19.240.2":
                        listeVotant.Add("Amine");
                        break;
                    case "172.19.240.3":
                        listeVotant.Add("Julien Mec !");
                        break;
                    case "172.19.240.4":
                        listeVotant.Add("Phuong");
                        break;
                    case "172.19.240.5":
                        listeVotant.Add("Dom, qui vote de mon poste???");
                        break;
                    case "172.19.240.6":
                        listeVotant.Add("JR");
                        break;
                    case "172.19.240.7":
                        listeVotant.Add("Joe-Nathan");
                        break;
                    case "172.19.240.8":
                        listeVotant.Add("Mehdi");
                        break;
                    case "172.19.240.9":
                        listeVotant.Add("Timothé");
                        break;
                    case "172.19.240.10":
                        listeVotant.Add("Cedric, qui vote de mon poste???");
                        break;
                    case "172.19.240.11":
                        listeVotant.Add("Marc");
                        break;
                    case "172.19.240.12":
                        listeVotant.Add("Emilien");
                        break;
                    case "172.19.240.13":
                        listeVotant.Add("Loic - Guldi");
                        break;
                    case "172.19.240.14":
                        listeVotant.Add("Simon le rageux");
                        break;
                    case "172.19.240.15":
                        listeVotant.Add("Dennis");
                        break;
                    case "172.19.240.16":
                        listeVotant.Add("Mourad");
                        break;
                    default:
                        listeVotant.Add("Je ne sais pas suivre une consigne simple");
                        break;
                }
                listeDesVotant = listeVotant;
                listeDesNomChoix = listeNomChoix;
            }

        }
         
    }
}