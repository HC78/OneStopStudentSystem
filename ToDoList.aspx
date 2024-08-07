<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ToDoList.aspx.cs" Inherits="fyp.ToDoList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /* CSS styles for the To-Do List */
        #todoContainer ul {
            margin: 0;
            padding: 0;
        }
        #todoContainer ul li {
            cursor: pointer;
            position: relative;
            padding: 12px 8px 12px 60px;
            list-style-type: none;
            background: #eee;
            font-size: 18px;
            transition: 0.2s;
            user-select: none;
        }
        #todoContainer ul li:nth-child(odd) {
            background: #f9f9f9;
        }
        #todoContainer ul li:hover {
            background: #ddd;
        }
        #todoContainer ul li.checked {
            background: #888;
            color: #fff;
            text-decoration: line-through;
        }
        #todoContainer ul li.checked::before {
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
        #todoContainer .close {
            position: absolute;
            right: 0;
            top: 0;
            padding: 12px 16px 9px 16px;
            color: rgb(102, 0, 255);
        }
        #todoContainer .close:hover {
            background-color: #f44336;
            color: rgb(0, 0, 0);
        }
        #todoContainer .header {
            background-color: #f44336;
            padding: 20px 40px;
            color: white;
            text-align: center;
            display: block;
        }
        #todoContainer .inputContainer {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px 0;
        }
        #todoContainer .header:after {
            content: "";
            display: table;
            clear: both;
        }
        #todoContainer input {
            margin: 0;
            border: none;
            width: 75%;
            padding: 10px;
            font-size: 16px;
            box-sizing: border-box;
        }
        #todoContainer .addBtn {
            padding: 10px;
            width: 25%;
            background: #d9d9d9;
            color: #555;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            box-sizing: border-box;
        }
        #todoContainer .addBtn:hover {
            background-color: #bbb;
        }
        #todoContainer .edit-task-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            padding: 5px;
            color: #555;
            font-size: 14px;
            cursor: pointer;
            transition: 0.3s;
        }
        #todoContainer .edit-task-btn:hover {
            background-color: #bbb;
        }
        #todoContainer .edit-popup {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }
        #todoContainer .edit-popup-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        #todoContainer .edit-popup-close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        #todoContainer .edit-popup-close:hover,
        #todoContainer .edit-popup-close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="todoContainer">
        <div class="container">
            <div id="myDIV1" class="header">
                <h2 style="margin: 5px">Important & Urgent - Do first</h2>
                <asp:TextBox ID="myInput1" runat="server" placeholder="Title..."></asp:TextBox>
                <asp:Button ID="addBtn1" runat="server" Text="+" OnClick="NewElement_Click" CommandArgument="1" CssClass="addBtn" />
            </div>
            <ul id="myUL1" runat="server">
                <p id="noTasksMessage1">&nbsp; &nbsp; &nbsp; No Any To Do Task</p>
            </ul>
        </div>
        <div class="container">
            <div id="myDIV2" class="header">
                <h2 style="margin: 5px">Important & Not Urgent - Schedule</h2>
                <asp:TextBox ID="myInput2" runat="server" placeholder="Title..."></asp:TextBox>
                <asp:Button ID="addBtn2" runat="server" Text="+" OnClick="NewElement_Click" CommandArgument="2" CssClass="addBtn" />
            </div>
            <ul id="myUL2" runat="server">
                <p id="noTasksMessage2">&nbsp; &nbsp; &nbsp; No Any To Do Task</p>
            </ul>
        </div>
        <div class="container">
            <div id="myDIV3" class="header">
                <h2 style="margin: 5px">Not Important & Urgent - Delegate</h2>
                <asp:TextBox ID="myInput3" runat="server" placeholder="Title..."></asp:TextBox>
                <asp:Button ID="addBtn3" runat="server" Text="+" OnClick="NewElement_Click" CommandArgument="3" CssClass="addBtn" />
            </div>
            <ul id="myUL3" runat="server">
                <p id="noTasksMessage3">&nbsp; &nbsp; &nbsp; No Any To Do Task</p>
            </ul>
        </div>
        <div class="container">
            <div id="myDIV4" class="header">
                <h2 style="margin: 5px">Not Important & Not Urgent - Delete/Postpone</h2>
                <asp:TextBox ID="myInput4" runat="server" placeholder="Title..."></asp:TextBox>
                <asp:Button ID="addBtn4" runat="server" Text="+" OnClick="NewElement_Click" CommandArgument="4" CssClass="addBtn" />
            </div>
            <ul id="myUL4" runat="server">
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
                    noTasksMessage.style.display = "block";
                } else {
                    noTasksMessage.style.display = "none";
                }
            }

            function appendButtons(li, containerId) {
                var closeSpan = document.createElement("SPAN");
                var closeIcon = document.createTextNode("\u{1F5D1}");
                var editTaskBtn = document.createElement("SPAN");
                editTaskBtn.className = "edit-task-btn";
                editTaskBtn.innerHTML = "&#9998;";
                editTaskBtn.addEventListener("click", function () {
                    todoEditID = li.dataset.todoid;
                    isEditTodo = true;
                    showEditPopup(li);
                });

                closeSpan.className = "close";
                closeSpan.appendChild(closeIcon);
                closeSpan.onclick = function () {
                    deleteTodo(li, containerId);
                };

                li.appendChild(editTaskBtn);
                li.appendChild(closeSpan);
            }

            function showEditPopup(li) {
                var popup = document.getElementById("editPopup");
                var editInput = document.getElementById("editInput");

                editInput.value = li.firstChild.textContent;
                popup.style.display = "block";
            }

            function confirmEdit() {
                var popup = document.getElementById("editPopup");
                var editInput = document.getElementById("editInput");
                var newValue = editInput.value;

                var taskToEdit = document.querySelector(`li[data-todoid="${todoEditID}"]`);

                if (taskToEdit) {
                    taskToEdit.firstChild.textContent = newValue;
                    popup.style.display = "none";

                    // Call server-side method to update task in the database
                    __doPostBack('UpdateTask', taskToEdit.dataset.todoid + ':' + newValue);
                }
            }

            function cancelEdit() {
                var popup = document.getElementById("editPopup");
                popup.style.display = "none";
            }

            function deleteTodo(li, containerId) {
                var taskId = li.dataset.todoid;
                li.style.display = "none";
                toggleNoTasksMessage(containerId);

                // Call server-side method to delete task from the database
                __doPostBack('DeleteTask', taskId);
            }

            function newElement(containerId) {
               string title = Uri.UnescapeDataString(args[2]);

                var input = document.getElementById(`myInput${containerId}`);
                var inputValue = input.value.trim();

                if (inputValue === '') {
                    alert("You must write something!");
                    return;
                }

                console.log(`Adding task: ${containerId}:${inputValue}`); // Log eventArgument

                var li = document.createElement("li");
                li.appendChild(document.createTextNode(inputValue));
                li.dataset.todoid = Date.now(); // Temporary ID

                document.getElementById(`myUL${containerId}`).appendChild(li);

                appendButtons(li, containerId);
                input.value = "";
                toggleNoTasksMessage(containerId);

                // Construct and pass the eventArgument
               // var eventArgument = `AddTask:${containerId}:${inputValue}`;
               // console.log(`Triggering postback with eventArgument: ${eventArgument}`); // Debug log
                //__doPostBack('', eventArgument);
                var encodedTitle = encodeURIComponent(inputValue);
                var eventArgument = `AddTask:${containerId}:${encodedTitle}`;
                __doPostBack('', eventArgument);

            }



        </script>
    </div>
</asp:Content>
