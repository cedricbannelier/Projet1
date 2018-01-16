using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class Choix
    {
        public String nomChoix { get; set; }
        public Int32 numChoix { get; set; }
        public Int32 numSondage { get; set; }
        public Choix (string nomduChoix)
        {
            nomChoix = nomduChoix;
        }
    }
}