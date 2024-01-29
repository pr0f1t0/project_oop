using System;
using MahApps.Metro.Controls;
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
using ControlzEx.Standard;
using System.Data.SqlClient;
using System.Windows.Threading;
using System.Windows.Navigation;
using Transport.Driver;
using System.Data;
namespace Transport
{
    /// <summary>
    /// Interaction logic for zgloszenie.xaml
    /// </summary>
    public partial class zgloszenie : UserControl
    {
        int driverid;
        Database db = new Database();
        public zgloszenie(int id) 
        { 
            InitializeComponent();
            driverid = id;

        }

        private void goback_click(object sender, RoutedEventArgs e)
        {
            Main main = new Main(driverid);
            this.Content = main;
        }

        private void zglos_Click(object sender, RoutedEventArgs e)
        {
            string vehicleNum = numerPojazdu.Text;
            string accType = typZdarzenia.Text;
            int accId;

            try
            {
                if (db.DBConnect())
                {

                    string accidentsQuery = "select max(entry_id) from [Vehicles Incidents]";
                    using (SqlCommand cmd = new SqlCommand(accidentsQuery, db.DataBase))
                    {
                        object idObj = cmd.ExecuteScalar();

                        if (idObj != null && idObj != DBNull.Value)
                        {
                            accId = Convert.ToInt32(idObj) + 1;
                        }
                        else
                        {
                            accId = 1;
                            
                        }




                    }

                    if (Validate(vehicleNum, accType))
                    {
                        string insertInc = "insert into [Vehicles Incidents] values ((@accId), (@vehicleNum), (@accType), (@driverId))";
                        using (SqlCommand insCmd = new SqlCommand(insertInc, db.DataBase))
                        {
                            insCmd.Parameters.AddWithValue("@accId", accId);
                            insCmd.Parameters.AddWithValue("@vehicleNum", vehicleNum);
                            insCmd.Parameters.AddWithValue("@accType", accType);
                            insCmd.Parameters.AddWithValue("@driverId", driverid);

                            try
                            {

                                int affected = insCmd.ExecuteNonQuery();

                                if (affected > 0)
                                {
                                    MessageBox.Show("Informacja o zdarzeniu dodana pomyślnie!");

                                }
                            }
                            catch (SqlException ex)
                            {
                                MessageBox.Show($"Błąd bazy danych: {ex.Message}");
                            }

                        }
                    }
                    else
                    {
                        MessageBox.Show("Proszę podać poprawne dane");
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

        public bool Validate(string vehicleNum, string accType)
        {
            Validator validator = new Validator();
            if (vehicleNum != null && accType != null)
            {
                if ((validator.BusNumCheck(vehicleNum) || validator.TramNumCheck(vehicleNum)) && validator.NumbersCheck(accType) )
                {
                    return true;

                }
                else
                {
                    return false;
                    
                }
            }
            else
            {
                return false;
            }
           

        }
    }
}
