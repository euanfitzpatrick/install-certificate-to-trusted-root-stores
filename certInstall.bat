@echo off
setlocal

REM Prompt the user for the certificate name
set /p "certName=Please enter the name of your root certificate: "

REM Check if the user provided an extension; if not, default to .cer
if "%certName%"=="" (
    set "certName=default.cer"
) else (
    set "certName=%certName%.cer"
)

REM Construct the full path to the certificate file using %~dp0 and the provided or default certificate name
set "certFile=%~dp0%certName%"

REM Check if the certificate file exists
if not exist "%certFile%" (
    echo Certificate file not found: %certFile%
    exit /b 1
)

REM Check if the certificate is already installed
certutil -store "Root" | findstr /i /c:"%certFile%" > nul
if %errorlevel% equ 0 (
    echo Certificate is already installed.
    exit /b 0
)

REM Install the certificate using certutil
certutil -addstore "Root" "%certFile%"

REM Check the return code of certutil
if %errorlevel% neq 0 (
    echo Certificate installation failed.
    exit /b 1
)

echo Certificate installed successfully.
exit /b 0
