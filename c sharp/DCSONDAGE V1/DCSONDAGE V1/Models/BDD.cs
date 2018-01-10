using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

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
        public static void RequeteAjoutSqlSondage(String titreSondage, Int32 RadioB)
        {
            Connection();
            SqlCommand requeteSql = new SqlCommand("Insert into sondage (questionSondage,typeSondage) Values(@qSondage,@tSondage)", DCConnect);
            var qSondageParameter = new SqlParameter("@qSondage", titreSondage);
            var tSondageParameter= new SqlParameter("@tSondage", RadioB);
            requeteSql.Parameters.Add(qSondageParameter);
            requeteSql.Parameters.Add(tSondageParameter);
            requeteSql.ExecuteNonQuery();

            Deconnection();

        }
    }
}