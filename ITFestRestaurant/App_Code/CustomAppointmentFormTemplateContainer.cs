using DevExpress.Web.ASPxScheduler;
using DevExpress.XtraScheduler;

public class CustomAppointmentFormTemplateContainer : AppointmentFormTemplateContainer
{
    public int idTable { get; set; }

    public int idMessage { get; set; }

    public CustomAppointmentFormTemplateContainer(ASPxScheduler control)
        : base(control)
    {

    }

    public CustomAppointmentFormTemplateContainer(ASPxScheduler control, Appointment apt)
        : base(control, apt)
    {

    }
}

public class CustomAppointmentFormController : DevExpress.Web.ASPxScheduler.Internal.AppointmentFormController
{
    public CustomAppointmentFormController(ASPxScheduler control, Appointment apt) : 
        base(control, apt)
    {
    }
}

public class CustomAppointmentFormSaveCallbackCommand : DevExpress.Web.ASPxScheduler.Internal.AppointmentFormSaveCallbackCommand
{
    public CustomAppointmentFormSaveCallbackCommand(ASPxScheduler control) : base(control)
    {
    }
}