@echo off
setlocal

:: Define the path to the Python script
set PYTHON_SCRIPT=chatbot.py
set WORKING_DIR="C:\Users\SEOW HUI CHEE\source\repos\OneStopStudentSystem"
set USER_INPUT=%1

:: Change to the working directory
cd /d %WORKING_DIR%

:: Run the Python script and capture output
python %PYTHON_SCRIPT% "%USER_INPUT%" > response.txt

:: Check if response.txt was created and is not empty
if exist response.txt (
    type response.txt
) else (
    echo No response received or response.txt not found
)

endlocal
