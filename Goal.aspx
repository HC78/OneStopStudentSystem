<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Goal.aspx.cs" Inherits="OneStopStudentSystem.Goal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style15 {
            height: 32px;
        }
        .auto-style16 {
            height: 60px;
        }
        .auto-style19 {
            margin-right: 51px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <table style="width: 1000px;">
        <tr>
            <td class="auto-style16">
     <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Goal Getter" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style16">
                Goal:
            </td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:TextBox ID="txtGoal" runat="server" Height="27px" Width="690px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style15"></td>
        </tr>
        <tr>
            <td class="auto-style17">
                Reward:
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:TextBox ID="txtReward" runat="server" Height="27px" Width="690px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style17">
                Milestones:
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:TextBox ID="txtMilestones" runat="server" Height="58px" Width="690px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">
                Motivational Quote:
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:TextBox ID="txtQuote" runat="server" Height="27px" Width="690px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style15">
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:Button ID="btnAdd" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="BtnAdd_Click" Text="Add Goal" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
                &nbsp;
                <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="BtnCancel_Click" Text="Cancel" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:GridView ID="GridView7" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="GoalID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowEditing="GridView7_RowEditing" OnRowDeleting="GridView7_RowDeleting" OnRowUpdating="GridView7_RowUpdating" OnRowCancelingEdit="GridView7_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" style="width:690px">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="GoalID" HeaderText="GoalID" SortExpression="GoalID" ReadOnly="True" />
                        <asp:BoundField DataField="GoalTitle" HeaderText="GoalTitle" SortExpression="GoalTitle" />
                        <asp:BoundField DataField="GoalReward" HeaderText="GoalReward" SortExpression="GoalReward" />
                        <asp:BoundField DataField="GoalMilestone" HeaderText="GoalMilestone" SortExpression="GoalMilestone" />
                        <asp:BoundField DataField="GoalQuote" HeaderText="GoalQuote" SortExpression="GoalQuote" />
                        <asp:TemplateField HeaderText="Completed" SortExpression="IsCompleted">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkCompleted" runat="server" Checked='<%# Eval("IsCompleted") != DBNull.Value && Convert.ToBoolean(Eval("IsCompleted")) %>' OnCheckedChanged="chkCompleted_CheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                        </asp:TemplateField>
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

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [GoalID], [GoalTitle], [GoalReward], [GoalMilestone], [GoalQuote], [IsCompleted] FROM [Goal] WHERE ([studentID] = @studentID)" DeleteCommand="DELETE FROM [Goal] WHERE [GoalID] = @GoalID" UpdateCommand="UPDATE [Goal] SET [GoalTitle] = @GoalTitle, [GoalReward] = @GoalReward, [GoalMilestone] = @GoalMilestone, [GoalQuote] = @GoalQuote, [IsCompleted] = @IsCompleted WHERE [GoalID] = @GoalID">
                    <DeleteParameters>
                        <asp:Parameter Name="GoalID" Type="String" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="GoalTitle" Type="String" />
                        <asp:Parameter Name="GoalReward" Type="String" />
                        <asp:Parameter Name="GoalMilestone" Type="String" />
                        <asp:Parameter Name="GoalQuote" Type="String" />
                        <asp:Parameter Name="IsCompleted" Type="Boolean" />
                        <asp:Parameter Name="GoalID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:Label ID="noGoalMsg" runat="server" Text="No Any Goal" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
