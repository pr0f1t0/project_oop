using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
using System.Windows.Threading;

namespace Transport.Driver
{
    /// <summary>
    /// Interaction logic for Main.xaml
    /// </summary>
    public partial class Main : UserControl
    {
        Database db = new Database();
        int driverid;
        public Main(int id)
        {
            driverid = id;

            InitializeComponent();

            DispatcherTimer timer = new DispatcherTimer();
            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += timer_Tick;
            timer.Start();

            try
            {
                if (db.DBConnect())
                {

                    string nameQuery = "select * from Drivers where driver_id = @driverid";
                    using (SqlCommand cmd = new SqlCommand(nameQuery, db.DataBase))
                    {
                        cmd.Parameters.AddWithValue("@driverid", id);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string name = reader["firstName"].ToString();
                                string surnname = reader["lastName"].ToString();
                                Powitanie.Text = $"Dzień dobry, {name} {surnname}";

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



        private void timer_Tick(object sender, EventArgs e)
        {

            Czas.Text = DateTime.Now.ToString();
        }


        private void zglos_Click(object sender, RoutedEventArgs e)
        {
            zgloszenie zgl = new zgloszenie(driverid);
            this.Content = zgl;
        }

        private void zmianyB_Click(object sender, RoutedEventArgs e)
        {
            zmiany zmiany = new zmiany(driverid);
            this.Content = zmiany;
        }


        private void trasyB_Click(object sender, RoutedEventArgs e)
        {
            trasy t = new trasy(driverid);
            this.Content = t;   

        }

        private void logout(object sender, EventArgs e)
        {
            LoginWindow login = new LoginWindow();
            Window parent = Window.GetWindow(this);
            parent.Close();
            db.DBClose();
            login.Show();
        }

        private void rozkladButton_Click(object sender, RoutedEventArgs e)
        {
            rozklad rozklad = new rozklad(driverid);
            this.Content = rozklad;
            
        }

        private void MojeD_Click(object sender, RoutedEventArgs e)
        {
            mojedane mojedane = new mojedane(driverid);
            this.Content = mojedane;

        }

    }
}
