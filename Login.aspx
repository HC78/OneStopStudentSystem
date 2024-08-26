<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OneStopStudentSystem.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
            width: 448px;
        }
        .auto-style3 {
            width: 700px;
        }
        .auto-style15 {
            width: 700px;
            height: 86px;
        }
        .auto-style16 {
            width: 600px;
            height: 130px;
        }
        .auto-style17 {
            width: 448px;
            height: 48px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <table style="width:100%; margin-left:100px; margin-right:-20px;">
        <tr>
            <td class="auto-style14">
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Login" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style15">          
                <asp:Button ID="btnGoogleLogin" runat="server" Text="Login with Google" OnClick="BtnGoogleLogin_Click" />
                <br />
                <asp:Label ID="Label8" runat="server" Text="-------------------------------OR-------------------------------"></asp:Label>
                <br />
                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <asp:Label ID="Label3" runat="server" Text="Username or Email Address"></asp:Label>
                <br />
                <asp:TextBox ID="txtUsernameOrEmail" runat="server" BackColor="White" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px"  style="border-radius: 7px; " OnTextChanged="txtPsw_TextChanged" BorderWidth="1px" ForeColor="Black"></asp:TextBox>
                </td>
        </tr>
        <tr>
            <td class="auto-style16">
                <br />
                <asp:Label ID="Label5" runat="server" Text="Password"></asp:Label>
                <br />
                <asp:TextBox ID="txtPsw" runat="server" BackColor="White" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px"  style="border-radius: 7px; " OnTextChanged="txtPsw_TextChanged" TextMode="Password" BorderWidth="1px" ForeColor="Black"></asp:TextBox>
                <br />
                <asp:Label ID="tip" runat="server" ForeColor="#CC6600" Font-Size="Small">Tips: If you forget the password, try to login with Google account</asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                
                <br />
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <br />
                <asp:Button ID="btnLogin" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="BtnLogin_Click" Text="Login" Width="184px" style="border-radius: 10px;" ForeColor="White" />
            &nbsp;&nbsp;
                <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="BtnCancel_Click" Text="Cancel" Width="184px" style="border-radius: 10px;" ForeColor="White" />
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label6" runat="server" Text="Don't have an account yet?" ForeColor="Black"></asp:Label>
                &nbsp;<asp:LinkButton ID="linkSignUp" runat="server" ForeColor="#5F6F52" OnClick="linkForgotPsw_Click">Sign Up Now</asp:LinkButton>
                </td>
        </tr>
    </table>
    <br />
</asp:Content>
