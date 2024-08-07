<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="OneStopStudentSystem.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style5 {
            width: 304px;
        }
        .auto-style8 {
            width: 100%;
            height: 381px;
        }
        .auto-style10 {
            width: 428px;
            height: 68px;
        }
        .auto-style11 {
            height: 68px;
            width: 414px;
        }
        .auto-style12 {
            width: 428px;
            height: 74px;
        }
        .auto-style16 {
            width: 304px;
            height: 22px;
        }
        .auto-style17 {
            height: 22px;
            width: 414px;
        }
        .auto-style19 {
            width: 428px;
            height: 22px;
        }
        .auto-style20 {
            width: 414px;
        }
        .auto-style23 {
            width: 239px;
            height: 228px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style8">
        <tr>
            <td class="auto-style5" rowspan="4">
               <asp:Image ID="girlProfile" runat="server" ImageUrl="/Image/girlProfile.jfif" AlternateText="Girl Profile" CssClass="auto-style23" /><br />
                <asp:Image ID="boyProfile" runat="server" ImageUrl="/Image/boyProfile.jpg" AlternateText="Boy Profile" CssClass="auto-style23" /><br />
                <asp:Image ID="Image1" runat="server" Height="256px" Width="300px" />
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </td>
            <td class="auto-style10">
                <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
                <br />
                <asp:TextBox ID="txtName" runat="server" BackColor="White" BorderColor="#BCBCBC" BorderStyle="Solid" Height="32px" Width="379px" OnTextChanged="txtName_TextChanged" style="border-radius: 7px; color: black;" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style11">
                <asp:Label ID="Label17" runat="server" Text="Date of Birth"></asp:Label>
                <br />

                <asp:TextBox ID="txtCal0" runat="server" BackColor="White" BorderColor="#BCBCBC" BorderStyle="Solid" Height="32px" Width="379px"  style="border-radius: 7px; color: black;" OnTextChanged="txtCal0_TextChanged" ForeColor="Black"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <br />
                <asp:Label ID="Label8" runat="server" Text="Gender"></asp:Label>
                <br />
                <asp:RadioButtonList ID="rblGender" runat="server" Font-Overline="False" OnSelectedIndexChanged="rblGender_SelectedIndexChanged" ForeColor="Black">
                    <asp:ListItem>Male </asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="auto-style11">
                <br />
                Location<br />
                <asp:DropDownList ID="ddlState0" runat="server" BackColor="White" ForeColor="Black" Height="32px" Width="379px"  style="border-radius: 7px; color: black;" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                    <asp:ListItem>&lt;--Select State--&gt;</asp:ListItem>
                    <asp:ListItem>Selangor</asp:ListItem>
                    <asp:ListItem>Kuala Lumpur</asp:ListItem>
                    <asp:ListItem>Putrajaya</asp:ListItem>
                    <asp:ListItem>Penang</asp:ListItem>
                    <asp:ListItem>Kedah</asp:ListItem>
                    <asp:ListItem>Johor</asp:ListItem>
                    <asp:ListItem>Kelantan</asp:ListItem>
                    <asp:ListItem>Melaka</asp:ListItem>
                    <asp:ListItem>Negeri Sembilan</asp:ListItem>
                    <asp:ListItem>Pahang</asp:ListItem>
                    <asp:ListItem>Perak</asp:ListItem>
                    <asp:ListItem>Perlis</asp:ListItem>
                    <asp:ListItem>Sabah</asp:ListItem>
                    <asp:ListItem>Sarawak</asp:ListItem>
                    <asp:ListItem>Labuan</asp:ListItem>
                    <asp:ListItem>Terengganu</asp:ListItem>
                    <asp:ListItem>Others</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <br />
                <asp:Label ID="Label3" runat="server" Text="Email"></asp:Label>
                <br />
                <asp:TextBox ID="txtEmail" runat="server" BackColor="White" BorderColor="#BCBCBC" BorderStyle="Solid" Height="32px" Width="379px" OnTextChanged="txtEmail_TextChanged"  style="border-radius: 7px; color: black;" ReadOnly="True" TextMode="Email" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style11">
                <br />
                <asp:Label ID="Label19" runat="server" Text="Mobile Number"></asp:Label>
                <br />
                <asp:TextBox ID="txtPhone0" runat="server" BackColor="White" Height="32px" Width="379px" BorderColor="#BCBCBC" OnTextChanged="txtPhone_TextChanged"  style="border-radius: 7px; color: black;" ForeColor="Black"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style12">
                &nbsp;</td>
            <td class="auto-style20">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style16">
                <br />
                <asp:Button ID="btnSave" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="54px" OnClick="btnSave_Click" Text="Save Change" Width="390px" style="border-radius: 10px;" ForeColor="White" />
            </td>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style17"></td>
        </tr>
        <tr>
            <td class="auto-style16">
                 <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>&nbsp;</td>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style17">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style16">
                &nbsp;</td>
            <td class="auto-style19">&nbsp;</td>
            <td class="auto-style17">&nbsp;</td>
        </tr>
    </table>
</asp:Content>

