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
    /// Interaction logic for mojedane.xaml
    /// </summary>
    public partial class mojedane : UserControl
    {
        public int driverid;
        Database db = new Database();
        public mojedane(int id)
        {
            InitializeComponent();
            driverid = id;
            showData();
        }


        void showData()
        {
            try
            {
                if (db.DBConnect())
                {
                    string dataQuery = $"select firstName, lastName, pesel, city, street, street_num, flat_num, format(birthdate, 'dd-MM-yyyy') as dataUrodzenia, phone_num from Drivers where driver_id = @driverid";
                    using (SqlCommand cmd = new SqlCommand(dataQuery, db.DataBase))
                    {
                        cmd.Parameters.AddWithValue("@driverid", driverid);

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            daneGrid.ItemsSource = dt.DefaultView;

                        }


                    }
                }

            }
            catch(SqlException ex) 
            {
                MessageBox.Show($"Błąd SQL: {ex.Message}");
            }
        }

        void goback_click(object sender, RoutedEventArgs e)
        {
            Main main = new Main(driverid);
            this.Content = main;

        }

        private void passwordChange_Click(object sender, RoutedEventArgs e)
        {
            PasswordChange passwordChange = new PasswordChange(driverid);
            this.Content = passwordChange;
        }
    }
}
