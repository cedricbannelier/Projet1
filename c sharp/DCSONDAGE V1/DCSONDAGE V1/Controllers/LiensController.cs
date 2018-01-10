using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DCSONDAGE_V1.Controllers
{
    public class LiensController : Controller
    {
        // GET: Liens
        public ActionResult Index()
        {
            return View("Liens");
        }
    }
}