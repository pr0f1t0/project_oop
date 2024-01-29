using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace Transport
{
    public class ComboBoxFiller
    {
        public void AddSeparator(string text, ComboBox comboBox)
        {
            ComboBoxItem separator = new ComboBoxItem
            {
                Content = text,
                IsEnabled = false
            };
            comboBox.Items.Add(separator);
        }

        public void AddComboBoxItem(string text, ComboBox comboBox)
        {
            ComboBoxItem item = new ComboBoxItem
            {
                Content = text
            };
            comboBox.Items.Add(item);

        }

    }
}
