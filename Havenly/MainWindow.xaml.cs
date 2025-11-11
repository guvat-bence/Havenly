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
            readData("users");
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
    }
}