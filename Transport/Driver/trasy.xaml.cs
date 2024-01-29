using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
    /// Interaction logic for trasy.xaml
    /// </summary>
    public partial class trasy : UserControl
    {
         

        public string SelectedLine { get; set; }
        Database db = new Database();
        int driverid;
        ComboBoxFiller filler = new ComboBoxFiller();

        
        List<string> busLines = new List<string>();
        List<string> tramLines = new List<string>();
        public ObservableCollection<string> routeStops { get; set; }



        public trasy(int id)
        {
            InitializeComponent();
            DataContext = this;
            driverid = id;
            routeStops = new ObservableCollection<string>();
            StopsListBox.ItemsSource = routeStops;



            try
            {
                if (db.DBConnect())
                {

                    string busLinesQuery = "select line_num from [Bus Lines]";
                    string tramLinesQuery = "select line_num from [Tram Lines]";
                    using (SqlCommand cmd = new SqlCommand(busLinesQuery, db.DataBase))
                    {

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while(reader.Read())
                            {
                               busLines.Add(reader.GetString(0));
                                

                            }

                        }
                    }

                    foreach (string line in busLines) 
                    {
                        filler.AddComboBoxItem(line, TrasyCombo);
                    }
                    filler.AddSeparator("Tramwaje: ", TrasyCombo);


                    using (SqlCommand cmd = new SqlCommand(tramLinesQuery, db.DataBase))
                    {

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                tramLines.Add(reader.GetString(0));


                            }

                        }
                    }
                    
                    foreach (string line in tramLines)
                    {
                        filler.AddComboBoxItem(line, TrasyCombo);
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

        void goback_click(object sender, RoutedEventArgs e)
        {
            Main main = new Main(driverid);
            this.Content = main;
        }






        bool SearchInBusLines(string route)
        {

            string query = $"select count(*) from [Bus Lines] where line_num = '{route}'";

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

        void Route()
        {
            string selectedLine = (TrasyCombo.SelectedItem as ComboBoxItem)?.Content.ToString();
            string selectedRoute = "";


            if (SearchInBusLines(selectedLine))
            {
                try
                {
                    if (db.DBConnect())
                    {
                        string routeQuery = "select route from [Bus Lines] where @selectedLine = line_num";
                        using (SqlCommand cmd = new SqlCommand(routeQuery, db.DataBase))
                        {
                            cmd.Parameters.AddWithValue("@selectedLine", selectedLine);
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    selectedRoute = reader.GetString(0);
                                }


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
                        string routeQuery = "select route from [Tram Lines] where @selectedLine = line_num";
                        using (SqlCommand cmd = new SqlCommand(routeQuery, db.DataBase))
                        {
                            cmd.Parameters.AddWithValue("@selectedLine", selectedLine);
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    selectedRoute = reader.GetString(0);
                                }
                            }

                        }


                    }



                }
                catch (SqlException ex)
                {
                    MessageBox.Show($"Błąd bazy danych: {ex.Message}");

                }

            }

            string[] stops = selectedRoute.Split(' ', ',');


            if (SearchInBusLines(selectedLine))
            {

                foreach (string stop in stops)
                {
                    string locationQuery = $"select stop_name from [Bus Stops] where stop_id = '{stop}' ";
                    using (SqlCommand сmd = new SqlCommand(locationQuery, db.DataBase))
                    {

                        using (SqlDataReader reader = сmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Stop tempStop = new Stop();
                                int index = reader.GetOrdinal("stop_name");
                                tempStop.StopName = reader.GetString(index);
                                routeStops.Add(tempStop.StopName);


                            }
                        }
                    }
                }

            }
            else
            {
                foreach (string stop in stops)
                {
                    string locationQuery = $"select stop_name from [Tram Stops] where stop_id = '{stop}' ";
                    using (SqlCommand сmd = new SqlCommand(locationQuery, db.DataBase))
                    {
                        using (SqlDataReader reader = сmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Stop tempStop = new Stop();
                                int index = reader.GetOrdinal("stop_name");
                                tempStop.StopName = reader.GetString(index);
                                routeStops.Add(tempStop.StopName);
                            }

                        }
                    }
                }

            }

        }

        void ShowRoute_Click(object sender, RoutedEventArgs e)
        {
            routeStops.Clear();
            Route();
        }
    }

    public class Stop
    {
        public string StopName {  get; set; }
    }


}
