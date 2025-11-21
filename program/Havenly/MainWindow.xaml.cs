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
            optionBorder.Visibility = Visibility.Visible;
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

        private void editButton_Click(object sender, RoutedEventArgs e)
        {
            saveOrCancle();
           
        }

        private void approveButon_Click(object sender, RoutedEventArgs e)
        {

        }

        private void declineButton_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}