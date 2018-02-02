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
        /// <summary>
        /// creer un cokkie et l'envoi au client
        /// cette methodes est utilisé dans HomeController/SubmitVote
        /// </summary>
        /// <param name="id"></param>
        /// <param name="cookiename"></param>
        public static void AjoutCookie(Int32 id, string cookiename)
        {
            HttpCookie UnCookie = new HttpCookie(cookiename);
            UnCookie.Value = "A deja voté";
            UnCookie.Expires = DateTime.Now.AddDays(1);
            HttpContext.Current.Response.Cookies.Add(UnCookie);
        }
    }
}