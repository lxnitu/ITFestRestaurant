<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="ITFestRestaurant.Pages.Schedule.Messages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" Theme="Metropolis" Width="100%">
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsDataSecurity AllowInsert="False" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="InsertDate" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="EmailAddress" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="RezervationDate" VisibleIndex="4">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="MessageBody" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NumberOfPersons" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Confirmed" VisibleIndex="7">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="Processed" VisibleIndex="8">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataDateColumn FieldName="ProcessingDate" VisibleIndex="9">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="EmailID" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT * FROM [tblMessages]" DeleteCommand="DELETE FROM [tblMessages] WHERE [ID] = @ID" InsertCommand="INSERT INTO [tblMessages] ([InsertDate], [EmailAddress], [RezervationDate], [MessageBody], [NumberOfPersons], [Confirmed], [Processed], [ProcessingDate], [EmailID]) VALUES (@InsertDate, @EmailAddress, @RezervationDate, @MessageBody, @NumberOfPersons, @Confirmed, @Processed, @ProcessingDate, @EmailID)" UpdateCommand="UPDATE [tblMessages] SET [InsertDate] = @InsertDate, [EmailAddress] = @EmailAddress, [RezervationDate] = @RezervationDate, [MessageBody] = @MessageBody, [NumberOfPersons] = @NumberOfPersons, [Confirmed] = @Confirmed, [Processed] = @Processed, [ProcessingDate] = @ProcessingDate, [EmailID] = @EmailID WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="InsertDate" Type="DateTime" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="RezervationDate" />
            <asp:Parameter Name="MessageBody" Type="String" />
            <asp:Parameter Name="NumberOfPersons" Type="Int16" />
            <asp:Parameter Name="Confirmed" Type="Boolean" />
            <asp:Parameter Name="Processed" Type="Boolean" />
            <asp:Parameter Name="ProcessingDate" Type="DateTime" />
            <asp:Parameter Name="EmailID" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="InsertDate" Type="DateTime" />
            <asp:Parameter Name="EmailAddress" Type="String" />
            <asp:Parameter DbType="DateTime2" Name="RezervationDate" />
            <asp:Parameter Name="MessageBody" Type="String" />
            <asp:Parameter Name="NumberOfPersons" Type="Int16" />
            <asp:Parameter Name="Confirmed" Type="Boolean" />
            <asp:Parameter Name="Processed" Type="Boolean" />
            <asp:Parameter Name="ProcessingDate" Type="DateTime" />
            <asp:Parameter Name="EmailID" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
