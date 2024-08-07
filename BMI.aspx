<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BMI.aspx.cs" Inherits="OneStopStudentSystem.BMI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        input,
        select {
            width: 590px;
            padding: 10px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        button {
            background-color: #68565B;
            border-style: Solid;
            height: 55px;
            width: 184px;
            border-radius: 10px;
            color: white;
        }

        #result {
            margin-top: 20px;
            font-weight: bold;
        }

        .CUnderweight {
            color: #20D5FB;
        }

        .CNormal {
            color: #9BB722;
        }

        .COverweight {
            color: #FFD623;
        }

        .CObese {
            color: #FF6C35;
        }

        .SevereThinness {
            color: #D32F2E;
        }

        .ModerateThinness {
            color: #F5511E;
        }

        .MildThinness {
            color: #FF9F00;
        }

        .Normal {
            color: #00ACC4;
        }

        .Overweight {
            color: #009788;
        }

        .ObeseClass1 {
            color: #FF9F00;
        }

        .ObeseClass2 {
            color: #F5511E;
        }

        .ObeseClass3 {
            color: #D32F2E;
        }

        #bmiChartCanvas {
            width: 10px;
            height: 10px;
        }

        #resetChartBtn {
            background-color: #5F6F52;
            border-style: Solid;
            height: 55px;
            width: 184px;
            border-radius: 10px;
            color: white;
        }

        /*   #gaugeCanvas {
         width: 200px;
         height: 200px;
         margin-top: 20px;
         display: block;
         margin: auto;
     }
     */

        label {
            display: block;
            margin-bottom: 5px;
        }

        .auto-style15 {
            width: 0px;
            height: 0px;
        }

        .auto-style16 {
            height: 32px;
            width: 1170px;
        }

        .auto-style17 {
            width: 33%;
            height: 358px;
        }

        .hidden {
            display: none;
        }

        .glow-bold {
            font-weight: bold;
            color: #00FF00;
            text-shadow: 0 0 10px #00FF00; 
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="calculator" style="margin-left: 100px; margin-right: 1000px; width: 2000px">
        <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="BMI Calculator" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
        <label for="age">
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <asp:Label ID="lblCong" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <asp:Label ID="Label8" runat="server" Font-Size="Large" ForeColor="Black" Text="Recent Data : " Font-Bold="False" Font-Names="Times New Roman" Font-Underline="True"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" AutoPostBack="true">
                <Columns>
                    <asp:TemplateField HeaderText="Apply Height & Weight">
                        <ItemTemplate>
                            <button type="button" onclick='<%# "applyValues(\"" + Eval("Height") + "\", \"" + Eval("Weight") + "\")" %>'>Apply</button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [dateTime], [Height], [Weight], [CalorieValue], [BMIValue] FROM [HealthyValue] WHERE ([studentID] = @studentID)">
                <SelectParameters>
                    <asp:SessionParameter Name="studentID" SessionField="UserID" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:TemplateField HeaderText="Apply Age & Gender">
                        <ItemTemplate>
                            <button type="button" onclick='<%# "applyValuesA(\"" + Eval("Age") + "\", \"" + Eval("studentGender") + "\")" %>'>Apply</button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT studentGender, DATEDIFF(YEAR, studentDOB, GETDATE()) AS Age FROM Student WHERE studentID = @StudentID">
                <SelectParameters>
                    <asp:SessionParameter Name="StudentID" SessionField="UserID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            Age:</label>
        <input type="number" id="age" placeholder="Enter your age">

        <label for="gender">Gender:</label>
        <select id="gender">
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>

        <label for="height">Height (cm):</label>
        <input type="number" id="height" placeholder="Enter your height in centimeters">

        <label for="weight">Weight (kg):</label>
        <input type="number" id="weight" placeholder="Enter your weight in kilograms"><br />
        <br />

        <button type="button" onclick="calculateBMI()">Calculate BMI</button>
        <button type="button" id="btnCancel" onclick="cancelForm()" style="background-color: #5F6F52; border-style: solid; height: 55px; width: 184px; border-radius: 10px; color: white;">Cancel</button>
        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" BackColor="#68565B" ForeColor="White" Text="Save" Width="158px" CssClass="hidden" />

        <div id="result"></div>
        <div id="BMIbodyPic"></div>

        <div id="BMIreco" style="width: 690px"></div>
        <table class="auto-style17">
            <tr>
                <td class="auto-style16">
                    <canvas id="bmiChartCanvas" class="auto-style15"></canvas>

                </td>
            </tr>
        </table>
        <br />
        <br />
        <button id="resetChartBtn" type="button" onclick="resetChart()">Reset Chart</button>
        <button id="redoChartBtn" type="button" onclick="redoChart()">Redo Chart</button>
        <!--<canvas id="gaugeCanvas" width="200" height="200"></canvas>-->
    </div>
    <asp:HiddenField ID="hiddenWeight" runat="server" />
    <asp:HiddenField ID="hiddenHeight" runat="server" />
    <asp:HiddenField ID="hiddenAge" runat="server" />
    <asp:HiddenField ID="hiddenGender" runat="server" />
    <asp:HiddenField ID="hiddenBMI" runat="server" />

    <script>

        var bmiChart;

        document.addEventListener("DOMContentLoaded", function () {
            var savedData = JSON.parse(localStorage.getItem("bmiChartData")) || { labels: [], data: [] };

            bmiChart = new Chart(document.getElementById('bmiChartCanvas').getContext('2d'), {
                type: 'line',
                data: {
                    labels: savedData.labels,
                    datasets: [{
                        label: 'BMI Over Time',
                        borderColor: 'rgb(75, 192, 192)',
                        data: savedData.data,
                        fill: false,
                    }]
                },
            });
        });

        function redoChart() {
            //remove latest data point
            if (bmiChart.data.labels.length > 0) {
                bmiChart.data.labels.pop();
                bmiChart.data.datasets[0].data.pop();
                bmiChart.update();

                //save updated data to localStorage
                var savedData = {
                    labels: bmiChart.data.labels,
                    data: bmiChart.data.datasets[0].data
                };
                localStorage.setItem("bmiChartData", JSON.stringify(savedData));
            }
        }

        function updateChart(date, bmi) {
            var currentDate = new Date().toLocaleString(); // Get current date and time
            bmiChart.data.labels.push(currentDate);
            bmiChart.data.datasets[0].data.push(bmi);
            bmiChart.update();

            //save updated data to localStorage
            var savedData = {
                labels: bmiChart.data.labels,
                data: bmiChart.data.datasets[0].data
            };
            localStorage.setItem("bmiChartData", JSON.stringify(savedData));
        }

        function resetChart() {
            //clear the chart data and update
            bmiChart.data.labels = [];
            bmiChart.data.datasets[0].data = [];
            bmiChart.update();

            //clear localStorage
            localStorage.removeItem("bmiChartData");
        }

        function calculateBMI() {
            var age = parseInt(document.getElementById("age").value);
            var gender = document.getElementById("gender").value;
            var height = parseFloat(document.getElementById("height").value);
            var weight = parseFloat(document.getElementById("weight").value);

            document.getElementById('<%= hiddenWeight.ClientID %>').value = weight.toFixed(2);
            document.getElementById('<%= hiddenHeight.ClientID %>').value = height.toFixed(2);
            document.getElementById('<%= hiddenAge.ClientID %>').value = age;
            document.getElementById('<%= hiddenGender.ClientID %>').value = gender;

            if (isNaN(age) || isNaN(height) || isNaN(weight) || age <= 0 || height <= 0 || weight <= 0) {
                alert("Please enter valid age, height, and weight values.");
                return;
            }

            if (age < 18) {
                alert("Please enter valid university student age (more than 18 years old).")
                return;
            }

            var bmi = weight / (Math.pow((height / 100), 2));
            document.getElementById('<%= hiddenBMI.ClientID %>').value = bmi.toFixed(2);

            var interpretation = getInterpretation(bmi, age, gender);

            var resultElement = document.getElementById("result");
            resultElement.innerHTML = `Your BMI is: ${bmi.toFixed(2)}<br>Interpretation: ${interpretation}`;

            var textBodyColor = getBodyColor(age, bmi, gender, interpretation);
            resultElement.className = textBodyColor;

            var pic = getPic(age, bmi, gender, interpretation);
            var BMIbodyPic = document.getElementById("BMIbodyPic");
            BMIbodyPic.innerHTML = `<img src="Image/${pic}" alt="BMI body Picture">`;

            var recommendation = getRecommendation(interpretation);
            var BMIreco = document.getElementById("BMIreco");
            BMIreco.innerHTML = `Recommendation: ${recommendation}`;


            var healthyMinWeight, healthyMaxWeight;

            if (interpretation == "Thinness") {
                healthyMinWeight = (18.5 * Math.pow((height / 100), 2));
                healthyMaxWeight = (24.9 * Math.pow((height / 100), 2));
                var gainWeight = ((healthyMinWeight - weight));
                BMIreco.innerHTML = `Recommendation: ${recommendation}<br>`;
                BMIreco.innerHTML += `Healthy weight for the height: ${healthyMinWeight.toFixed(2)} kg - ${healthyMaxWeight.toFixed(2)} kg<br>`;
                BMIreco.innerHTML += `Gain ${gainWeight.toFixed(2)} kg to reach a BMI of 18.5 kg/m².`;
            } else if (interpretation == "Overweight" || interpretation == "Obese") {
                healthyMinWeight = (18.5 * Math.pow((height / 100), 2));
                healthyMaxWeight = (24.9 * Math.pow((height / 100), 2));
                var loseWeight = ((weight - healthyMaxWeight));
                BMIreco.innerHTML = `Recommendation: ${recommendation}<br>`;
                BMIreco.innerHTML += `Healthy weight for the height: ${healthyMinWeight.toFixed(2)} kg - ${healthyMaxWeight.toFixed(2)} kg<br>`;
                BMIreco.innerHTML += `Lose ${loseWeight.toFixed(2)} kg to reach a BMI of 24.9 kg/m².`;
            } else {
                healthyMinWeight = (18.5 * Math.pow((height / 100), 2));
                healthyMaxWeight = (24.9 * Math.pow((height / 100), 2));
                BMIreco.innerHTML = `Recommendation: ${recommendation}<br>`;
                BMIreco.innerHTML += `Healthy weight for the height: ${healthyMinWeight.toFixed(2)} kg - ${healthyMaxWeight.toFixed(2)} kg`;
            }

            var bmiPrime = (bmi / 25).toFixed(2);
            BMIreco.innerHTML += `<br>BMI Prime: ${bmiPrime}`;

            var ponderalIndex = (weight / Math.pow((height / 100), 3)).toFixed(2);
            BMIreco.innerHTML += `<br>Ponderal Index: ${ponderalIndex}`;

            document.getElementById('<%= btnSave.ClientID %>').classList.remove('hidden');

            // Calculate angle for the gauge pointer (limited to 180 degrees)
            //  var minBMI = 0;
            //   var maxBMI = 100;
            //  var scale = 180 / (maxBMI - minBMI);
            //  var angle = Math.min(180, (bmi - minBMI) * scale);

            // Draw the half-circular gauge
            //  drawGauge(bmi);

            // Update chart with current BMI data

            updateChart(new Date(), bmi);
            PageMethods.CompareBMI(onSuccess, onError);
            // Display the gaugeCanvas
            //  var gaugeCanvas = document.getElementById("gaugeCanvas");
            // gaugeCanvas.style.display = "block";

        }
        function onSuccess(result) {
            var lblCong = document.getElementById('<%= lblCong.ClientID %>');
            lblCong.innerText = result;
            lblCong.style.color = result.includes("Congratulations") ? "green" : "red";
            lblCong.classList.add("glow-bold");
        }

        function onError(result) {
            alert("Error: " + result.get_message());
        }

        function getRecommendation(interpretation) {
            switch (interpretation) {
                case 'Underweight':
                    return "Focus on a balanced diet, including nutrient-dense foods, and consult a healthcare professional or a nutritionist for a balanced diet if needed.";
                case 'Normal':
                    return "Maintain a healthy lifestyle with regular exercise and a balanced diet.";
                case 'Overweight':
                    return "Increase physical activity with a mix of aerobic and strength exercises, adopt a healthier diet and seek professional guidance if necessary.";
                case 'Obese':
                    return "Implement lifestyle changes, including a well-managed diet and regular exercise, and consult healthcare providers for personalized guidance.";
                default:
                    return "Consult with a healthcare professional for personalized advice.";
            }
        }

        /*    function drawGauge(bmi) {
                var canvas = document.getElementById("gaugeCanvas");
                var context = canvas.getContext("2d");
    
                // Clear the canvas
                context.clearRect(0, 0, canvas.width, canvas.height);
    
                // Draw the gauge background
                context.beginPath();
                context.arc(canvas.width / 2, canvas.height, canvas.width / 2 - 5, 0, Math.PI, false);
                context.strokeStyle = "#ddd";
                context.lineWidth = 20; // Wider gauge
                context.stroke();
    
                // Calculate angle for the gauge pointer (limited to 180 degrees)
                var minBMI = 0;
                var maxBMI = 100;
                var scale = 180 / (maxBMI - minBMI);
                var angle = Math.min(180, (bmi - minBMI) * scale);
    
                // Draw colored section (limited to 180 degrees)
                context.beginPath();
                context.arc(canvas.width / 2, canvas.height, canvas.width / 2 - 5, 0, degreesToRadians(angle), false);
                context.strokeStyle = getColor(bmi);
                context.lineWidth = 20; // Wider gauge
                context.stroke();
            }
            function degreesToRadians(degrees) {
                return degrees * (Math.PI / 180);
            }
    
            function getColor(bmi) {
                if (bmi < 18.5) {
                    return "#20D5FB"; // Underweight
                } else if (bmi < 25) {
                    return "#9BB722"; // Normal
                } else if (bmi < 30) {
                    return "#FFD623"; // Overweight
                } else {
                    return "#FF6C35"; // Obese
                }
            }
    */

        function getBodyColor(age, bmi, gender, interpretation) {
            if (age <= 20) {
                if (interpretation == "Underweight") {
                    return "CUnderweight";
                } else if (interpretation == "Normal") {
                    return "CNormal";
                } else if (interpretation == "Overweight") {
                    return "COverweight";
                } else {
                    return "CObese";
                }
            }
            else {
                if (gender == "Male") {
                    if (bmi < 16) {
                        return "SevereThinness";
                    } else if (bmi < 17) {
                        return "ModerateThinness";
                    } else if (bmi < 18.5) {
                        return "MildThinness";
                    } else if (bmi < 25) {
                        return "Normal";
                    } else if (bmi < 30) {
                        return "Overweight";
                    } else if (bmi < 35) {
                        return "ObeseClass1";
                    } else if (bmi < 40) {
                        return "ObeseClass2";
                    } else {
                        return "ObeseClass3";
                    }
                } else {
                    if (bmi < 16) {
                        return "SevereThinness";
                    } else if (bmi < 17) {
                        return "ModerateThinness";
                    } else if (bmi < 18.5) {
                        return "MildThinness";
                    } else if (bmi < 25) {
                        return "Normal";
                    } else if (bmi < 30) {
                        return "Overweight";
                    } else if (bmi < 35) {
                        return "ObeseClass1";
                    } else if (bmi < 40) {
                        return "ObeseClass2";
                    } else {
                        return "ObeseClass3";
                    }
                }
            }
        }

        function cancelForm() {
            document.getElementById('age').value = '';
            document.getElementById('gender').value = 'Male';
            document.getElementById('height').value = '';
            document.getElementById('weight').value = '';
            document.getElementById('<%= btnSave.ClientID %>').classList.add('hidden');
            document.getElementById('<%= hiddenWeight.ClientID %>').value = '';
            document.getElementById('<%= hiddenHeight.ClientID %>').value = '';
            document.getElementById('<%= hiddenGender.ClientID %>').value = '';
            document.getElementById('<%= hiddenAge.ClientID %>').value = '';
        }

        function getPic(age, bmi, gender, interpretation) {
            if (age <= 20) {
                if (gender == "Male") {
                    if (interpretation == "Underweight") {
                        return "cboyu.png";
                    } else if (interpretation == "Normal") {
                        return "cboyn.png";
                    } else if (interpretation == "Overweight") {
                        return "cboyover.png";
                    } else {
                        return "cboyo.png";
                    }
                } else if (gender == "Female") {
                    if (interpretation == "Underweight") {
                        return "cgirlu.png";
                    } else if (interpretation == "Normal") {
                        return "cgirln.png";
                    } else if (interpretation == "Overweight") {
                        return "cgirlover.png";
                    } else {
                        return "cgirlo.png";
                    }
                }
            }
            else {
                if (gender == "Male") {
                    if (bmi < 16) {
                        return "boyst.png";
                    } else if (bmi < 17) {
                        return "boymt.png";
                    } else if (bmi < 18.5) {
                        return "boymildt.png";
                    } else if (bmi < 25) {
                        return "boyn.png";
                    } else if (bmi < 30) {
                        return "boyo.png";
                    } else if (bmi < 35) {
                        return "boyo1.png";
                    } else if (bmi < 40) {
                        return "boyo2.png";
                    } else {
                        return "boyo3.png";
                    }
                } else {
                    if (bmi < 16) {
                        return "girlst.png";
                    } else if (bmi < 17) {
                        return "girlmt.png";
                    } else if (bmi < 18.5) {
                        return "girlmildt.png";
                    } else if (bmi < 25) {
                        return "girln.png";
                    } else if (bmi < 30) {
                        return "girlo.png";
                    } else if (bmi < 35) {
                        return "girlo1.png";
                    } else if (bmi < 40) {
                        return "girlo2.png";
                    } else {
                        return "girlo3.png";
                    }
                }
            }
        }

        //https://www.cdc.gov/healthyweight/assessing/bmi/childrens_bmi/about_childrens_bmi.html
        //further enhancement->the children age below 18 which is not university student yet
        function getInterpretation(bmi, age, gender) {
            if (age == 18) {
                if (gender == "Male") {
                    if (bmi < 18.2) {
                        return "Underweight";
                    } else if (bmi < 25.6) {
                        return "Normal";
                    } else if (bmi < 28.9) {
                        return "Overweight";
                    } else {
                        return "Obese";
                    }
                } else if (gender == "Female") {
                    if (bmi < 17.59) {
                        return "Underweight";
                    } else if (bmi < 25.6) {
                        return "Normal";
                    } else if (bmi < 30.3) {
                        return "Overweight";
                    } else {
                        return "Obese";
                    }
                }
            } else if (age == 19) {
                if (gender == "Male") {
                    if (bmi < 18.75) {
                        return "Underweight";
                    } else if (bmi < 26.37) {
                        return "Normal";
                    } else if (bmi < 29.67) {
                        return "Overweight";
                    } else {
                        return "Obese";
                    }
                } else if (gender == "Female") {
                    if (bmi < 17.8) {
                        return "Underweight";
                    } else if (bmi < 26.1) {
                        return "Normal";
                    } else if (bmi < 31) {
                        return "Overweight";
                    } else {
                        return "Obese";
                    }
                }
            } else if (age == 20) {
                if (gender == "Male") {
                    if (bmi < 19.1) {
                        return "Underweight";
                    } else if (bmi < 27) {
                        return "Normal";
                    } else if (bmi < 30.6) {
                        return "Overweight";
                    } else {
                        return "Obese";
                    }
                } else if (gender == "Female") {
                    if (bmi < 17.8) {
                        return "Underweight";
                    } else if (bmi < 26.5) {
                        return "Normal";
                    } else if (bmi < 31.8) {
                        return "Overweight";
                    } else {
                        return "Obese";
                    }
                }
            }
            else {
                // BMI for adults >=20
                if (bmi < 18.5) {
                    return "Underweight";
                } else if (bmi < 25) {
                    return "Normal";
                } else if (bmi < 30) {
                    return "Overweight";
                } else {
                    return "Obese";
                }

            }
        }

        function applyValues(height, weight) {
            document.getElementById('height').value = height;
            document.getElementById('weight').value = weight;
        }

        function applyValuesA(age, gender) {
            document.getElementById('age').value = age;
            document.getElementById('gender').value = gender;
        }
    </script>

</asp:Content>
