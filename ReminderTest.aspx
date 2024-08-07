<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ReminderTest.aspx.cs" Inherits="fyp.ReminderTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style19 {
            margin-right: 51px;
        }

        .ajax__calendar_inactive {
            color: green;
        }

        .disabled-date {
            pointer-events: none;
            background-color: grey;
            color: grey;
        }

        .ajax__calendar_invalid {
            color: #ccc;
            background-color: #f9f9f9;
            cursor: not-allowed;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <title>Create Event</title>
    <div>
        <h2>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Label ID="Label8" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Reminder" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
        </h2>
        <asp:Label ID="lblMessage" runat="server" Visible="False" ForeColor="Red"></asp:Label>
        &nbsp;<asp:Label ID="lblPass" runat="server" ForeColor="Red"></asp:Label>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        <br />
        <label for="txtEventName">Event Name:</label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEventName" ErrorMessage="Event name is required" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="txtEventName" runat="server" Height="27px" Width="690px"></asp:TextBox>
        <br />
        <br />
        <label for="txtEventDesc">Event Description:</label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEventDesc" ErrorMessage="Event description is required" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="txtEventDesc" runat="server" Height="27px" Width="690px"></asp:TextBox>
        <br />
        <br />
        <label for="txtEventDate">Event Date and Time (ex: 07-16-2024 00:29:58):</label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEventDate" ErrorMessage="Event date is required" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
        <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtEventDate" ClientValidationFunction="validateEventDate" ErrorMessage="Event date time must be greater than now" ForeColor="Red" Display="Dynamic"></asp:CustomValidator>
        <br />
        <asp:TextBox ID="txtEventDate" runat="server" Height="27px" Width="690px"></asp:TextBox>
        <ajaxToolkit:CalendarExtender
            ID="CalendarExtender1"
            runat="server"
            TargetControlID="txtEventDate"
            Format="MM-dd-yyyy HH:mm:ss"
            OnClientShown="disablePastDates" />
        <br />
        <br />
        <label for="txtTime">Email Reminder Sent Again x min before event start (ex: 30):</label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtTime" ErrorMessage="Please mention before x min want to resent reminder" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="txtTime" runat="server" Height="27px" Width="690px" TextMode="Number"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnCreateEvent" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="BtnCreateEvent_Click" Text="Add" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
        &nbsp;
        <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="btnCancel_Click" Text="Cancel" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
        <br />
        <br />
        <asp:GridView ID="GridView7" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="ReminderID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowEditing="GridView7_RowEditing" OnRowDeleting="GridView7_RowDeleting" OnRowUpdating="GridView7_RowUpdating" OnRowCancelingEdit="GridView7_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" Style="width: 690px">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="dateTime" HeaderText="dateTime" SortExpression="dateTime" />
                <asp:BoundField DataField="eventName" HeaderText="eventName" SortExpression="eventName" />
                <asp:BoundField DataField="eventDesc" HeaderText="eventDesc" SortExpression="eventDesc" />
                <asp:BoundField DataField="reminderTime" HeaderText="reminderMinBefore" SortExpression="reminderTime" />
            </Columns>
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Reminder] WHERE [ReminderID] = @ReminderID" InsertCommand="INSERT INTO [Reminder] ([dateTime], [eventName], [eventDesc], [ReminderID]) VALUES (@dateTime, @eventName, @eventDesc, @ReminderID)" SelectCommand="SELECT [dateTime], [eventName], [eventDesc], [reminderTime], [ReminderID] FROM [Reminder] WHERE ([studentID] = @studentID)" UpdateCommand="UPDATE [Reminder] SET [dateTime] = @dateTime, [eventName] = @eventName, [eventDesc] = @eventDesc WHERE [ReminderID] = @ReminderID">
            <DeleteParameters>
                <asp:Parameter Name="ReminderID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="dateTime" Type="DateTime" />
                <asp:Parameter Name="eventName" Type="String" />
                <asp:Parameter Name="eventDesc" Type="String" />
                <asp:Parameter Name="ReminderID" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="dateTime" Type="DateTime" />
                <asp:Parameter Name="eventName" Type="String" />
                <asp:Parameter Name="eventDesc" Type="String" />
                <asp:Parameter Name="ReminderID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="noReminderMsg" runat="server" Text="No Any Reminder" Visible="False"></asp:Label>
    </div>

    <script type="text/javascript">
        function validateEventDate(sender, args) {
            var eventDate = new Date(args.Value);
            var now = new Date();
            now.setSeconds(0);
            now.setMilliseconds(0);

            if (eventDate <= now) {
                args.IsValid = false;
            } else {
                args.IsValid = true;
            }
        }

        function disablePastDates(sender, args) {
            var today = new Date();
            today.setHours(0, 0, 0, 0); 

            var days = sender._days.body.rows;
            for (var i = 0; i < days.length; i++) {
                for (var j = 0; j < days[i].cells.length; j++) {
                    var cell = days[i].cells[j];
                    var cellDate = new Date(cell.date);

                    if (cellDate < today) {
                        cell.className += " disabled-date";
                        cell.style.pointerEvents = "none"; 
                    } else {
                        cell.className = cell.className.replace("disabled-date", "");
                        cell.style.pointerEvents = "auto";
                    }
                }
            }
        }


    </script>
</asp:Content>

