<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OneStopStudentSystem.Register" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOM6DjQ9/KFR1F0GzlQME5/R2G7PbX5A6G7D1H5L" crossorigin="anonymous">
    <style>
        .auto-style1 {
            height: 26px;
        }

        .auto-style2 {
            height: 26px;
            width: 17225px;
        }

        .auto-style15 {
            width: 100%;
        }

        .auto-style16 {
            width: 866px;
        }

        .auto-style17 {
            width: 463px;
            height: 1356px;
            margin-left: 20px;
            margin-top: 0px;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="margin-left: 100px; margin-right: -20px;" class="auto-style15">
        <tr>
            <td class="auto-style2">
                <asp:Label ID="Label17" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Sign Up" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
                <br />
            </td>
            <td class="auto-style16" rowspan="14">
                <img src="/Image/picReg.jpg" alt="RegPic" class="auto-style17"></td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:Label ID="Label2" runat="server" Text="Already have an account?"></asp:Label>
                &nbsp;
                <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#5F6F52" OnClick="LinkButton1_Click">Login Now</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
                <br />
                <asp:Label ID="Label1" runat="server" Text="Full Name"></asp:Label>
                <br />
                <asp:TextBox ID="txtName" runat="server" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px" OnTextChanged="txtName_TextChanged" Style="border-radius: 7px;" BorderWidth="1px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" EnableClientScript="False" ErrorMessage="You must enter a name" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <br />
                <asp:Label ID="Label3" runat="server" Text="Mobile Number"></asp:Label>
                &nbsp;
                <asp:Label ID="Label15" runat="server" Text="*It cannot be changed after submission." ForeColor="#68565B"></asp:Label>


                <br />
                <asp:TextBox ID="txtPhone" runat="server" Height="32px" Width="379px" BorderColor="#5F6F52" OnTextChanged="txtPhone_TextChanged" Style="border-radius: 7px;" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtPhone" EnableClientScript="False" ErrorMessage="You must enter a phone number" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                    ControlToValidate="txtPhone" ErrorMessage="Please enter correct mobile number 01x-xxxxxxx or 01x-xxxxxxxx"
                    ValidationExpression="^01[0-9]-[0-9]{7}$|^01[0-9]-[0-9]{8}$" ForeColor="Red"></asp:RegularExpressionValidator>


                <br />
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <br />
                <asp:Label ID="Label4" runat="server" Text="Email Address"></asp:Label>
                &nbsp;
                <asp:Label ID="Label18" runat="server" Text="*It cannot be changed after submission." ForeColor="#68565B"></asp:Label>


                <br />
                <asp:TextBox ID="txtEmail" runat="server" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px" OnTextChanged="txtEmail_TextChanged" Style="border-radius: 7px;" BorderWidth="1px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtEmail" EnableClientScript="False" ErrorMessage="You must enter a email address" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                    ControlToValidate="txtEmail" ErrorMessage="Please enter correct email address with @ and ."
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red"></asp:RegularExpressionValidator>

                <br />


            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <br />
                <asp:Label ID="Label16" runat="server" Text="Username"></asp:Label>
                <br />
                <asp:TextBox ID="txtUsername" runat="server" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px" Style="border-radius: 7px;" OnTextChanged="txtPsw_TextChanged" BorderWidth="1px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUsername" EnableClientScript="False" ErrorMessage="You must enter a username" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td class="auto-style2">
                <br />
                <asp:Label ID="Label5" runat="server" Text="Password"></asp:Label>
                &nbsp;<br />
                <asp:TextBox ID="txtPsw" runat="server" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px" Style="border-radius: 7px;" CssClass="form-control" BorderWidth="1px" OnTextChanged="txtPsw_TextChanged" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPsw" EnableClientScript="False" ErrorMessage="You must enter a password" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <div id="passwordValidationMessage"></div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtPsw"
                ErrorMessage="Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character"
                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$" ForeColor="Red" />

            </td>
        </tr>

        <tr>
            <td class="auto-style2">
                <br />
                <asp:Label ID="Label6" runat="server" Text="Retype Password"></asp:Label>
                <br />
                <asp:TextBox ID="txtRePsw" runat="server" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px" OnTextChanged="txtRePsw_TextChanged" Style="border-radius: 7px;" BorderWidth="1px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtRePsw" EnableClientScript="False" ErrorMessage="You must retype password" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtRePsw" ControlToValidate="txtPsw" ErrorMessage="Password does not match." ForeColor="Red"></asp:CompareValidator>
            </td>
        </tr>

        <tr>
            <td class="auto-style2">
                <br />
                <asp:Label ID="Label7" runat="server" Text="Date Of Birth"></asp:Label>


                &nbsp;
                <asp:Label ID="Label13" runat="server" Text="  *It cannot be changed after submission." ForeColor="#68565B"></asp:Label>


                <br />

                <asp:TextBox ID="txtCal" runat="server" BorderColor="#5F6F52" BorderStyle="Solid" Height="32px" Width="379px" Style="border-radius: 7px;" TextMode="Date" BorderWidth="1px" ForeColor="Black"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtCal" EnableClientScript="False" ErrorMessage="You must choose DOB" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                &nbsp;<asp:CustomValidator ID="customValidatorAge" runat="server" ControlToValidate="txtCal" ErrorMessage="Only university students who are 18 years old or older are eligible to register an account." OnServerValidate="customValidatorAge_ServerValidate" ValidateEmptyText="true" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>



                <br />


            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <br />
                <asp:Label ID="Label8" runat="server" Text="Gender"></asp:Label>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rblGender" EnableClientScript="False" ErrorMessage="You must choose gender" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem>Male </asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <br />
                Location
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlState0" EnableClientScript="False" ErrorMessage="Please choose location" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <br />
                <asp:DropDownList ID="ddlState0" runat="server" Height="32px" Width="379px" Style="border-radius: 7px;" ForeColor="Black">
                    <asp:ListItem Text="&lt;--Select State--&gt;" Value="" Disabled="True" Selected="True"></asp:ListItem>
                    <asp:ListItem>Selangor</asp:ListItem>
                    <asp:ListItem>Kuala Lumpur</asp:ListItem>
                    <asp:ListItem>Putrajaya</asp:ListItem>
                    <asp:ListItem>Penang</asp:ListItem>
                    <asp:ListItem>Kedah</asp:ListItem>
                    <asp:ListItem>Johor</asp:ListItem>
                    <asp:ListItem>Kelantan</asp:ListItem>
                    <asp:ListItem>Melaka</asp:ListItem>
                    <asp:ListItem>Negeri Sembilan</asp:ListItem>
                    <asp:ListItem>Pahang</asp:ListItem>
                    <asp:ListItem>Perak</asp:ListItem>
                    <asp:ListItem>Perlis</asp:ListItem>
                    <asp:ListItem>Sabah</asp:ListItem>
                    <asp:ListItem>Sarawak</asp:ListItem>
                    <asp:ListItem>Labuan</asp:ListItem>
                    <asp:ListItem>Terengganu</asp:ListItem>
                    <asp:ListItem>Others</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
                <br />
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <br />
                <asp:CheckBox ID="cbterms" runat="server" Text="I certify that I am 18 years old or older, and agree to abide by TAR UMT's" />
                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" ForeColor="#5F6F52" OnClick="LinkButton2_Click">Terms &amp; Conditions</asp:LinkButton>
                &nbsp;
                <asp:Label ID="Label11" runat="server" Text="and"></asp:Label>
                &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" ForeColor="#5F6F52" OnClick="LinkButton3_Click">Privacy Policy</asp:LinkButton>
                &nbsp;<asp:Label ID="Label12" runat="server" Text=". I hereby confirm that the information provided is accurate, complete, and up-to-date."></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:CustomValidator runat="server" ID="CheckBoxRequired" EnableClientScript="true"
                OnServerValidate="CheckBoxRequired_ServerValidate"
                ClientValidationFunction="CheckBoxRequired_ClientValidate" ForeColor="Red">You must select this box to proceed.</asp:CustomValidator></td>
        </tr>
        <tr>
            <td class="auto-style2">
                <br />
                <asp:Button ID="btnSubmit" runat="server" BackColor="#68565B" BorderStyle="Solid" Height="55px" OnClick="btnSubmit_Click" Text="Register" Width="184px" Style="border-radius: 10px;" ForeColor="White" />

                &nbsp;&nbsp;
                <asp:Button ID="btnCancel" runat="server" BackColor="#5F6F52" BorderStyle="Solid" Height="55px" OnClick="btnCancel_Click" Text="Cancel" Width="184px" Style="border-radius: 10px;" ForeColor="White" />

                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style2">&nbsp;</td>
        </tr>
    </table>
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
