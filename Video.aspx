<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Video.aspx.cs" Inherits="OneStopStudentSystem.Video" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #videoContainer {
            max-width: 600px;
        }
        iframe {
            width: 600px;
            height: 600px;
        }
        .auto-style17 {
            height: 32px;
            width: 2253px;
        }
        .auto-style19 {
            height: 59px;
            width: 2253px;
        }
        .auto-style20 {
            width: 2253px;
        }
        .auto-style21 {
            width: 575px;
        }
        .auto-style22 {
            width: 2253px;
            height: 34px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div width="3000px">
        <table style="margin-left:100px; margin-right:-20px; " class="auto-style21">
            <tr>
                <td class="auto-style17">
                <asp:Label ID="Label17" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Pronunciation Teaching Video" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style22"><label for="wordInput">Enter a word:</label>
<asp:TextBox ID="wordInput" runat="server" Width="170px"></asp:TextBox>&nbsp;<br />
                </td>
            </tr>
            <tr>
                <td class="auto-style19">
        <asp:Button ID="showVideoButton" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="SearchAndShowVideo" Text="Show Video" Width="184px" Style="border-radius: 10px;" ForeColor="White" /> &nbsp;
                    <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="btnCancel_Click" Text="Cancel" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
                </td>
            </tr>
            <tr>
                <td class="auto-style20">&nbsp;</td>
            </tr>
        </table>
        
        <div id="videoContainer" runat="server">
        </div>
        
        <br />
        <br />
        &nbsp; 
        </div>
     
    <script>
         function showVideo(videoId) {
             var videoContainer = document.getElementById('<%= videoContainer.ClientID %>');
             videoContainer.innerHTML = '';

             var iframe = document.createElement('iframe');
             iframe.src = 'https://www.youtube.com/embed/' + videoId;
             iframe.allowFullscreen = true;

             videoContainer.appendChild(iframe);
         }
     </script>
</asp:Content>
