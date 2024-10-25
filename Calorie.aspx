﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Calorie.aspx.cs" Inherits="OneStopStudentSystem.Calorie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .calculator-container {
            width: 3000px;
        }

        .input-section {
            margin: 10px 0;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input,
        select {
            width: 590px;
            padding: 8px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }

        button {
            background-color: #68565B;
            border-style: Solid;
            height: 55px;
            width: 184px;
            border-radius: 10px;
            color: white;
        }

            button:hover {
                background-color: #45a049;
            }

        .auto-style15 {
            width: 590px;
        }

        .hidden {
            display: none;
        }
          .glow-bold {
      font-weight: bold;
      color: #00FF00;
      text-shadow: 0 0 10px #00FF00; 
  }
        .auto-style17 {
            width: 135px;
        }
        .auto-style18 {
            width: 635px;
            height: 1036px;
        }
        .auto-style19 {
            height: 81px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="calculator-container">
        <div class="input-section">
            <label for="age">
                <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Calorie Calculator" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
                <br />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <asp:Label ID="lblCong" runat="server" ForeColor="Red"></asp:Label>
                <br />
             </label>
                            <table>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="Label8" runat="server" Font-Size="Large" ForeColor="Black" Text="Recent Data : " Font-Bold="False" Font-Names="Times New Roman" Font-Underline="True"></asp:Label>
                    </td>
                    <td class="auto-style17">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" AutoPostBack="true" PageSize="5">
                            <Columns>
                                <asp:TemplateField HeaderText="Apply Height & Weight">
                                    <ItemTemplate>
                                        <button type="button" onclick='<%# "applyValues(\"" + Eval("Height") + "\", \"" + Eval("Weight") + "\", \"" + Eval("TargetWeight") + "\")" %>'>Apply</button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [dateTime], [Height], [Weight], [CalorieValue], [TargetWeight] FROM [HealthyValue] WHERE ([studentID] = @studentID) AND CalorieValue IS NOT NULL ORDER BY [dateTime] Desc">
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
                    </td>
                    <td class="auto-style17" rowspan="8">
                        <img alt="cal" class="auto-style18" src="Image/foodcal.jpg" /></td>
                </tr>
                <tr>
                    <td>Age (years):<br />
                        <input type="number" id="age" name="age" required class="auto-style15"></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Gender:<br />
                        <select id="gender" name="gender">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select></td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style19">Height (cm):<br />
                        <input type="number" id="height" name="height" required></td>
                    <td class="auto-style19"></td>
                </tr>
                <tr>
                    <td>Weight (kg):<br />
                        <input type="number" id="weight" name="weight" required></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Target Weight (kg):<br />
                        <input type="number" id="targetWeight" name="targetWeight" required></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Number of weeks to Reach Target Weight:<br />
                        <input type="number" id="weeksToReachTarget" name="weeksToReachTarget" required></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Activity Level:<p style="font-size: 12px; border-style: double; width: 590px; text-align: left;">
                        &nbsp;Exercise: 15-30 minutes of elevated heart rate activity.<br />
                        &nbsp;Intense exercise: 45-120 minutes of elevated heart rate activity.<br />
                        &nbsp;Very intense exercise: 2+ hours of elevated heart rate activity.
                        </p>
                        <br />
                       
                        <select id="activityLevel" name="activityLevel">
                            <option value="1.2">Sedentary: little or no exercise</option>
                            <option value="1.375">Light: exercise 1-3 times/week</option>
                            <option value="1.55">Moderate: exercise 4-5 times/week</option>
                            <option value="1.725">Very Active: intense exercise 6-7 times/week</option>
                            <option value="1.9">Extra Active: very intense exercise daily, or physical job</option>
                        </select>
                    </td>
                    <td>
                       
                        &nbsp;</td>
                </tr>
            </table>
        </div>


        <button type="button" onclick="calculateCalories()">Calculate</button>
        &nbsp;
     <button type="button" id="btnCancel" onclick="cancelForm()" style="background-color: #5F6F52; border-style: solid; height: 55px; width: 184px; border-radius: 10px; color: white;">Cancel</button>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" BackColor="#68565B" ForeColor="White" Text="Save" Width="158px" CssClass="hidden" />


        <div id="result"></div>
        <div id="daysToContinue"></div>
        <div id="errDaysToContinue"></div>

        <asp:HiddenField ID="hiddenIsTargetAchieved" runat="server" />
        <p style="color: red; display: none;" id="notice">
            ====RECOMENDED/OPTIMUM CALORIES(NOT ACCORDING YOUR TARGET WEIGHT)====
            <br />
            You can monitor your weight progress over the next few weeks and adjust your calorie intake accordingly
         based on how quickly you lose or gain weight.
            <br />
        </p>
        <div id="nutrientResult1"></div>
        <div id="nutrientResult2"></div>
        <div id="mealSuggestions"></div>
    </div>
    <asp:HiddenField ID="hiddenMaintenanceCalories" runat="server" />
    <asp:HiddenField ID="hiddenWeight" runat="server" />
    <asp:HiddenField ID="hiddenHeight" runat="server" />
    <asp:HiddenField ID="hiddenAge" runat="server" />
    <asp:HiddenField ID="hiddenGender" runat="server" />
    <asp:HiddenField ID="hiddenTargetWeight" runat="server" />
    <script type="text/javascript">
        function toggleNoticeVisibility() {
            var isTargetAchieved = document.getElementById('<%= hiddenIsTargetAchieved.ClientID %>').value === 'true';
            var noticeElement = document.getElementById('notice');
            var nutrientResult1 = document.getElementById('nutrientResult1');
            var nutrientResult2 = document.getElementById('nutrientResult2');

            if (isTargetAchieved) {
                document.getElementById('notice').style.display = 'none';
                noticeElement.style.display = 'none';
                nutrientResult1.style.display = 'none';
                nutrientResult2.style.display = 'none';
            } else {
                noticeElement.style.display = 'block';
                nutrientResult1.style.display = 'block';
                nutrientResult2.style.display = 'block';
            }
        }
    </script>
    <script>
        function calculateCalories() {
            const gender = document.getElementById('gender').value;
            const age = parseFloat(document.getElementById('age').value);
            const weight = parseFloat(document.getElementById('weight').value);
            const height = parseFloat(document.getElementById('height').value);
            const activityLevel = parseFloat(document.getElementById('activityLevel').value);
            const targetWeight = parseFloat(document.getElementById('targetWeight').value);
            const weeksToReachTarget = parseFloat(document.getElementById('weeksToReachTarget').value);

            document.getElementById('<%= hiddenWeight.ClientID %>').value = weight.toFixed(2);
            document.getElementById('<%= hiddenHeight.ClientID %>').value = height.toFixed(2);
            document.getElementById('<%= hiddenAge.ClientID %>').value = age;
            document.getElementById('<%= hiddenGender.ClientID %>').value = gender;
            document.getElementById('<%= hiddenTargetWeight.ClientID %>').value = targetWeight.toFixed(2);

            const notice = document.getElementById('notice');
            notice.style.display = 'block';

            var error = "";
            if (isNaN(age) || isNaN(weight) || isNaN(height) || isNaN(targetWeight) || isNaN(weeksToReachTarget)) {
                 if (isNaN(age)) {
                   error+="Please enter age\n";
      
               }
               if (isNaN(height)) {
                   error += "Please enter height\n";
   
               }
               if (isNaN(weight)) {
                   error += "Please enter weight\n";
     
               }
                 if (isNaN(targetWeight)) {
                  error += "Please enter target weight\n";
     
              }  if (isNaN(weeksToReachTarget)) {
                  error += "Please enter weeks to reach target\n";
     
              }
               if (height <= 0) {
                   error += "Please enter valid height\n";
       
               }
               if (weight <= 0) {
                   error += "Please enter valid weight\n";
  
               }
                 if (targetWeight <= 0) {
                  error += "Please enter valid target weight\n";
  
              }  if (weeksToReachTarget <= 0) {
                  error += "Please enter valid weeks to reach target\n";
  
              }
               if (age < 18) {
                   error += "Please enter valid university student age (more than 18 years old)\n";
       
               }

                alert(error);
                document.getElementById('notice').style.display = 'none';
                return;
            }

            let bmr, targetBmr;

            if (gender === 'Male') {
                //Mifflin-St Jeor formula
                bmr = 9.99 * weight + 6.25 * height - 4.92 * age + 5;
                targetBmr = 9.99 * targetWeight + 6.25 * height - 4.92 * age + 5;
            } else {
                bmr = 9.99 * weight + 6.25 * height - 4.92 * age - 161;
                targetBmr = 9.99 * targetWeight + 6.25 * height - 4.92 * age - 161;
            }

            const maintenanceCalories = bmr * activityLevel;
            document.getElementById('<%= hiddenMaintenanceCalories.ClientID %>').value = maintenanceCalories.toFixed(2);


            const targetMaintenanceCalories = targetBmr * activityLevel;

            const mildWeightLossCalories = maintenanceCalories - 250;  //https://timesofindia.indiatimes.com/life-style/health-fitness/fitness/this-is-the-number-of-calories-you-should-eat-to-lose-weight-maintain-weight-and-gain-weight/photostory/81330014.cms?from=mdr (If you want to lose around 0.25 kilos of weight in a week, you need to create a calorie deficit of 250 calories daily. )
            const weightLossCalories = maintenanceCalories - 500;
            const extremeWeightLossCalories = maintenanceCalories - 1000;
            const mildWeightGainCalories = maintenanceCalories + 250;
            const weightGainCalories = maintenanceCalories + 500;
            const extremeWeightGainCalories = maintenanceCalories + 1000;

            //const mildWeightLossCaloriesTarget = maintenanceCaloriesTarget - 250;
            //const weightLossCaloriesTarget = maintenanceCaloriesTarget - 500;
            //const extremeWeightLossCaloriesTarget = maintenanceCaloriesTarget - 1000;
            // const mildWeightGainCaloriesTarget = maintenanceCaloriesTarget + 250;
            //const weightGainCaloriesTarget = maintenanceCaloriesTarget + 500;
            // const extremeWeightGainCaloriesTarget = maintenanceCaloriesTarget + 1000;

            //const rateOfChange = (targetWeight - weight) / (weeksToReachTarget * 7700);
            //const caloriesToReachTargetWeight = maintenanceCalories + (rateOfChange * 7700 * weeksToReachTarget);

            let daysToContinueMG, daysToContinueWG, daysToContinueEG, daysToContinueML, daysToContinueWL, daysToContinueEL;
            let weeksToContinueMG, weeksToContinueWG, weeksToContinueEG, weeksToContinueML, weeksToContinueWL, weeksToContinueEL;
            const resultElement = document.getElementById('result');
            const daysToContinueElement = document.getElementById('daysToContinue');
            const errDaysToContinueElement = document.getElementById('errDaysToContinue');

            if (targetWeight > weight) { //gain weight 
                resultElement.innerHTML = `
             <p>Maintain Current Weight: ${maintenanceCalories.toFixed(2)} kcal/day</p>
             <p>Mild Weight Gain (0.25 kg/week): ${mildWeightGainCalories.toFixed(2)} kcal/day</p>
             <p>Weight Gain (0.5 kg/week): ${weightGainCalories.toFixed(2)} kcal/day</p>
             <p>Extreme Weight Gain (1 kg/week): ${extremeWeightGainCalories.toFixed(2)} kcal/day</p>
             <p>========================================================================================================</p>
             <p>Calories for Target Weight: ${targetMaintenanceCalories.toFixed(2)} kcal/day</p>
             <p style="font-size:8">You need to eat ${(targetMaintenanceCalories - maintenanceCalories).toFixed(2)} more kcal/day</p>
             `;

                daysToContinueMG = ((targetMaintenanceCalories - maintenanceCalories) / 0.25) * 7.0;
                weeksToContinueMG = (targetMaintenanceCalories - maintenanceCalories) / 0.25;

                daysToContinueWG = ((targetMaintenanceCalories - maintenanceCalories) / 0.5) * 7.0;
                weeksToContinueWG = (targetMaintenanceCalories - maintenanceCalories) / 0.5;

                daysToContinueEG = ((targetMaintenanceCalories - maintenanceCalories) / 1) * 7.0;
                weeksToContinueEG = (targetMaintenanceCalories - maintenanceCalories) / 1;

                daysToContinueElement.innerHTML = `
             <p> Number of days to continue eating according to Calories to Reach Target Weight: ${daysToContinueMG.toFixed(0)} days (${weeksToContinueMG.toFixed(0)} weeks) for gainning 0.25 kg/week</p>
             <p> Number of days to continue eating according to Calories to Reach Target Weight: ${daysToContinueWG.toFixed(0)} days (${weeksToContinueWG.toFixed(0)} weeks) for gainning 0.5 kg/week</p>
             <p> Number of days to continue eating according to Calories to Reach Target Weight: ${daysToContinueEG.toFixed(0)} days (${weeksToContinueEG.toFixed(0)} weeks) for gainning 1 kg/week</p>
             `;
                if (weeksToContinueEG > weeksToReachTarget || weeksToContinueWG > weeksToReachTarget || weeksToContinueMG > weeksToReachTarget) {
                    errDaysToContinueElement.innerHTML = `
                 <p style="color: red"> Sorry, you cannot reach your target weight within ${weeksToReachTarget} week(s) </p>
                 `;
                }
            } else if (targetWeight < weight) {//loss weight
                resultElement.innerHTML = `
             <p> Maintain Current Weight: ${maintenanceCalories.toFixed(2)} kcal / day</p>
             <p>Mild Weight Loss (0.25 kg/week): ${mildWeightLossCalories.toFixed(2)} kcal/day</p>
             <p>Weight Loss (0.5 kg/week): ${weightLossCalories.toFixed(2)} kcal/day</p>
             <p>Extreme Weight Loss (1 kg/week): ${extremeWeightLossCalories.toFixed(2)} kcal/day</p>
             <p>========================================================================================================</p>
             <p>Calories of Target Weight: ${targetMaintenanceCalories.toFixed(2)} kcal/day </p>
             <p style="font-size:8">You need to decrease eating ${(maintenanceCalories - targetMaintenanceCalories).toFixed(2)} less kcal/day</p> 
             `;
                daysToContinueML = ((maintenanceCalories - targetMaintenanceCalories) / 0.25) * 7.0;
                weeksToContinueML = (maintenanceCalories - targetMaintenanceCalories) / 0.25;

                daysToContinueWL = ((maintenanceCalories - targetMaintenanceCalories) / 0.5) * 7.0;
                weeksToContinueWL = (maintenanceCalories - targetMaintenanceCalories) / 0.5;

                daysToContinueEL = ((maintenanceCalories - targetMaintenanceCalories) / 1) * 7.0;
                weeksToContinueEL = (maintenanceCalories - targetMaintenanceCalories) / 1;

                daysToContinueElement.innerHTML = `
             <p> Number of days to continue eating according to Calories to Reach Target Weight: ${daysToContinueML.toFixed(0)} days (${weeksToContinueML.toFixed(0)} week) for lossing 0.25 kg/week</p>
             <p> Number of days to continue eating according to Calories to Reach Target Weight: ${daysToContinueWL.toFixed(0)} days (${weeksToContinueWL.toFixed(0)} week) for lossing 0.5 kg/week</p>
             <p> Number of days to continue eating according to Calories to Reach Target Weight: ${daysToContinueEL.toFixed(0)} days (${weeksToContinueEL.toFixed(0)} week) for lossing 1 kg/week</p>
             `;

                if (weeksToContinueEL > weeksToReachTarget || weeksToContinueWL > weeksToReachTarget || weeksToContinueML > weeksToReachTarget) {
                    errDaysToContinueElement.innerHTML = `
                 <p style="color: red"> Sorry, you cannot reach your target weight within ${weeksToReachTarget} week(s) </p>
                 `;
                } else {
                    errDaysToContinueElement.innerHTML = ``;
                }
            } else if (targetWeight == weight) { //same weight
                resultElement.innerHTML = `
             <p> Maintain Current Weight: ${maintenanceCalories.toFixed(2)} kcal / day</p>
             `;
                daysToContinueElement.innerHTML = ``;
                document.getElementById('notice').style.display = 'block';

            }

            //nutrient 
            const proteinGoalMin = weight * 1.0;
            const proteinGoalMax = weight * 1.2;

            const fatIntakeMin = (maintenanceCalories * 0.2) / 9;
            const fatIntakeMax = (maintenanceCalories * 0.4) / 9;

            const carbIntakeMin = 1200 - (proteinGoalMin * 4) - (fatIntakeMin * 9) / 4; //1200 calorie diet
            const carbIntakeMax = 1200 - (proteinGoalMax * 4) - (fatIntakeMax * 9) / 4;

            const nutrientResultElement1 = document.getElementById('nutrientResult1');
            const nutrientResultElement2 = document.getElementById('nutrientResult2');
            let adjustedCaloriesForGoalMin, adjustedCaloriesForGoalMax; //https://www.myprotein.cn/blog/nutrition/macro-calculator-how-to-calculate-macros-iifym/
            if (targetWeight > weight) { //gain weight 
                adjustedCaloriesForGoalMin = maintenanceCalories + 300;
                adjustedCaloriesForGoalMax = maintenanceCalories + 400;
                nutrientResultElement1.innerHTML = `
             <p>Adjusted Calories for Goal: ${adjustedCaloriesForGoalMin.toFixed(2)} to ${adjustedCaloriesForGoalMax.toFixed(2)} (more better) kcal/day</p>
             `;
            } else if (targetWeight < weight) { //loss weight 
                adjustedCaloriesForGoalMin = maintenanceCalories - 200;
                adjustedCaloriesForGoalMax = maintenanceCalories - 300;
                nutrientResultElement1.innerHTML = `
             <p>Adjusted Calories for Goal: ${adjustedCaloriesForGoalMin.toFixed(2)} to ${adjustedCaloriesForGoalMax.toFixed(2)} (more better) kcal/day</p>
             `;
            } else if (targetWeight == weight) { //same weight
                adjustedCaloriesForGoalMin = maintenanceCalories;
                adjustedCaloriesForGoalMax = maintenanceCalories;
                nutrientResultElement1.innerHTML = `
             <p>Adjusted Calories for Goal: ${adjustedCaloriesForGoalMin.toFixed(2)} kcal/day</p>
             `;
            }
            nutrientResultElement2.innerHTML = `
             <p>Protein Goal: ${proteinGoalMin.toFixed(2)} to ${proteinGoalMax.toFixed(2)} grams/day</p>
             <p>Fat Intake: ${fatIntakeMin.toFixed(2)} to ${fatIntakeMax.toFixed(2)} grams/day</p>
             <p>Carbohydrate Intake: ${carbIntakeMin.toFixed(2)} to ${carbIntakeMax.toFixed(2)} grams/day</p>
         `;

            document.getElementById('<%= btnSave.ClientID %>').classList.remove('hidden');

            //===================
          
           // const proteinCalories = (proteinGoalMin + proteinGoalMax)/2
          //  const fatCalories = (fatIntakeMin + fatIntakeMax) / 2
          //  const carbCalories = (carbIntakeMin + carbIntakeMax) / 2

            const tdee = bmr * activityLevel; // Total Daily Energy Expenditure

            const proteinCalories = tdee * 0.3; // 30% of calories from protein
            const fatCalories = tdee * 0.25; // 25% of calories from fat
            const carbCalories = tdee * 0.45; // 45% of calories from carbohydrates

            const proteinGrams = proteinCalories / 4; // 1 gram of protein = 4 calories
            const fatGrams = fatCalories / 9; // 1 gram of fat = 9 calories
            const carbGrams = carbCalories / 4; // 1 gram of carbohydrate = 4 calories

            suggestMeals(proteinGrams, fatGrams, carbGrams);
        }

        function suggestMeals(proteinGrams, fatGrams, carbGrams) {
            const meals = {
                protein: [
                    { name: "Grilled Chicken Breast", portion: "100g", protein: 31 },
                    { name: "Salmon", portion: "100g", protein: 25 },
                    { name: "Eggs", portion: "2 large (100g)", protein: 13 },
                    { name: "Plain Yogurt", portion: "200g", protein: 20 },
                    { name: "Tofu", portion: "100g", protein: 8 }
                ],
                fat: [
                    { name: "Avocado", portion: "100g", fat: 15 },
                    { name: "Olive Oil", portion: "1 tbsp", fat: 14 },
                    { name: "Almonds", portion: "30g", fat: 15 },
                ],
                carbs: [
                    { name: "Brown Rice", portion: "100g", carbs: 23 },
                    { name: "Sweet Potato", portion: "100g", carbs: 20 },
                    { name: "Oats", portion: "50g", carbs: 27 },
                    { name: "Whole Wheat Bread", portion: "1 slice (30g)", carbs: 15 },
                    { name: "Banana", portion: "1 medium (120g)", carbs: 27 }
                ],
            };

            let mealSuggestionHTML = `Suggested Meals:`;
            mealSuggestionHTML += ``; mealSuggestionHTML += ``;
            // Suggest protein meals
            mealSuggestionHTML += `<br/>Proteins: <br/> ${suggestMealOptions(meals.protein, proteinGrams, "protein")}`;
            mealSuggestionHTML += ``; mealSuggestionHTML += ``;
            // Suggest fat meals
            mealSuggestionHTML += `<br/>Fats: <br/>${suggestMealOptions(meals.fat, fatGrams, "fat")}`;
            mealSuggestionHTML += ``; mealSuggestionHTML += ``;
            // Suggest carb meals
            mealSuggestionHTML += `<br/>Carbohydrates:<br/> ${suggestMealOptions(meals.carbs, carbGrams, "carbs")}`;

            mealSuggestionHTML += ``;

            document.getElementById('mealSuggestions').innerHTML = mealSuggestionHTML;
        }

        function suggestMealOptions(meals, gramsNeeded, type) {
            let suggestions = "";
            let gramsPerMeal = gramsNeeded / meals.length;

            meals.forEach(meal => {
                let grams = meal[type];
                let portions = (gramsPerMeal / grams).toFixed(2);
                let portionString = meal.portion;
                let portionSize = parseFloat(portionString); // Extract the numeric part
                let eatPor = (portions * portionSize).toFixed(2);
                suggestions += `${portions} x ${meal.portion} = ${eatPor}g of ${meal.name} (${grams}g ${type} per portion)<br>`;
            });

            return suggestions;
        }

        function cancelForm() {
            document.getElementById('age').value = '';
            document.getElementById('gender').value = 'male';
            document.getElementById('height').value = '';
            document.getElementById('weight').value = '';
            document.getElementById('targetWeight').value = '';
            document.getElementById('weeksToReachTarget').value = '';
            document.getElementById('activityLevel').value = '1.2';

            document.getElementById('result').innerHTML = '';
            document.getElementById('daysToContinue').innerHTML = '';
            document.getElementById('errDaysToContinue').innerHTML = '';
            document.getElementById('nutrientResult1').innerHTML = '';
            document.getElementById('nutrientResult2').innerHTML = '';
            document.getElementById('notice').style.display = 'none';
            document.getElementById('<%= btnSave.ClientID %>').classList.add('hidden');
            document.getElementById('<%= hiddenWeight.ClientID %>').value = '';
            document.getElementById('<%= hiddenHeight.ClientID %>').value = '';
            document.getElementById('<%= hiddenGender.ClientID %>').value = '';
            document.getElementById('<%= hiddenAge.ClientID %>').value = '';
        }
        function applyValues(height, weight, targetWeight) {
            document.getElementById('height').value = height;
            document.getElementById('weight').value = weight;
            document.getElementById('targetWeight').value = targetWeight;
        }

        function applyValuesA(age, gender) {
            document.getElementById('age').value = age;
            document.getElementById('gender').value = gender;
        }
    </script>
</asp:Content>
