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
using System.Security.Cryptography.X509Certificates;
using Transport.Driver;

namespace Transport
{
    /// <summary>
    /// Interaction logic for DriverWindow.xaml
    /// </summary>
    public partial class DriverWindow : MetroWindow
    {
        public DriverWindow(int id)
        {
            InitializeComponent();
            Main main = new Main(id);
            this.Content = main;

        }

    }

    


}
