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
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }
        private void experience_button_Click(object sender, RoutedEventArgs e)
        {
        }

        private void citybtn_Click(object sender, RoutedEventArgs e)
        {
            readData("city");
            saveOrCancle();
            citybtn.IsEnabled = false;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = true;
            accommodationbtn.IsEnabled = true;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = true;
        }

        private void detailsbtn_Click(object sender, RoutedEventArgs e)
        {
            readData("apartman_details");
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = false;
            countrybtn.IsEnabled = true;
            accommodationbtn.IsEnabled = true;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = true;
        }

        private void countrybtn_Click(object sender, RoutedEventArgs e)
        {
            readData("country");
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = false;
            accommodationbtn.IsEnabled = true;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = true;
        }

        private void experience_button_Click_1(object sender, RoutedEventArgs e)
        {
            readData("experiences");
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = true;
            accommodationbtn.IsEnabled = true;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = false;
        }

        private void favouritebtn_Click(object sender, RoutedEventArgs e)
        {
            readData("favourite");
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = true;
            accommodationbtn.IsEnabled = true;
            favouritebtn.IsEnabled = false;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = true;
        }

        private void historybtn_Click(object sender, RoutedEventArgs e)
        {
            readData("history");
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = true;
            accommodationbtn.IsEnabled = true;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = false;
            experience_button.IsEnabled = true;
        }

        private void usersbtn_Click(object sender, RoutedEventArgs e)
        {
            readData("users");
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = true;
            accommodationbtn.IsEnabled = true;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = false;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = true;
        }

        private void accommodationbtn_Click(object sender, RoutedEventArgs e)
        {
            readData("apartmans");
            citybtn.IsEnabled = true;
            detailsbtn.IsEnabled = true;
            countrybtn.IsEnabled = true;
            accommodationbtn.IsEnabled = false;
            favouritebtn.IsEnabled = true;
            usersbtn.IsEnabled = true;
            historybtn.IsEnabled = true;
            experience_button.IsEnabled = true;
        }

        
    }
}