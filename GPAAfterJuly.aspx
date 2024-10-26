﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="GPAAfterJuly.aspx.cs" Inherits="fyp.GPAAfterJuly" %>

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
                transition: background-color 0.3s ease;
            }

                .container button:hover {
                    background-color: #485240;
                }

                .container button:active {
                    background-color: #4A4A4A;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>
            <asp:Label ID="Label17" runat="server" Font-Size="X-Large" ForeColor="Black" Text="GPA Grade Calculator" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
        </h1>

        <h3>Grade Table for before July 2023 intake students</h3>
        <table>
            <tr>
                <th>Grade</th>
                <th>Mark Range</th>
                <th>Grade Point</th>
            </tr>
            <tr>
                <td>A</td>
                <td>80-100</td>
                <td>4.0000</td>
            </tr>
            <tr>
                <td>A-</td>
                <td>75-79</td>
                <td>3.7500</td>
            </tr>
            <tr>
                <td>B+</td>
                <td>70-74</td>
                <td>3.5000</td>
            </tr>
            <tr>
                <td>B</td>
                <td>65-69</td>
                <td>3.0000</td>
            </tr>
            <tr>
                <td>B-</td>
                <td>60-64</td>
                <td>2.7500</td>
            </tr>
            <tr>
                <td>C+</td>
                <td>55-59</td>
                <td>2.5000</td>
            </tr>
            <tr>
                <td>C</td>
                <td>50-54</td>
                <td>2.0000</td>
            </tr>
            <tr>
                <td>F</td>
                <td>0-49</td>
                <td>0.0000</td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <label for="currentCGPA">Current CGPA:</label>
        <input type="text" id="currentCGPA" placeholder="Enter current CGPA">
        </br>
    <label for="aimedCGPA">Target CGPA:</label>
        <input type="text" id="aimedCGPA" placeholder="Enter target CGPA">
        </br>
    <label for="totalCredit">Total Credits Hours Earned:</label>
        <input type="text" id="totalCredit" placeholder="Enter Total Credits Hours Earned">

        <div id="subjectsContainer">
            <h4>Tips: Next Semester Subjects (Arrange it according to ability - confident to less confident)&nbsp;</h4>

            <div class="subject-row">
                <label for="subjectName1">Subject 1 Name:</label>
                <input type="text" id="subjectName1" class="subject-name" placeholder="Enter subject 1 name">
                <label for="credit1">Credit for Subject 1:</label>
                <input type="text" id="credit1" class="subject-credit" placeholder="Enter credit for subject 1">
                <br />
            </div>
        </div>

        <button type="button" onclick="addSubject()">Add Subject</button>
        <button type="button" onclick="removeSubject()">Remove Subject</button>
        &nbsp;

    <button type="button" onclick="calculatePredictions()">Calculate Predictions</button>

        <button type="button" id="btnCancel" onclick="cancelForm()" style="background-color: #5F6F52; border-style: solid; height: 55px; width: 184px; border-radius: 10px; color: white;">Cancel</button>

        <div id="resultsContainer">
        </div>
    </div>

    <script>
        let subjectCount = 1;

        function addSubject() {
            if (subjectCount < 7) {
                subjectCount++;
                const subjectsContainer = document.getElementById('subjectsContainer');

                const newSubjectRow = document.createElement('div');
                newSubjectRow.classList.add('subject-row');
                newSubjectRow.id = `subjectRow${subjectCount}`;

                // Subject Name Input
                const nameLabel = document.createElement('label');
                nameLabel.textContent = `Subject ${subjectCount} Name:`;

                const nameInput = document.createElement('input');
                nameInput.type = 'text';
                nameInput.classList.add('subject-name');
                nameInput.placeholder = `Enter subject ${subjectCount} name`;
                nameInput.id = `subjectName${subjectCount}`;

                // Credit Input
                const creditLabel = document.createElement('label');
                creditLabel.textContent = `Credit for Subject ${subjectCount}:`;

                const creditInput = document.createElement('input');
                creditInput.type = 'text';
                creditInput.classList.add('subject-credit');
                creditInput.placeholder = `Enter credit for subject ${subjectCount}`;
                creditInput.id = `credit${subjectCount}`;

                newSubjectRow.appendChild(nameLabel);
                newSubjectRow.appendChild(nameInput);
                newSubjectRow.appendChild(creditLabel);
                newSubjectRow.appendChild(creditInput);

                subjectsContainer.appendChild(newSubjectRow);
            } else {
                alert("Students can take up to 7 subjects in a semester.");
            }
        }

        function removeSubject() {
            if (subjectCount > 0) {
                const lastSubjectRow = document.getElementById(`subjectRow${subjectCount}`);

                if (lastSubjectRow) {
                    lastSubjectRow.remove();
                    subjectCount--;
                }
            } else {
                alert("No subjects to remove.");
            }
        }

        function calculatePredictions() {
            // Retrieve user inputs
            const currentCGPA = parseFloat(document.getElementById('currentCGPA').value);
            const aimedCGPA = parseFloat(document.getElementById('aimedCGPA').value);
            const totalCredit = parseFloat(document.getElementById('totalCredit').value);

            const subjectCredits = [];

            // Initialize error message
            let errorMessage = "";

            // Validate totalCredit
            if (isNaN(totalCredit) || totalCredit <= 0) {
                errorMessage += "Please enter a valid positive integer value for total credit field\n";
            }

            // Validate currentCGPA
            if (isNaN(currentCGPA)) {
                errorMessage += "Please enter a valid numerical value for current CGPA\n";
            } else if (currentCGPA < 0.0 || currentCGPA > 4.0) {
                errorMessage += "Current CGPA should be between 0.0 and 4.0\n";
            }

            // Validate aimedCGPA
            if (isNaN(aimedCGPA)) {
                errorMessage += "Please enter a valid numerical value for target CGPA\n";
            } else if (aimedCGPA < 0.0 || aimedCGPA > 4.0) {
                errorMessage += "Target CGPA should be between 0.0 and 4.0\n";
            }

            // Loop through all dynamically added subject inputs
            for (let i = 1; i <= subjectCount; i++) {
                const subjectName = document.getElementById(`subjectName${i}`).value.trim();
                const credit = parseFloat(document.getElementById(`credit${i}`).value);
                if (subjectName === "") {
                    errorMessage += `Please enter a valid subject name for subject ${i}\n`;
                }
                if (isNaN(credit) || credit <= 0) {
                    errorMessage += `Please enter a valid positive numerical value for credit of subject ${i}.\n`;
                } else {
                    subjectCredits.push({
                        subject: i,
                        subjectName: subjectName, // Store subject name here
                        subjectCredit: credit // Store subject credit here
                    });
                }
            }

            if (errorMessage) {
                alert(errorMessage);
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
            const totalNextSemesterCredits = subjectCredits.reduce((total, subject) => total + subject.subjectCredit, 0);

            // Calculate total quality points needed for the aimed CGPA
            const totalAimedQualityPoints = aimedCGPA * (totalCredit + totalNextSemesterCredits);

            // Calculate the difference in quality points needed
            let requiredQualityPoints = totalAimedQualityPoints - totalQualityPoints;

            // Sort subjects by credit hours in descending order
            subjectCredits.sort((a, b) => b.subjectCredit - a.subjectCredit);

            // Initialize an array to store grade and remaining quality points for each subject
            const subjectResults = [];

            // Loop through each subject to calculate grade and remaining quality points
            for (const subject of subjectCredits) {
                const subjectCredit = subject.subjectCredit;
                let gradePoint = requiredQualityPoints / subjectCredit;

                // Ensure the calculated grade point is within the valid range
                gradePoint = Math.max(0, Math.min(4.0, gradePoint));

                // Ensure the calculated grade is not lower than 'C'
                const grade = markToGrade(Math.max(gradePoint, gradePoints['C']));

                subjectResults.push({
                    subject: subject.subject,
                    subjectName: subject.subjectName, // Include subject name in results
                    subjectCredit: subject.subjectCredit, // Include subject credit in results
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
                maxAchievableQualityPoints += subject.subjectCredit * gradePoints['A'];
            }
            const maxAchievableCGPA = maxAchievableQualityPoints / (totalCredit + totalNextSemesterCredits);

            // Output results
            let resultsHTML = `<p>Grades needed for each subject:</p>`;
            subjectResults.forEach(result => {
                resultsHTML += `<p>Subject ${result.subject} (${result.subjectName}, ${result.subjectCredit} credits): ${result.grade}</p>`;
            });


            if (requiredQualityPoints > 0) {
                resultsHTML += `<p style="color: red; font-weight: bold;">Unfortunately, even though you achieve A's in all subjects, you still cannot achieve the target CGPA in the next semester with the provided subjects.</p>`;
                resultsHTML += `<p style="color: red; font-weight: bold;">The maximum achievable CGPA is ${maxAchievableCGPA.toFixed(4)}.</p>`;
                resultsHTML += `<p style="color: red; font-weight: bold;">Keep trying hard, and you can improve in the next semester!</p>`;
                resultsHTML += `<img src="/Image/sad.gif" alt="Sad" />`;
            } else {
                resultsHTML += `<p style="color: green; font-weight: bold;">Congratulations! You can achieve your target CGPA with the provided subject grade!</p>`;
                resultsHTML += `<img src="/Image/happy.gif" alt="Happy" />`;
            }

            document.getElementById('resultsContainer').innerHTML = resultsHTML;
        }

        //https://calculategrades.net/my/tarumt.html ->demo

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
