<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ToDoE.aspx.cs" Inherits="OneStopStudentSystem.ToDoE" MaintainScrollPositionOnPostBack="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
    .auto-style15 {
        height: 32px;
    }

    .auto-style16 {
        height: 60px;
    }

    .auto-style18 {
        height: 31px;
    }

    .auto-style19 {
        margin-right: 51px;
    }

    .auto-style20 {
            height: 32px;
            width: 265px;
        }

    .auto-style23 {
            height: 31px;
            width: 265px;
        }

    .auto-style24 {
        width: 265px;
    }

    .pointer-cursor {
        cursor: pointer;
    }

    .auto-style25 {
        height: 66px;
    }

    .auto-style26 {
        height: 66px;
        width: 265px;
    }

    .high-priority {
        color: red;
    }

    .important {
        color: orange;
    }

    .urgent {
        color: yellow;
    }

    .normal {
        color: green;
    }

    .auto-style27 {
    }

    .auto-style28 {
            height: 32px;
            width: 236px;
        }

    .auto-style29 {
        height: 66px;
        width: 236px;
    }

    .auto-style31 {
            height: 31px;
            width: 236px;
        }

    .auto-style32 {
        width: 236px;
    }

    .auto-style33 {
        width: 700px;
        margin-left: 1px;
    }

    /* General GridView Styling */
    .pretty-gridview {
        border: 1px solid #333;
        border-radius: 8px;
        overflow: hidden;
        font-family: Arial, sans-serif;
        font-size: 14px;
        color: #333;
        width: 90%;
        margin-bottom: 20px;
    }

        .pretty-gridview th, .pretty-gridview td {
            padding: 12px;
            text-align: left;
        }

  /* Specific Styles Based on Importance and Urgency */
.important {
    background-color: #ffccff !important; /* Light Pink */
}

.not-important {
    background-color: #d0e8f2 !important; /* Light Blue */
}

.urgent {
    background-color: #ffffcc !important; /* Light Yellow */
}

.not-urgent {
    background-color: #f0f0f0 !important; /* Light Grey */
}

.important-urgent {
    background-color: #ff6666 !important; /* Red */
}

.important-not-urgent {
    background-color: #fff3b0 !important; /* Yellow */
}

.not-important-urgent {
    background-color: #cce5ff !important; /* Blue */
}

.not-important-not-urgent {
    background-color: #e0e0e0 !important; /* Grey */
}
        .auto-style34 {
            height: 487px;
        }
        .auto-style35 {
            height: 487px;
            width: 10px;
        }
        .auto-style36 {
            width: 10px;
        }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table class="auto-style33">
        <tr>
            <td class="auto-style28">
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="To-Do List" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>

            <td class="auto-style20">&nbsp;</td>

            <td class="auto-style27">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style29">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                <br />
                Task:<br />
                <asp:TextBox ID="txtTask" runat="server" Placeholder="Enter task" Height="39px" Width="314px"></asp:TextBox>
                <br />
                <br />
                <asp:DropDownList ID="ddlImportance" runat="server" Height="39px" Width="173px">
                    <asp:ListItem Text="&lt;--Select Importance--&gt;" Value="" />
                    <asp:ListItem Text="Important" Value="Important" />
                    <asp:ListItem Text="Not Important" Value="NotImportant" />
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:DropDownList ID="ddlUrgency" runat="server" Height="39px" Width="173px">
                    <asp:ListItem Text="&lt;--Select Urgency--&gt;" Value="" />
                    <asp:ListItem Text="Urgent" Value="Urgent" />
                    <asp:ListItem Text="Not Urgent" Value="NotUrgent" />
                </asp:DropDownList>
                &nbsp;<asp:Button ID="btnAddTask" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="37px" OnClick="btnAddTask_Click" Text="+" Width="84px" Style="        border-radius: 10px;" ForeColor="White" />
                <br />
                <br />
                <asp:Panel ID="tasksPlaceholder" runat="server">
                    <!-- Tasks will be added here -->
                </asp:Panel>
            </td>

            <td class="auto-style26">&nbsp;</td>

            <td class="auto-style25"></td>
        </tr>
        <tr>
            <td class="auto-style28">
                <table style="width:100%;">
                    <tr>
                       <td style="background-color: lightgreen;">
               &nbsp;&nbsp;&nbsp; <asp:Label ID="Label2" runat="server" Text="Important &amp; Urgent - Do first"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <asp:GridView ID="GridView7" runat="server" Style="margin-left:16px;margin-right:20px;" DataSourceID="SqlDataSource2" DataKeyNames="TaskID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowEditing="GridView7_RowEditing" OnRowDeleting="GridView7_RowDeleting" OnRowUpdating="GridView7_RowUpdating" OnRowCancelingEdit="GridView7_RowCancelingEdit" OnRowDataBound="GridView7_RowDataBound" CssClass="auto-style19" Width="463px" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnSelectedIndexChanged="GridView7_SelectedIndexChanged1">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowCancelButton="True" ShowDeleteButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal1" runat="server" Text='<%# Bind("TaskDescription") %>'></asp:Label>
                                <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete7_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TaskDescription") %>' title="Enter new ToDo content"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#487575" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#275353" />
                </asp:GridView>
