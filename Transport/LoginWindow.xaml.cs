using MahApps.Metro.Controls;
using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using Transport.Driver;

namespace Transport
{
    /// <summary>
    /// Interaction logic for LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : MetroWindow
    {
        Database db = new Database();
        public LoginWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            int id;

            string login = Username.Text;
            string password = Password.Password;

            if (DriverRadio.IsChecked == true)
            {
                try
                {
                    if (db.DBConnect())
                    {
                        string driversQuery = "select * from LoginDriver where login = @login and password = @password";
                        using (SqlCommand cmd = new SqlCommand(driversQuery, db.DataBase))
                        {
                            cmd.Parameters.AddWithValue("@login", login);
                            cmd.Parameters.AddWithValue("@password", password);
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    id = Convert.ToInt32(reader["driver_id"]);
                                    DriverWindow driverWindow = new DriverWindow(id);
                                    driverWindow.Show();
                                    this.Close();
                                }
                                else
                                {
                                    MessageBox.Show("Niepoprawny login lub hasło.");
                                }
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {

                    MessageBox.Show($"Błąd SQL:\n {ex.Message}");
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Błąd:\n {ex.Message}");
                }
            }



            else
            {
                MessageBox.Show("Proszę wybrać typ konta.");
            }




        }
    }
}
