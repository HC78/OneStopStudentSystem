<b>Abstract</b><br/>
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

<br/> ---------------------------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Note Taking</i><br/>
![image](https://github.com/user-attachments/assets/dc2d4773-12af-4cc8-b12c-9de0b568ee2c)
<br/>You can add note, edit note, delete note. To ease user, there will be an apply function which system will detect when there is a new course and color, then it will shown up in left hand side to let user to apply existing course and color. Therefore, user no need to waste their memory remember or to find which course is pair with which color. 

![image](https://github.com/user-attachments/assets/6912be65-efee-4c93-bd22-7ffee11771d0)
<br/>You can search by week or by course or both. 

![image](https://github.com/user-attachments/assets/ec697805-d79a-4fcf-aa2e-a5c96e895a88)
<br/>Once you upload a photo in a particular note, then you would like to edit the note by uploading photos, it will detect whether you have uploaded duplicate photo and not allowed to have duplicate photo exist. 
<br/> ---------------------------------------------------------------------------------------------------------------------------------------------------<br/>

<i>GPA Grade Calculator </i><br/>
![image](https://github.com/user-attachments/assets/261a517a-9d02-4a32-8a3d-f813a7e7a45a)
<br/>It will calculates the subjects grades needed for next semester to achieve a target CGPA based on user inputs with TAR UMT grading system. 

![image](https://github.com/user-attachments/assets/d19287e5-f711-47eb-b8f1-694c3ff0ffcb)
<br/>It will check whether all the input field are valid. 

![image](https://github.com/user-attachments/assets/18e10b4c-f773-41c4-8436-4c3df2fc9dc8)
<br/>Students can adjust the number of subject input self but can only take up to 7 subjects in a semester.
<br/> ---------------------------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Measurement Converter</i><br/>
![image](https://github.com/user-attachments/assets/4e623ae3-d4ab-449a-add9-d4624c3f2b10)
<br/>It consist convert unit such as temperature, case, energy, calculator and so on. It will offer enhanced customization options which is to select the preferred number notation such as normal (123.45) or exponential (1.2345E2), as well as specify the desired decimal places for display to improve readability and usability.
<br/> ---------------------------------------------------------------------------------------------------------------------------------------------------<br/>

<i>Video Teaching Pronunciation</i><br/>
![image](https://github.com/user-attachments/assets/06b54720-d30e-494b-b5e6-fdd5b6d9a0ff)
<br/>User can choose to input a confuse and mispronounced word into the textbox by typing with keyboard or via voice input recognition. Then it will fetch the related pronunciation video from YouTube and display out.
<br/> ---------------------------------------------------------------------------------------------------------------------------------------------------<br/>



