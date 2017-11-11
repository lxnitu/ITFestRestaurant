using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using Microsoft.AspNet.Identity;
using System.Data.SqlClient;
using System.Data.Common;
using System.Data;

namespace ITFestRestaurant
{
    public partial class RootMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxLabel2.Text = DateTime.Now.Year + Server.HtmlDecode("");
        }
        protected void HeadLoginStatus_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }

        protected void NotificationsTime_Tick(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = AppConfiguration.DatabaseConnectionString)
            using (SqlCommand cmd = new SqlCommand(@"SELECT * FROM tblAppointments WHERE InsertDate > DATEADD(SECOND, -15, GETDATE())", con))
            {
                try
                {
                    con.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                    adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    Logger.LogError(System.Reflection.MethodBase.GetCurrentMethod(), "[RegisterAppointment] - Eroare la salvarea mesajului. Mesaj: " + ex.Message);
                }
                finally
                {
                    if (con.State == System.Data.ConnectionState.Open)
                        con.Close();
                }
            }

            if (dt != null)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string message = string.Format("notifyMe('New appointment from {0} for {1}.')", dr.Field<string>("Name"), dr.Field<DateTime>("StartDate").ToString("dd.MM HH:mm"));
                    ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", message, true);
                }
            }
        }
    }
}