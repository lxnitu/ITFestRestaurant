<%@ Control Language="C#" AutoEventWireup="true" Inherits="SelectionToolTip" Codebehind="SelectionToolTip.ascx.cs" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<div runat="server" id="buttonDiv">
    <dx:ASPxButton ID="btnShowMenu" runat="server" AutoPostBack="False" AllowFocus="False">
        <Border BorderWidth="0px" />
        <Paddings Padding="0px" />
        <FocusRectPaddings Padding="4px" />
        <FocusRectBorder BorderStyle="None" BorderWidth="0px" />
    </dx:ASPxButton>
</div>