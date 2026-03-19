@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

::***************************************************************************
:: to creat pnp.cmd
echo pnputil.exe -i -a %%1>pnp.cmd
echo echo %%errorlevel%% ^>temp.log>>pnp.cmd
echo echo Installed %%1 ^>^>log.txt>>pnp.cmd
echo echo return code:%%errorlevel%% ^>^>log.txt>>pnp.cmd
echo ping 127.0.0.1 -n ^1>>pnp.cmd
echo exit>>pnp.cmd

ping 127.0.0.1 -n 1

:InstallDriver
del /f /q log.txt
for /f "delims=" %%i in ('dir .\Source\*.INF /s/b') do (
	del /f /q temp.log
	start /w pnp.cmd "%%~fi"
	if not exist temp.log ping 127.0.0.1 -n 10
	if not exist temp.log goto NO_Temp
	(for /f "usebackq eol=" %%a in (temp.log) do break) && echo get return-code ok~ || goto NO_FOUND
	for /f "delims= " %%b in (temp.log) do (
		if "%%b" NEQ "0" (
		if "%%b" NEQ "259" (
		if "%%b" NEQ "3010" goto NG
			)
		)
	)
)
goto end

:NO_Temp
del /f /q pnp.cmd
echo No found temp.log....
exit /b 1

:NO_FOUND
del /f /q pnp.cmd
echo No any data in temp.log....
exit /b 1

:NG
del /f /q pnp.cmd
echo Install Fail....
exit /b 1

:end
del /f /q temp.log
del /f /q pnp.cmd
del /f /q log.txt
