using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient; // librairie de gestion SQL

namespace DCSONDAGE_V1.Models
{
    public class BDD
    {
        /// <summary>
        /// 2 SQL string : une pour le local et une pour le serveur CCI
        /// </summary>
        // public static string SQlConnectString = @"server=.\SQLEXPRESS;Database=projet;Trusted_Connection=Yes"; 
        // public static string SQlConnectString = @"server=172.19.240.123;Database=DCSondage;user id=sa;password=pf68*CCI";
        public static string SQlConnectString = @"server=FIXE;Database=projet;Trusted_Connection=Yes";

        static SqlConnection DCConnect = new SqlConnection(SQlConnectString);
        
        public static void Connection()
        {
                DCConnect.Open();
        }
        public static void Deconnection()
        {
            DCConnect.Close();
        }
        /// <summary>
        /// Permet d'insérer une question et un type de sondage dans la table Sondage
        /// Cette méthode est utilisée par le HomeController / Submit
        /// Renvoie l'id du sondage, nouvellement créé (Int32)
        /// </summary>
        /// <param name="titreSondage"></param>
        /// <param name="RadioB"></param>
        /// <returns></returns>
        public static Int32 RequeteAjoutSqlSondage(String titreSondage, Int32 RadioB)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("INSERT INTO sondage (questionSondage,typeSondage) VALUES(@questionSondage,@typeSondage); SELECT numSondage FROM sondage WHERE numsondage=SCOPE_IDENTITY()", DCConnect);
            var questionSondageParameter = new SqlParameter("@questionSondage", titreSondage);
            var typeSondageParameter = new SqlParameter("@typeSondage", RadioB);
            requeteSql.Parameters.Add(questionSondageParameter);
            requeteSql.Parameters.Add(typeSondageParameter);
            Int32 idSondage = Convert.ToInt32(requeteSql.ExecuteScalar());
            DCConnect.Close();
            return idSondage;
        }
        /// <summary>
        /// Permet d'insérer les différents choix de réponses dans la table Choix
        /// Cette méthode est utilisée par le HomeController / Submit
        /// </summary>
        /// <param name="idSondage"></param>
        /// <param name="listechoix"></param>
        public static void RequetteAjoutSqlChoix(Int32 idSondage, List<String> listechoix)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();

