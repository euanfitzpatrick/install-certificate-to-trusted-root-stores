@echo off
setlocal enabledelayedexpansion

:installCertificate
REM Prompt the user for the certificate name
set /p "certName=Please enter the name of your root certificate (without extension): "

REM Check if the user provided an extension; if not, default to .cer
if "%certName%"=="" (
    set "certName=default.cer"
) else (
    set "certName=!certName!.cer"
)

REM Prompt the user to select the store
cls
echo Which store would you like to install this to?
echo.
echo 1: Trusted Root Store
echo 2: Intermediate CA Store
echo.
set /p "storeChoice=Enter the number (1 or 2) for your choice: "

REM Check the user's choice and set the store accordingly
if "%storeChoice%"=="1" (
    set "store=Root"
) else if "%storeChoice%"=="2" (
    set "store=CA"
) else (
    echo.
    echo Invalid choice. Please select 1 or 2.
    goto selectStore
)

REM Construct the full path to the certificate file using %~dp0 and the provided or default certificate name
set "certFile=%~dp0%certName%"

REM Check if the certificate file exists
if not exist "%certFile%" (
    echo.
    echo Certificate file not found: %certFile%
    goto askInstallAnotherCertificate
)

REM Install the certificate using PowerShell
powershell.exe -Command "Import-Certificate -FilePath \"%certFile%\" -CertStoreLocation \"Cert:\LocalMachine\!store!\""

REM Check if the certificate is now installed
powershell.exe -Command "if (Get-ChildItem -Path \"Cert:\LocalMachine\!store!\" | Where-Object { $_.Thumbprint -eq (Get-FileHash -Algorithm SHA1 -Path \"%certFile%\" | Select-Object -ExpandProperty Hash) }) { exit 0 } else { exit 1 }"

:askInstallAnotherCertificate
REM Prompt the user to install another certificate
echo.
echo Would you like to install another certificate?
echo 1: Yes
echo 2: No
echo.
set /p "installAnother=Enter the number (1 or 2) for your choice: "

REM Check the user's choice and repeat or exit accordingly
if "%installAnother%"=="1" (
    goto installCertificate
) else if "%installAnother%"=="2" (
    exit /b 0
) else (
    echo.
    echo Invalid choice. Please select 1 or 2.
    goto askInstallAnotherCertificate
)
