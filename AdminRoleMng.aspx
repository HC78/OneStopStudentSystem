<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" MaintainScrollPositionOnPostBack="true" CodeBehind="AdminRoleMng.aspx.cs" Inherits="OneStopStudentSystem.AdminRoleMng" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style23 {
            width: 100%;
            margin-left: 21px;
        }

        .auto-style24 {
            height: 32px;
        }

        .auto-style25 {
            height: 52px;
        }
        .auto-style26 {
            height: 39px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table class="auto-style23">
        <tr>
            <td class="auto-style25">
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Role Management" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
            <td class="auto-style25"></td>
            <td class="auto-style25"></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
             <!--
                <asp:Label ID="Label4" runat="server" Text="The newly added user (Temporary User) is : "></asp:Label>
                <br />
                <asp:GridView ID="GridView1" runat="server" EnableViewState="true" AutoGenerateColumns="False" DataKeyNames="userID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AllowPaging="True" AllowSorting="True" Height="46px" Width="375px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="userID" HeaderText="userID" ReadOnly="True" SortExpression="userID" />
                        <asp:BoundField DataField="userRole" HeaderText="userRole" SortExpression="userRole" />
                        <asp:BoundField DataField="tempUserID" HeaderText="tempUserID" SortExpression="tempUserID" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [userID], [userRole], [tempUserID] FROM [UserAccount] WHERE ([userRole] = 'TempUser')"></asp:SqlDataSource>
                <br />
                <asp:Label ID="Label5" runat="server" Text="Assign userID: "></asp:Label>
                &nbsp;<asp:DropDownList ID="ddlUserID" runat="server" DataSourceID="SqlDataSource5" DataTextField="userID" DataValueField="userID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [userID] FROM [UserAccount] WHERE ([userRole] = 'TempUser')"></asp:SqlDataSource>
                &nbsp;&nbsp;
                <asp:Label ID="Label6" runat="server" Text="to role: "></asp:Label>
                <asp:DropDownList ID="ddlNewRole" runat="server">
                    <asp:ListItem Value="NewRole">&lt;--New Role--&gt;</asp:ListItem>
                    <asp:ListItem Value="Admin">Admin</asp:ListItem>
                    <asp:ListItem Value="Student">Student</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSubmit" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="btnSubmit_Click" Text="Save Changes" Width="388px" Style="border-radius: 10px;" ForeColor="White" />
           --></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td class="auto-style26">
                <asp:Label ID="Label8" runat="server" Font-Size="X-Large" ForeColor="Black" Text="View Role Details" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
            <td class="auto-style26"></td>
            <td class="auto-style26"></td>
        </tr>
        <tr>
            <td class="auto-style24">
                <asp:Label ID="Label3" runat="server" Text="Select role: "></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Height="19px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem>&lt;--Role--&gt;</asp:ListItem>
                    <asp:ListItem>Admin</asp:ListItem>
                    <asp:ListItem>Student</asp:ListItem>
                </asp:DropDownList>
                 <asp:CheckBox ID="chkLockedAccounts" runat="server" Text="Locked Account Users" AutoPostBack="True" OnCheckedChanged="chkLockedAccounts_CheckedChanged" />
                <br />
                <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="Vertical" AllowPaging="True">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src="Image/<%#Eval("adminImage")%>" style="width: 80px;" height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Admin] WHERE [adminId] = @adminId" InsertCommand="INSERT INTO [Admin] ([adminId], [adminUsername], [adminPassword], [adminName], [adminMobileNo], [adminEmail], [adminDOB], [adminGender], [adminState], [adminImage], [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime]) VALUES (@adminId, @adminUsername, @adminPassword, @adminName, @adminMobileNo, @adminEmail, @adminDOB, @adminGender, @adminState, @adminImage, @FailedLoginAttempts, @IsAccountLocked, @AccountLockTime)" SelectCommand="SELECT [adminId], [adminUsername], [adminPassword], [adminName], [adminMobileNo], [adminEmail], FORMAT(adminDOB, 'dd/MM/yyyy') AS adminDOB, [adminGender], [adminState], [adminImage] FROM [Admin]" UpdateCommand="UPDATE [Admin] SET [adminUsername] = @adminUsername, [adminPassword] = @adminPassword, [adminName] = @adminName, [adminMobileNo] = @adminMobileNo, [adminEmail] = @adminEmail, [adminDOB] = @adminDOB, [adminGender] = @adminGender, [adminState] = @adminState, [adminImage] = @adminImage, [FailedLoginAttempts] = @FailedLoginAttempts, [IsAccountLocked]= @IsAccountLocked, [AccountLockTime]=@AccountLockTime  WHERE [adminId] = @adminId">
                    <DeleteParameters>
                        <asp:Parameter Name="adminId" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="adminId" Type="String" />
                        <asp:Parameter Name="adminUsername" Type="String" />
                        <asp:Parameter Name="adminPassword" Type="String" />
                        <asp:Parameter Name="adminName" Type="String" />
                        <asp:Parameter Name="adminMobileNo" Type="String" />
                        <asp:Parameter Name="adminEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="adminDOB" />
                        <asp:Parameter Name="adminGender" Type="String" />
                        <asp:Parameter Name="adminState" Type="String" />
                        <asp:Parameter Name="adminImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" />
                        <asp:Parameter Name="IsAccountLocked" />
                        <asp:Parameter Name="AccountLockTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="adminUsername" Type="String" />
                        <asp:Parameter Name="adminPassword" Type="String" />
                        <asp:Parameter Name="adminName" Type="String" />
                        <asp:Parameter Name="adminMobileNo" Type="String" />
                        <asp:Parameter Name="adminEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="adminDOB" />
                        <asp:Parameter Name="adminGender" Type="String" />
                        <asp:Parameter Name="adminState" Type="String" />
                        <asp:Parameter Name="adminImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" />
                        <asp:Parameter Name="IsAccountLocked" />
                        <asp:Parameter Name="AccountLockTime" />
                        <asp:Parameter Name="adminId" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="GridView4" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource4" ForeColor="Black" GridLines="Vertical" AllowPaging="True" OnRowCommand="GridView4_RowCommand" OnRowDataBound="GridView4_RowDataBound">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src="Image/<%#Eval("studentImage")%>" style="width: 80px;" height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnResetAccount" runat="server" Text="Unlock Account" CommandName="ResetAccount" CommandArgument='<%# Eval("studentID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Student] WHERE [studentID] = @studentID" InsertCommand="INSERT INTO [Student] ([studentID], [studenttUsername], [studentPassword], [studentName], [studentMobileNo], [studentEmail], [studentDOB], [studentGender], [studentState], [studentImage], [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime]) VALUES (@studentID, @studentUsername, @studentPassword, @studentName, @studentMobileNo, @studentEmail, @studentDOB, @studentGender, @studentState, @studentImage, @FailedLoginAttempts, @IsAccountLocked, @AccountLockTime)" SelectCommand="SELECT [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime], [studentID], [studentUsername], [studentPassword], [studentName], [studentMobileNo], [studentEmail], FORMAT(studentDOB, 'dd/MM/yyyy') AS studentDOB, [studentGender], [studentState], [studentImage] FROM [Student]" UpdateCommand="UPDATE [Student] SET [studentUsername] = @studentUsername, [studentPassword] = @studentPassword, [studentName] = @studentName, [studentMobileNo] = @studentMobileNo, [studentEmail] = @studentEmail, [studentDOB] = @studentDOB, [studentGender] = @studentGender, [studentState] = @studentState, [studentImage] = @studentImage, [FailedLoginAttempts] = @FailedLoginAttempts, [IsAccountLocked]= @IsAccountLocked, [AccountLockTime]=@AccountLockTime WHERE [studentID] = @studentID">

                    <DeleteParameters>
                        <asp:Parameter Name="studentID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="studentID" Type="String" />
                        <asp:Parameter Name="studentUsername" Type="String" />
                        <asp:Parameter Name="studentPassword" Type="String" />
                        <asp:Parameter Name="studentName" Type="String" />
                        <asp:Parameter Name="studentMobileNo" Type="String" />
                        <asp:Parameter Name="studentEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="studentDOB" />
                        <asp:Parameter Name="studentGender" Type="String" />
                        <asp:Parameter Name="studentState" Type="String" />
                        <asp:Parameter Name="studentImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="studentUsername" Type="String" />
                        <asp:Parameter Name="studentPassword" Type="String" />
                        <asp:Parameter Name="studentName" Type="String" />
                        <asp:Parameter Name="studentMobileNo" Type="String" />
                        <asp:Parameter Name="studentEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="studentDOB" />
                        <asp:Parameter Name="studentGender" Type="String" />
                        <asp:Parameter Name="studentState" Type="String" />
                        <asp:Parameter Name="studentImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                        <asp:Parameter Name="studentID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>


                <br />

                <asp:GridView ID="GridView6" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource7" ForeColor="Black" GridLines="Vertical" AllowPaging="True" OnRowCommand="GridView4_RowCommand" OnRowDataBound="GridView4_RowDataBound">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src="Image/<%#Eval("studentImage")%>" style="width: 80px;" height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnResetAccount0" runat="server" Text="Unlock Account" CommandName="ResetAccount" CommandArgument='<%# Eval("studentID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Student] WHERE [studentID] = @studentID" InsertCommand="INSERT INTO [Student] ([studentID], [studenttUsername], [studentPassword], [studentName], [studentMobileNo], [studentEmail], [studentDOB], [studentGender], [studentState], [studentImage], [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime]) VALUES (@studentID, @studentUsername, @studentPassword, @studentName, @studentMobileNo, @studentEmail, @studentDOB, @studentGender, @studentState, @studentImage, @FailedLoginAttempts, @IsAccountLocked, @AccountLockTime)" SelectCommand="SELECT [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime], [studentID], [studentUsername], [studentPassword], [studentName], [studentMobileNo], [studentEmail], FORMAT(studentDOB, 'dd/MM/yyyy') AS studentDOB, [studentGender], [studentState], [studentImage] FROM [Student] WHERE IsAccountLocked = 1" UpdateCommand="UPDATE [Student] SET [studentUsername] = @studentUsername, [studentPassword] = @studentPassword, [studentName] = @studentName, [studentMobileNo] = @studentMobileNo, [studentEmail] = @studentEmail, [studentDOB] = @studentDOB, [studentGender] = @studentGender, [studentState] = @studentState, [studentImage] = @studentImage, [FailedLoginAttempts] = @FailedLoginAttempts, [IsAccountLocked]= @IsAccountLocked, [AccountLockTime]=@AccountLockTime WHERE [studentID] = @studentID">

                    <DeleteParameters>
                        <asp:Parameter Name="studentID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="studentID" Type="String" />
                        <asp:Parameter Name="studentUsername" Type="String" />
                        <asp:Parameter Name="studentPassword" Type="String" />
                        <asp:Parameter Name="studentName" Type="String" />
                        <asp:Parameter Name="studentMobileNo" Type="String" />
                        <asp:Parameter Name="studentEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="studentDOB" />
                        <asp:Parameter Name="studentGender" Type="String" />
                        <asp:Parameter Name="studentState" Type="String" />
                        <asp:Parameter Name="studentImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="studentUsername" Type="String" />
                        <asp:Parameter Name="studentPassword" Type="String" />
                        <asp:Parameter Name="studentName" Type="String" />
                        <asp:Parameter Name="studentMobileNo" Type="String" />
                        <asp:Parameter Name="studentEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="studentDOB" />
                        <asp:Parameter Name="studentGender" Type="String" />
                        <asp:Parameter Name="studentState" Type="String" />
                        <asp:Parameter Name="studentImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                        <asp:Parameter Name="studentID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>


                <br />

                <asp:GridView ID="GridView5" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource6" ForeColor="Black" GridLines="Vertical" AllowPaging="True" OnRowCommand="GridView5_RowCommand" OnRowDataBound="GridView5_RowDataBound">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src="Image/<%#Eval("tempUserImage")%>" style="width: 80px;" height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnResetAccount" runat="server" Text="Unlock Account" CommandName="ResetAccount" CommandArgument='<%# Eval("tempUserID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [TempUser] WHERE [tempUserID] = @tempUserID" InsertCommand="INSERT INTO [TempUser] ([tempUserID], [tempUsertUsername], [tempUserPassword], [tempUserName], [tempUserMobileNo], [tempUserEmail], [tempUserDOB], [tempUserGender], [tempUserState], [tempUserImage], [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime]) VALUES (@tempUserID, @tempUserUsername, @tempUserPassword, @tempUserName, @tempUserMobileNo, @tempUserEmail, @tempUserDOB, @tempUserGender, @tempUserState, @tempUserImage, @FailedLoginAttempts, @IsAccountLocked, @AccountLockTime)" SelectCommand="SELECT [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime], [tempUserID], [tempUserUsername], [tempUserPassword], [tempUserName], [tempUserMobileNo], [tempUserEmail], FORMAT(tempUserDOB, 'dd/MM/yyyy') AS tempUserDOB, [tempUserGender], [tempUserState], [tempUserImage] FROM [TempUser]" UpdateCommand="UPDATE [TempUser] SET [tempUserUsername] = @tempUserUsername, [tempUserPassword] = @tempUserPassword, [tempUserName] = @tempUserName, [tempUserMobileNo] = @tempUserMobileNo, [tempUserEmail] = @tempUserEmail, [tempUserDOB] = @tempUserDOB, [tempUserGender] = @tempUserGender, [tempUserState] = @tempUserState, [tempUserImage] = @tempUserImage, [FailedLoginAttempts] = @FailedLoginAttempts, [IsAccountLocked]= @IsAccountLocked, [AccountLockTime]=@AccountLockTime WHERE [tempUserID] = @tempUserID">

                    <DeleteParameters>
                        <asp:Parameter Name="tempUserID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="tempUserID" Type="String" />
                        <asp:Parameter Name="tempUserUsername" Type="String" />
                        <asp:Parameter Name="tempUserPassword" Type="String" />
                        <asp:Parameter Name="tempUserName" Type="String" />
                        <asp:Parameter Name="tempUserMobileNo" Type="String" />
                        <asp:Parameter Name="tempUserEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="tempUserDOB" />
                        <asp:Parameter Name="tempUserGender" Type="String" />
                        <asp:Parameter Name="tempUserState" Type="String" />
                        <asp:Parameter Name="tempUserImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="tempUserUsername" Type="String" />
                        <asp:Parameter Name="tempUserPassword" Type="String" />
                        <asp:Parameter Name="tempUserName" Type="String" />
                        <asp:Parameter Name="tempUserMobileNo" Type="String" />
                        <asp:Parameter Name="tempUserEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="tempUserDOB" />
                        <asp:Parameter Name="tempUserGender" Type="String" />
                        <asp:Parameter Name="tempUserState" Type="String" />
                        <asp:Parameter Name="tempUserImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                        <asp:Parameter Name="tempUserID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>


                <br />

                <asp:GridView ID="GridView7" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource8" ForeColor="Black" GridLines="Vertical" AllowPaging="True" OnRowCommand="GridView5_RowCommand" OnRowDataBound="GridView5_RowDataBound">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src="Image/<%#Eval("tempUserImage")%>" style="width: 80px;" height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnResetAccount1" runat="server" Text="Unlock Account" CommandName="ResetAccount" CommandArgument='<%# Eval("tempUserID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [TempUser] WHERE [tempUserID] = @tempUserID" InsertCommand="INSERT INTO [TempUser] ([tempUserID], [tempUsertUsername], [tempUserPassword], [tempUserName], [tempUserMobileNo], [tempUserEmail], [tempUserDOB], [tempUserGender], [tempUserState], [tempUserImage], [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime]) VALUES (@tempUserID, @tempUserUsername, @tempUserPassword, @tempUserName, @tempUserMobileNo, @tempUserEmail, @tempUserDOB, @tempUserGender, @tempUserState, @tempUserImage, @FailedLoginAttempts, @IsAccountLocked, @AccountLockTime)" SelectCommand="SELECT [FailedLoginAttempts], [IsAccountLocked], [AccountLockTime], [tempUserID], [tempUserUsername], [tempUserPassword], [tempUserName], [tempUserMobileNo], [tempUserEmail], FORMAT(tempUserDOB, 'dd/MM/yyyy') AS tempUserDOB, [tempUserGender], [tempUserState], [tempUserImage] FROM [TempUser] WHERE [IsAccountLocked] = 1" UpdateCommand="UPDATE [TempUser] SET [tempUserUsername] = @tempUserUsername, [tempUserPassword] = @tempUserPassword, [tempUserName] = @tempUserName, [tempUserMobileNo] = @tempUserMobileNo, [tempUserEmail] = @tempUserEmail, [tempUserDOB] = @tempUserDOB, [tempUserGender] = @tempUserGender, [tempUserState] = @tempUserState, [tempUserImage] = @tempUserImage, [FailedLoginAttempts] = @FailedLoginAttempts, [IsAccountLocked]= @IsAccountLocked, [AccountLockTime]=@AccountLockTime WHERE [tempUserID] = @tempUserID">

                    <DeleteParameters>
                        <asp:Parameter Name="tempUserID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="tempUserID" Type="String" />
                        <asp:Parameter Name="tempUserUsername" Type="String" />
                        <asp:Parameter Name="tempUserPassword" Type="String" />
                        <asp:Parameter Name="tempUserName" Type="String" />
                        <asp:Parameter Name="tempUserMobileNo" Type="String" />
                        <asp:Parameter Name="tempUserEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="tempUserDOB" />
                        <asp:Parameter Name="tempUserGender" Type="String" />
                        <asp:Parameter Name="tempUserState" Type="String" />
                        <asp:Parameter Name="tempUserImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="tempUserUsername" Type="String" />
                        <asp:Parameter Name="tempUserPassword" Type="String" />
                        <asp:Parameter Name="tempUserName" Type="String" />
                        <asp:Parameter Name="tempUserMobileNo" Type="String" />
                        <asp:Parameter Name="tempUserEmail" Type="String" />
                        <asp:Parameter DbType="Date" Name="tempUserDOB" />
                        <asp:Parameter Name="tempUserGender" Type="String" />
                        <asp:Parameter Name="tempUserState" Type="String" />
                        <asp:Parameter Name="tempUserImage" Type="String" />
                        <asp:Parameter Name="FailedLoginAttempts" Type="Int32" />
                        <asp:Parameter Name="IsAccountLocked" Type="Boolean" />
                        <asp:Parameter Name="AccountLockTime" Type="DateTime" />
                        <asp:Parameter Name="tempUserID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>


                <br />

            </td>
            <td class="auto-style24"></td>
            <td class="auto-style24"></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