            foreach (var choix in listechoix)
            {
                SqlCommand requeteSql = new SqlCommand("INSERT INTO Choix (nomChoix,numSondage) VALUES(@choix,@idSondage);", DCConnect);
                var choixParameter = new SqlParameter("@choix", choix);
                var idSondageParameter = new SqlParameter("@idsondage", idSondage);
                requeteSql.Parameters.Add(choixParameter);
                requeteSql.Parameters.Add(idSondageParameter);
                requeteSql.ExecuteNonQuery();
            }
            DCConnect.Close();
        }
        /// <summary>
        /// Permet d'insérer le Guid de Suppression dans la table Lien
        /// Cette méthode est utilisée par le HomeController / Submit
        /// </summary>
        /// <param name="idSondage"></param>
        /// <param name="guidSuppression"></param>
        public static void RequetteAjoutSqlLienSuppr(Int32 idSondage, Guid guidSuppression)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("INSERT INTO Lien (adresseLien,numSondage) VALUES(@guidSuppression,@idsondage);", DCConnect);
            var LienParameter = new SqlParameter("@guidSuppression", guidSuppression);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(LienParameter);
            requeteSql.Parameters.Add(idsondageParameter);
            requeteSql.ExecuteNonQuery();
            DCConnect.Close();
        }
        /// <summary>
        /// Permet de créer une instance de la classe AfficheVote
        /// En injectant dans 2 listes les noms et ids des choix en lien avec le sondage
        /// Cette méthode est utilisée par le HomeController / Vote
        /// Renvoie une instance d'AfficheVote
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static AfficheVote GetListeChoixetId(Int32 idSondage)
        {
            List<String> listeChoixVote = new List<String>();
            List<int> listeIdChoix = new List<int>();
            Int32 idSondage2 = idSondage;
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT nomChoix,numChoix FROM choix WHERE numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                listeChoixVote.Add((string)dr["nomChoix"]);
                listeIdChoix.Add((Int32)dr["numChoix"]);
            }
            DCConnect.Close();
            Int32 typeSondage = GetTypeSondage(idSondage);
            AfficheVote Affiche = new AfficheVote(idSondage, listeIdChoix, listeChoixVote, typeSondage);
            return Affiche;
        }
        /// <summary>
        /// Permet de récupérer la question du sondage
        /// Cette méthode est utilisée par le HomeController / Vote
        /// Renvoie le nom du sondage (String)
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static String GetNomSondage(Int32 idSondage)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT questionSondage FROM Sondage WHERE numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            string nomDuSondage = (String)requeteSql.ExecuteScalar();
            DCConnect.Close();
            return nomDuSondage;
        }
        /// <summary>
        /// Permet d'insérer l'ip dans la table votant
        /// Cette méthode est utilisée par le HomeController / Vote
        /// Renvoie l'id du votant, nouvellement créé, lié à l'adresse IP (Int32)
        /// </summary>
        /// <param name="adresseIp"></param>
        /// <returns></returns>
        public static Int32 RequeteSqlDepotvotant(string adresseIp)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();

            SqlCommand requeteSql = new SqlCommand("INSERT INTO Votant (adresseIp) VALUES(@adresseIp); SELECT numVotant FROM Votant WHERE numVotant=SCOPE_IDENTITY()", DCConnect);
            var adresseIpParameter = new SqlParameter("@adresseIp", adresseIp);
            requeteSql.Parameters.Add(adresseIpParameter);
            Int32 numVotant = Convert.ToInt32(requeteSql.ExecuteScalar());

            DCConnect.Close();
            return numVotant;
        }
        /// <summary>
        ///  Permet de créer une liste de vote en incluant les choix qui n'ont pas été sélectionnés (votés)
        ///  On additionne le nombre de votes effectifs afin d'avoir le nombre total de votes
        ///  Puis on calcule le pourcentage de chaque choix (même ce qui n'ont reçu aucun vote)
        ///  Cette méthode est utilisée par le HomeController / AffichageResultat
        ///  Renvoie une instance d'AfficheResultat
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static AfficheResultat RequeteSqlRecupListeChoixetIdetNbVote(Int32 idSondage)
        {
            List<String> listeChoixVote = new List<String>();
            //List<Int32> listeIdChoix = new List<Int32>();
            //List<Int32> listeIdChoix2 = new List<Int32>();
            List<Int32> ListeNbVote = new List<Int32>();
            List<Double> ListePourcentageTemporaire = new List<Double>();
            List<Double> ListePourcentage = new List<Double>();
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT c.numChoix,c.nomChoix,SUM(nbVote) AS sommeVote FROM choix c LEFT JOIN vote ON c.numChoix = vote.numChoix WHERE numSondage = @idSondage GROUP BY c.numChoix,c.nomChoix ORDER BY sommeVote DESC; ", DCConnect);
            var idSondageParameter = new SqlParameter("@idSondage", idSondage);
            requeteSql.Parameters.Add(idSondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                listeChoixVote.Add((string)dr["nomChoix"]);

                if (dr["sommeVote"] == DBNull.Value)
                {
                    ListeNbVote.Add(0);
                    ListePourcentageTemporaire.Add(0);
                }
                else
                {
                    ListeNbVote.Add(Convert.ToInt32(dr["sommeVote"]));
                    ListePourcentageTemporaire.Add(Convert.ToInt32(dr["sommeVote"]));
                }
            }
            dr.Close();
            int totalDeVotes = 0;
                foreach (int ligne in ListePourcentageTemporaire)
                {
                    totalDeVotes += ligne;
                }

                for (int i = 0; i < ListePourcentageTemporaire.Count; i++)
                {
                    if (totalDeVotes == 0)
                    {
                    totalDeVotes = 1;
                    }
                    ListePourcentage.Add(Math.Round(100 * ListePourcentageTemporaire.ElementAt(i) / totalDeVotes, 2));
                }
            DCConnect.Close();
            string nomDuSondage = GetNomSondage(idSondage);
            AfficheResultat Affiche = new AfficheResultat(idSondage, nomDuSondage, listeChoixVote, ListeNbVote, ListePourcentage);
            return Affiche;
        }
        /// <summary>
        /// Permet d'insérer les votes et l'id du votant dans la table Vote
        /// Cette méthode est utilisée par le HomeController / submitVote
        /// </summary>
        /// <param name="listeDesVotes"></param>
        /// <param name="idDuVotant"></param>
        public static void RequeteSqlDepotDesVotesMultiple(List<Int32> listeDesVotes, Int32 idDuVotant)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            foreach (var vote in listeDesVotes)
            {
                SqlCommand requeteSql = new SqlCommand("INSERT INTO vote (numChoix,numVotant,nbVote) VALUES(@numChoix,@numVotant,1);", DCConnect);
                var voteParameter = new SqlParameter("@numChoix", vote);
                var idDuVotantParameter = new SqlParameter("@numVotant", idDuVotant);
                requeteSql.Parameters.Add(voteParameter);
                requeteSql.Parameters.Add(idDuVotantParameter);
                requeteSql.ExecuteNonQuery();
            }
            DCConnect.Close();
        }
        /// <summary>
        /// Permet en fonction du type de vote (multiple ou unique) de calculer le nombre de personnes qui ont voté (qui est différent du nombre de vote)
        /// Permet en fonction du type de vote (multiple ou unique) de calculer le nombre de votants (qui est différent du nombre de vote)
        /// Cette méthode est utilisée par le HomeController / submitVote
        /// Renvoie le nombre de votants (Int32)
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        /// 
        public static Int32 RequeteSqlRecupNbVotant(Int32 idSondage)
        {
            Int32 type = GetTypeSondage(idSondage);
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            Int32 nbVotant = 0;
            if ((type == Constantes.COOKIEUNIQUE) || (type == Constantes.IPUNIQUE))
            {
                SqlCommand requeteSql = new SqlCommand("SELECT COUNT(nbVote) FROM Vote v, choix c WHERE c.numChoix=v.numChoix AND c.numSondage= @idSondage;", DCConnect);
                var idSondageParameter = new SqlParameter("@idSondage", idSondage);
                requeteSql.Parameters.Add(idSondageParameter);
                nbVotant = (Int32)requeteSql.ExecuteScalar();
            }
            else
            {
                SqlCommand requeteSql = new SqlCommand("SELECT COUNT(distinct numVotant) FROM Vote v, choix c WHERE c.numChoix=v.numChoix AND c.numSondage=@idsondage; ", DCConnect);
                var idsondageParameter = new SqlParameter("@idsondage", idSondage);
                requeteSql.Parameters.Add(idsondageParameter);
                nbVotant = (Int32)requeteSql.ExecuteScalar();
            }
            DCConnect.Close();
            return nbVotant;
        }
        /// <summary>
        /// Permet de retrouver l'id d'un sondage par le Guid
        /// Cette méthode est utilisée par le HomeController / Suppression
        /// Renvoie l'id du sondage (Int32)
        /// </summary>
        /// <param name="GuidSuppr"></param>
        /// <returns></returns>
        public static Int32 RechercheEtDesactivationSondage(String GuidSuppr)
        {
            Int32 idSondage = GetIdSondageParGuid(GuidSuppr);
            RequeteSqlUpdateType(idSondage);
            return idSondage;
        }
        /// <summary>
        /// Permet de mettre à jour le type du sondage, en sondage désactivé dans la table Sondage
        /// Cette méthode est utiliséé par la methode BDD.rechercheEtDesactivationSondage
        /// </summary>
        /// <param name="idSondage"></param>
        public static void RequeteSqlUpdateType(Int32 idSondage)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("UPDATE Sondage SET typeSondage=103 WHERE numSondage=@idSondage;", DCConnect);
            //var typeParameter = new SqlParameter("@type", Constantes.SONDAGEDESACTIVE);
            var idSondageParameter = new SqlParameter("@idSondage", idSondage);
            requeteSql.Parameters.Add(idSondageParameter);
            requeteSql.ExecuteNonQuery();
            DCConnect.Close();
        }
        /// <summary>
        /// Permet de tester si le sondage est désactivé
        /// Cette méthode est utilisée par le HomeController / Vote et  HomeController / submitVote
        /// Renvoie un bolleen
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static Boolean TestSiVoteDesactive(Int32 idSondage)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT typeSondage FROM Sondage WHERE numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            Int32 typeVoteEnInt = (Int32)requeteSql.ExecuteScalar();
            DCConnect.Close();
            if (typeVoteEnInt == Constantes.SONDAGEDESACTIVE)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// Permet de créer deux listes : une pour les noms des votes et une autre avec leurs pourcentages
        /// Cette méthode est utilisée par le HomeController / AfficheResultat
        /// Retourne une instance de CreationCamembert
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static CreationCamembert RequeteSqlPourCamembert(Int32 idSondage)
        {
            List<String> listeChoixVote = new List<String>();
            List<Double> ListePourcentage = new List<Double>();

            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT C.nomChoix, 100*COUNT(nomChoix)/(SELECT  COUNT(nomChoix) FROM Choix c, Vote v WHERE numSondage=@idSondage AND v.numChoix=c.numChoix ) AS pourcentage FROM Vote V, Sondage S, Choix C WHERE S.numSondage=@idSondage AND C.numSondage=S.numSondage AND C.numChoix=V.numChoix GROUP BY C.nomChoix,C.numChoix ;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                listeChoixVote.Add((string)dr["nomChoix"]);
                ListePourcentage.Add((Int32)dr["pourcentage"]);

            }
            DCConnect.Close();
            CreationCamembert Affiche = new CreationCamembert(listeChoixVote, ListePourcentage);
            return Affiche;
        }
        /// <summary>
        /// Permet de trouver le type de sondage
        /// Cette méthode est utilisée par le HomeController / Liens et HomeController /Vote, HomeController / SubmitVote et la methode GetListeChoixEtId
        /// Renvoie le type du sondage (Int32)
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static Int32 GetTypeSondage(Int32 idSondage)
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT typeSondage FROM Sondage WHERE numSondage=@idSondage;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            Int32 typeVoteEnInt = (Int32)requeteSql.ExecuteScalar();
            Deconnection();
            return typeVoteEnInt;
        }
        /// <summary>
        /// Permet de créer une liste de tous les guids en base de donnée et de les comparer avec le guid d'entrée 
        /// Cette méthode est utilisée par le HomeController / Liens, HomeController /Vote, HomeController /SubmitVote et la methode GetListeChoixEtId
        /// Renvoie l'id du sondage si trouvé sinon renvoi -1 si aucun id n'a été trouvé (Int32)
        /// </summary>
        /// <param name="GuidSuppr"></param>
        /// <returns></returns>
        public static Int32 GetIdSondageParGuid(String GuidSuppr)
        {
            List<String> listeGuid = new List<String>();
            List<Int32> listeIdSondage = new List<Int32>();
            Int32 idSondage = 0;
            Int32 i = 0;
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
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
                    break;
                }
                else
                {
                    idSondage = -1;
                }
                i++;
            }
            DCConnect.Close();
            return idSondage;
        }
        /// <summary>
        /// Permet de créer une liste des ip qui ont déjà voté sur un sondage
        /// Cette méthode est utilisée par le HomeController / Vote et HomeController / submitVote
        /// Renvoie la liste des ip qui ont déjà voté sur un sondage
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static List<String> GetIp(Int32 idSondage)
        {
            List<String> ipEnBDD = new List<String>();
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT adresseIp FROM votant o, vote v ,choix c, sondage s WHERE s.numSondage=@idsondage AND s.numsondage=c.numSondage AND c.numChoix=v.numChoix AND V.numVotant=o.numVotant;", DCConnect);
            var idsondageParameter = new SqlParameter("@idsondage", idSondage);
            requeteSql.Parameters.Add(idsondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                ipEnBDD.Add((String)dr["adresseIp"]);
            }
            DCConnect.Close();
            return ipEnBDD;
        }
        /// <summary>
        /// Permet de créer une liste des ip et des votes qu'ils ont fait
        /// Permet de créer une liste des ip et des votes que les utilisateurs ont fait
        /// Cette méthode est utilisée par le BigController / Brother 
        /// Renvoie une instance d'AfficheBigBrother
        /// </summary>
        /// <param name="idSondage"></param>
        /// <returns></returns>
        public static AfficheBigBrother BigBrotherIP(Int32 idSondage)
        {
            List<String> ipEnBDD = new List<String>();
            List<String> choixEnBDD = new List<String>();
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT adresseIp, c.nomChoix FROM votant o, vote v ,choix c, sondage s WHERE s.numSondage = @idSondage AND s.numsondage = c.numSondage AND c.numChoix = v.numChoix AND V.numVotant = o.numVotant GROUP BY adresseIp, c.nomChoix;", DCConnect);
            var idSondageParameter = new SqlParameter("@idSondage", idSondage);
            requeteSql.Parameters.Add(idSondageParameter);
            SqlDataReader dr = requeteSql.ExecuteReader();
            while (dr.Read())
            {
                ipEnBDD.Add((String)dr["adresseIp"]);
                choixEnBDD.Add((String)dr["nomChoix"]);
            }
            DCConnect.Close();
            AfficheBigBrother surveillance = new AfficheBigBrother(ipEnBDD, choixEnBDD);
            return surveillance;
        }
        /// <summary>
        /// Permet de chercher l'id MAX de la table Sondage
        /// Cette méthode est utilisée par Methodes.isBiggerQueMaxId
        /// Renvoie la valeur la plus grande des id sondage
        /// </summary>
        /// <returns></returns>
        public static Int32 GetMaxId()
        {
            SqlConnection DCConnect = new SqlConnection(SQlConnectString);
            DCConnect.Open();
            SqlCommand requeteSql = new SqlCommand("SELECT MAX(numSondage) FROM  sondage s ", DCConnect);
            Int32 maxId = (Int32)requeteSql.ExecuteScalar();
            DCConnect.Close();
            return maxId;
        }

        // tentative de barre de recherche.
        //public static List<Int32>  GetSondageParNom(string ligne, List<Int32> listLigne)
        //{
        //    List<Int32> listeLigne = new List<Int32>();

        //    Connection();
        //    SqlCommand requeteSql = new SqlCommand("SELECT numSondage FROM  sondage WHERE questionSondage LIKE '%@ligne%' ", DCConnect);
        //    var idsondageParameter = new SqlParameter("@ligne", ligne);
        //    requeteSql.Parameters.Add(idsondageParameter);
        //    SqlDataReader dr = requeteSql.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        listeLigne.Add((Int32)dr["numSondage"]);
        //    }
        //    Deconnection();

        //    return listeLigne;
        //} 
    }
}
