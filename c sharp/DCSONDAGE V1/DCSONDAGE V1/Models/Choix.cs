using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class Choix
    {
        public String NomChoix { get; set; }

        public Choix (string nomChoix)
        {
            NomChoix = nomChoix;
        }
    }
}