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
       // public static string SQlConnectString = @"server=.\SQLEXPRESS;Database=projet;Trusted_Connection=Yes"; 
        public static string SQlConnectString = @"server=172.19.240.123;Database=DCSondage;user id=sa;password=pf68*CCI";

        public static SqlConnection DCConnect = new SqlConnection(SQlConnectString);
        public static void Connection()
        {
            DCConnect.Open();
        }
        public static void Deconnection()
        {
            DCConnect.Close();
        }
       
        public static Int32 RequeteAjoutSqlSondage(String titreSondage, Int32 RadioB)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("INSERT INTO sondage (questionSondage,typeSondage) VALUES(@qSondage,@tSondage); SELECT numSondage FROM sondage WHERE numsondage=SCOPE_IDENTITY()", DCConnect);
            var qSondageParameter = new SqlParameter("@qSondage", titreSondage);
            var tSondageParameter = new SqlParameter("@tSondage", RadioB);
            requeteSql.Parameters.Add(qSondageParameter);
            requeteSql.Parameters.Add(tSondageParameter);
            Int32 idSondage = Convert.ToInt32(requeteSql.ExecuteScalar());
            Deconnection();
            return idSondage;
        }
        public static void requetteAjoutSqlChoix(Int32 idSondage, List<String> listechoix)
        {
            Connection();

            foreach (var Choix in listechoix)
            {
                SqlCommand requeteSql = new SqlCommand("INSERT INTO Choix (nomChoix,numSondage) VALUES(@choix,@idSondage);", DCConnect);
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
            SqlCommand requeteSql = new SqlCommand("INSERT INTO Lien (adresseLien,numSondage) VALUES(@guidSuppression,@idsondage);", DCConnect);
            var LienParameter = new SqlParameter("@guidSuppression", guidSuppression);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(LienParameter);
            requeteSql.Parameters.Add(idsondageParameter);
            requeteSql.ExecuteNonQuery();
            Deconnection();
        }
        public static AfficheVote requeteSqlRecupListeChoixetId(Int32 idSondage)
        {
            List<String> listeChoixVote = new List<String>();
            List<int> listeIdChoix = new List<int>();
            Int32 idSondage2 = idSondage;
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT nomChoix,numChoix FROM choix WHERE numSondage=@idSondage;", DCConnect);
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
            SqlCommand requeteSql2 = new SqlCommand("SELECT typeSondage FROM Sondage WHERE numSondage=@idSondage2;", DCConnect);
            var idsondageParameter2 = new SqlParameter("@idSondage2", idSondage2);
            requeteSql2.Parameters.Add(idsondageParameter2);
            Int32 typeSondage = Convert.ToInt32(requeteSql2.ExecuteScalar());
            Deconnection();
            AfficheVote Affiche = new AfficheVote(idSondage, listeIdChoix, listeChoixVote, typeSondage);
            return Affiche;
        }
        public static Int32 requeteSqlTypeVote(Int32 idSondage)
        {
            Int32 typeVote = 0;
            Int32 typeVoteEnInt = GetTypeSondage(idSondage);
            if (typeVoteEnInt % 10 == 1)
            {
                typeVote = 1;
            }
            Deconnection();
            return typeVote;
        }
        public static String requeteSqlRecupNomSondage(Int32 idSondage)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT questionSondage FROM Sondage WHERE numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            string nomDuSondage = (String)requeteSql.ExecuteScalar();
            Deconnection();
            return nomDuSondage;
        }
        public static Int32 requeteSqlDepotvotant(string adresseIp)
        {
            Connection();
            if (adresseIp == null)
            {
                SqlCommand requeteSql = new SqlCommand("INSERT INTO Votant (adresseIp) VALUES(''); SELECT numVotant FROM Votant WHERE numVotant=SCOPE_IDENTITY()", DCConnect);
                Int32 idSondage = Convert.ToInt32(requeteSql.ExecuteScalar());
                Deconnection();
                return idSondage;
            }
            else
            {
                SqlCommand requeteSql = new SqlCommand("INSERT INTO Votant (adresseIp) VALUES(@adresseIp); SELECT numVotant FROM Votant WHERE numVotant=SCOPE_IDENTITY()", DCConnect);
                var adresseIpParameter = new SqlParameter("@adresseIp", adresseIp);
                requeteSql.Parameters.Add(adresseIpParameter);
                Int32 idSondage = Convert.ToInt32(requeteSql.ExecuteScalar());
                Deconnection();
                return idSondage;
            }
        }
        public static void requeteSqlDepotDesVotes(int idChoix, int idduVotant)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("INSERT INTO vote (numChoix,numVotant,nbVote) VALUES(@numChoix,@numVotant,1);", DCConnect);
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
            List<Int32> ListeNbVote = new List<Int32>();
            List<Double> ListePourcentage = new List<Double>();
            List<Double> ListePourcentage2 = new List<Double>();
            Int32 idSondage2 = idSondage;
            Int32 idSondage3 = idSondage;
            Connection();
            SqlCommand requeteSql2 = new SqlCommand("SELECT c.numChoix,c.nomChoix,Sum(nbVote) AS sommeVote FROM choix c LEFT JOIN vote ON c.numChoix = vote.numChoix WHERE numSondage = @idsondage2 GROUP BY c.numChoix,c.nomChoix ORDER BY sommeVote DESC; ", DCConnect);
            var idsondageParameter2 = new SqlParameter("@idsondage2", idSondage2);
            requeteSql2.Parameters.Add(idsondageParameter2);
            SqlDataReader dr2 = requeteSql2.ExecuteReader();
            while (dr2.Read())
            {
                listeChoixVote.Add((string)dr2["nomChoix"]);
                listeIdChoix2.Add((Int32)dr2["numChoix"]);
                
                if (dr2["sommeVote"] == DBNull.Value)
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
            int total = 0;
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
                    if (total == 0)
                    {
                        total = 1;
                    }
                    ListePourcentage2.Add(Math.Round(100 * ListePourcentage.ElementAt(i) / total, 2));
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
        public static void requeteSqlDepotDesVotesMultiple(List<Int32> listeDesVotes, Int32 idDuVotant)
        {
            Connection();
            foreach (var vote in listeDesVotes)
            {
                SqlCommand requeteSql = new SqlCommand("INSERT INTO vote (numChoix,numVotant,nbVote) VALUES(@numChoix,@numVotant,1);", DCConnect);
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
            Int32 nbVotant = 0;
            if (type % 10 == 1)
            {
                SqlCommand requeteSql = new SqlCommand("SELECT COUNT(nbVote) FROM Vote v, choix c WHERE c.numChoix=v.numChoix AND c.numSondage= @idsondage;", DCConnect);
                var idsondageParameter = new SqlParameter("@idsondage", idSondage);
                requeteSql.Parameters.Add(idsondageParameter);
                nbVotant = (Int32)requeteSql.ExecuteScalar();
            }
            else
            {
                SqlCommand requeteSql = new SqlCommand("SELECT COUNT(distinct numVotant) FROM Vote v, choix c WHERE c.numChoix=v.numChoix AND c.numSondage=@idsondage; ", DCConnect);
                var idsondageParameter = new SqlParameter("@idsondage", idSondage);
                requeteSql.Parameters.Add(idsondageParameter);
                nbVotant = (Int32)requeteSql.ExecuteScalar();
            }
            Deconnection();
            return nbVotant;
        }
        public static Int32 rechercheEtDesactivationSondage(String GuidSuppr)
        {
            Int32 idSondage=GetIdSondageParGuid(GuidSuppr);
            RequeteSqlUpdateType(idSondage);
            return idSondage;
        }
        public static void RequeteSqlUpdateType(Int32 idSondage)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("UPDATE Sondage SET typeSondage=103 WHERE numSondage=@idSondage;", DCConnect);
            var idSondageParameter = new SqlParameter("@idSondage", idSondage);
            requeteSql.Parameters.Add(idSondageParameter);
            requeteSql.ExecuteNonQuery();
            Deconnection();
        }
        public static Boolean testSiVoteDesactive(Int32 idSondage)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT typeSondage FROM Sondage WHERE numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            Int32 typeVoteEnInt = (Int32)requeteSql.ExecuteScalar();
            Deconnection();
            if (typeVoteEnInt == 103)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public static CreationCammembert requeteSqlPourCammebert(Int32 idSondage)
        {
            List<String> listeChoixVote = new List<String>();
            List<Double> ListePourcentage = new List<Double>();


            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT C.nomChoix, 100*COUNT(nomChoix)/(SELECT  COUNT(nomChoix) FROM Choix c, Vote v WHERE numSondage=@idSondage AND v.numChoix=c.numChoix ) AS pourcentage FROM Vote V, Sondage S, Choix C WHERE S.numSondage=@idSondage AND C.numSondage=S.numSondage AND C.numChoix=V.numChoix GROUP BY C.nomChoix,C.numChoix ;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                listeChoixVote.Add((string)dr["nomChoix"]);
                ListePourcentage.Add((Int32)dr["pourcentage"]);

            }
            Deconnection();
            CreationCammembert Affiche = new CreationCammembert(listeChoixVote, ListePourcentage);
            return Affiche;
        }
        public static Int32 GetTypeSondage(Int32 idSondage)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT typeSondage FROM Sondage WHERE numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            Int32 typeVoteEnInt = (Int32)requeteSql.ExecuteScalar();
            Deconnection();
            return typeVoteEnInt;
        }
        public static Int32 GetIdSondageParGuid(String GuidSuppr)
        {
            List<String> listeGuid = new List<String>();
            List<Int32> listeIdSondage = new List<Int32>();
            Int32 idSondage = 0;
            Int32 i = 0;
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT adresseLien, s.numSondage FROM sondage s,lien l WHERE s.numSondage=l.numSondage ;", DCConnect);
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
            return idSondage;
        }
        public static List<String> GetIp (Int32 idSondage)
        {
            List<String> ipEnBDD = new List<String>();
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT adresseIp FROM votant o, vote v ,choix c, sondage s WHERE s.numSondage=@idsondage AND s.numsondage=c.numSondage AND c.numChoix=v.numChoix AND V.numVotant=o.numVotant;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                ipEnBDD.Add((String)dr["adresseIp"]);
            }
            Deconnection();
            return ipEnBDD;
        }
        public static AfficheBigBrother BigBrotherIP(Int32 idSondage)
        { 
            List<String> ipEnBDD = new List<String>();
            List<String> choixEnBDD = new List<String>();
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT adresseIp, c.nomChoix FROM votant o, vote v ,choix c, sondage s WHERE s.numSondage = @idsondage AND s.numsondage = c.numSondage AND c.numChoix = v.numChoix AND V.numVotant = o.numVotant GROUP BY adresseIp, c.nomChoix;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                ipEnBDD.Add((String)dr["adresseIp"]);
                choixEnBDD.Add((String)dr["nomChoix"]);
            }
            Deconnection();
            AfficheBigBrother surveillance = new AfficheBigBrother(ipEnBDD, choixEnBDD);
            return surveillance;
        }
        public static Int32 GetMaxId()
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("SELECT MAX(numSondage) FROM  sondage s ", DCConnect);
            Int32 maxId = (Int32)requeteSql.ExecuteScalar();
            Deconnection();
            return maxId;
        }
    }
}
