using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DCSONDAGE_V1.Models
{
    public class Vote
    {
        public Int32 NbVote { get; set; }
        public Int32 NbVotant { get; set; }
        public Int32 numChoix { get; set; }
        public Int32 numVotant { get; set; }
        public Vote(int nbVote, int nbVotant)
        {
            NbVote = NbVote;
            NbVotant = nbVotant;
        }
    }
}