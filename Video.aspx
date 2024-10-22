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
        <table style="margin-left: 100px; margin-right: -20px;" class="auto-style21">
            <tr>
                <td class="auto-style17">
                    <asp:Label ID="Label17" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Pronunciation Teaching Video" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style22">
                    <label for="wordInput">Enter a word:</label>
                    <asp:TextBox ID="wordInput" runat="server" Width="170px"></asp:TextBox>&nbsp;
                    <button id="btnVoice" class="button" style="background-color: bisque; color: black" type="button">
                        🎤
                    </button>
                    <br />
                </td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Button ID="showVideoButton" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="SearchAndShowVideo" Text="Show Video" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
                    &nbsp;
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
        // Initialize speech recognition
        const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        const recognition = new SpeechRecognition();
        recognition.lang = 'en-US'; // Set language to English (US)
        recognition.interimResults = false; // Only show final results
        recognition.maxAlternatives = 1; // Limit to 1 alternative result

        recognition.onresult = function (event) {
            const word = event.results[0][0].transcript; // Get recognized word
            document.getElementById('<%= wordInput.ClientID %>').value = word; // Set recognized word in the input field

            // Automatically trigger the video search when a word is recognized
            triggerSearchVideo();

            // Change the color of the button back to the original after recognition ends
            btnVoice.style.backgroundColor = 'bisque'; // Reset to original color
        };

        recognition.onerror = function (event) {
            console.error('Speech recognition error:', event.error); // Handle errors
        };

        recognition.onend = function () {
            console.log('Voice recognition ended');
            btnVoice.style.backgroundColor = 'bisque'; // Reset to original color
        };

        // Event listener for the mic button
        const btnVoice = document.getElementById('btnVoice');
        btnVoice.addEventListener('click', function () {
            recognition.start();  // Start voice recognition

            // Change the button color when clicked
            btnVoice.style.backgroundColor = 'lightgreen'; // New color while recognition is active
        });

        function triggerSearchVideo() {
            // Call the server-side method to search and show the video via AJAX
            __doPostBack('<%= showVideoButton.UniqueID %>', '');
        }

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
