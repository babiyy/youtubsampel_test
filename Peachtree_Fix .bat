@echo off
title PatchTree Fixer
setlocal

rem Set the directory where you want to delete .LOC, .PTL, 
set "target_directory=D:\Companiy"

rem Change to the target directory
cd /d "%target_directory%"

rem Ask the user to close any applications using the files
set /p close_app=" ########### Please close any applications that may be using Peachtree files and press Enter to continue...########"

rem Ask for confirmation
set /p confirm=" ################ Are you sure you want to fix Login Probelam files in %target_directory%? (Yes/No)##############: "



if /i "%confirm%"=="Y" (
    echo Fixing the following files:
    
    rem Loop through and list all .LOC, .PTL, and ~plc~.LOC files before deletion
    for %%f in (*.LOC *.PTL ~plc~.LOC) do (
        echo %%f
    )
    
    echo.
    echo Waiting for 5 seconds...
    timeout /t 5 >nul

    echo.
    echo Starting Fixing...
    set "total_files=0"
    set "deleted_files=0"

    rem Count total .LOC, .PTL, ~plc~.LOC 
    for %%f in (*.LOC *.PTL  ~plc~.LOC) do (
        set /a total_files+=1
    )

    rem Fixing files with progress bar
    for %%f in (*.LOC *.PTL ~plc~.LOC) do (
        del /q "%%f"
        set /a deleted_files+=1
        call :ProgressBar %%deleted_files%% %%total_files%%
    )

    echo.
    
    echo "##############################   Congratulations, fix is successful!    ##############################"
	
) else (
    echo Operation canceled.
)

echo.
set /p exit_prompt="Press Enter to exit..."
endlocal
goto :EOF

