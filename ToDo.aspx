<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ToDo.aspx.cs" Inherits="fyp.ToDo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 
    <style type="text/css">
        .auto-style15 {
            height: 32px;
        }

        .auto-style16 {
            height: 60px;
        }

        .auto-style17 {
            height: 33px;
        }

        .auto-style18 {
            height: 31px;
        }

        .auto-style19 {
            margin-right: 51px;
        }
        .auto-style20 {
            height: 32px;
            width: 403px;
        }
        .auto-style21 {
            height: 33px;
            width: 403px;
        }
        .auto-style22 {
            height: 60px;
            width: 403px;
        }
        .auto-style23 {
            height: 31px;
            width: 403px;
        }
        .auto-style24 {
            width: 403px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table style="width: 100%;">
        <tr>
            <td class="auto-style20">
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="To-Do List" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>

            <td class="auto-style15">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:Label ID="Label2" runat="server" Text="Important &amp; Urgent - Do first"></asp:Label>
            </td>

            <td class="auto-style15">
                <asp:Label ID="Label3" runat="server" Text="Important &amp; Not Urgent - Schedule"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style21">
                <asp:TextBox ID="myInput1" runat="server"></asp:TextBox>
                <asp:Button ID="addBtn1" runat="server" Text="+" OnClick="addBtn1_Click" Width="25px" />
            </td>
            <td class="auto-style17">
                <asp:TextBox ID="myInput2" runat="server"></asp:TextBox>
                <asp:Button ID="addBtn2" runat="server" Text="+" OnClick="addBtn2_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style20" id="myUL1">
                <asp:GridView ID="GridView7" runat="server" DataSourceID="SqlDataSource2" DataKeyNames="ToDoID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowEditing="GridView7_RowEditing" OnRowDeleting="GridView7_RowDeleting"  OnRowUpdating="GridView7_RowUpdating" OnRowCancelingEdit="GridView7_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnSelectedIndexChanged="GridView7_SelectedIndexChanged1">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowCancelButton="True" ShowDeleteButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal1" runat="server" Text='<%# Bind("ToDoContent") %>'></asp:Label>
                                 <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>           
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ToDoContent") %>' title="Enter new ToDo content"></asp:TextBox>
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

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ToDoContent], [ToDoID] FROM [ToDoList] WHERE (([studentID] = @studentID) AND ([Category] = @Category))" DeleteCommand="DELETE FROM [ToDoList] WHERE [ToDoID] = @ToDoID" InsertCommand="INSERT INTO [ToDoList] ([ToDoContent], [ToDoID]) VALUES (@ToDoContent, @ToDoID)" UpdateCommand="UPDATE [ToDoList] SET [ToDoContent] = @ToDoContent WHERE [ToDoID] = @ToDoID">
                    <DeleteParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                        <asp:Parameter DefaultValue="1" Name="Category" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Label ID="noTasksMessage1" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>
            </td>
            <td class="auto-style15" id="myUL2">
                 <asp:GridView ID="GridView8" runat="server" DataSourceID="SqlDataSource3" DataKeyNames="ToDoID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="GridView8_RowDeleting" OnRowEditing="GridView8_RowEditing" OnRowUpdating="GridView8_RowUpdating" OnRowCancelingEdit="GridView7_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal2" runat="server" Text='<%# Bind("ToDoContent") %>'></asp:Label>
                                 <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ToDoContent") %>' title="Enter new ToDo content"></asp:TextBox>
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
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ToDoID], [ToDoContent] FROM [ToDoList] WHERE (([Category] = @Category) AND ([studentID] = @studentID))" DeleteCommand="DELETE FROM [ToDoList] WHERE [ToDoID] = @ToDoID" InsertCommand="INSERT INTO [ToDoList] ([ToDoID], [ToDoContent]) VALUES (@ToDoID, @ToDoContent)" UpdateCommand="UPDATE [ToDoList] SET [ToDoContent] = @ToDoContent WHERE [ToDoID] = @ToDoID">
                    <DeleteParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                        <asp:Parameter Name="ToDoContent" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="2" Name="Category" Type="Int32" />
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Label ID="noTasksMessage2" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>

            </td>
        </tr>
        <tr>
            <td class="auto-style20">&nbsp;</td>
            <td class="auto-style15">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style22">
                <asp:Label ID="Label5" runat="server" Text="Not Important &amp; Urgent - Delegate"></asp:Label>
            </td>
            <td class="auto-style16">
                <asp:Label ID="Label4" runat="server" Text="Not Important &amp; Not Urgent - Delete/Postpone"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:TextBox ID="myInput3" runat="server"></asp:TextBox>
                <asp:Button ID="addBtn3" runat="server" Text="+" OnClick="addBtn3_Click" />
            </td>
            <td class="auto-style15">
                <asp:TextBox ID="myInput4" runat="server"></asp:TextBox>
                <asp:Button ID="addBtn4" runat="server" Text="+" OnClick="addBtn4_Click" Style="width: 24px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style23" id="myUL3">
                 <asp:GridView ID="GridView9" runat="server" DataSourceID="SqlDataSource4" DataKeyNames="ToDoID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="GridView9_RowDeleting" OnRowEditing="GridView9_RowEditing" OnRowUpdating="GridView9_RowUpdating" OnRowCancelingEdit="GridView9_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal3" runat="server" Text='<%# Bind("ToDoContent") %>'></asp:Label>
                                 <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ToDoContent") %>' title="Enter new ToDo content"></asp:TextBox>
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
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ToDoID], [ToDoContent] FROM [ToDoList] WHERE (([Category] = @Category) AND ([studentID] = @studentID))" DeleteCommand="DELETE FROM [ToDoList] WHERE [ToDoID] = @ToDoID" InsertCommand="INSERT INTO [ToDoList] ([ToDoID], [ToDoContent]) VALUES (@ToDoID, @ToDoContent)" UpdateCommand="UPDATE [ToDoList] SET [ToDoContent] = @ToDoContent WHERE [ToDoID] = @ToDoID">
                    <DeleteParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                        <asp:Parameter Name="ToDoContent" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="3" Name="Category" Type="Int32" />
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Label ID="noTasksMessage3" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>
            </td>
            <td class="auto-style18" id="myUL4">
                 <asp:GridView ID="GridView10" runat="server" DataSourceID="SqlDataSource5" DataKeyNames="ToDoID" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="GridView10_RowDeleting" OnRowEditing="GridView10_RowEditing" OnRowUpdating="GridView10_RowUpdating" OnRowCancelingEdit="GridView10_RowCancelingEdit" CssClass="auto-style19" Width="463px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Content">
                            <ItemTemplate>
                                <asp:Label ID="Literal4" runat="server" Text='<%# Bind("ToDoContent") %>'></asp:Label>
                                 <asp:CheckBox ID="chkComplete" runat="server" OnCheckedChanged="chkComplete_CheckedChanged" AutoPostBack="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="EditLabel" runat="server" Text="Please Write Edit ToDo Content HERE: "></asp:Label>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ToDoContent") %>' title="Enter new ToDo content"></asp:TextBox>
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
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ToDoContent], [ToDoID] FROM [ToDoList] WHERE (([Category] = @Category) AND ([studentID] = @studentID))" DeleteCommand="DELETE FROM [ToDoList] WHERE [ToDoID] = @ToDoID" InsertCommand="INSERT INTO [ToDoList] ([ToDoContent], [ToDoID]) VALUES (@ToDoContent, @ToDoID)" UpdateCommand="UPDATE [ToDoList] SET [ToDoContent] = @ToDoContent WHERE [ToDoID] = @ToDoID">
                    <DeleteParameters>
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="4" Name="Category" Type="Int32" />
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ToDoContent" Type="String" />
                        <asp:Parameter Name="ToDoID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Label ID="noTasksMessage4" runat="server" Text="No Do Any Task" Visible="False"></asp:Label>
            </td>

        </tr>
        <tr>
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
    </script>

</asp:Content>
