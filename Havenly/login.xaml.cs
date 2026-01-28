using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics.Metrics;
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
    /// Interaction logic for login.xaml
    /// </summary>
    public partial class login : Window
    {
        MySql.Data.MySqlClient.MySqlConnection connection = new MySql.Data.MySqlClient.MySqlConnection("server=localhost;database=havenly;uid=root;password=''");
        MySql.Data.MySqlClient.MySqlCommand command;

        public login()
        {
            InitializeComponent();
            loginButton.IsEnabled = false;
          
        }

        int counter = 0;

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

        private void loginButton_Click(object sender, RoutedEventArgs e)
        {

            try
            {
                MySql.Data.MySqlClient.MySqlDataAdapter adapter = new MySql.Data.MySqlClient.MySqlDataAdapter($"SELECT `user_type` FROM `users` WHERE `email` = '{emailTextBox.Text}' AND `password` = '{passwordTextBox.Text}'", connection);
                openConnection();
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string userType = ds.Tables[0].Rows[0]["user_type"].ToString();

                    if(userType != "A")
                    {
                        MessageBox.Show("Önnek nincsen jogosultsága belépni!");
                        this.Close();
                    }
                    else
                    {
                        MessageBox.Show("Sikeres bejelentkezés!");
                        MainWindow mw = new MainWindow();
                        mw.Show();
                        this.Close();
                    }
                }
                else
                {
                    MessageBox.Show("Hibás email vagy jelszó!");
                    emailTextBox.Text = "";
                    passwordTextBox.Text = "";
                }

            }
            catch (Exception error)
            {
                MessageBox.Show(error.Message);
            }
        }

        private void emailTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            string email = emailTextBox.Text;
            if (email.Contains("@") && counter == 0)
            {
                counter++;
            }
            if (email.Contains("@") && emailTextBox.Text.Count() > 0 && passwordTextBox.Text.Count() > 0)
            {
                loginButton.IsEnabled = true;
            }
            else
            {
                loginButton.IsEnabled = false;
            }

        }

        private void passwordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (counter == 1)
            {
                counter++;
            }
            if (counter == 2 && emailTextBox.Text.Count() > 0 && passwordTextBox.Text.Count() > 0)
            {
                loginButton.IsEnabled = true;
            }
            else
            {
                loginButton.IsEnabled = false;
            }
        }
    }
}
