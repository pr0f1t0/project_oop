using System;
using System.Collections.Generic;
using System.Data;
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

namespace Transport.Driver
{
    /// <summary>
    /// Interaction logic for rozklad.xaml
    /// </summary>
    public partial class rozklad : UserControl
    {
        Database db = new Database();
        public int driverid;

       ComboBoxFiller filler = new ComboBoxFiller();
       List<string> busStops = new List<string>();
       List<string> tramStops = new List<string>();


        public rozklad(int id)
        {
            InitializeComponent();
            DataContext = this;
            driverid = id;

            ComboItems();
        }


        void ComboItems()
        {


            try
            {
                if (db.DBConnect())
                {
                    string BusStopNamesQuery = "select stop_name from [Bus Stops]";
                    string TramStopNamesQuery = "select stop_name from [Tram Stops]";

                    using (SqlCommand cmd = new SqlCommand(BusStopNamesQuery, db.DataBase))
                    {

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                busStops.Add(reader["stop_name"].ToString());
                            }

                        }
                    }

                    foreach (string stop in busStops) 
                    {
                        filler.AddComboBoxItem(stop, PrzystankiCombo);
                    }
                    filler.AddSeparator("Przystanki tramwajowe: ", PrzystankiCombo);





                    using (SqlCommand cmd = new SqlCommand(TramStopNamesQuery, db.DataBase))
                    {

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                tramStops.Add(reader["stop_name"].ToString());

                            }

                        }
                    }

                    foreach (string stop in tramStops)
                    {
                        filler.AddComboBoxItem(stop, PrzystankiCombo);
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

        void Schedule()
        {
            string selectedStop = (PrzystankiCombo.SelectedItem as ComboBoxItem)?.Content.ToString();
            if (SearchInBusStops(selectedStop))
            {
                try
                {
                    if (db.DBConnect())
                    {
                        string scheduleQuery = $"select line_num, departure_time from [Bus Departures] bd inner join [Bus Stops] bs on bd.stop_id = bs.stop_id where stop_name = '{selectedStop}'";
                        using (SqlCommand cmd = new SqlCommand(scheduleQuery, db.DataBase))
                        {
                            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                adapter.Fill(dt);

                                rozkladGrid.ItemsSource = dt.DefaultView;




                            }

                        }
                    }
                }
                catch (SqlException ex)
                {
                    MessageBox.Show($"Błąd bazy danych: {ex.Message}");

                }


            }
            else
            {

                try
                {
                    if (db.DBConnect())
                    {
                        string scheduleQuery = $"select line_num, departure_time from [Tram Departures] td inner join [Tram Stops] ts on td.stop_id = ts.stop_id where stop_name = '{selectedStop}'";
                        using (SqlCommand cmd = new SqlCommand(scheduleQuery, db.DataBase))
                        {
                            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                adapter.Fill(dt);

                                rozkladGrid.ItemsSource = dt.DefaultView;




                            }

                        }
                    }
                }
                catch (SqlException ex)
                {
                    MessageBox.Show($"Błąd bazy danych: {ex.Message}");

                }

            }
        }





        bool SearchInBusStops(string stop)
        {

            string query = $"select count(*) from [Bus Stops] where stop_name = '{stop}'";

            try
            {
                db.DBConnect();
                SqlCommand command = new SqlCommand(query, db.DataBase);
                int count = Convert.ToInt32(command.ExecuteScalar());

                return count > 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Błąd: {ex.Message} ");
                return false;
            }

        }

        private void ShowSchedule_Click(object sender, RoutedEventArgs e)
        {
            Schedule();
        }

        private void goback_Click(object sender, RoutedEventArgs e)
        {
            Main main = new Main(driverid);
            this.Content = main;
        }
    }
}
