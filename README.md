![image](https://github.com/user-attachments/assets/ef56ab84-c19d-45b7-b60a-b6f72a5a1bc1)<b>Abstract</b><br/>
This One-Stop Student System aims to solve common challenges faced by students such as browser cluttering and memory usage, physical health concerns, time management issues, lack of motivation and goal setting, information access and communication barriers problem. This system provides a comprehensive study system that simplifies and enhances the student experience by integrating academic, health and personal management tools into a single interface. The system scope is the three main modules, study, health and personal categories, each of the categories containing multiple features to meet a wide range of student needs and expectations. For instance, the study module consists of note taking, grade calculator, measurement converter, video teaching pronunciation and calendar reminder function for academic support, the health module offers BMI calculator, calorie calculator and exercise workout schedule for health monitoring and the personal module include to-do list, goal getter and AI chatbot to assist with various daily tasks.
<br/><br/>The Feature-Driven Development (Agile methodology) is adopted throughout the development process to ensure frequent progress updates, early feedback and adaptability to changing requirements. Thorough testing is conducted to ensure the system's usability, reliability and functionality to ensure that the system is user-friendly and well-functioning.
<br/><br/>The four objectives of the system have been achieved with all the functions provided in the system. However, the system also highlighted some potential areas for future improvement, such as adding a game module to help students relax and integrating VR technology to allow students to explore the campus environment virtually which are outside the current project scope. Overall, the One-Stop Student System provides students with convenient access to a wide range of study, health and personal category functions which ease the students’ study journey. 

<b>Implementation</b><br/> 
The One-Stop Student system is developed using Microsoft Visual Studio, a free and user-friendly integrated development environment (IDE). ASP.NET is used which is a free web framework for building great websites and web applications using HTML, CSS, and JavaScript.
HTML is used for the structural layout of web pages, CSS for styling and JS for adding interactivity and responsiveness to ensure a dynamic user experience. 
It also uses the AjaxControlToolkit which is a set of controls and extenders for ASP.NET applications that enhance the capabilities of standard web controls. This toolkit provides AJAX (Asynchronous JavaScript and XML) functionality which allowed data to be fetched and updated dynamically without the need of a full page reload. 
It also uses OWIN (Open Web Interface for .NET) middleware for managing authentication and authorization. OWIN provides a standard interface between .NET web applications and web servers which allow for modular and flexible authentication mechanisms. The system integrates with Google for user authentication using OWIN's external authentication capabilities. This integration is achieved using the GoogleOAuth2AuthenticationOptions and OWIN's authentication middleware which facilitate the implementation of OAuth 2.0 for secure authentication via Google accounts. Hence, students can log in using their Google credentials. 
The application includes a chatbot feature developed using Python. The chatbot is trained using the Natural Language Toolkit (NLTK) and scikit-learn libraries for intent classification. To integrate Python scripts with the ASP.NET application, batch files (.bat) are used to execute Python scripts from the server-side code. The batch file handles the execution of Python scripts, captures user input and returns responses to the web application. 
This system uses the Google Calendar API to integrate with Google Calendar which allows student to add, edit, delete events directly from this system. Youtube API is used to allow students to search for YouTube videos and display the results directly on the page. It also uses Gmail's SMTP (Simple Mail Transfer Protocol) server for sending email reminders which implemented using .NET's SmtpClient class. 

<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Note Taking</i><br/>
![image](https://github.com/user-attachments/assets/dc2d4773-12af-4cc8-b12c-9de0b568ee2c)
<br/>User can add note, edit note, delete note. To ease user, there will be an apply function which system will detect when there is a new course and color, then it will shown up in left hand side to let user to apply existing course and color. Therefore, user no need to waste their memory remember or to find which course is pair with which color. 

![image](https://github.com/user-attachments/assets/6912be65-efee-4c93-bd22-7ffee11771d0)
<br/>User can search by week or by course or both. 

![image](https://github.com/user-attachments/assets/ec697805-d79a-4fcf-aa2e-a5c96e895a88)
<br/>Once user uploads a photo in a particular note, then user would like to edit the note by uploading photos, it will detect whether user have uploaded duplicate photo and not allowed to have duplicate photo exist. 
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>GPA Grade Calculator </i><br/>
![image](https://github.com/user-attachments/assets/261a517a-9d02-4a32-8a3d-f813a7e7a45a)
<br/>It will calculates the subjects grades needed for next semester to achieve a target CGPA based on user inputs with TAR UMT grading system. 

![image](https://github.com/user-attachments/assets/d19287e5-f711-47eb-b8f1-694c3ff0ffcb)
<br/>It will check whether all the input field are valid. 

![image](https://github.com/user-attachments/assets/18e10b4c-f773-41c4-8436-4c3df2fc9dc8)
<br/>User can adjust the number of subject input self but can only take up to 7 subjects in a semester.
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Measurement Converter</i><br/>
![image](https://github.com/user-attachments/assets/4e623ae3-d4ab-449a-add9-d4624c3f2b10)
<br/>It consist convert unit such as temperature, case, energy, calculator and so on. It will offer enhanced customization options which is to select the preferred number notation such as normal (123.45) or exponential (1.2345E2), as well as specify the desired decimal places for display to improve readability and usability.
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Video Teaching Pronunciation</i><br/>
![image](https://github.com/user-attachments/assets/06b54720-d30e-494b-b5e6-fdd5b6d9a0ff)
<br/>User can choose to input a confuse and mispronounced word into the textbox by typing with keyboard or via voice input recognition. Then it will fetch the related pronunciation video from YouTube and display it out.
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Calendar Reminder</i><br/>
![image](https://github.com/user-attachments/assets/22dccd77-870f-4280-bc2d-ce20afc1b258)
<br/>User can set an event reminder and the reminder will save in the user's Google Calendar and generate email reminder to Gmail. It will sent again for the email reminder x(user input) min before event start.

![image](https://github.com/user-attachments/assets/3506ff28-b072-425a-a072-ccc99074e395)
<br/>All the previous date in the AJAX calendar will be disabled and crossed out to prevent users from selecting past dates.

![image](https://github.com/user-attachments/assets/3b784719-5156-464d-ad4f-80cac5ffa7ff)
<br/>The event date set must be greater than now.

![image](https://github.com/user-attachments/assets/49a2a04a-d94c-4bbb-95c5-38e443b00300)
<br/>If reminder time has already passed, no reminder will be send again to remind before event start.

![image](https://github.com/user-attachments/assets/1614bced-ebbc-48f5-9b37-da33240adc0e)
<br/>Example of reminder email.

![image](https://github.com/user-attachments/assets/f239b512-aa1e-49ec-8299-24fd9b181b84)
<br/>Example of sent reminder email again before x min event start.

![image](https://github.com/user-attachments/assets/a787a72d-335c-47ee-8b98-9d9c66c08ec0)
<br/>Example of delete event reminder.

![image](https://github.com/user-attachments/assets/e6a04183-d1ac-4b28-987f-fa006ffafb6d)
<br/>Example of update event reminder. 

![image](https://github.com/user-attachments/assets/64efd94d-c66c-44e4-9978-8171c7f6dc30)
<br/>Example of sent again update event reminder.

![image](https://github.com/user-attachments/assets/650fd79f-3087-41aa-8441-30d9cf5f3120)
<br/>Example of Calendar reminder.

<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>BMI Calculator</i><br/>
![image](https://github.com/user-attachments/assets/7023308c-ace5-4423-9df6-79dada0d858c)
<br/>User can click the apply button to apply the recent data or type in manually. The table is ordered by date in descending order.

![image](https://github.com/user-attachments/assets/251a467d-15e8-4fff-9ce9-993f7f2656f8)
<br/>After click the calculate BMI button, it wil show the relavant BMI result and exercise suggestion. User can click save if they want to save this data in database.

![image](https://github.com/user-attachments/assets/7ceb2f41-e19b-4dc5-a7c2-54d6ccf672cf)
<br/>If user do not click save button, it will not save into the chart.
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Calorie Calculator</i><br/>
![image](https://github.com/user-attachments/assets/d1225ca5-f021-46c9-aeb9-7cf4b6fd46ad)
<br/>User can click the apply button to apply the recent data or type in manually similar like BMI calculator. 

![image](https://github.com/user-attachments/assets/ca16d06a-6d4b-41d2-aa7f-805ad46d010e)
<br/>After click the calculate button, it wil show the relavant calorie result and meal portion suggestion. User can click save if they want to save this data in database.
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Exercise Workout Schedule</i><br/>
![image](https://github.com/user-attachments/assets/eb9cd7b8-21f6-4caf-9541-a4ace56688ad)
<br/>It consist of exercise suggestion get from the saved BMI result from BMI calculator to let user know what suggested exercise can be done. 
<br/>User can choose the day, time and input exercise name to save the exercise in the timeslot table below. 

![image](https://github.com/user-attachments/assets/d82d1e71-6c02-4398-be6e-7056f71d38fa)
<br/>When user click the exercise name link in the timeslot table, it will search from the YouTube and show the relavant exercise video links. 

![image](https://github.com/user-attachments/assets/56a42831-9a1c-47df-a5c9-2e4a6c9861c9)
<br/>It has also a function to let user to solve any exercise concern or unknown exercise details by showing all the relavant exercise concern video links. 

![image](https://github.com/user-attachments/assets/58b2c031-ac05-421c-a793-9c2540f13e59)
<br/>Example of exercise reminder email.
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>To-Do List</i><br/>
![image](https://github.com/user-attachments/assets/ee58d19b-2ba2-470d-9dbc-81993ca5ccb7)
<br/>User can input the task, select importance and urgency to categories the task into one of the four category of Eisenhower matrix. Them, user can edit or delete the task. User also can mark tasks as complete or incomplete directly from the grid view by strike through the task.

![image](https://github.com/user-attachments/assets/d2d1ffb3-a639-4c08-8c42-c7ee295efb91)
<br/>User can search the to-do task using category importance or urgence or both. 

![image](https://github.com/user-attachments/assets/faeea95c-684c-4e1d-a46b-40ac206ca4f1)
<br/>User can also select the check box to show only not completed task. 

![image](https://github.com/user-attachments/assets/ef4e4164-363f-4d3f-b7f0-12bfde272fdd)
<br/>Another UI version.
<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Goal Getter</i><br/>
![image](https://github.com/user-attachments/assets/a80f3792-282d-4107-b70c-14a2a75b9ad7)
<br/>Similar like to-do list, user can add, edit and delete goal.

<br/> ---------------------------------------------------------------------------------------------------------------------------------<br/>

<i>AI Chatbot</i><br/>
![image](https://github.com/user-attachments/assets/bffcf366-f290-41d6-b3da-976991f0b777)
<br/>New student can ask queries related to TAR UMT university and get response in real time. User can ask  

