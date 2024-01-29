using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Transport.Driver
{
    /// <summary>
    /// Interaction logic for PasswordChange.xaml
    /// </summary>
    public partial class PasswordChange : UserControl
    {
        int driverid;
        Database db = new Database();
        Validator validator = new Validator();  

        public PasswordChange(int id)
        {
            InitializeComponent();
            driverid = id;
        }

        private void change_Click(object sender, RoutedEventArgs e)
        {
            string oldPass = OldPassBox.Password;
            string newPass = NewPassBox.Password;

            if (passCheck(oldPass))
            {
                if(validator.PasswordCheck(newPass)) 
                {
                    passSet(newPass);
                    MessageBox.Show("Hasło zostało zmienione.");

                }
                else
                {
                    MessageBox.Show("Nowe hasło musi zawierać minimum 8 znaków i liczb");
                }


            }
            else
            {
                MessageBox.Show("Podano niepoprawne stare hasło");
            }
        }


        bool passCheck(string oldPass)
        {
            try
            {
                if (db.DBConnect())
                {
                    string passwordQuery = "select password from LoginDriver where driver_id = @driverid";
                    using (SqlCommand cmd = new SqlCommand(passwordQuery, db.DataBase))
                    {
                        cmd.Parameters.AddWithValue("@driverid", driverid);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string dbOldPass = reader["password"].ToString();
                                if (oldPass == dbOldPass)
                                {
                                    return true;
                                }
                            }
                            

                            

                        }

                    }
                }
            }
            catch (SqlException ex) 
            {
                MessageBox.Show($"Błąd bazy danych: {ex.Message}");
            }
            return false;
            

        }

        bool passSet(string newpass)
        {
            
            try
            {
                db.DBConnect();
                string passwordChangeQuery = $"update LoginDriver set password = '{newpass}' where driver_id = @driverid";
                using (SqlCommand cmd = new SqlCommand(passwordChangeQuery, db.DataBase)) 
                {
                    cmd.Parameters.AddWithValue("@driverid", driverid);
                    int count = Convert.ToInt32(cmd.ExecuteNonQuery());
                    return count > 0;

                } 
            }
            catch (SqlException ex)
            {
                MessageBox.Show($"Błąd bazy danych: {ex.Message}");
            }
            return false;
        }

        void goback_click(object sender, EventArgs e)
        {
            mojedane mojedane = new mojedane(driverid);
            this.Content = mojedane;
        }



    }
}
