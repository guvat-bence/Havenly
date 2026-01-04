using Google.Protobuf.WellKnownTypes;
using Mysqlx.Expr;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
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
using System.Xml.Linq;

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

        int textBoxCounter = 0;
        int dataCount = 0;
        string variation = "";

        public Datas(object data,string operation, MainWindow mainWindow, Action<DataRowView> saveDatas)
        {
            InitializeComponent();
            this.mainWindow = mainWindow;
            this.Closed += ClosedEvent;
            this.saveDatas = saveDatas;

            this.Height = 660;
            this.Width = 400;


            if (data is DataRowView)
            {
                DataRowView dataRow = (DataRowView)data;

                currentData = dataRow;

                dataCount = dataRow.Row.Table.Columns.Count;
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
            textBoxCounter = dataCount - counter;
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

                switch (colName)
                {
                    case "gender":
                    case "bedroom":
                    case "bed":
                    case "bathroom":
                    case "user_type":
                        tb.MaxLength = 1;
                        break;

                    case "guest_number":
                        tb.MaxLength = 2;
                        break;

                    case "cvv":
                    case "size":
                        tb.MaxLength = 3;
                        break;

                    case "expiration":
                    case "price":
                        tb.MaxLength = 7;
                        break;

                    case "card_number":
                        tb.MaxLength = 19;
                        break;

                    case "first_name":
                    case "last_name":
                    case "middle_name":
                    case "folder_name":
                    case "phone_number":
                    case "password":
                        tb.MaxLength = 40;
                        break;

                    case "name":
                    case "payment_type":
                        tb.MaxLength = 150;
                        break;

                    case "email":
                        tb.MaxLength = 254;
                        break;

                    default:
                        tb.MaxLength = 5;
                        break;
                }


                mainLabelsBorder.Visibility = Visibility.Visible;
                mainTextboxsesBorder.Visibility = Visibility.Visible;
            }

            if (dataCount - textBoxCounter > 0)
            {
                this.Height = 660;
                this.Width = 800;

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
                            ltb.MaxLength = 500;
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
            var response = MessageBox.Show("Biztos szeretne módosítani?", "Adat szerkesztő", MessageBoxButton.YesNo);
            if (response == MessageBoxResult.Yes)
            {
                bool errorType = false;

                if (variation == "checkbox")
                {

                    foreach (var tb in CheckBoxStackPanel.Children.OfType<TextBox>())
                    {
                        string colName = tb.Tag.ToString();

                        try
                        {
                            currentData[colName] = Convert.ToInt32(tb.Text);
                        }
                        catch (Exception)
                        {

                            MessageBox.Show($"Rossz tipusó adatott adott meg a(z) {colName} nevű mezőben!", "Tipus hiba", MessageBoxButton.OK);
                            errorType = true;
                        }
                    }
                    foreach (var cb in CheckBoxStackPanel.Children.OfType<CheckBox>())
                    {
                        string colName = cb.Tag.ToString();
                        if (cb.IsChecked == true)
                        {
                            currentData[colName] = 1;
                        }
                        else
                        {
                            currentData[colName] = 0;
                        }
                    }
                    foreach (var cb in extra_checkboxsesStackPanel.Children.OfType<CheckBox>())
                    {
                        string colName = cb.Tag.ToString();
                        if (cb.IsChecked == true)
                        {
                            currentData[colName] = 1;
                        }
                        else
                        {
                            currentData[colName] = 0;
                        }
                    }
                    if (errorType == false)
                    {
                        MessageBox.Show("Módosítások elmentve!");
                        this.Close();
                        mainWindow.Show();
                        saveDatas?.Invoke(currentData);
                       
                    }
                }
                else
                {
                    foreach (var tb in mainTextboxsesStackPanel.Children.OfType<TextBox>())
                    {
                        string colName = tb.Tag.ToString();
                        try
                        {
                            if ( colName == "price"
                                || colName == "size")
                            {
                                currentData[colName] = Convert.ToInt32(tb.Text);
                            }
                            else
                            {
                                currentData[colName] =tb.Text;
                            }
                        }
                        catch (Exception)
                        {
                            MessageBox.Show($"Rossz tipusó adatott adott meg a(z) {colName} nevű mezőben!", "Tipus hiba", MessageBoxButton.OK);
                            errorType = true;
                        }
                    }

                    if (variation != "")
                    {
                        switch (variation)
                        {
                            case "datetime":
                                foreach (var dt in dateTimeStackPanel.Children.OfType<DatePicker>())
                                {
                                    string colName = dt.Tag.ToString();
                                    currentData[colName] = Convert.ToDateTime(dt.Text);
                                }
                                break;

                            case "description":
                                foreach (var ltb in bigTextboxStackPanel.Children.OfType<TextBox>())
                                {
                                    string colName = ltb.Tag.ToString();
                                    currentData[colName] = ltb.Text;
                                }
                                break;
                        }
                    }
                    if (errorType == false)
                    {
                        MessageBox.Show("Módosítások elmentve!");
                        this.Close();
                        mainWindow.Show();
                        saveDatas?.Invoke(currentData);
                       
                    }
                }
            }
            else
            {
                MessageBox.Show("A módosítások nem lettek elmentve!");
            }
        }

        private void removeButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Módosítások nem lettek elmentve!");
            this.Close();
            mainWindow.Show();
            
        }
        private void ClosedEvent(object sender, EventArgs e)
        {
            mainWindow.Show();
        }
    }
}
