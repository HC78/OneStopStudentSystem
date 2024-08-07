<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Chatbot.aspx.cs" Inherits="OneStopStudentSystem.Chatbot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            width: 995px;
            margin: 0 auto;
        }

        .chatbox {
            border-radius: 20px;
            width: 985px;
            height: 500px;
            border: 2px solid #ccc;
            padding: 10px;
            overflow-y: scroll;
        }

        .chat-bubble {
            margin: 10px;
            padding: 10px;
            border-radius: 10px;
            width: 800px;
            display: inline-block;
        }

        .user-bubble {
            background-color: #eaedee;
            text-align: left;
            float: right;
            clear: both;
            width: 400px;
        }

        .bot-bubble {
            background-color: #f2ded6;
            text-align: left;
            float: left;
            clear: both;
            width: 800px;
        }

        .input-container {
            border-radius: 20px;
            width: 990px;
            justify-content: space-between;
            margin-top: 10px;
            border: 2px solid #ccc;
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #f9f9f9;
        }

        .inputbox {
            border-radius: 50px;
            padding: 10px;
            width: 80%;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

        .button {
            border-radius: 50px;
            padding: 10px 20px;
            border: none;
            color: white;
            cursor: pointer;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        h1 {
            text-align: center;
        }

          .rounded-img-btn {
            border-radius: 10px;
            overflow: hidden;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <asp:Label ID="Label17" runat="server" Font-Size="X-Large" ForeColor="Black" Text="AI Chatbot" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            <br />
&nbsp;<div class="container">
        <div class="chatbox" id="chatbox">
            <asp:Literal ID="litChat" runat="server"></asp:Literal>
        </div>
        <div class="input-container">
            <asp:TextBox ID="txtQuestion" runat="server" class="inputbox" placeholder="Type your message here..."></asp:TextBox>
            <asp:ImageButton ID="Ask" runat="server" Width="42px" CssClass="rounded-img-btn" ImageUrl="~/Image/sendi.jpg" OnClick="btnAsk_Click" Height="43px" />
            <asp:ImageButton ID="btnCancel" runat="server" Width="42px" CssClass="rounded-img-btn" ImageUrl="~/Image/bini.jpg" OnClick="BtnCancel_Click" Height="43px" />
&nbsp;&nbsp;
        </div>
    </div>
</asp:Content>
