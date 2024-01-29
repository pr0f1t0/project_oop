using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Transport
{
    public class Database
    {
        public SqlConnection DataBase;

        public Boolean DBConnect()
        {
            try
            {
                DataBase = new SqlConnection("Server=(LocalDb)\\MSSQLLocalDB;Database=Transport_miejski;Trusted_Connection=True;");

                if (DataBase.State != ConnectionState.Open)
                {
                    DataBase.Open();
                }
                return true;
            }

            finally
            {
                if (DataBase.State == ConnectionState.Closed)
                {
                    DataBase.Dispose();
                }
            }
        }
        public void DBClose()
        {
            DataBase.Close();
        }
    }
}


