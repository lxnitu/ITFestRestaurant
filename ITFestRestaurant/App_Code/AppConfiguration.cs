using System.IO;
using System;
using System.Web.Hosting;
using System.Data.SqlClient;
using System.Configuration;

internal class AppConfiguration
{
    private static bool m_LogEnabled;

    public static String LogFilePath
    {
        get
        {
            string path = Path.Combine(HostingEnvironment.ApplicationPhysicalPath, @"Logs/Logs.txt");

            if (!System.IO.File.Exists(path))
            {
                try
                {
                    File.Create(path);
                    Logger.LogError("Log file created successfully", Logger.LogType.Info);
                }
                catch
                {
                    LogEnabled = false;
                }
            }

            return path;
        }
    }

    public static string ApplicationPath
    {
        get
        {
            return Path.Combine(HostingEnvironment.ApplicationPhysicalPath);
        }
    }

    public static object AppVersion { get { return "1.0.0.0"; } }

    public static bool LogEnabled { get { return m_LogEnabled; } set { m_LogEnabled = value; } }

    public static string ApplicationName { get { return "Grocery Store"; } }

    public static SqlConnection DatabaseConnectionString { get
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
        }
    }
}