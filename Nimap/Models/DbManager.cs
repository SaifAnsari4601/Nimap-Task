using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


namespace Nimap.Models
{
    public class DbManager
    {
        SqlConnection con = new SqlConnection("Data Source=DESKTOP-FQU9AMD;Initial Catalog=db_nimap;Integrated Security=True");
        public DataTable TblDb(string proc,SqlParameter[] parameters)
        {
            SqlCommand cm = new SqlCommand(proc,con);
            cm.CommandType = CommandType.StoredProcedure;
            foreach(SqlParameter parameter in parameters)
            {
                cm.Parameters.Add(parameter);
            }
            DataTable tbl = new DataTable();
            SqlDataAdapter ad = new SqlDataAdapter(cm);
            ad.Fill(tbl);
            return tbl;
        }
    }
}