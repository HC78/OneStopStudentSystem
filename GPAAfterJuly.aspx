<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GPAAfterJuly.aspx.cs" Inherits="fyp.GPAAfterJuly" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            margin-left: 50px;
            margin-right: -20px;
            width: 1000px;
        }

            .container table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }

            .container th, .container td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            .container th {
                background-color: #f2f2f2;
            }

            .container button {
                background-color: #68565B;
                border-style: solid;
                height: 55px;
                width: 184px;
                border-radius: 10px;
                color: white;
                margin-right: 10px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container">
     <h1>
            <asp:Label ID="Label17" runat="server" Font-Size="X-Large" ForeColor="Black" Text="GPA Grade Calculator" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
         </h1>

     <h3>Grade Table for after July 2023 intake students</h3>
     <table>
         <tr>
             <th>Grade</th>
             <th>Mark Range</th>
             <th>Grade Point</th>
             <th>Description</th>
         </tr>
         <tr>
             <td>A+</td>
             <td>90 - 100</td>
             <td>4.0000</td>
             <td>High Distinction</td>
         </tr>
         <tr>
             <td>A</td>
             <td>80 - 89</td>
             <td>4.0000</td>
             <td>Distinction</td>
         </tr>
         <tr>
             <td>A-</td>
             <td>75 - 79</td>
             <td>3.6700</td>
             <td>Distinction</td>
         </tr>
         <tr>
             <td>B+</td>
             <td>70 - 74</td>
             <td>3.3300</td>
             <td>Merit</td>
         </tr>
         <tr>
             <td>B</td>
             <td>65 - 69</td>
             <td>3.0000</td>
             <td>Merit</td>
         </tr>
         <tr>
             <td>B-</td>
             <td>60 - 64</td>
             <td>2.6700</td>
             <td>Merit</td>
         </tr>
         <tr>
             <td>C+</td>
             <td>55 - 59</td>
             <td>2.3300</td>
             <td>Pass</td>
         </tr>
         <tr>
             <td>C</td>
             <td>50 - 54</td>
             <td>2.0000</td>
             <td>Pass</td>
         </tr>
         <tr>
             <td>F</td>
             <td>0 - 49</td>
             <td>0.0000</td>
             <td>Fail</td>
         </tr>
     </table>
     <br/><br/><br/>
     <label for="currentCGPA">Current CGPA:</label>
     <input type="text" id="currentCGPA" placeholder="Enter current CGPA">

     </br>
     <label for="aimedCGPA">Aimed CGPA:</label>
     <input type="text" id="aimedCGPA" placeholder="Enter aimed CGPA">

     </br>
     <label for="totalCredit">Total Credits in Previous Semesters:</label>
     <input type="text" id="totalCredit" placeholder="Enter Total Credits in Previous Semesters">

     <div id="subjectsContainer">
         <h4>Next Semester Subjects (Arrange it according to ability - confident to less confident)</h4>

         <div class="subject-row">
             <label for="credit1">Credit for Subject 1:</label>
             <input type="text" id="credit1" class="subject-credit" placeholder="Enter credit for subject 1">
         </div>

     </div>

     <button type="button" onclick="addSubject()">Add Subject</button>

     <button type="button" onclick="calculatePredictions()">Calculate Predictions</button>
                
         
      <button type="button" id="btnCancel" onclick="cancelForm()" style="background-color: #5F6F52; border-style: solid; height: 55px; width: 184px; border-radius: 10px; color: white;">Cancel</button>
     <div id="resultsContainer">
     </div>
 </div>

 <script>
     let subjectCount = 1;

     function addSubject() {
         if (subjectCount <= 7) {
             subjectCount++;
             const subjectsContainer = document.getElementById('subjectsContainer');

             const newSubjectRow = document.createElement('div');
             newSubjectRow.classList.add('subject-row');

             const label = document.createElement('label');
             label.textContent = `Credit for Subject ${subjectCount}:`;

             const input = document.createElement('input');
             input.type = 'text';
             input.classList.add('subject-credit');
             input.placeholder = `Enter credit for subject ${subjectCount}`;
             input.id = `credit${subjectCount}`;

             newSubjectRow.appendChild(label);
             newSubjectRow.appendChild(input);

             subjectsContainer.appendChild(newSubjectRow);
         } else {
             alert("Students will take up to 8 subjects in a semester.");
         }
     }

     function calculatePredictions() {
         // Retrieve user inputs
         const currentCGPA = parseFloat(document.getElementById('currentCGPA').value);
         const aimedCGPA = parseFloat(document.getElementById('aimedCGPA').value);
         const totalCredit = parseFloat(document.getElementById('totalCredit').value);

         if (isNaN(currentCGPA) || isNaN(aimedCGPA) || isNaN(totalCredit) || subjectCredits.length === 0 ||
             currentCGPA > 4.0 || currentCGPA < 0.0 || aimedCGPA > 4.0 || aimedCGPA < 0.0) {
             let errorMessage = "";

             // Check if all fields are filled with valid numerical values
             if (isNaN(currentCGPA) || isNaN(aimedCGPA) || isNaN(totalCredit) || subjectCredits.length === 0) {
                 errorMessage += "Please enter valid numerical values for all fields.\n";
             }

             // Check if CGPA values are within the valid range
             if (currentCGPA > 4.0) {
                 errorMessage += "Current CGPA should not be more than 4.0.\n";
             }
             if (currentCGPA < 0.0) {
                 errorMessage += "Current CGPA should not be less than 0.0.\n";
             }
             if (aimedCGPA > 4.0) {
                 errorMessage += "Aimed CGPA should not be more than 4.0.\n";
             }
             if (aimedCGPA < 0.0) {
                 errorMessage += "Aimed CGPA should not be less than 0.0.\n";
             }

             // If there are any errors, show the alert and stop further processing
             if (errorMessage) {
                 alert(errorMessage);
                 return;
             }
         }

         const subjectCredits = [];

         // Loop through all dynamically added subject inputs
         for (let i = 1; i <= subjectCount; i++) {
             const credit = parseFloat(document.getElementById(`credit${i}`).value);
             if (!isNaN(credit) && credit > 0) {
                 subjectCredits.push({
                     subject: i,
                     credit: credit
                 });
             }
         }

         // Ensure all inputs are provided
         if (isNaN(currentCGPA) || isNaN(aimedCGPA) || isNaN(totalCredit) || subjectCredits.length === 0) {
             alert("Please enter valid numerical values for all fields.");
             return;
         }

         // Define grade points for different grades
         const gradePoints = {
             'A+': 4.0,
             'A': 4.0,
             'A-': 3.67,
             'B+': 3.33,
             'B': 3.0,
             'B-': 2.67,
             'C+': 2.33,
             'C': 2.0,
             'F': 0.0
         };


         // Calculate total quality points for the current CGPA
         const totalQualityPoints = currentCGPA * totalCredit;

         // Calculate total credits for the next semester dynamically
         const totalNextSemesterCredits = subjectCredits.reduce((total, subject) => total + subject.credit, 0);

         // Calculate total quality points needed for the aimed CGPA
         const totalAimedQualityPoints = aimedCGPA * (totalCredit + totalNextSemesterCredits);

         // Calculate the difference in quality points needed
         let requiredQualityPoints = totalAimedQualityPoints - totalQualityPoints;

         // Sort subjects by credit hours in descending order
         subjectCredits.sort((a, b) => b.credit - a.credit);

         // Initialize an array to store grade and remaining quality points for each subject
         const subjectResults = [];

         // Loop through each subject to calculate grade and remaining quality points
         for (const subject of subjectCredits) {
             const subjectCredit = subject.credit;
             let gradePoint = requiredQualityPoints / subjectCredit;

             // Ensure the calculated grade point is within the valid range
             gradePoint = Math.max(0, Math.min(4.0, gradePoint));

             // Ensure the calculated grade is not lower than 'C'
             const grade = markToGrade(Math.max(gradePoint, gradePoints['C']));

             subjectResults.push({
                 subject: subject.subject,
                 grade: grade,
             });

             // Update remaining quality points for the next iteration
             requiredQualityPoints -= gradePoint * subjectCredit;

             // Stop if we have met or exceeded the required quality points
             if (requiredQualityPoints <= 0) break;
         }

         // Calculate maximum achievable CGPA
         let maxAchievableQualityPoints = totalQualityPoints;
         for (const subject of subjectCredits) {
             maxAchievableQualityPoints += subject.credit * gradePoints['A']; // Assume 'A' grade
         }
         const maxAchievableCGPA = maxAchievableQualityPoints / (totalCredit + totalNextSemesterCredits);

         // Output results
         let resultsHTML = `<p>Grades needed for each subject:</p>`;
         subjectResults.forEach(result => {
             resultsHTML += `<p>Subject ${result.subject}: ${result.grade}</p>`;
         });

         if (requiredQualityPoints > 0) {
             resultsHTML += `<p style="color: red; font-weight: bold;">Unfortunately, eventhough you achieve A's in all subjects, you still cannot achieve the target CGPA in the next semester with the provided subjects.</p>`;
             resultsHTML += `<p style="color: red; font-weight: bold;">The maximum achievable CGPA is ${maxAchievableCGPA.toFixed(4)}.</p>`;
             resultsHTML += `<p style="color: red; font-weight: bold;">Keep trying hard, and you can improve in the next semester!</p>`;
             resultsHTML += `<img src="/Image/sad.gif" alt="Sad" />`;
         } else {
             resultsHTML += `<p style="color: green; font-weight: bold;">Congratulations! You can achieve your target CGPA with the provided subject grade!</p>`;
             resultsHTML += `<img src="/Image/happy.gif" alt="cong" />`;
         }

         document.getElementById('resultsContainer').innerHTML = resultsHTML;
     }


     function cancelForm() {
         document.getElementById('currentCGPA').value = '';
         document.getElementById('aimedCGPA').value = '';
         document.getElementById('totalCredit').value = '';

         const subjectsContainer = document.getElementById('subjectsContainer');
         subjectsContainer.innerHTML = '';

         const h4 = document.createElement('h4');
         h4.textContent = 'Next Semester Subjects (Arrange it according to ability - confident to less confident)';
         subjectsContainer.appendChild(h4);

         const initialSubjectRow = document.createElement('div');
         initialSubjectRow.classList.add('subject-row');

         const label = document.createElement('label');
         label.textContent = `Credit for Subject 1: `;

         const input = document.createElement('input');
         input.type = 'text';
         input.classList.add('subject-credit');
         input.placeholder = `Enter credit for subject 1`;
         input.id = `credit1`;

         initialSubjectRow.appendChild(label);
         initialSubjectRow.appendChild(input);

         subjectsContainer.appendChild(initialSubjectRow);

         subjectCount = 1;

         document.getElementById('resultsContainer').innerHTML = '';
     }


     function markToGrade(gradePoint) {
         if (gradePoint > 3.75 && gradePoint <= 4.0) {
             return 'A+ or A';
         } else if (gradePoint > 3.33 && gradePoint <= 3.67) {
             return 'A-';
         } else if (gradePoint > 3.0 && gradePoint <= 3.33) {
             return 'B+';
         } else if (gradePoint > 2.67 && gradePoint <= 3.0) {
             return 'B';
         } else if (gradePoint > 2.33 && gradePoint <= 2.67) {
             return 'B-';
         } else if (gradePoint > 2.0 && gradePoint <= 2.33) {
             return 'C+';
         } else if (gradePoint > 0.0 && gradePoint <= 2.0) {
             return 'C';
         } else if (gradePoint >= -100 && gradePoint <= 0.0) {
             return 'F';
         } else {
             return 'NULL';
         }
     }
 </script>
</asp:Content>
