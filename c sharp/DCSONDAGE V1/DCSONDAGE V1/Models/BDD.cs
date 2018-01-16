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
            AfficheVote Affiche = new AfficheVote(idSondage, listeIdChoix, listeChoixVote);
            Deconnection();
            return Affiche;

        }
        public static Boolean requeteSqlTypeVote(Int32 idSondage)
        {
            Boolean typeVote= false;
            Connection();
            SqlCommand requeteSql = new SqlCommand("Select typeSondage from Sondage where numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            Int32 typeVoteEnInt = (Int32)requeteSql.ExecuteScalar();
            if (typeVoteEnInt==1)
            {
                typeVote = true;     
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

    }
}