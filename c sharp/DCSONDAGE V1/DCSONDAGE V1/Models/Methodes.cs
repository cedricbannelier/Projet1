using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace DCSONDAGE_V1.Models
{
    public class Methodes
    {
        public static Boolean IsBiggerQueMaxId(Int32 id)
        {
            if (BDD.GetMaxId() < id)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public static void AjoutCookie(Int32 id, string cookiename)
        {
            HttpCookie UnCookie = new HttpCookie(cookiename);
            UnCookie.Value = "A deja voté";
            UnCookie.Expires = DateTime.Now.AddDays(1);
            HttpContext.Current.Response.Cookies.Add(UnCookie);
        }
        public static void DepotVoteEtVotantPourChoixUnique(Int32 radioname)
        {
            int idduVotant = BDD.requeteSqlDepotvotant(HttpContext.Current.Request.UserHostName.ToString());
            BDD.requeteSqlDepotDesVotes(radioname, idduVotant);

        }

    }

}