using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Serialization;
using System.ServiceModel;
using System;
using System.Net.Http;
using System.Text;
using System.IO;
using Microsoft.Azure.CognitiveServices.Language.TextAnalytics;
using Microsoft.Azure.CognitiveServices.Language.TextAnalytics.Models;

namespace ITFestRestaurant
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "AppointmentsService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select AppointmentsService.svc or AppointmentsService.svc.cs at the Solution Explorer and start debugging.
    public class AppointmentsService : IAppointmentsService
    {
        public void RegisterAppointment(string message)
        {
            if (string.IsNullOrEmpty(message))
                return;

            QueueAppointment app = null;

            try
            {
                app = Newtonsoft.Json.JsonConvert.DeserializeObject<QueueAppointment>(message);
            }
            catch (Exception ex)
            {
                Logger.LogError(System.Reflection.MethodBase.GetCurrentMethod(), string.Format("[RegisterAppointment] - Eroare la parsarea mesajului. Mesaj: {0}. Eroare: {1}.", message, ex.Message));
                return;
            }

            SqlParameter response = new SqlParameter("@Response", System.Data.SqlDbType.NVarChar);
            response.Direction = System.Data.ParameterDirection.Output;
            response.Size = int.MaxValue;

            SqlParameter responseMessage = new SqlParameter("@ResponseMessage", System.Data.SqlDbType.NVarChar);
            responseMessage.Direction = System.Data.ParameterDirection.Output;
            responseMessage.Size = int.MaxValue;

            SqlParameter messageID = new SqlParameter("@MessageID", System.Data.SqlDbType.Int);
            messageID.Direction = System.Data.ParameterDirection.Output;

            using (SqlConnection con = AppConfiguration.DatabaseConnectionString)
            using (SqlCommand cmd = new SqlCommand(@"EXEC sp_RegisterAppointmentMessage 
	            @RequestedDate = @RequestedDate,
	            @Email = @Email,
	            @Message = @Message,
	            @EmailID = @EmailID,
	            @Name = @Name,
	            @NumberOfPersons = @NumberOfPersons,
	            @GoodCustomer = @GoodCustomer,
	            @Response = @Response OUTPUT, 
	            @ResponseMessage = @ResponseMessage OUTPUT, 
	            @MessageID = @MessageID OUTPUT", con))
            {
                cmd.Parameters.Add(new SqlParameter("@RequestedDate", app.date));
                cmd.Parameters.Add(new SqlParameter("@Email", app.email));
                cmd.Parameters.Add(new SqlParameter("@Message", app.message));
                cmd.Parameters.Add(new SqlParameter("@EmailID", DBNull.Value));
                cmd.Parameters.Add(new SqlParameter("@Name", DBNull.Value));
                cmd.Parameters.Add(new SqlParameter("@NumberOfPersons", DBNull.Value));


                ITextAnalyticsAPI client = new TextAnalyticsAPI();
                client.AzureRegion = AzureRegions.Westeurope;
                client.SubscriptionKey = "fcd70fa96095470fa5c7ec05f3a56d60";

                Console.OutputEncoding = System.Text.Encoding.UTF8;

                SentimentBatchResult result3 = client.Sentiment(
                    new MultiLanguageBatchInput(
                        new List<MultiLanguageInput>()
                        {
                          new MultiLanguageInput("en", "0", app.message),
                        }));

                try
                {
                    if (result3 != null && result3.Documents.Count > 0)
                        cmd.Parameters.Add(new SqlParameter("@GoodCustomer", result3.Documents[0].Score > 0.5));
                    else
                        cmd.Parameters.Add(new SqlParameter("@GoodCustomer", DBNull.Value));
                }
                catch
                {
                    cmd.Parameters.Add(new SqlParameter("@GoodCustomer", DBNull.Value));
                }

                cmd.Parameters.Add(response);
                cmd.Parameters.Add(responseMessage);
                cmd.Parameters.Add(messageID);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    if (responseMessage.Value != null)
                        Utils.SendEmail(responseMessage.Value.ToString(), app.email);
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

            Logger.LogError(System.Reflection.MethodBase.GetCurrentMethod(), "[RegisterAppointment] - Raspuns: " + responseMessage.Value);
        }
    }
}