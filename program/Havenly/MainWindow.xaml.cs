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
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
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
            readData("experience");
            enable_btns();
            experience_button.IsEnabled = false;
        }

        private void citybtn_Click(object sender, RoutedEventArgs e)
        {
            readData("city");
            enable_btns();
            citybtn.IsEnabled = false;
        }

        private void detailsbtn_Click(object sender, RoutedEventArgs e)
        {
            readData("apartman_details");
            enable_btns();
            detailsbtn.IsEnabled = false;

        }

        private void countrybtn_Click(object sender, RoutedEventArgs e)
        {
            readData("country");
            enable_btns();
            countrybtn.IsEnabled = false;
        }

        private void experience_button_Click_1(object sender, RoutedEventArgs e)
        {
            readData("experiences");
            enable_btns();
            experience_button.IsEnabled = false;
        }

        private void favouritebtn_Click(object sender, RoutedEventArgs e)
        {
            readData("favourite");
            enable_btns();
            favouritebtn.IsEnabled = false;
        }

        private void historybtn_Click(object sender, RoutedEventArgs e)
        {
            readData("rents");
            enable_btns();
            historybtn.IsEnabled = false;
        }

        private void usersbtn_Click(object sender, RoutedEventArgs e)
        {
            readData("users");
            enable_btns();
            usersbtn.IsEnabled = false;
        }

        private void accommodationbtn_Click(object sender, RoutedEventArgs e)
        {
            readData("apartmans");
            enable_btns();
            accommodationbtn.IsEnabled = false;

        }

        string operation = "";
        bool isCommitting = false;
        int watcher = 0;

        private void editButton_Click(object sender, RoutedEventArgs e)
        {
            saveOrCancle();
            datagrid0.IsReadOnly = false;
            operation = "edit";
            watcher = 0;

        }

        private void addButton_Click(object sender, RoutedEventArgs e)
        {
            saveOrCancle();
            datagrid0.IsReadOnly = false;
            datagrid0.CanUserAddRows = true;
            operation = "add";
            watcher = 0;

            DataTable dt = (datagrid0.ItemsSource as DataView).Table;
            dt.Rows.Clear();
        }

        private void removeButton_Click(object sender, RoutedEventArgs e)
        {
            saveOrCancle();
            datagrid0.IsReadOnly = false;
            datagrid0.CanUserDeleteRows = true;
            operation = "delete";
            watcher = 0;
        }

        
        // AZ adatbázisba méég nem tölti fel a változtatásokat.


        private void datagrid0_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {
            if (operation == "edit")
            {
                if (!isCommitting)
                {
                    isCommitting = true;
                    datagrid0.CommitEdit(DataGridEditingUnit.Row, true);
                    isCommitting = false;
                    watcher += 1;
                }

                if (e.Row.Item is DataRowView && watcher == 1)
                {
                    DataRowView datas = (DataRowView)e.Row.Item;

                    var response = MessageBox.Show("Biztos szeretné módosítani a sort?", "Adat szerkesztő", MessageBoxButton.YesNo);
                    if (response == MessageBoxResult.Yes)
                    {
                        MessageBox.Show("Módosítások elmentve!");
                        enable_btns();
                    }
                    else
                    {
                        datas.CancelEdit();
                        MessageBox.Show("A módosítások nem lettek elmentve!");
                        enable_btns();
                    }
                }
            }
            else if (operation == "add")
            {
                if (!isCommitting)
                {
                    isCommitting = true;
                    datagrid0.CommitEdit(DataGridEditingUnit.Row, true);
                    isCommitting = false;
                    watcher += 1;
                }

                if (e.Row.Item is DataRowView && watcher == 1)
                {
                    DataRowView datas = (DataRowView)e.Row.Item;

                    var response = MessageBox.Show("Biztos szeretné felvinni az adatokat?", "Adat szerkesztő", MessageBoxButton.YesNo);
                    if (response == MessageBoxResult.Yes)
                    {
                        MessageBox.Show("Módosítások elmentve!");
                        enable_btns();
                    }
                    else
                    {
                        datas.CancelEdit();
                        MessageBox.Show("A módosítások nem lettek elmentve!");
                        enable_btns();
                    }
                }
            }
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
                        datas.Delete();
                        MessageBox.Show("Módosítások elmentve!");
                        enable_btns();
                    }
                    else
                    {
                        e.Handled = true;
                        MessageBox.Show("A módosítások nem lettek elmentve!");
                        enable_btns();
                    }
                }
            }
        }
    }
}