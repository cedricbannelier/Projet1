using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using DCSONDAGE_V1.Models;

namespace DCSONDAGE_V1.Models
{
    public class BDD
    {
        public static string SQlConnectString = @"server=.\SQLEXPRESS;Database=projet;Trusted_Connection=Yes";

        public static SqlConnection DCConnect = new SqlConnection(SQlConnectString);
        public static void Connection()
        {
            DCConnect.Open();
        }

        public static void Deconnection()
        {
            DCConnect.Close();
        }

        //public static Int32 LectureRSBdd()
        //{
        //    Connection();

        //    SqlCommand RS = new SqlCommand("select count(*) from sondage",DCConnect);
        //    int nbcount = (int)RS.ExecuteScalar();
        //    Deconnection();
        //    return nbcount;

        //}
        public static Int32 RequeteAjoutSqlSondage(String titreSondage, Int32 RadioB)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("Insert into sondage (questionSondage,typeSondage) Values(@qSondage,@tSondage); Select numSondage from sondage where numsondage=SCOPE_IDENTITY()", DCConnect);
            var qSondageParameter = new SqlParameter("@qSondage", titreSondage);
            var tSondageParameter= new SqlParameter("@tSondage", RadioB);
            requeteSql.Parameters.Add(qSondageParameter);
            requeteSql.Parameters.Add(tSondageParameter);
            Int32 idSondage = Convert.ToInt32(requeteSql.ExecuteScalar());
            Deconnection();
            return idSondage;
            
        }
        public static void requetteAjoutSqlChoix(Int32 idSondage, string Choix1, string Choix2, string Choix3, string Choix4, string Choix5)
        {
            Connection();
            List<string> listechoix = new List<string>() ;
            if (Choix1 !="")
            {
                listechoix.Add(Choix1);
            }
            if (Choix2 != "")
            {
                listechoix.Add(Choix2);
            }
            if (Choix3 != "")
            {
                listechoix.Add(Choix3);
            }
            if (Choix4 != "")
            {
                listechoix.Add(Choix4);
            }
            if (Choix5 != "")
            {
                listechoix.Add(Choix5);
            }
            foreach (var Choix in listechoix)
            {
                SqlCommand requeteSql = new SqlCommand("Insert into Choix (nomChoix,numSondage) Values(@choix,@idSondage);", DCConnect);
                var ChoixParameter = new SqlParameter("@choix", Choix);
                var idSondageParameter = new SqlParameter("@idsondage", idSondage);
                requeteSql.Parameters.Add(ChoixParameter);
                requeteSql.Parameters.Add(idSondageParameter);
                requeteSql.ExecuteNonQuery();
            }
            Deconnection();
        }
        public static void requetteAjoutSqlLienSuppr(Int32 idSondage, Guid guidSuppression)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("Insert into Lien (adresseLien,numSondage) Values(@guidSuppression,@idsondage);", DCConnect);
            var LienParameter = new SqlParameter("@guidSuppression", guidSuppression);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(LienParameter);
            requeteSql.Parameters.Add(idsondageParameter);
            requeteSql.ExecuteNonQuery();
            Deconnection();
        }
        public static AfficheVote requeteSqlRecupListeChoixetId (Int32 idSondage)
        {
            List<String> listeChoixVote = new List<String>();
            List<int> listeIdChoix = new List<int>();
            Int32 idSondage2 = idSondage;
            Connection();
            SqlCommand requeteSql = new SqlCommand("Select nomChoix,numChoix from choix where numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                listeChoixVote.Add((string)dr["nomChoix"]);
                listeIdChoix.Add((Int32)dr["numChoix"]);
            }
            Deconnection();
            Connection();
            SqlCommand requeteSql2 = new SqlCommand("Select typeSondage from Sondage where numSondage=@idSondage2;", DCConnect);
            var idsondageParameter2 = new SqlParameter("@idSondage2", idSondage2);
            requeteSql2.Parameters.Add(idsondageParameter2);
            Int32 typeSondage = Convert.ToInt32(requeteSql2.ExecuteScalar());
            Deconnection();
            AfficheVote Affiche = new AfficheVote(idSondage, listeIdChoix, listeChoixVote, typeSondage);
            return Affiche;

        }
        public static Int32 requeteSqlTypeVote(Int32 idSondage)
        {
            Int32 typeVote= 0;
            Connection();
            SqlCommand requeteSql = new SqlCommand("Select typeSondage from Sondage where numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            Int32 typeVoteEnInt = (Int32)requeteSql.ExecuteScalar();
            if (typeVoteEnInt%10==1)
            {
                typeVote = 1;     
            }
            Deconnection();
            return typeVote;
            
        }
        public static String requeteSqlRecupNomSondage(Int32 idSondage)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("Select questionSondage from Sondage where numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            string nomDuSondage = (String)requeteSql.ExecuteScalar();
            Deconnection();
            return nomDuSondage;
        }
        public static Int32 requeteSqlDepotvotant(string adresseIp)
        {
            Connection();
            if (adresseIp==null)
            {
                SqlCommand requeteSql = new SqlCommand("Insert into Votant (adresseIp) Values(''); Select numVotant from Votant where numVotant=SCOPE_IDENTITY()", DCConnect);
                Int32 idSondage = Convert.ToInt32(requeteSql.ExecuteScalar());
                Deconnection();
                return idSondage;
            }
            else
            {
                SqlCommand requeteSql = new SqlCommand("Insert into Votant (adresseIp) Values(@adresseIp); Select numVotant from Votant where numVotant=SCOPE_IDENTITY()", DCConnect);
                var adresseIpParameter = new SqlParameter("@adresseIp", adresseIp);
                requeteSql.Parameters.Add(adresseIpParameter);
                Int32 idSondage = Convert.ToInt32(requeteSql.ExecuteScalar());
                Deconnection();
                return idSondage;
            }

            

        }
        public static void requeteSqlDepotDesVotes(int idChoix,int idduVotant )
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("Insert into vote (numChoix,numVotant,nbVote) Values(@numChoix,@numVotant,1);", DCConnect);
            var numChoixParameter = new SqlParameter("@numChoix", idChoix);
            var numVotantParameter = new SqlParameter("@numVotant", idduVotant);
            requeteSql.Parameters.Add(numChoixParameter);
            requeteSql.Parameters.Add(numVotantParameter);
            requeteSql.ExecuteNonQuery();
            Deconnection();
        }

        public static AfficheResultat requeteSqlRecupListeChoixetIdetNbVote(Int32 idSondage)
        {

            
            List<String> listeChoixVote = new List<String>();
            List<Int32> listeIdChoix = new List<Int32>();
            List<Int32> listeIdChoix2 = new List<Int32>();
            List <Int32> ListeNbVote = new List<Int32>();
            List <Double> ListePourcentage = new List<Double>();
            List<Double> ListePourcentage2 = new List<Double>();
            Int32 idSondage2 = idSondage;
            Int32 idSondage3 = idSondage;

            Connection();
            SqlCommand requeteSql2 = new SqlCommand(//"Select C.nomChoix,C.numChoix,sum(nbVote) as sommeVote, 100*count(nomChoix)/(select  count(nomChoix) from Choix c, Vote v where numSondage=@idSondage2 and v.numChoix=c.numChoix ) as pourcentage from Vote V, Sondage S, Choix C where S.numSondage=@idSondage2 and C.numSondage=S.numSondage and C.numChoix=V.numChoix group by C.nomChoix,C.numChoix ;", DCConnect);
            "SELECT c.numChoix,c.nomChoix,Sum(nbVote) as sommeVote FROM choix c LEFT JOIN vote ON c.numChoix = vote.numChoix where numSondage = @idsondage2 group by c.numChoix,c.nomChoix order by sommeVote desc; ", DCConnect);

              var idsondageParameter2 = new SqlParameter("@idsondage2", idSondage2);
            requeteSql2.Parameters.Add(idsondageParameter2);
            SqlDataReader dr2 = requeteSql2.ExecuteReader();
            while (dr2.Read())
            {
                listeChoixVote.Add((string)dr2["nomChoix"]);
                listeIdChoix2.Add((Int32)dr2["numChoix"]); 
               // ListePourcentage.Add((Int32)dr2["pourcentage"]); 
               if (dr2["sommeVote"]==DBNull.Value)
                {
                    ListeNbVote.Add(0);
                    ListePourcentage.Add(0);
                }
               else
                {
                    ListeNbVote.Add(Convert.ToInt32(dr2["sommeVote"]));
                    ListePourcentage.Add(Convert.ToInt32(dr2["sommeVote"]));
                }
                
            }
            dr2.Close();
            int total=0;
            if (ListePourcentage.Count == 0)
            {
                total = 1;
            }
            else
            {
                foreach (int ligne in ListePourcentage)
                {
                    total += ligne;
                }

                for (int i = 0; i < ListePourcentage.Count; i++)
                {
                    if (total==0)
                    {
                        total = 1;
                    }
                    ListePourcentage2.Add(100*ListePourcentage.ElementAt(i) / total);
                }
               
                
            }
           
            SqlCommand requeteSql3 = new SqlCommand("Select questionSondage from sondage where numSondage=@idSondage3  ;", DCConnect);
            var idsondageParameter3 = new SqlParameter("@idsondage3", idSondage3);
            requeteSql3.Parameters.Add(idsondageParameter3);
            string nomDuSondage = (String)requeteSql3.ExecuteScalar();
            Deconnection();
            AfficheResultat Affiche = new AfficheResultat(idSondage, nomDuSondage, listeIdChoix, listeChoixVote, ListeNbVote, ListePourcentage2);
            return Affiche;
        }
        public static void requeteSqlDepotDesVotesMultiple(List<Int32> listeDesVotes,Int32 idDuVotant)
        {

            Connection();

            foreach (var vote in listeDesVotes)
            {
                SqlCommand requeteSql = new SqlCommand("Insert into vote (numChoix,numVotant,nbVote) Values(@numChoix,@numVotant,1);", DCConnect);
                var voteParameter = new SqlParameter("@numChoix", vote);
                var idDuVotantParameter = new SqlParameter("@numVotant", idDuVotant);
                requeteSql.Parameters.Add(voteParameter);
                requeteSql.Parameters.Add(idDuVotantParameter);
                requeteSql.ExecuteNonQuery();
            }
            
            Deconnection();
        }
        public static Int32 requeteSqlRecupNbVotant(Int32 idSondage)
        {
            
            Int32 type = requeteSqlTypeVote(idSondage);
            Connection();
            Int32 nbVotant=0;
            if (type%10 ==1)
            {
                SqlCommand requeteSql = new SqlCommand(" select count(nbVote) from Vote v, choix c where c.numChoix=v.numChoix and c.numSondage= @idsondage;", DCConnect);
                var idsondageParameter = new SqlParameter("@idsondage", idSondage);
                requeteSql.Parameters.Add(idsondageParameter);
                nbVotant = (Int32)requeteSql.ExecuteScalar();
            }
             else
            {
                SqlCommand requeteSql = new SqlCommand("select count(distinct numVotant) from Vote v, choix c where c.numChoix=v.numChoix and c.numSondage=@idsondage; ", DCConnect);
                var idsondageParameter = new SqlParameter("@idsondage", idSondage);
                requeteSql.Parameters.Add(idsondageParameter);
                nbVotant = (Int32)requeteSql.ExecuteScalar();
            }

            Deconnection();
            return nbVotant;


        }
        public static Int32 rechercheEtDesactivationSondage(String GuidSuppr)
        {
            List<String> listeGuid = new List<String>();
            List<Int32> listeIdSondage = new List<Int32>();
            Int32 idSondage=0;
            Int32 i = 0;
            Connection();
            SqlCommand requeteSql = new SqlCommand("Select adresseLien, s.numSondage from sondage s,lien l where s.numSondage=l.numSondage ;", DCConnect);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                listeGuid.Add((String)dr["adresseLien"]);
                listeIdSondage.Add((Int32)dr["numSondage"]);
            }

            foreach (var ligne in listeGuid)
            {
                if (ligne.ToLower() == GuidSuppr)
                {
                    idSondage = listeIdSondage.ElementAt(i);
                }
                else
                {
                    idSondage = -1;
                }
                i++;
            }
            Deconnection();
            RequeteSqlUpdateType(idSondage);
            return idSondage;
        }
        public static void RequeteSqlUpdateType(Int32 idSondage)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("update Sondage set typeSondage=103 where numSondage=@idSondage;", DCConnect);
            var idSondageParameter = new SqlParameter("@idSondage", idSondage);
            requeteSql.Parameters.Add(idSondageParameter);
            requeteSql.ExecuteNonQuery();
            Deconnection();

        }
        public static Boolean testSiVoteDesactive (Int32 idSondage)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("Select typeSondage from Sondage where numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            Int32 typeVoteEnInt = (Int32)requeteSql.ExecuteScalar();
            Deconnection();
            if (typeVoteEnInt==103)
            {
                return true;
            }
            else
            {
                return false;
            }


        }


    }
}