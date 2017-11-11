using DevExpress.Web.ASPxScheduler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITFestRestaurant.Pages.Schedule
{
    public partial class Calendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        //protected void ASPxScheduler1_AppointmentFormShowing(object sender, DevExpress.Web.ASPxScheduler.AppointmentFormEventArgs e)
        //{
        //    e.Container = new CustomAppointmentFormTemplateContainer((ASPxScheduler)sender);
        //}

        //protected void ASPxScheduler1_BeforeExecuteCallbackCommand(object sender, SchedulerCallbackCommandEventArgs e)
        //{
        //    if (e.CommandId == SchedulerCallbackCommandId.AppointmentSave)
        //    {
        //        e.Command = new CustomAppointmentFormSaveCallbackCommand((ASPxScheduler)sender);
        //    }
        //}
    }
}