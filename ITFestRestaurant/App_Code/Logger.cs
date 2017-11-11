using System;
using System.IO;
using System.Reflection;
using System.Web;

public class Logger
{
    public static string LogFileName { get; set; }

    public static void LogError(string error)
    {
        Logger.LogError(error, LogType.Error);
    }

    public static void LogError(string error, Exception ex)
    {
        Logger.LogError(error, ex, LogType.Error);
    }

    internal static void LogError(MethodBase mb, Exception ex)
    {
        Logger.LogError(string.Format("[{0}][{1}]", mb.DeclaringType, mb.Name), ex, LogType.Error);
    }

    internal static void LogError(MethodBase mb, string error)
    {
        Logger.LogError(string.Format("[{0}][{1}] - {2}", mb.DeclaringType, mb.Name, error), LogType.Error);
    }

    public static void LogError(string error, Exception ex, LogType LogType)
    {
        if (ex != null)
            error += " " + ex.Message;

        LogError(error, LogType);
    }

    public static void LogError(string error, LogType LogType)
    {
        if (!AppConfiguration.LogEnabled)
            return;

        if (LogFileName == null)
            LogFileName = string.Empty;

        try
        {
            if (string.IsNullOrEmpty(LogFileName) || !File.Exists(LogFileName))
            {
                if (!Directory.Exists(string.Format("{0}\\Logs", AppConfiguration.ApplicationPath)))
                    Directory.CreateDirectory(string.Format("{0}\\Logs", AppConfiguration.ApplicationPath));

                Logger.LogFileName = string.Format("{0}\\Logs\\{1}_log.txt", AppConfiguration.ApplicationPath, DateTime.Now.ToString("yyyyMMdd"));
                FileStream fs = File.Create(LogFileName);
                fs.Close();
            }

            lock (LogFileName)
                using (StreamWriter sw = new StreamWriter(LogFileName, true))
                {
                    string url = "";

                    sw.WriteLine(string.Format("[{0:dd-MM-yyyy HH:mm:ss}] [{1}] [{2}] {3}", DateTime.Now, AppConfiguration.AppVersion, LogType, error));
                    sw.Close();

                    if (HttpContext.Current != null && HttpContext.Current.Request != null)
                        url = HttpContext.Current.Request.Url.ToString();

                    sw.WriteLine(string.Format("[{0} {1} {2}]", url, HttpContext.Current.Request.UserHostAddress, HttpContext.Current.User.Identity.Name));
                    sw.WriteLine(error);
                    sw.WriteLine("");
                }
        }
        catch { }
    }

    public enum LogType
    {
        Error,
        Debug,
        Info,
        Warning,
        ExecutedQuery
    }
}
