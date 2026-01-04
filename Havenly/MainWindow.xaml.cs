using System.Data;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;

namespace Havenly
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        MySql.Data.MySqlClient.MySqlConnection connection = new MySql.Data.MySqlClient.MySqlConnection("server=localhost;database=havenly;uid=root;password=''");
        MySql.Data.MySqlClient.MySqlCommand command;
        public MainWindow()
        {
            InitializeComponent();


            addButton.IsEnabled = false;
            editButton.IsEnabled = false;
            removeButton.IsEnabled = false;
            datagrid0.IsReadOnly = true;
            datagrid0.CanUserAddRows = false;
            datagrid0.CanUserDeleteRows = false;
        }

        public void openConnection()
        {
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
        }

        public void closeConnection()
        {
            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }
        }

        public void saveOrCancle()
        {

            citybtn.IsEnabled = false;
            detailsbtn.IsEnabled = false;
            countrybtn.IsEnabled = false;
            accommodationbtn.IsEnabled = false;
            favouritebtn.IsEnabled = false;
            usersbtn.IsEnabled = false;
            historybtn.IsEnabled = false;
            experience_button.IsEnabled = false;
            addButton.IsEnabled = false;
            editButton.IsEnabled = false;
            removeButton.IsEnabled = false;
        }

        string currentTable = "";
        public void readData(string tableName)
        {
            try
            {
                MySql.Data.MySqlClient.MySqlDataAdapter adapter = new MySql.Data.MySqlClient.MySqlDataAdapter($"SELECT * FROM {tableName}", connection);
                openConnection();
                DataSet ds = new DataSet();
                adapter.Fill(ds);
                datagrid0.ItemsSource = ds.Tables[0].DefaultView;


                addButton.IsEnabled = true;
                editButton.IsEnabled = true;
                removeButton.IsEnabled = true;
                operation = "read";
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }

        public void executeQuery(string query) 
        {
            try
            {
                openConnection();
                MySqlCommand command = new MySqlCommand(query, connection);

                if(command.ExecuteNonQuery()>=1) 
                {
                    MessageBox.Show("Sikeresen végrehajtva");
                }
                else
                {
                    MessageBox.Show("Nem lett végrehajtva!");
                }
            }
            catch (Exception e)
            {

                MessageBox.Show(e.Message);
            }
            finally
            {
                closeConnection();
            }
        }

        private void enable_btns()
        {
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = true;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = true;
            accommodationbtn.IsEnabled = true;
            datagrid0.IsReadOnly = true;
        }
        private void experience_button_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "experience";
            readData("experience");
            enable_btns();
            experience_button.IsEnabled = false;
        }

        private void citybtn_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "cities";
            readData("cities");
            enable_btns();
            citybtn.IsEnabled = false;
        }

        private void detailsbtn_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "accommodations_details";
            readData("accommodations_details");
            enable_btns();
            detailsbtn.IsEnabled = false;

        }

        private void countrybtn_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "countries";
            readData("countries");
            enable_btns();
            countrybtn.IsEnabled = false;
        }

        private void experience_button_Click_1(object sender, RoutedEventArgs e)
        {
            currentTable = "experiences";
            readData("experiences");
            enable_btns();
            experience_button.IsEnabled = false;
        }

        private void favouritebtn_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "favourite";
            readData("favourite");
            enable_btns();
            favouritebtn.IsEnabled = false;
        }

        private void historybtn_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "history";
            readData("history");
            enable_btns();
            historybtn.IsEnabled = false;
        }

        private void usersbtn_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "users";
            readData("users");
            enable_btns();
            usersbtn.IsEnabled = false;
        }

        private void accommodationbtn_Click(object sender, RoutedEventArgs e)
        {
            currentTable = "accommodations";
            readData("accommodations");
            enable_btns();
            accommodationbtn.IsEnabled = false;

        }

        string operation = "";
        private void editButton_Click(object sender, RoutedEventArgs e)
        {
            saveOrCancle();
            datagrid0.IsReadOnly = true;
            operation = "edit";
        }

        private void addButton_Click(object sender, RoutedEventArgs e)
        {
            saveOrCancle();
            datagrid0.IsReadOnly = false;
            datagrid0.CanUserAddRows = true;
            operation = "add";
         
            DataTable dt = (datagrid0.ItemsSource as DataView).Table;
            dt.Rows.Clear();
        }

        private void removeButton_Click(object sender, RoutedEventArgs e)
        {
            saveOrCancle();
            datagrid0.IsReadOnly = true;
            datagrid0.CanUserDeleteRows = true;
            operation = "delete";
        }
        private void datagrid0_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (operation == "delete" && e.Key == Key.Delete)
            {
                if (datagrid0.SelectedItem is DataRowView)
                {
                    DataRowView datas = (DataRowView)datagrid0.SelectedItem;

                    var response = MessageBox.Show("Biztos szeretné kitörölni a sort?", "Adat szerkesztő", MessageBoxButton.YesNo);
                    if (response == MessageBoxResult.Yes)
                    {
                        string deletingDatas = $"DELETE FROM {currentTable} WHERE {datas.Row.Table.Columns[0].ColumnName} = {datas[0]}";
                        executeQuery(deletingDatas);
               
                        MessageBox.Show("Módosítások elmentve!");
                        enable_btns();
                     
                    }
                    else
                    {
                        MessageBox.Show("A módosítások nem lettek elmentve!");
                        enable_btns();
                    }
                }
            }
        }

        public void datagrid0_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if(datagrid0.CurrentColumn != null && operation != "delete")
            {
                Datas dataWin = new Datas(datagrid0.SelectedItem, operation, this,saveEditedRow);
                dataWin.Show();
                this.Hide();

                if (operation != "read")
                {
                    //datagrid0.ItemsSource = null;
                    enable_btns();
                }
            }
        }
        public void saveEditedRow(DataRowView row)
        {

            List<string> columns = new List<string>();
            List<string> values = new List<string>();

            for (int i = 0; i < row.Row.Table.Columns.Count; i++)
            {
                columns.Add(row.Row.Table.Columns[i].ColumnName);
                object value = row[i];

                if (value == null || value == DBNull.Value)
                {
                    values.Add("NULL");
                }
                else if (value is string || value is DateTime)
                {
                    string converted = value.ToString().Replace("'", "''");
                    values.Add($"'{converted}'");
                }
                else
                {
                    values.Add(value.ToString());
                }
            }
            switch (operation) 
            {
                case "add":

                    string newDatas = $"INSERT INTO {currentTable} ({string.Join(",", columns)})" +
                                      $"VALUES ({string.Join(",", values)})";

                    executeQuery(newDatas);

                    break;

                case "edit":

                    var datasWithName = columns.Select((col, index) => $"{col} = {values[index]}");

                    string editedDatas = $"UPDATE {currentTable} SET {string.Join(",", datasWithName)}" +
                                         $"WHERE {columns[0]} = {values[0]}";

                    executeQuery(editedDatas);
                    break;
            }
        }
    }
}