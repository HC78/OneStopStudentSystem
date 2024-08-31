<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Exercise.aspx.cs" Inherits="OneStopStudentSystem.Exercise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container label,
        .container select,
        .container input,
        .container button {
            margin-bottom: 10px;
            display: block;
        }

        .container select,
        .container input {
            width: 100%;
            padding: 8px;
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


        .container button:hover {
            background-color: #45a049;
        }

        .container table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .container th,
        .container td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .container th {
            background-color: #68565B;
            color: #fff;
        }

        .container td {
            background-color: #fff;
        }

        .container #youtubeResults {
            margin-top: 20px;
        }

        .container .exercise-cell {
            cursor: pointer;
            text-decoration: underline;
            color: blue;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" EnablePageMethods="true" />
    <div class="container">
        <asp:Label ID="Label7" runat="server" Font-Size="X-Large" ForeColor="Black" Text="Workout Schedule" Font-Bold="True" Font-Names="Times New Roman"></asp:Label>
        <form id="exerciseForm">
            <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            Suggestion:
            <br />
            <asp:Label ID="lblExerciseSuggestion" runat="server"></asp:Label>
<br />
            Day:
            <select id="day">
                <option value="Monday">Monday</option>
                <option value="Tuesday">Tuesday</option>
                <option value="Wednesday">Wednesday</option>
                <option value="Thursday">Thursday</option>
                <option value="Friday">Friday</option>
                <option value="Saturday">Saturday</option>
                <option value="Sunday">Sunday</option>
            </select>

            <label for="time">Time:</label>
            <select id="time">
                <option value="12:00 AM - 1:00 AM">12:00 AM - 1:00 AM</option>
                <option value="1:00 AM - 2:00 AM">1:00 AM - 2:00 AM</option>
                <option value="2:00 AM - 3:00 AM">2:00 AM - 3:00 AM</option>
                <option value="3:00 AM - 4:00 AM">3:00 AM - 4:00 AM</option>
                <option value="4:00 AM - 5:00 AM">4:00 AM - 5:00 AM</option>
                <option value="5:00 AM - 6:00 AM">5:00 AM - 6:00 AM</option>
                <option value="6:00 AM - 7:00 AM">6:00 AM - 7:00 AM</option>
                <option value="7:00 AM - 8:00 AM">7:00 AM - 8:00 AM</option>
                <option value="8:00 AM - 9:00 AM">8:00 AM - 9:00 AM</option>
                <option value="9:00 AM - 10:00 AM">9:00 AM - 10:00 AM</option>
                <option value="10:00 AM - 11:00 AM">10:00 AM - 11:00 AM</option>
                <option value="11:00 AM - 12:00 PM">11:00 AM - 12:00 PM</option>
                <option value="12:00 PM - 1:00 PM">12:00 PM - 1:00 PM</option>
                <option value="1:00 PM - 2:00 PM">1:00 PM - 2:00 PM</option>
                <option value="2:00 PM - 3:00 PM">2:00 PM - 3:00 PM</option>
                <option value="3:00 PM - 4:00 PM">3:00 PM - 4:00 PM</option>
                <option value="4:00 PM - 5:00 PM">4:00 PM - 5:00 PM</option>
                <option value="5:00 PM - 6:00 PM">5:00 PM - 6:00 PM</option>
                <option value="6:00 PM - 7:00 PM">6:00 PM - 7:00 PM</option>
                <option value="7:00 PM - 8:00 PM">7:00 PM - 8:00 PM</option>
                <option value="8:00 PM - 9:00 PM">8:00 PM - 9:00 PM</option>
                <option value="9:00 PM - 10:00 PM">9:00 PM - 10:00 PM</option>
                <option value="10:00 PM - 11:00 PM">10:00 PM - 11:00 PM</option>
                <option value="11:00 PM - 12:00 AM">11:00 PM - 12:00 AM</option>
            </select>

            <label for="exercise">Exercise:</label>
            <input type="text" id="exercise" placeholder="Enter exercise">

            <button type="button" onclick="addExercise()">Add Exercise</button>
        </form>
        <div id="youtubeResults"></div>
        <table id="timetable">
            <thead>
                <tr>
                    <th>Time</th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                    <th>Sunday</th>
                </tr>
            </thead>
            <tbody>
                <!-- Timetable rows will be generated by JS -->
            </tbody>
        </table>
        <br />
        <div>
            <label for="keywords">Enter Exercise Concern or Any Unknown Exercise Details:</label>
            <input type="text" id="keywords" placeholder="Enter keywords">
            <button type="button" onclick="searchByKeywords()">Search</button>
        </div>
        <div id="youtubeResultsKeyword"></div>
    </div>
    <!--
    <asp:HiddenField ID="hiddenDay" runat="server" />
    <asp:HiddenField ID="hiddenTime" runat="server" />
    <asp:HiddenField ID="hiddenName" runat="server" />
    -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var timeSlots = [
                "12:00 AM - 1:00 AM",
                "1:00 AM - 2:00 AM",
                "2:00 AM - 3:00 AM",
                "3:00 AM - 4:00 AM",
                "4:00 AM - 5:00 AM",
                "5:00 AM - 6:00 AM",
                "6:00 AM - 7:00 AM",
                "7:00 AM - 8:00 AM",
                "8:00 AM - 9:00 AM",
                "9:00 AM - 10:00 AM",
                "10:00 AM - 11:00 AM",
                "11:00 AM - 12:00 PM",
                "12:00 PM - 1:00 PM",
                "1:00 PM - 2:00 PM",
                "2:00 PM - 3:00 PM",
                "3:00 PM - 4:00 PM",
                "4:00 PM - 5:00 PM",
                "5:00 PM - 6:00 PM",
                "6:00 PM - 7:00 PM",
                "7:00 PM - 8:00 PM",
                "8:00 PM - 9:00 PM",
                "9:00 PM - 10:00 PM",
                "10:00 PM - 11:00 PM",
                "11:00 PM - 12:00 AM"
            ];

            var timetable = document.getElementById("timetable");
            var tbody = timetable.querySelector("tbody");
            var youtubeResultsDiv = document.getElementById("youtubeResults");
            var youtubeResultsKeywordDiv = document.getElementById("youtubeResultsKeyword");
            var channelID;

            timeSlots.forEach(function (timeSlot) {
                var tr = document.createElement("tr");
                tr.setAttribute("data-time", timeSlot);
                tbody.appendChild(tr);

                var timeCell = document.createElement("td");
                timeCell.textContent = timeSlot;
                tr.appendChild(timeCell);

                for (var i = 0; i < 7; i++) {
                    var dayCell = document.createElement("td");
                    dayCell.setAttribute("data-day", getDayName(i));
                    tr.appendChild(dayCell);
                }
            });

            window.addExercise = function () {
                var dayInput = document.getElementById("day");
                var timeInput = document.getElementById("time");
                var exerciseInput = document.getElementById("exercise");

                if (exerciseInput.value.trim() === "") {
                    alert("Please enter exercise name.");
                    return;
                }

                var timeSlot = timeInput.value;
                var selectedDay = dayInput.value;
                var exerciseName = exerciseInput.value.trim();

                dayInput.selectedIndex = 0;
                timeInput.selectedIndex = 0;
                exerciseInput.value = "";

                var tr = tbody.querySelector(`tr[data-time="${timeSlot}"]`);
                if (!tr) {
                    console.error("Time slot not found:", timeSlot);
                    return;
                }

                var dayCell = tr.querySelector(`td[data-day="${selectedDay}"]`);
                if (!dayCell) {
                    console.error("Day cell not found:", selectedDay);
                    return;
                }

              //  dayCell.textContent = exerciseName;
                dayCell.classList.add("exercise-cell");

              //  PageMethods.SaveIntoExerciseSchedule(selectedDay, timeSlot, exerciseName, onSaveSuccess, onSaveFailure);

                PageMethods.SaveIntoExerciseSchedule(selectedDay, timeSlot, exerciseName, function (result) {
                    if (result === "EXISTS") {
                        var replace = confirm("An exercise already exists for this day and time. Do you want to replace it?");
                        if (replace) {
                            PageMethods.ReplaceExercise(selectedDay, timeSlot, exerciseName, function (replaceResult) {
                                alert(replaceResult);
                                location.reload();
                            }, function (error) {
                                console.error(error);
                            });
                        } else {
                            alert("No replace");
                            location.reload();
                        }
                    } else {
                        location.reload();
                    }
                }, function (error) {
                    console.error(error);
                });
            };

            function onSaveSuccess(response) {
                alert(response);
                document.getElementById('<%= lblMessage.ClientID %>').innerText = response;
            document.getElementById('<%= lblMessage.ClientID %>').style.color = "green";
            }

            function onSaveFailure(error) {
                alert("Error: " + error.get_message());
                document.getElementById('<%= lblMessage.ClientID %>').innerText = "Error: " + error.get_message();
            document.getElementById('<%= lblMessage.ClientID %>').style.color = "red";
            }


            window.searchByKeywords = function () {
                var keywordInput = document.getElementById("keywords");
                var keywords = keywordInput.value.trim();

                if (keywords === "") {
                    alert("Please enter keywords.");
                    return;
                }

                displayYouTubeResultsKeyword(keywords);

                keywordInput.value = "";
            };

            timetable.addEventListener("click", function (event) {
                var targetCell = event.target;
                if (targetCell.classList.contains("exercise-cell")) {
                    var exerciseName = targetCell.textContent;
                    displayYouTubeResults(exerciseName);
                }
            });

            function displayYouTubeResults(query) {
                var apiKey = 'AIzaSyBafbT2BttAIInM8ugNbBTG45bjCIC_2V0';
                var apiUrl = `https://www.googleapis.com/youtube/v3/search?part=snippet&q=${query}&type=video&key=${apiKey}&channelId=${channelID}`;

                fetch(apiUrl)
                    .then(response => response.json())
                    .then(data => {
                        youtubeResultsDiv.innerHTML = "";
                        data.items.forEach(item => {
                            var videoUrl = `https://www.youtube.com/watch?v=${item.id.videoId}`;
                            var videoTitle = item.snippet.title;

                            if (isExerciseVideo(videoTitle)) {
                                var resultItem = document.createElement("div");
                                resultItem.innerHTML = `<a href="${videoUrl}" target="_blank">${videoTitle}</a>`;
                                youtubeResultsDiv.appendChild(resultItem);
                            }
                        });
                    })
                    .catch(error => console.error('Error fetching YouTube results:', error));
            }


            function isExerciseVideo(title) {
                var exerciseKeywords = ['exercise', 'workout', 'tutorial', 'fitness', 'fat', 'calorie', 'technique', 'properly', 'perfect', 'form', 'runner', 'athlet'];

                var lowercasedTitle = title.toLowerCase();

                return exerciseKeywords.some(keyword => lowercasedTitle.includes(keyword));
            }

            function searchByKeyword() {
                var apiKey = 'AIzaSyBafbT2BttAIInM8ugNbBTG45bjCIC_2V0';
                var results = YouTube.Search.list('id,snippet', {
                    q: 'exercise,workout,tutorial,fitness,fat,calorie,technique,properly,perfect,form,runner,athlet',
                    maxResults: 25,
                    key: apiKey,
                    channelId: channelID
                });

                for (var i in results.items) {
                    var item = results.items[i];
                    Logger.log('[%s] Title: %s', item.id.videoId, item.snippet.title);
                }
            }

            function searchByNewKeyword() {
                var apiKey = 'AIzaSyBafbT2BttAIInM8ugNbBTG45bjCIC_2V0';
                var results = YouTube.Search.list('id,snippet', {
                    q: 'exercise,workout,tutorial,fitness,fat,calorie,technique,properly,perfect,form,runner,athlet',
                    maxResults: 25,
                    key: apiKey,
                    channelId: channelID
                });

                for (var i in results.items) {
                    var item = results.items[i];
                    Logger.log('[%s] Title: %s', item.id.videoId, item.snippet.title);
                }
            }

            function displayYouTubeResultsKeyword(query) {
                var apiKey = 'AIzaSyBafbT2BttAIInM8ugNbBTG45bjCIC_2V0';
                var apiUrl = `https://www.googleapis.com/youtube/v3/search?part=snippet&q=${query}&type=video&key=${apiKey}&channelId=${channelID}`;

                fetch(apiUrl)
                    .then(response => response.json())
                    .then(data => {
                        youtubeResultsKeywordDiv.innerHTML = "";
                        data.items.forEach(item => {
                            var videoUrl = `https://www.youtube.com/watch?v=${item.id.videoId}`;
                            var videoTitle = item.snippet.title;

                            if (isExerciseVideo(videoTitle)) {
                                var resultItem = document.createElement("div");
                                resultItem.innerHTML = `<a href="${videoUrl}" target="_blank">${videoTitle}</a>`;
                                youtubeResultsKeywordDiv.appendChild(resultItem);
                            }
                        });
                    })
                    .catch(error => console.error('Error fetching YouTube results:', error));
            }

            channelID = 'UCDUlDJcPPOOQK-3UrxEyhAQ' || 'UC7t6QJ4u8qF8pI-vibX-BUQ' || 'UCPW6LgHyaHu17_KhqdlLyXw';

            function getDayName(dayIndex) {
                var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
                return days[dayIndex];
            }

            loadSavedExercises();

            function loadSavedExercises() {
                PageMethods.GetSavedExercises(onGetSavedExercisesSuccess, onGetSavedExercisesFailure);
            }

            function onGetSavedExercisesSuccess(data) {
                data.forEach(function (item) {
                    var tr = tbody.querySelector(`tr[data-time="${item.Time}"]`);
                    if (!tr) {
                        console.error("Time slot not found:", item.Time);
                        return;
                    }

                    var dayCell = tr.querySelector(`td[data-day="${item.Day}"]`);
                    if (!dayCell) {
                        console.error("Day cell not found:", item.Day);
                        return;
                    }

                    dayCell.textContent = item.ExerciseName;
                    dayCell.classList.add("exercise-cell");
                });
            }

            function onGetSavedExercisesFailure(error) {
                console.error("Error loading saved exercises:", error.get_message());
            }
        });
    </script>
</asp:Content>
