using Google.Protobuf.WellKnownTypes;
using System;
using System.Collections.Generic;
using System.Data;
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
        private MainWindow mainWindow;

        public Datas(object data, MainWindow mainWindow)


        {
            InitializeComponent();

            

            this.mainWindow = mainWindow;

            this.Closed += ClosedEvent;

            this.Height = 660;
            this.Width = 800;

            this.DataSortingAndElementCreating(data);

            if (data is DataRowView)
            {
                DataRowView rowDatas = (DataRowView)data;

                if (rowDatas.Row.Table.Columns.Count < 15)
                {
                    for (int i = 0; i < rowDatas.Row.Table.Columns.Count; i++)
                    {
                        string colName = rowDatas.Row.Table.Columns[i].ColumnName;
                        string value = rowDatas[colName].ToString();

                        Label lb = new Label();
                        lb.Width = 200;
                        lb.Margin = new Thickness(4);
                        lb.HorizontalAlignment = HorizontalAlignment.Right;
                        lb.HorizontalContentAlignment = HorizontalAlignment.Right;
                        lb.Foreground = Brushes.White;
                        lb.Content = $"{colName}";
                        mainLabelsStackPanel.Children.Add(lb);

                        TextBox tb = new TextBox();
                        tb.Width = 200;
                        tb.Margin = new Thickness(7);
                        tb.HorizontalAlignment = HorizontalAlignment.Right;
                        tb.Text = $"{value}";
                        mainTextboxsesStackPanel.Children.Add(tb);
                    }
                }
                else
                {
                    for (int i = 0; i < 15; i++)
                    {
                        extra_textboxses1.Visibility = Visibility.Visible;
                        extra_textboxses2.Visibility = Visibility.Visible;
                        string colName = rowDatas.Row.Table.Columns[i].ColumnName;
                        string value = rowDatas[colName].ToString();

                        Label lb = new Label();
                        lb.Width = 200;
                        lb.Margin = new Thickness(4);
                        lb.HorizontalAlignment = HorizontalAlignment.Right;
                        lb.HorizontalContentAlignment = HorizontalAlignment.Right;
                        lb.Foreground = Brushes.White;
                        lb.Content = $"{colName}";
                        mainLabelsStackPanel.Children.Add(lb);

                        TextBox tb = new TextBox();
                        tb.Width = 200;
                        tb.Margin = new Thickness(7);
                        tb.HorizontalAlignment = HorizontalAlignment.Right;
                        tb.Text = $"{value}";
                        mainTextboxsesStackPanel.Children.Add(tb);
                    }
                    for (int i = 15; i < rowDatas.Row.Table.Columns.Count; i++)
                    {
                        string colName = rowDatas.Row.Table.Columns[i].ColumnName;
                        string value = rowDatas[colName].ToString();

                        Label lb = new Label();
                        lb.Width = 200;
                        lb.Margin = new Thickness(4);
                        lb.HorizontalAlignment = HorizontalAlignment.Right;
                        lb.HorizontalContentAlignment = HorizontalAlignment.Right;
                        lb.Foreground = Brushes.White;
                        lb.Content = $"{colName}";
                        extra_textboxsesStackPanel.Children.Add(lb);

                        TextBox tb = new TextBox();
                        tb.Width = 200;
                        tb.Margin = new Thickness(7);
                        tb.HorizontalAlignment = HorizontalAlignment.Right;
                        tb.Text = $"{value}";
                        extra_textboxsesStackPanel2.Children.Add(tb);
                    }
                }
            }

            for (int i = 0; i < 2; i++)
            {
                Label dlb = new Label();
                dlb.Width = 200;
                dlb.Margin = new Thickness(4);
                dlb.HorizontalAlignment = HorizontalAlignment.Center;
                dlb.HorizontalContentAlignment = HorizontalAlignment.Center;
                dlb.Foreground = Brushes.White;
                dlb.Content = $"{data}";
                dateTimeStackPanel.Children.Add(dlb);
                DatePicker dt = new DatePicker();
                dt.Width = 150;
                dt.Margin = new Thickness(5);
                dateTimeStackPanel.Children.Add(dt);
            }

            Label llb = new Label();
            llb.Width = 200;
            llb.Margin = new Thickness(4);
            llb.HorizontalAlignment = HorizontalAlignment.Center;
            llb.HorizontalContentAlignment = HorizontalAlignment.Center;
            llb.Foreground = Brushes.White;
            llb.Content = "asd";
            bigTextboxStackPanel.Children.Add(llb);

            TextBox ltb = new TextBox();
            ltb.Width = 300;
            ltb.Height = 400;
            ltb.AcceptsReturn = true;
            ltb.TextWrapping = TextWrapping.Wrap;
            ltb.VerticalScrollBarVisibility = ScrollBarVisibility.Auto;
            ltb.HorizontalAlignment = HorizontalAlignment.Center;
            ltb.Text = $"{data}";
            bigTextboxStackPanel.Children.Add(ltb);


            //CheckBox tb = new CheckBox();
            //tb.Width = 200;
            //tb.Margin = new Thickness(7);
            //tb.HorizontalAlignment = HorizontalAlignment.Right;
            //CheckBoxStackPanel.Children.Add(tb);

            //bool isChecked = false;

            //if (value == "1" || value.Equals("True", StringComparison.OrdinalIgnoreCase))
            //{
            //    isChecked = true;
            //}
            //tb.IsChecked = isChecked;
        }

        public void DataSortingAndElementCreating(object asd) 
        {
            
        }
        private void ClosedEvent(object sender, EventArgs e)
        {
            mainWindow.Show();
        }
    }
}
