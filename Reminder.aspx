<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reminder.aspx.cs" Inherits="OneStopStudentSystem.Reminder" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style19 {
            margin-right: 51px;
        }

        .auto-style20 {
            width: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Reminder" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="passDate" runat="server" ForeColor="Red"></asp:Label>
                <br />
                Date Time:&nbsp;
            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtDateTime" runat="server" Height="27px" TextMode="DateTime" Width="690px"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDateTime" Format="yyyy-MM-dd HH:mm:ss" />

            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Event Name:</td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtName" runat="server" Height="27px" Width="690px"></asp:TextBox>
            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Event Description:</td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtDesc" runat="server" Height="56px" TextMode="MultiLine" Width="690px"></asp:TextBox>
            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAdd" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="btnAdd_Click" Text="Add" Width="184px" Style="border-radius: 10px;" ForeColor="White" />

                &nbsp;
                <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="btnCancel_Click" Text="Cancel" Width="184px" Style="border-radius: 10px;" ForeColor="White" />

            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView7" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="ReminderID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowEditing="GridView7_RowEditing" OnRowDeleting="GridView7_RowDeleting" OnRowUpdating="GridView7_RowUpdating" OnRowCancelingEdit="GridView7_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" Style="width: 690px">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="dateTime" HeaderText="dateTime" SortExpression="dateTime" />
                        <asp:BoundField DataField="eventName" HeaderText="eventName" SortExpression="eventName" />
                        <asp:BoundField DataField="eventDesc" HeaderText="eventDesc" SortExpression="eventDesc" />
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

            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [dateTime], [eventName], [eventDesc], [ReminderID] FROM [Reminder] WHERE ([studentID] = @studentID)" DeleteCommand="DELETE FROM [Reminder] WHERE [ReminderID] = @ReminderID" UpdateCommand="UPDATE [Reminder] SET [dateTime] = @dateTime, [eventName] = @eventName, [eventDesc] = @eventDesc WHERE [ReminderID] = @ReminderID" InsertCommand="INSERT INTO [Reminder] ([dateTime], [eventName], [eventDesc], [ReminderID]) VALUES (@dateTime, @eventName, @eventDesc, @ReminderID)">
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
            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="noReminderMsg" runat="server" Text="No Any Reminder" Visible="False"></asp:Label>
            </td>
            <td class="auto-style20">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />

    &nbsp;&nbsp;
                
            &nbsp;
    <br />
    <br />
    <br />
    <br />
</asp:Content>
