<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ResetPsw.aspx.cs" Inherits="fyp.ResetPsw" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
            width: 448px;
        }
        .auto-style3 {
            width: 1055px;
        }
        .auto-style4 {
            width: 1055px;
            height: 8px;
        }
        .auto-style17 {
            height: 26px;
            width: 1055px;
        }
            .valid {
        color: green;
    }

    .invalid {
        color: red;
    }

    .validation-message {
        font-size: 14px;
        display: flex;
        align-items: center;
    }

        .validation-message.valid {
            color: green;
        }

        .validation-message.invalid {
            color: red;
        }

        .validation-message i {
            margin-right: 5px;
        }
        .auto-style18 {
            height: 26px;
            width: 742px;
        }
        .auto-style19 {
            width: 742px;
        }
        .auto-style20 {
            width: 742px;
            height: 8px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <table style="margin-right: -120px;">
        <tr>
            <td class="auto-style18">
                &nbsp;</td>
            <td class="auto-style17">
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Reset Password" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style19">
                &nbsp;</td>
            <td class="auto-style3">
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
                <br />
                Old Password<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtConfirmPsw" EnableClientScript="False" ErrorMessage="You must enter old password" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                &nbsp;(Ignore if do not set password before)<br />
                <asp:TextBox ID="txtOldPsw" runat="server" BackColor="White" BorderColor="#BCBCBC" BorderStyle="Solid" Height="32px" Width="379px"  style="border-radius: 7px;" OnTextChanged="txtPsw_TextChanged"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="New Password"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPsw" EnableClientScript="False" ErrorMessage="You must enter new password" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtPsw" runat="server" BackColor="White" BorderColor="#BCBCBC" BorderStyle="Solid" Height="32px" Width="379px"  style="border-radius: 7px;" OnTextChanged="txtPsw_TextChanged"></asp:TextBox>
                &nbsp;
                </td>
        </tr>
        <tr>
            <td class="auto-style19">
                &nbsp;</td>
            <td class="auto-style3">
                <div id="passwordValidationMessage">
                </div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtPsw" ErrorMessage="Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character" ForeColor="Red" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$" />
                </td>
        </tr>
        <tr>
            <td class="auto-style20">
                &nbsp;</td>
            <td class="auto-style4">
                <br />
                <asp:Label ID="Label5" runat="server" Text="Confirm Password"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtConfirmPsw" EnableClientScript="False" ErrorMessage="You must enter confirm password" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtConfirmPsw" runat="server" BackColor="White" BorderColor="#BCBCBC" BorderStyle="Solid" Height="32px" Width="379px"  style="border-radius: 7px; " OnTextChanged="txtConfirmPsw_TextChanged"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
            </td>
        </tr>
        <tr>
            <td class="auto-style19">
              
                &nbsp;</td>
            <td class="auto-style3">
              
                <br />
            </td>
        </tr>
        <tr>
            <td class="auto-style19">
                &nbsp;</td>
            <td class="auto-style3">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style19">
                &nbsp;</td>
            <td class="auto-style3">
                <asp:Button ID="btnReset" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="BtnReset_Click" Text="Reset Password" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
                &nbsp;
                <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="BtnCancel_Click" Text="Cancel" Width="184px" Style="border-radius: 10px;" ForeColor="White" />
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        var passwordInput = document.getElementById('<%= txtPsw.ClientID %>');
        var validationMessage = document.getElementById('passwordValidationMessage');

        passwordInput.addEventListener('input', function () {
            validatePassword(passwordInput.value);
        });

        function validatePassword(password) {
            var criteria = [
                { regex: /.{8,}/, message: "Minimum of 8 characters" },
                { regex: /[A-Z]/, message: "At least 1 upper case character" },
                { regex: /[a-z]/, message: "At least 1 lower case character" },
                { regex: /[0-9]/, message: "At least 1 number character" },
                { regex: /[^a-zA-Z0-9]/, message: "At least 1 special character" }
            ];

            var messages = criteria.map(function (criterion) {
                var isValid = criterion.regex.test(password);
                return `<div class="validation-message ${isValid ? 'valid' : 'invalid'}">
                            <i class="fa-solid ${isValid ? 'fa-check' : 'fa-times'}"></i>
                            ${criterion.message}
                        </div>`;
            });

            validationMessage.innerHTML = messages.join('');
        }
    });
</script>
    <script>
        function CheckBoxRequired_ClientValidate(sender, e) {
            e.IsValid = jQuery(".AcceptedAgreement input:checkbox").is(':checked');
        }

        function validatePassword(sender, args) {
            var password = document.getElementById('<%= txtPsw.ClientID %>').value;
            var minLength = document.getElementById('minLength');
            var upperCase = document.getElementById('upperCase');
            var lowerCase = document.getElementById('lowerCase');
            var number = document.getElementById('number');
            var specialChar = document.getElementById('specialChar');

            var isValid = true;

            // Validate length
            if (password.length >= 8) {
                minLength.classList.remove('invalid');
                minLength.classList.add('valid');
            } else {
                minLength.classList.remove('valid');
                minLength.classList.add('invalid');
                isValid = false;
            }

            // Validate uppercase letter
            if (/[A-Z]/.test(password)) {
                upperCase.classList.remove('invalid');
                upperCase.classList.add('valid');
            } else {
                upperCase.classList.remove('valid');
                upperCase.classList.add('invalid');
                isValid = false;
            }

            // Validate lowercase letter
            if (/[a-z]/.test(password)) {
                lowerCase.classList.remove('invalid');
                lowerCase.classList.add('valid');
            } else {
                lowerCase.classList.remove('valid');
                lowerCase.classList.add('invalid');
                isValid = false;
            }

            // Validate number
            if (/\d/.test(password)) {
                number.classList.remove('invalid');
                number.classList.add('valid');
            } else {
                number.classList.remove('valid');
                number.classList.add('invalid');
                isValid = false;
            }

            // Validate special character
            if (/[\W_]/.test(password)) {
                specialChar.classList.remove('invalid');
                specialChar.classList.add('valid');
            } else {
                specialChar.classList.remove('valid');
                specialChar.classList.add('invalid');
                isValid = false;
            }

            args.IsValid = isValid;
        }

    </script>
</asp:Content>
