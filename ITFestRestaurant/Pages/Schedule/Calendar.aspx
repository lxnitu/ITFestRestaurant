<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="ITFestRestaurant.Pages.Schedule.Calendar" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.XtraScheduler.v17.1.Core, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dxwschs:ASPxScheduler ID="ASPxScheduler1" runat="server" AppointmentDataSourceID="SqlDataSource1" ClientIDMode="AutoID" DataMember="" DataSourceID="" Start="2017-11-11" Theme="Metropolis" ResourceDataSourceID="SqlDataSource2" >
        <Storage>
            <Appointments AutoRetrieveId="True">
                <Mappings AppointmentId="ID" Description="Description" End="EndDate" Location="TableName" 
                    OriginalOccurrenceEnd="OriginalOccurenceEnd" OriginalOccurrenceStart="OriginalOccurenceStart" ResourceId="idResource" Start="StartDate" Subject="Name" />
                <CustomFieldMappings>
                    <dxwschs:ASPxAppointmentCustomFieldMapping Member="NumberOfPersons" Name="NumberOfPersons" />
                </CustomFieldMappings>
            </Appointments>
            <Resources>
                <Mappings Caption="Caption" Color="Color" ResourceId="ID" />
            </Resources>
        </Storage>
        <Views>
            <DayView>
                <TimeRulers>
                    <cc1:TimeRuler>
                    </cc1:TimeRuler>
                </TimeRulers>
                <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4">
                </AppointmentDisplayOptions>
            </DayView>
            <WorkWeekView>
                <TimeRulers>
                    <cc1:TimeRuler>
                    </cc1:TimeRuler>
                </TimeRulers>
                <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4">
                </AppointmentDisplayOptions>
            </WorkWeekView>
            <WeekView Enabled="false">
            </WeekView>
            <FullWeekView Enabled="true">
                <TimeRulers>
                    <cc1:TimeRuler>
                    </cc1:TimeRuler>
                </TimeRulers>
                <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4">
                </AppointmentDisplayOptions>
            </FullWeekView>
        </Views>
        <%--<OptionsForms AppointmentFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/CustomAppointmentForm.ascx" 
            AppointmentInplaceEditorFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/InplaceEditor.ascx" 
            GotoDateFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/GotoDateForm.ascx" 
            RecurrentAppointmentDeleteFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/RecurrentAppointmentDeleteForm.ascx" 
            RecurrentAppointmentEditFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/RecurrentAppointmentEditForm.ascx" 
            RemindersFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/ReminderForm.ascx" />
        <OptionsToolTips AppointmentDragToolTipUrl="~/DevExpress/ASPxSchedulerForms/AppointmentDragToolTip.ascx" 
            AppointmentToolTipUrl="~/DevExpress/ASPxSchedulerForms/AppointmentToolTip.ascx" 
            SelectionToolTipUrl="~/DevExpress/ASPxSchedulerForms/SelectionToolTip.ascx" />--%>
    </dxwschs:ASPxScheduler>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT [ID], [Caption], [Color] FROM [tblAppointmentsResources]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="SELECT * FROM [tblAppointments]" 
        DeleteCommand="DELETE FROM [tblAppointments] WHERE [ID] = @ID" 
        InsertCommand="INSERT INTO [tblAppointments] ([idMessage], [Name], [StartDate], [EndDate], [NumberOfPersons], [idTable], [Label], [TableName], [OriginalOccurenceEnd], [OriginalOccurenceStart], [Type], [idResource], [Status], [Description]) VALUES (@idMessage, @Name, @StartDate, @EndDate, @NumberOfPersons, @idTable, @Label, @TableName, @OriginalOccurenceEnd, @OriginalOccurenceStart, @Type, @idResource, @Status, @Description)" 
        UpdateCommand="UPDATE [tblAppointments] SET [idMessage] = @idMessage, [Name] = @Name, [StartDate] = @StartDate, [EndDate] = @EndDate, [NumberOfPersons] = @NumberOfPersons, [idTable] = @idTable, [Label] = @Label, [TableName] = @TableName, [OriginalOccurenceEnd] = @OriginalOccurenceEnd, [OriginalOccurenceStart] = @OriginalOccurenceStart, [Type] = @Type, [idResource] = @idResource, [Status] = @Status, [Description] = @Description WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="idMessage" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="StartDate" />
            <asp:Parameter DbType="DateTime2" Name="EndDate" />
            <asp:Parameter Name="NumberOfPersons" Type="Int16" />
            <asp:Parameter Name="idTable" Type="Int32" />
            <asp:Parameter Name="Label" Type="String" />
            <asp:Parameter Name="TableName" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="OriginalOccurenceEnd" />
            <asp:Parameter DbType="DateTime2" Name="OriginalOccurenceStart" />
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="idResource" Type="Int32" />
            <asp:Parameter Name="Status" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="InsertDate" Type="DateTime" />
            <asp:Parameter Name="idMessage" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="StartDate" />
            <asp:Parameter DbType="DateTime2" Name="EndDate" />
            <asp:Parameter Name="NumberOfPersons" Type="Int16" />
            <asp:Parameter Name="idTable" Type="Int32" />
            <asp:Parameter Name="Label" Type="String" />
            <asp:Parameter Name="TableName" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="OriginalOccurenceEnd" />
            <asp:Parameter DbType="DateTime2" Name="OriginalOccurenceStart" />
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="idResource" Type="Int32" />
            <asp:Parameter Name="Status" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>