<br />
                        </td>
                        <td style="background-color: lightblue;">
               &nbsp;&nbsp;&nbsp; <asp:Label ID="Label3" runat="server" Text="Important &amp; Not Urgent - Schedule"></asp:Label>
                <asp:GridView ID="GridView8" runat="server" Style="margin-left:16px;margin-right:20px;" DataSourceID="SqlDataSource3" OnRowDataBound="GridView8_RowDataBound" DataKeyNames="TaskID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="GridView8_RowDeleting" OnRowEditing="GridView8_RowEditing" OnRowUpdating="GridView8_RowUpdating" OnRowCancelingEdit="GridView7_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowCancelButton="True" ShowDeleteButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal2" runat="server" Text='<%# Bind("TaskDescription") %>'></asp:Label>
                                <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete8_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TaskDescription") %>' title="Enter new ToDo content"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" ForeColor="#003399" />
                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                    <SortedDescendingHeaderStyle BackColor="#002876" />
                </asp:GridView><br />
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: lightpink;">
            &nbsp;&nbsp;&nbsp;    <asp:Label ID="Label5" runat="server" Text="Not Important &amp; Urgent - Delegate"></asp:Label>
                <asp:GridView ID="GridView9" runat="server" Style="margin-left:16px;margin-right:20px;" DataSourceID="SqlDataSource4" OnRowDataBound="GridView9_RowDataBound" DataKeyNames="TaskID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="GridView9_RowDeleting" OnRowEditing="GridView9_RowEditing" OnRowUpdating="GridView9_RowUpdating" OnRowCancelingEdit="GridView9_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowCancelButton="True" ShowDeleteButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal3" runat="server" Text='<%# Bind("TaskDescription") %>'></asp:Label>
                                <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete9_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("TaskDescription") %>' title="Enter new ToDo content"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <SortedAscendingCellStyle BackColor="#FEFCEB" />
                    <SortedAscendingHeaderStyle BackColor="#AF0101" />
                    <SortedDescendingCellStyle BackColor="#F6F0C0" />
                    <SortedDescendingHeaderStyle BackColor="#7E0000" />
                </asp:GridView><br />
                        </td>
                        <td style="background-color: lightgrey;">
               &nbsp;&nbsp;&nbsp; <asp:Label ID="Label4" runat="server" Text="Not Important &amp; Not Urgent - Delete/Postpone"></asp:Label>
                <asp:GridView ID="GridView10" runat="server" Style="margin-left:16px;margin-right:20px;" DataSourceID="SqlDataSource5" OnRowDataBound="GridView10_RowDataBound" DataKeyNames="TaskID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="GridView10_RowDeleting" OnRowEditing="GridView10_RowEditing" OnRowUpdating="GridView10_RowUpdating" OnRowCancelingEdit="GridView10_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowCancelButton="True" ShowDeleteButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal4" runat="server" Text='<%# Bind("TaskDescription") %>'></asp:Label>
                                <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete10_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TaskDescription") %>' title="Enter new ToDo content"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView><br />
                        </td>
                    </tr>
                </table>

            </td>

            <td class="auto-style27">
                <asp:Label ID="noTasksMessage2" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>

                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [TaskDescription], [TaskID], [IsCompleted] FROM [Tasks] WHERE (([studentID] = @studentID) AND ([Importance] = @Importance) AND ([Urgency]=@Urgency))" DeleteCommand="DELETE FROM [ToDoList] WHERE [ToDoID] = @ToDoID" InsertCommand="INSERT INTO [ToDoList] ([ToDoID], [ToDoContent]) VALUES (@ToDoID, @ToDoContent)" UpdateCommand="UPDATE [ToDoList] SET [ToDoContent] = @ToDoContent WHERE [ToDoID] = @ToDoID">
                    <DeleteParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                        <asp:Parameter Name="ToDoContent" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="Important" Name="Importance" />
                        <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [TaskDescription], [TaskID], [IsCompleted] FROM [Tasks] WHERE (([studentID] = @studentID) AND ([Importance] = @Importance) AND ([Urgency]=@Urgency))" DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID" InsertCommand="INSERT INTO [Tasks] ([TaskDescription], [TaskID]) VALUES (@TaskDescription, @TaskID)" UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskDescription" />
                        <asp:Parameter Name="TaskID" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="Important" Name="Importance" />
                        <asp:Parameter DefaultValue="Urgent" Name="Urgency" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" />
                        <asp:Parameter Name="TaskID" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Label ID="noTasksMessage1" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>
                <asp:Label ID="noTasksMessage3" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [TaskDescription], [TaskID], [IsCompleted] FROM [Tasks] WHERE (([studentID] = @studentID) AND ([Importance] = @Importance) AND ([Urgency]=@Urgency))" DeleteCommand="DELETE FROM [ToDoList] WHERE [ToDoID] = @ToDoID" InsertCommand="INSERT INTO [ToDoList] ([ToDoID], [ToDoContent]) VALUES (@ToDoID, @ToDoContent)" UpdateCommand="UPDATE [ToDoList] SET [ToDoContent] = @ToDoContent WHERE [ToDoID] = @ToDoID">
                    <DeleteParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                        <asp:Parameter Name="ToDoContent" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="NotImportant" Name="Importance" />
                        <asp:Parameter DefaultValue="Urgent" Name="Urgency" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Label ID="noTasksMessage4" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [TaskDescription], [TaskID], [IsCompleted] FROM [Tasks] WHERE (([studentID] = @studentID) AND ([Importance] = @Importance) AND ([Urgency]=@Urgency))" DeleteCommand="DELETE FROM [ToDoList] WHERE [ToDoID] = @ToDoID" InsertCommand="INSERT INTO [ToDoList] ([ToDoContent], [ToDoID]) VALUES (@ToDoContent, @ToDoID)" UpdateCommand="UPDATE [ToDoList] SET [ToDoContent] = @ToDoContent WHERE [ToDoID] = @ToDoID">
                    <DeleteParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="NotImportant" Name="Importance" />
                        <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style31" id="myUL3">
                <br />
                Searching:
                <br />
                <asp:DropDownList ID="ddlSearchImp" runat="server" Height="39px" Width="173px" AutoPostBack="True" OnSelectedIndexChanged="ddlSearchImp_SelectedIndexChanged1">
                    <asp:ListItem Text="&lt;--Search Importance--&gt;" Value="" />
                    <asp:ListItem Text="Important" Value="Important" />
                    <asp:ListItem Text="Not Important" Value="NotImportant" />
                </asp:DropDownList>
                &nbsp;<asp:DropDownList ID="ddlSearchUrgency" runat="server" Height="39px" Width="173px" AutoPostBack="True" OnSelectedIndexChanged="ddlSearchUrgency_SelectedIndexChanged1">
                    <asp:ListItem Text="&lt;--Search Urgency--&gt;" Value="" />
                    <asp:ListItem Text="Urgent" Value="Urgent" />
                    <asp:ListItem Text="Not Urgent" Value="NotUrgent" />
                </asp:DropDownList>
            &nbsp;<asp:CheckBox ID="chkNotCompleted" runat="server" Text="Not Completed Task" AutoPostBack="True" OnCheckedChanged="chkNotCompleted_CheckedChanged" />
            </td>
            <td class="auto-style23" id="myUL3">&nbsp;</td>
            <td class="auto-style18" id="myUL4">&nbsp;</td>

        </tr>
        <tr>
            <td class="auto-style32">
                <asp:GridView ID="GridView11" runat="server" ShowHeader="False" CssClass="pretty-gridview important" DataSourceID="SqlDataSource1">
                  
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Importance] = @Importance)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="Important" Name="Importance" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>


                <asp:GridView ID="GridView12" runat="server" ShowHeader="False" CssClass="pretty-gridview not-important" DataSourceID="SqlDataSource6">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Importance] = @Importance)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="NotImportant" Name="Importance" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView13" runat="server" ShowHeader="False"  CssClass="pretty-gridview urgent" DataSourceID="SqlDataSource7">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="Urgent" Name="Urgency" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView14" runat="server" ShowHeader="False" CssClass="pretty-gridview not-urgent" DataSourceID="SqlDataSource8">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView15" runat="server" ShowHeader="False" CssClass="pretty-gridview important-urgent" DataSourceID="SqlDataSource9">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="Urgent" Name="Urgency" Type="String" />
                        <asp:Parameter DefaultValue="Important" Name="Importance" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView16" runat="server" ShowHeader="False" CssClass="pretty-gridview not-important-urgent" DataSourceID="SqlDataSource10">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="Urgent" Name="Urgency" Type="String" />
                        <asp:Parameter DefaultValue="NotImportant" Name="Importance" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>



                <asp:GridView ID="GridView17" runat="server" ShowHeader="False" CssClass="pretty-gridview important-not-urgent" DataSourceID="SqlDataSource11">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" Type="String" />
                        <asp:Parameter DefaultValue="Important" Name="Importance" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="GridView18" runat="server"  ShowHeader="False" CssClass="pretty-gridview not-important-not-urgent" DataSourceID="SqlDataSource13">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource13" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
                    InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
                    SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)"
                    UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
                    <DeleteParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TaskID" Type="String" />
                        <asp:Parameter Name="TaskDescription" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" Type="String" />
                        <asp:Parameter DefaultValue="NotImportant" Name="Importance" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TaskDescription" Type="String" />
                        <asp:Parameter Name="TaskID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                


                 <asp:GridView ID="GridView1" runat="server" ShowHeader="False" CssClass="pretty-gridview important" DataSourceID="SqlDataSource12">
   
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource12" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Importance] = @Importance) AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="Important" Name="Importance" Type="String" />
                  <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>


 <asp:GridView ID="GridView2" runat="server" ShowHeader="False" CssClass="pretty-gridview not-important" DataSourceID="SqlDataSource14">
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource14" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Importance] = @Importance)  AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="NotImportant" Name="Importance" Type="String" />
                           <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>
 <asp:GridView ID="GridView3" runat="server" ShowHeader="False"  CssClass="pretty-gridview urgent" DataSourceID="SqlDataSource15">
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource15" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency)  AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="Urgent" Name="Urgency" Type="String" />
                           <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>
 <asp:GridView ID="GridView4" runat="server" ShowHeader="False" CssClass="pretty-gridview not-urgent" DataSourceID="SqlDataSource16">
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource16" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency)  AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" Type="String" />
                           <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>
 <asp:GridView ID="GridView5" runat="server" ShowHeader="False" CssClass="pretty-gridview important-urgent" DataSourceID="SqlDataSource17">
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource17" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)  AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="Urgent" Name="Urgency" Type="String" />
         <asp:Parameter DefaultValue="Important" Name="Importance" Type="String" />
                           <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>
 <asp:GridView ID="GridView6" runat="server" ShowHeader="False" CssClass="pretty-gridview not-important-urgent" DataSourceID="SqlDataSource18">
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource18" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)  AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="Urgent" Name="Urgency" Type="String" />
         <asp:Parameter DefaultValue="NotImportant" Name="Importance" Type="String" />
                           <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>



 <asp:GridView ID="GridView19" runat="server" ShowHeader="False" CssClass="pretty-gridview important-not-urgent" DataSourceID="SqlDataSource19">
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource19" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)  AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" Type="String" />
         <asp:Parameter DefaultValue="Important" Name="Importance" Type="String" />
                           <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>

 <asp:GridView ID="GridView20" runat="server"  ShowHeader="False" CssClass="pretty-gridview not-important-not-urgent" DataSourceID="SqlDataSource20">
 </asp:GridView>
 <asp:SqlDataSource ID="SqlDataSource20" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
     DeleteCommand="DELETE FROM [Tasks] WHERE [TaskID] = @TaskID"
     InsertCommand="INSERT INTO [Tasks] ([TaskID], [TaskDescription]) VALUES (@TaskID, @TaskDescription)"
     SelectCommand="SELECT DISTINCT [TaskDescription] FROM [Tasks] WHERE ([studentID] = @studentID) AND ([Urgency] = @Urgency) AND ([Importance] = @Importance)  AND ([IsCompleted] = @IsCompleted)"
     UpdateCommand="UPDATE [Tasks] SET [TaskDescription] = @TaskDescription WHERE [TaskID] = @TaskID">
     <DeleteParameters>
         <asp:Parameter Name="TaskID" Type="String" />
     </DeleteParameters>
     <InsertParameters>
         <asp:Parameter Name="TaskID" Type="String" />
         <asp:Parameter Name="TaskDescription" Type="String" />
     </InsertParameters>
     <SelectParameters>
         <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
         <asp:Parameter DefaultValue="NotUrgent" Name="Urgency" Type="String" />
         <asp:Parameter DefaultValue="NotImportant" Name="Importance" Type="String" />
                           <asp:Parameter DefaultValue="false" Name="IsCompleted" Type="String" />
     </SelectParameters>
     <UpdateParameters>
         <asp:Parameter Name="TaskDescription" Type="String" />
         <asp:Parameter Name="TaskID" Type="String" />
     </UpdateParameters>
 </asp:SqlDataSource>





                <br />
                <br />
                <map name="workmap">
                    <area shape="poly" coords="369, 442, 197, 332, 198, 36, 528, 39, 525, 333, 439, 393, 78" id="workmapLink" class="pointer-cursor">
                </map>
                <img src="Image/doQ.jpg" alt="todoNav" usemap="#workmap">
            </td>
            <td class="auto-style24">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>

    <script type="text/javascript">
        function toggleStrikethrough(checkbox) {
            var row = checkbox.closest('tr');
            if (checkbox.checked) {
                row.style.textDecoration = 'line-through';
            } else {
                row.style.textDecoration = 'none';
            }
        }

        document.getElementById('workmapLink').addEventListener('click', function (event) {
            event.preventDefault();
            window.open('https://sherigraham.com/keeping-list-important-get-started/', '_blank');
        });

    </script>

</asp:Content>
