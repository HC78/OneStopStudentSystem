<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" MaintainScrollPositionOnPostBack="true" CodeBehind="Chatbot.aspx.cs" Inherits="OneStopStudentSystem.Chatbot" %>

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
            &nbsp;<asp:ImageButton ID="btnCancel" runat="server" Width="42px" CssClass="rounded-img-btn" ImageUrl="~/Image/bini.jpg" OnClick="BtnCancel_Click" Height="43px" />
&nbsp;&nbsp; <button id="btnVoice" type="button" class="button" style="background-color:bisque; color:black">🎤</button>
 <button id="btnSpeak" type="button" class="button" style="background-color:bisque; color:black">Speak</button>
 <asp:DropDownList ID="voiceSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="voiceSelect_SelectedIndexChanged" CssClass="button" style="background-color:bisque ; color:black">
     <asp:ListItem Value="none"><--Select voice--></asp:ListItem>
     <asp:ListItem Value="female">Female</asp:ListItem>
     <asp:ListItem Value="male">Male</asp:ListItem>
 </asp:DropDownList>
 <asp:HiddenField ID="hfSelectedVoiceType" runat="server" />
        </div>
    </div>

    <script>
    const btnVoice = document.getElementById('btnVoice');
    const txtQuestion = document.getElementById('<%= txtQuestion.ClientID %>');
    const btnSpeak = document.getElementById('btnSpeak');
    const voiceSelect = document.getElementById('<%= voiceSelect.ClientID %>');
    const hfSelectedVoiceType = document.getElementById('<%= hfSelectedVoiceType.ClientID %>');

    let voices = [];

    const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
    recognition.continuous = false;
    recognition.interimResults = false;

    recognition.onresult = function(event) {
        const transcript = event.results[0][0].transcript;
        txtQuestion.value = transcript;  // Set the text input to the recognized speech
        recognition.stop();  // Stop recognizing
        document.getElementById('<%= Ask.ClientID %>').click();  // Trigger the ask button click
    };

    recognition.onerror = function (event) {
        console.error(event.error);
        recognition.stop();  // Stop recognizing
    };

    btnVoice.addEventListener('click', function () {
        recognition.start();  // Start voice recognition
    });

    btnSpeak.addEventListener('click', function () {
        const chatBubbles = document.querySelectorAll('.bot-bubble');
        if (chatBubbles.length > 0) {
            const lastBotBubble = chatBubbles[chatBubbles.length - 1];
            const message = lastBotBubble.innerText;
            readOutLoud(message, hfSelectedVoiceType.value);
        }
    });

    function loadVoices() {
        voices = window.speechSynthesis.getVoices();
        console.log('Voices loaded:', voices);
    }

    // Load voices initially
    loadVoices();

    // Re-load voices when they become available
    window.speechSynthesis.onvoiceschanged = loadVoices;

    function readOutLoud(message, selectedVoiceType) {
        console.log('Reading out loud:', message);

        // Cancel any pending utterances
        window.speechSynthesis.cancel();

        const speech = new SpeechSynthesisUtterance();
        speech.text = message;
        speech.volume = 1;
        speech.rate = 1;
        speech.pitch = 1;

        // Filter for male or female voices based on selection
        let filteredVoices;
        if (selectedVoiceType === 'male') {
            filteredVoices = voices.filter(voice => voice.name.toLowerCase().includes('male') || voice.name.includes('David') || voice.name.includes('Alex'));
        } else if (selectedVoiceType === 'female') {
            filteredVoices = voices.filter(voice => voice.name.toLowerCase().includes('female') || voice.name.includes('Siri') || voice.name.includes('Victoria'));
        }

        // Use the first filtered voice if available, otherwise use the default
        if (filteredVoices.length > 0) {
            speech.voice = filteredVoices[0];
        } else {
            console.warn(`No ${selectedVoiceType} voice found. Using default.`);
            speech.voice = voices[0]; // Use the default voice
        }

        window.speechSynthesis.speak(speech);
    }
    </script>
</asp:Content>
