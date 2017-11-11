using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;

public class Utils
{
    public class ModifyStrings
    {
        /// <summary>
        /// Normalize a string to be valid for a regex search.
        /// </summary>
        /// <param name="text">String to be normalized</param>
        public static string NormalizeForRegex(string text)
        {
            if (string.IsNullOrEmpty(text))
                text = string.Empty;
            text = text.Replace("]", "[]]").Replace("[", "[[]");
            text = text.Replace("*", "/").Replace(".", "[.]");
            text = text.Replace(@"\", @"[\\]").Replace("{", "[{]").Replace("}", "[}]");
            text = text.Replace("+", "[+]").Replace("|", "[|]").Replace("?", "[?]");

            if (text == string.Empty)
                text = ".*";
            text = "^" + text.Replace("/", ".*") + "$";
            while (text.Contains(".*.*"))
                text = text.Replace(".*.*", ".*");

            return text;
        }

        public static string NormalizeForLIKE(string text)
        {
            if (string.IsNullOrEmpty(text))
                text = string.Empty;
            text = text.Replace("[", "[[]");
            text = text.Replace("*", "/").Replace(".", "[.]");
            text = text.Replace(@"\", @"[\\]").Replace("{", "[{]").Replace("}", "[}]");
            text = text.Replace("+", "[+]").Replace("|", "[|]").Replace("?", "[?]");
            text = text.Replace("_", "[_]");

            if (text == string.Empty)
                text = "%";
            text = text.Replace("/", "%");
            return text;
        }

        public static string NormalizeForLIKEInFilterPredicate(string text)
        {
            if (string.IsNullOrEmpty(text))
                text = "%";
            text = text.Replace("[", "[[]");
            text = text.Replace("*", "/").Trim();
            text = text.Replace("/", "%");
            return text;
        }

        public static string GetFilterString(string filter, string field)
        {
            filter = NormalizeForLIKE(filter);
            List<string> filters = filter.Split(new char[1] { '%' }, StringSplitOptions.RemoveEmptyEntries).ToList();

            if (filters.Count == 0)
                return field + " LIKE '%' ";

            for (int i = 0; i < filters.Count; i++)
            {
                if (i == 0 && !filter.StartsWith("%"))
                    filters[i] = string.Format(" {0} LIKE '{1}%'", field, filters[i]);
                else if (i == filters.Count - 1 && !filter.EndsWith("%"))
                    filters[i] = string.Format(" {0} LIKE '%{1}'", field, filters[i]);
                else
                    filters[i] = string.Format(" {0} LIKE '%{1}%'", field, filters[i]);
            }
            return string.Format("({0})", string.Join(" AND ", filters.ToArray()));
        }

        public static string GetCellName(string rowIndex, int column, int floor, int? storagePosition, string format)
        {
            if (format.Contains("{1:CHAR}"))
                format = format.Replace("{1:CHAR}", ((char)(column + 65)).ToString());
            if (format.Contains("{2:CHAR}"))
                format = format.Replace("{2:CHAR}", ((char)(floor + 65)).ToString());
            if (format.Contains("{3:CHAR}") && storagePosition != null)
                format = format.Replace("{3:CHAR}", ((char)(storagePosition + 65)).ToString());

            format = format.Replace(":CHAR", string.Empty);

            if (storagePosition != null)
                return string.Format(format, rowIndex, column, floor, storagePosition.Value);
            else
                return string.Format(format, rowIndex, column, floor, string.Empty);
        }
    }

    public static void SendEmail(string message, string to)
    {
        SmtpClient SmtpServer = new SmtpClient(ConfigurationManager.AppSettings["EmailServer"]);
        var mail = new MailMessage();
        mail.From = new MailAddress(ConfigurationManager.AppSettings["EmailSender"]);
        mail.To.Add(to);
        mail.Subject = "About Your Rezervation";
        mail.IsBodyHtml = true;

        mail.Body = message;
        SmtpServer.Port = 587;
        SmtpServer.UseDefaultCredentials = false;
        SmtpServer.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["EmailSender"], ConfigurationManager.AppSettings["EmailSenderPassword"]);
        SmtpServer.EnableSsl = true;
        SmtpServer.Send(mail);
    }
}