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
    /// Interaction logic for zmiany.xaml
    /// </summary>
    public partial class zmiany : UserControl
    {
        int driverid;
        Database db = new Database();
        public zmiany(int id)
        {
            InitializeComponent();
            driverid = id;
            try
            {
                if (db.DBConnect())
                {

                    string shiftsQuery = "select format(shift_date, 'dd-MM-yyyy') as Date, start_time, finish_time from [Work Shifts] where driver_id = @driverid";
                    using (SqlCommand cmd = new SqlCommand(shiftsQuery, db.DataBase))
                    {
                        cmd.Parameters.AddWithValue("@driverid", id);
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            zmianygrid.ItemsSource = dt.DefaultView;




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

        void goback_click(object sender, RoutedEventArgs e) 
        {
            Main main = new Main(driverid);
            this.Content = main;

        }



    }
}
