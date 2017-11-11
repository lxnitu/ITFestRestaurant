<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Tables.aspx.cs" Inherits="ITFestRestaurant.Pages.Administration.Tables" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Data.Linq" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxCardView ID="ASPxCardView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Theme="Metropolis" KeyFieldName="ID" Width="100%">
        <SettingsPager AlwaysShowPager="True">
        </SettingsPager>
        <Settings ShowHeaderPanel="True" ShowSummaryPanel="True" ShowHeaderFilterButton="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:CardViewTextColumn FieldName="MaxCapacity" VisibleIndex="0">
            </dx:CardViewTextColumn>
            <dx:CardViewTextColumn FieldName="Number" VisibleIndex="1">
            </dx:CardViewTextColumn>
            <dx:CardViewTextColumn FieldName="FloorNumber" VisibleIndex="2">
            </dx:CardViewTextColumn>
            <dx:CardViewTextColumn FieldName="Rating" VisibleIndex="3">
            </dx:CardViewTextColumn>
            <dx:CardViewCheckColumn FieldName="Active" VisibleIndex="4">
            </dx:CardViewCheckColumn>
        </Columns>
        <CardLayoutProperties>
            <Items>
                <dx:CardViewCommandLayoutItem HorizontalAlign="Right" ShowDeleteButton="True" ShowEditButton="True" ShowNewButton="True">
                </dx:CardViewCommandLayoutItem>
                <dx:CardViewColumnLayoutItem ColumnName="InsertDate">
                </dx:CardViewColumnLayoutItem>
                <dx:CardViewColumnLayoutItem ColumnName="MaxCapacity">
                </dx:CardViewColumnLayoutItem>
                <dx:CardViewColumnLayoutItem ColumnName="Number">
                </dx:CardViewColumnLayoutItem>
                <dx:CardViewColumnLayoutItem ColumnName="FloorNumber">
                </dx:CardViewColumnLayoutItem>
                <dx:CardViewColumnLayoutItem ColumnName="Rating">
                </dx:CardViewColumnLayoutItem>
                <dx:CardViewColumnLayoutItem ColumnName="Active">
                </dx:CardViewColumnLayoutItem>
                <dx:EditModeCommandLayoutItem HorizontalAlign="Right">
                </dx:EditModeCommandLayoutItem>
            </Items>
        </CardLayoutProperties>
    </dx:ASPxCardView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="SELECT * FROM [tblTables]" 
        ConflictDetection="CompareAllValues" 
        DeleteCommand="DELETE FROM [tblTables] WHERE [ID] = @original_ID AND [MaxCapacity] = @original_MaxCapacity AND [Number] = @original_Number AND [FloorNumber] = @original_FloorNumber AND [Rating] = @original_Rating AND [Active] = @original_Active" 
        InsertCommand="INSERT INTO [tblTables] ([MaxCapacity], [Number], [FloorNumber], [Rating], [Active]) VALUES (@MaxCapacity, @Number, @FloorNumber, @Rating, @Active)" 
        OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [tblTables] SET [MaxCapacity] = @MaxCapacity, [Number] = @Number, [FloorNumber] = @FloorNumber, [Rating] = @Rating, [Active] = @Active 
            WHERE [ID] = @original_ID AND [InsertDate] = @original_InsertDate AND [MaxCapacity] = @original_MaxCapacity AND [Number] = @original_Number AND 
                [FloorNumber] = @original_FloorNumber AND [Rating] = @original_Rating AND [Active] = @original_Active">
        <DeleteParameters>
            <asp:Parameter Name="original_MaxCapacity" Type="Int32" />
            <asp:Parameter Name="original_Number" Type="Int16" />
            <asp:Parameter Name="original_FloorNumber" Type="Int16" />
            <asp:Parameter Name="original_Rating" Type="Int16" />
            <asp:Parameter Name="original_Active" Type="Boolean" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MaxCapacity" Type="Int32" />
            <asp:Parameter Name="Number" Type="Int16" />
            <asp:Parameter Name="FloorNumber" Type="Int16" />
            <asp:Parameter Name="Rating" Type="Int16" />
            <asp:Parameter Name="Active" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MaxCapacity" Type="Int32" />
            <asp:Parameter Name="Number" Type="Int16" />
            <asp:Parameter Name="FloorNumber" Type="Int16" />
            <asp:Parameter Name="Rating" Type="Int16" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_InsertDate" Type="DateTime" />
            <asp:Parameter Name="original_MaxCapacity" Type="Int32" />
            <asp:Parameter Name="original_Number" Type="Int16" />
            <asp:Parameter Name="original_FloorNumber" Type="Int16" />
            <asp:Parameter Name="original_Rating" Type="Int16" />
            <asp:Parameter Name="original_Active" Type="Boolean" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>