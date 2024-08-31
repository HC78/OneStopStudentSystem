<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="noteTaking2.aspx.cs" Inherits="fyp.noteTaking2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .note-container {
            width: 100%;
            margin-top: 20px;
        }

        .note {
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
        }

        .edit-button, .delete-button {
            margin-top: 5px;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }

        .edit-button {
            background-color: rgb(48,119,34);
            color: white;
        }

        .delete-button {
            background-color: rgb(176,7,7);
            color: white;
        }

            .edit-button:hover, .delete-button:hover {
                opacity: 0.8;
            }

        label {
            display: block;
            margin-bottom: 5px;
        }

        button {
            background-color: #68565B;
            border-style: Solid;
            height: 55px;
            width: 184px;
            border-radius: 10px;
            color: white;
        }

        .auto-style17 {
            height: 132px;
        }

        .auto-style18 {
            height: 106px;
        }

        .auto-style19 {
            height: 60px;
        }

        .lblError0, .lblError1, lblError2, lblError3 {
            visibility: hidden;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Note Taking" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" AutoPostBack="true" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Course" HeaderText="Course" SortExpression="Course" />
                         <asp:TemplateField HeaderText="Color">
                            <ItemTemplate>
                                <div style='width: 40px; height: 40px; background-color: <%# Eval("noteColor") %>;'></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Apply Course & Color">
                            <ItemTemplate>
                                <button type="button" onclick='applyValues("<%# Eval("Course") %>", "<%# Eval("noteColor") %>")'>Apply</button>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [Course], [noteColor] FROM [NoteTaking] WHERE ([studentID] = @studentID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Title : "></asp:Label>
                <asp:Label ID="lblError0" runat="server" ForeColor="Red">*</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtTitle" runat="server" Height="27px" Width="690px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">
                <br />
                <asp:Label ID="Label8" runat="server" Text="Description : "></asp:Label>
                <asp:Label ID="lblError1" runat="server" ForeColor="Red">*</asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style18">
                <asp:TextBox ID="txtDesc" runat="server" Height="68px" Width="690px"></asp:TextBox>
                <br />
            </td>
        </tr>
        <tr>
            <td class="auto-style18">
                <asp:Label ID="LabelImage" runat="server" Text="Image : "></asp:Label>
                <br />
                <asp:FileUpload ID="fileUpload" runat="server" Height="32px" Width="690px" AllowMultiple="true" />
                <br />
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <br />
                <asp:Label ID="Label9" runat="server" Text="Colour : "></asp:Label>
                <br />
                <input type="color" id="ColorPicker" runat="server" value="#eeeeee" /><br />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelCourse" runat="server" Text="Course : "></asp:Label>
                <asp:Label ID="lblError2" runat="server" ForeColor="Red">*</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtCourse" runat="server" Height="27px" Width="690px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <asp:Label ID="LabelWeek" runat="server" Text="Week : "></asp:Label>
                <asp:Label ID="lblError3" runat="server" ForeColor="Red">*</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtWeek" runat="server" Height="27px" Width="690px" TextMode="Number" Min="1" Max="14" OnTextChanged="txtWeek_TextChanged"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAdd" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="BtnAdd_Click" Text="Add Note" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
                &nbsp;
                <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="BtnCancel_Click" Text="Cancel" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <br />
                <asp:Label ID="LabelSearchWeek" runat="server" Text="Search by Week:"></asp:Label>
                <asp:TextBox ID="txtSearchWeek" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="LabelSearchCourse" runat="server" Text="Search by Course:"></asp:Label>
                <asp:TextBox ID="txtSearchCourse" runat="server"></asp:TextBox>
                &nbsp;<br />
                <asp:Button ID="btnSearch" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="35px" OnClick="BtnSearch_Click" Text="Search" Width="113px" Style="border-radius: 10px;" ForeColor="White" />
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <br />
                <asp:Label ID="noNoteMessage1" runat="server" Text="No Any Note" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="noteContainer" runat="server" CssClass="note-container">
                </asp:Panel>
            </td>
        </tr>
    </table>

    <script>
        function applyValues(course, noteColor) {
            document.getElementById('<%= txtCourse.ClientID %>').value = course;
            document.getElementById('<%= ColorPicker.ClientID %>').value = noteColor;
        }
    </script>
</asp:Content>
