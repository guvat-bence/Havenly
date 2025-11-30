using Google.Protobuf.WellKnownTypes;
using Mysqlx.Expr;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
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
        private Action<DataRowView> saveDatas;
        private DataRowView currentData;

        public Datas(object data,string operation, MainWindow mainWindow, Action<DataRowView> saveDatas)
        {
            InitializeComponent();
            this.mainWindow = mainWindow;
            this.saveDatas = saveDatas;
            this.Closed += ClosedEvent;

            this.Height = 660;
            this.Width = 800;

            if (data is DataRowView)
            {
                DataRowView dataRow = (DataRowView)data;

                currentData = dataRow;

                int dataCount = dataRow.Row.Table.Columns.Count;
                string variation = "";
                int counter = 0;

                for (int i = 0; i < dataCount; i++)
                {
                    var dataType = dataRow.Row.Table.Columns[i].DataType;

                    var dataName = dataRow.Row.Table.Columns[i].ColumnName;

                    if (dataType == typeof(DateTime))
                    {
                        variation = "datetime";
                        counter++;
                    }
                    else if (dataType == typeof(string) && (dataName == "description" || dataName == "apartman_details"))
                    {
                        variation = "description";
                        counter++;
                        break;
                    }
                    else if (dataType == typeof(Boolean))
                    {
                        variation = "checkbox";
                        counter++;
                    }
                }

                this.ElementCreating(dataRow, variation, counter, dataCount, operation);

            }
        }

        public void ElementCreating(DataRowView data, string variation, int counter, int dataCount,string operation)
        {
            int textBoxCounter = dataCount - counter;
            string colName = "";
            string value = "";

            if(operation != "read")
            {
                applyorDeclineBorder.Visibility = Visibility.Visible;
            }


            for (int i = 0; i < textBoxCounter; i++)
            {
                colName = data.Row.Table.Columns[i].ColumnName;
                value = data[colName].ToString();

                Label lb = new Label();
                lb.Width = 200;
                lb.Margin = new Thickness(4);
                lb.Tag = colName;

                lb.Foreground = Brushes.White;
                lb.Content = $"{colName}";

                lb.HorizontalAlignment = HorizontalAlignment.Center;
                lb.HorizontalContentAlignment = HorizontalAlignment.Center;
    
                TextBox tb = new TextBox();
                tb.Width = 200;
                tb.Margin = new Thickness(7);
                tb.HorizontalAlignment = HorizontalAlignment.Right;
                tb.Text = $"{value}";
                tb.Tag = colName;

                if (operation == "read")
                {
                    tb.IsReadOnly = true;
                }

                if (textBoxCounter == 1)
                {
                    CheckBoxStackPanel.Children.Add(tb);
                    CheckBoxLabelsStackPanel.Children.Add(lb);
                }
                else
                {
                    mainTextboxsesStackPanel.Children.Add(tb);
                    mainLabelsStackPanel.Children.Add(lb);
                }
                mainLabelsBorder.Visibility = Visibility.Visible;
                mainTextboxsesBorder.Visibility = Visibility.Visible;
            }

            if (dataCount - textBoxCounter > 0)
            {

                for (int i = textBoxCounter; i < dataCount; i++)
                {
                    colName = data.Row.Table.Columns[i].ColumnName;
                    value = data[colName].ToString();

                    Label lb = new Label();

                    lb.Width = 200;
                    lb.Margin = new Thickness(4);
                    lb.HorizontalAlignment = HorizontalAlignment.Center;
                    lb.HorizontalContentAlignment = HorizontalAlignment.Center;
                    lb.Foreground = Brushes.White;
                    lb.Content = $"{colName}";
                    lb.Tag = colName;

                    switch (variation)
                    {
                        case "datetime":

                            dateTimeStackPanel.Children.Add(lb);
                            DatePicker dp = new DatePicker();
                            dp.Width = 150;
                            dp.SelectedDate = DateTime.Parse(value);
                            dp.Tag = colName;
                            dateTimeStackPanel.Children.Add(dp);
                            dateTimeBorder.Visibility = Visibility.Visible;

                            if (operation == "read")
                            {
                                dp.IsHitTestVisible = false;
                                dp.Focusable = false;
                            }
                            break;

                        case "description":
                           
                            bigTextboxStackPanel.Children.Add(lb);
                            TextBox ltb = new TextBox();
                            ltb.Width = 300;
                            ltb.Height = 400;
                            ltb.AcceptsReturn = true;
                            ltb.TextWrapping = TextWrapping.Wrap;
                            ltb.VerticalScrollBarVisibility = ScrollBarVisibility.Auto;
                            ltb.HorizontalAlignment = HorizontalAlignment.Center;
                            ltb.Text = $"{value}";
                            ltb.Tag = colName;
                            bigTextboxStackPanel.Children.Add(ltb);
                            bigTextboxBorder.Visibility = Visibility.Visible;

                            if (operation == "read")
                            {
                                ltb.IsReadOnly = true;
                            }
                            break;

                        case "checkbox":

                            CheckBox cb = new CheckBox();
                            cb.Margin = new Thickness(8.5);
                            cb.HorizontalAlignment = HorizontalAlignment.Center;
                            cb.Tag = colName;

                            if (i>14)
                            {
                                extra_labelsStackPanel.Children.Add(lb);
                                extra_checkboxsesStackPanel.Children.Add(cb);
                            }
                            else 
                            {
                                CheckBoxLabelsStackPanel.Children.Add(lb);
                                CheckBoxStackPanel.Children.Add(cb);
                            }

                            CheckBoxBorder.Visibility = Visibility.Visible;
                            CheckBoxLabelBorder.Visibility = Visibility.Visible;
                            extra_lables.Visibility = Visibility.Visible;
                            extra_checkboxses.Visibility = Visibility.Visible;

                            if (operation == "read")
                            {
                                cb.IsHitTestVisible = false;
                                cb.Focusable = false;
                            }

                            bool isChecked = false;

                            if (value == "1" || value.Equals("True", StringComparison.OrdinalIgnoreCase))
                            {
                                isChecked = true;
                            }
                            cb.IsChecked = isChecked;
                            break;
                    }
                }
            }
        }

        private void addButton_Click(object sender, RoutedEventArgs e)
        {


            //NIncs készen


            // currentData a már átadott DataRowView
            foreach (var tb in mainTextboxsesStackPanel.Children.OfType<TextBox>())
            {
                string colName = tb.Tag.ToString();
                currentData[colName] = tb.Text;
            }

            // ... ugyanígy a többi elem

            saveDatas?.Invoke(currentData);
            this.Close();
        }

        private void removeButton_Click(object sender, RoutedEventArgs e)
        {

        }
        private void ClosedEvent(object sender, EventArgs e)
        {
            mainWindow.Show();
        }
    }
}
