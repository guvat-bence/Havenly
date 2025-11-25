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

namespace Havenly
{
    /// <summary>
    /// Interaction logic for Datas.xaml
    /// </summary>
    public partial class Datas : Window
    {
        public Datas()
        {
            InitializeComponent();

            this.Height = 660;
            this.Width = 800;

            for (int i = 0; i <2; i++)
            {
                Label dlb = new Label();
                dlb.Width = 200;
                dlb.Margin = new Thickness(4);
                dlb.HorizontalAlignment = HorizontalAlignment.Center;
                dlb.HorizontalContentAlignment = HorizontalAlignment.Center;
                dlb.Foreground = Brushes.White;
                dlb.Content = "asd";
                asd1.Children.Add(dlb);
                DatePicker dt = new DatePicker();
                dt.Width = 150;
                dt.Margin = new Thickness(5);
                asd1.Children.Add(dt);
            }
          
            Label llb = new Label();
            llb.Width = 200;
            llb.Margin = new Thickness(4);
            llb.HorizontalAlignment = HorizontalAlignment.Center;
            llb.HorizontalContentAlignment = HorizontalAlignment.Center;
            llb.Foreground = Brushes.White;
            llb.Content = "asd";
            asd22.Children.Add(llb);

            TextBox ltb = new TextBox();
            ltb.Width = 300;
            ltb.Height = 400;
            ltb.AcceptsReturn = true;
            ltb.TextWrapping = TextWrapping.Wrap;
            ltb.VerticalScrollBarVisibility = ScrollBarVisibility.Auto;
            ltb.HorizontalAlignment = HorizontalAlignment.Center;
            ltb.Text = "Hoszzú szöveg";
            asd22.Children.Add(ltb);

            for (int i = 0; i < 15; i++)
            {
                TextBox tb = new TextBox();
                tb.Width = 200; 
                tb.Margin = new Thickness(7);
                tb.HorizontalAlignment = HorizontalAlignment.Right;
                tb.Text = $"Textbox #{i + 1}";
                asd.Children.Add(tb);

            }
            for(int i = 0; i < 15; i++)
            {
                Label lb = new Label();
                lb.Width = 200;
                lb.Margin = new Thickness(4);
                lb.HorizontalAlignment = HorizontalAlignment.Right;
                lb.HorizontalContentAlignment = HorizontalAlignment.Right;
                lb.Foreground = Brushes.White;
                lb.Content = "asd";
                asd33.Children.Add(lb);
            }
        }
    }
}
