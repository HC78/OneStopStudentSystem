<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ToDoList.aspx.cs" Inherits="fyp.ToDoList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">

     
        ul {
            margin: 0;
            padding: 0;
        }
         
            ul li {
                cursor: pointer;
                position: relative;
                padding: 12px 8px 12px 40px;
                list-style-type: none;
                background: #eee;
                font-size: 18px;
                transition: 0.2s;
                /* make the list items unselectable */
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }
      
                ul li:nth-child(odd) {
                    background: #f9f9f9;
                }

                ul li:hover {
                    background: #ddd;
                }

                ul li.checked {
                    background: #888;
                    color: #fff;
                    text-decoration: line-through;
                }

                    ul li.checked::before {
                        content: '';
                        position: absolute;
                        border-color: #fff;
                        border-style: solid;
                        border-width: 0 2px 2px 0;
                        top: 10px;
                        left: 16px;
                        transform: rotate(45deg);
                        height: 15px;
                        width: 7px;
                    }

        .close {
            position: absolute;
            right: 0;
            top: 0;
            padding: 12px 16px 9px 16px;
            color: rgb(102, 0, 255);
        }

            .close:hover {
                background-color: #f44336;
                color: rgb(0, 0, 0);
            }

        .header {
            background-color: #f44336;
            padding: 30px 40px;
            color: white;
            text-align: center;
        }

            .header:after {
                content: "";
                display: table;
                clear: both;
            }

        input {
            margin: 0;
            border: none;
            border-radius: 0;
            width: 75%;
            padding: 10px;
            float: left;
            font-size: 16px;
        }

        .addBtn {
            padding: 10px;
            width: 25%;
            background: #d9d9d9;
            color: #555;
            float: left;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            border-radius: 0;
        }

            .addBtn:hover {
                background-color: #bbb;
            }

        .container {
            float: left;
            width: 50%;
            padding: 10px;
        }

        .edit-task-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            padding: 5px;
            /* background: #ffffff;*/
            color: #555;
            font-size: 14px;
            cursor: pointer;
            transition: 0.3s;
            border-radius: 4px;
        }

            .edit-task-btn:hover {
                background-color: #bbb;
            }

        ul li {
            padding: 12px 8px 12px 60px;
        }

            ul li:hover .edit-task-btn {
                display: inline-block;
            }

        .edit-popup {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }

        .edit-popup-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .edit-popup-close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

            .edit-popup-close:hover,
            .edit-popup-close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div id="myDIV1" class="header">
            <h2 style="margin:5px">Important & Urgent - Do first</h2>
            <input type="text" id="myInput1" placeholder="Title...">
            <span onclick="newElement(1)" class="addBtn">&#43;</span>
        </div>

        <ul id="myUL1">
            <p id="noTasksMessage1">&nbsp; &nbsp; &nbsp; No Any To Do Task</p>
        </ul>
    </div>

    <div class="container">
        <div id="myDIV2" class="header">
            <h2 style="margin:5px">Important & Not Urgent - Schedule</h2>
            <input type="text" id="myInput2" placeholder="Title...">
            <span onclick="newElement(2)" class="addBtn">&#43;</span>
        </div>

        <ul id="myUL2">
            <p id="noTasksMessage2">&nbsp; &nbsp; &nbsp; No Any To Do Task</p>
        </ul>
    </div>

    <div class="container">
        <div id="myDIV3" class="header">
            <h2 style="margin:5px">Not Important & Urgent - Delegate</h2>
            <input type="text" id="myInput3" placeholder="Title...">
            <span onclick="newElement(3)" class="addBtn">&#43;</span>
        </div>

        <ul id="myUL3">
            <p id="noTasksMessage3">&nbsp; &nbsp; &nbsp; No Any To Do Task</p>
        </ul>
    </div>

    <div class="container">
        <div id="myDIV4" class="header">
            <h2 style="margin:5px">Not Important & Not Urgent - Delete/Postpone</h2>
            <input type="text" id="myInput4" placeholder="Title...">
            <span onclick="newElement(4)" class="addBtn">&#43;</span>
        </div>

        <ul id="myUL4">
            <p id="noTasksMessage4">&nbsp; &nbsp; &nbsp; No Any To Do Task</p>
        </ul>
    </div>

    <div id="editPopup" class="edit-popup">
        <div class="edit-popup-content">
            <span class="edit-popup-close" onclick="cancelEdit()">&times;</span>
            <h2>Edit Task</h2>
            <input type="text" id="editInput" placeholder="New Title...">
            <button onclick="confirmEdit()">OK</button>
            <button onclick="cancelEdit()">Cancel</button>
        </div>
    </div>


    <script>
        var isEditTodo = false;
        var todoEditID;

        // Function to check and toggle the visibility of the "No Any To Do Task" message
        function toggleNoTasksMessage(containerId) {
            var noTasksMessage = document.getElementById(`noTasksMessage${containerId}`);
            var taskList = document.getElementById(`myUL${containerId}`).getElementsByTagName("LI");

            var allTasksHidden = true;

            for (var i = 0; i < taskList.length; i++) {
                if (taskList[i].style.display !== "none") {
                    allTasksHidden = false;
                    break;
                }
            }

            if (allTasksHidden) {
                noTasksMessage.style.display = "block"; // Show the message
            } else {
                noTasksMessage.style.display = "none"; // Hide the message
            }
        }
        // Create a "close" and "edit" button and append it to each list item
        function appendButtons(li, containerId) {
            var closeSpan = document.createElement("SPAN");
            var closeIcon = document.createTextNode("\u{1F5D1}");

            var editTaskBtn = document.createElement("SPAN");
            editTaskBtn.className = "edit-task-btn";
            editTaskBtn.innerText = "Edit";

            closeSpan.className = "close";

            closeSpan.appendChild(closeIcon);
            li.appendChild(editTaskBtn);
            li.appendChild(closeSpan);

            // Add event listener to close buttons
            closeSpan.addEventListener('click', function () {
                var div = this.parentElement;
                div.style.display = "none";
                toggleNoTasksMessage(containerId);
            });

            // Add event listener to edit task button
            editTaskBtn.addEventListener('click', function () {
                // Get the closest parent LI element
                let listItem = this.closest('li');

                if (listItem) {
                    let id = parseInt(listItem.dataset.taskid);
                    let editdata = listItem.dataset.taskdata;
                    isEditTodo = true;
                    todoEditID = id;
                    openEditPopup(containerId, editdata);
                }
            });
        }


        // Create a new list item when clicking on the "Add" button
        function newElement(containerId) {
            var li = document.createElement("li");
            var inputValue = document.getElementById(`myInput${containerId}`).value;
            var t = document.createTextNode(inputValue);
            li.appendChild(t);

            if (inputValue === '') {
                alert("You must write something!");
            } else {
                document.getElementById(`myUL${containerId}`).appendChild(li);
                toggleNoTasksMessage(containerId);
            }

            document.getElementById(`myInput${containerId}`).value = "";
            li.dataset.taskid = isEditTodo ? todoEditID : Date.now(); // Assign unique task ID
            li.dataset.taskdata = inputValue.trim();
            appendButtons(li, containerId);
            isEditTodo = false;
            document.getElementById(`addBtn${containerId}`).innerText = "Add";
        }

        function openEditPopup(containerId, editdata) {
            var editPopup = document.getElementById("editPopup");
            var editInput = document.getElementById("editInput");

            // Set the current value in the input field
            editInput.value = editdata;

            // Store the containerId in a data attribute for later use
            editPopup.dataset.containerId = containerId;
            editPopup.style.display = "block";

            // Attach event listeners for the "OK" and "Cancel" buttons
            var confirmButton = editPopup.querySelector("button:nth-of-type(1)");
            var cancelButton = editPopup.querySelector("button:nth-of-type(2)");

            confirmButton.addEventListener('click', function () {
                confirmEdit(containerId);
            });

            cancelButton.addEventListener('click', function () {
                cancelEdit(containerId);
            });
        }

        /// Confirm edit and update task
        function confirmEdit() {
            var editPopup = document.getElementById("editPopup");
            var containerId = editPopup.dataset.containerId;
            var inputValue = document.getElementById("editInput").value;

            if (inputValue !== '') {
                var taskElement = document.querySelector(`#myUL${containerId} li[data-taskid='${todoEditID}']`);

                if (taskElement) {
                    taskElement.dataset.taskdata = inputValue;
                    taskElement.firstChild.nodeValue = inputValue;
                }
            } else {
                alert("Please input task");
            }

            editPopup.style.display = "none";
        }


        // Cancel edit
        function cancelEdit() {
            var editPopup = document.getElementById("editPopup");
            editPopup.style.display = "none";
        }

        // Function to initialize a new container
        function initializeContainer(containerId) {
            setupListEvents(containerId);
            toggleNoTasksMessage(containerId);
        }

        // Add a "checked" symbol when clicking on a list item
        function setupListEvents(containerId) {
            var list = document.querySelector(`#myUL${containerId}`);
            list.addEventListener('click', function (ev) {
                if (ev.target.tagName === 'LI') {
                    ev.target.classList.toggle('checked');
                }
            }, false);
        }

        // Initialize containers
        initializeContainer(1);
        initializeContainer(2);
        initializeContainer(3);
        initializeContainer(4);
        // Add event listener to edit buttons in the header
        document.querySelectorAll('.edit-task-btn').forEach(function (button) {
            button.addEventListener('click', function () {
                var containerId = this.dataset.containerId;
                openEditPopup(containerId);
            });
        });
</script>
</asp:Content>