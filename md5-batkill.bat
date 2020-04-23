:: Programmed by hXR16F
:: hXR16F.ar@gmail.com, https://github.com/hXR16F

@echo off
mode 60,40 & title MD5-BatKill & color 07
setlocal EnableDelayedExpansion
call core/cl.bat & rem https://github.com/hXR16F/cl

if exist "input.ini" (
	set line=1
	for /f "tokens=*" %%i in (input.ini) do (
		if !line! equ 1 set "hash_input=%%i"
		if !line! equ 2 (
			if "%%i" equ "1" set "method=core\md5.exe -l -d"
			if "%%i" equ "2" set "method=py core/md5.py "
		)
		set /a line+=1
	)
	del /f /q "input.ini" >nul

	call :getlen !hash_input!
	if not !l! equ 32 (
		echo Invalid hash D:> "output.txt"
		exit /b
	)

	find /i "!hash_input:~0,4!:" wordlist.lst > "temp1"
	for /f "tokens=1,2 delims=:" %%a in (temp1) do (
		set pass=%%b
		if not "!pass!" equ "" (
			for /f %%i in ('!method!!pass!') do (
				if /i "!hash_input!" equ "%%i" (
					echo !hash_input!:!pass!>> "found.txt"
					echo !pass!> "output.txt"
				)
			)
		)
	)
	if not exist "output.txt" echo Not found :/> "output.txt"
	del /f /q temp1 >nul
	exit /b
)

set "method=core\md5.exe -l -d"
REM set "method=py core/md5.py "

set "line=%fg`black%============================================================%`r% "

:banner
	echo %line%
	echo                      =%fg`red%=%`r% MD5-BatKill %fg`red%=%`r%=
	echo                       =%fg`red%=%`r% by hXR16F %fg`red%=%`r%=
	echo.

:main
	echo %line%
	set /p "hash_input=%`r% %fg`white%MD5 %fg`black%-> %fg`white%" & <nul set /p =%`r%
	call :getlen %hash_input%
	if not !l! equ 32 (
		echo  %fg`black%    -^> %fg`red%Invalid hash D:%`r%
		echo.
		goto :main
	)

	find /i "!hash_input:~0,4!:" wordlist.lst > "temp1"
	for /f "tokens=1,2 delims=:" %%a in (temp1) do (
		set pass=%%b
		if not "!pass!" equ "" (
			for /f %%i in ('%method%!pass!') do (
				if /i "!hash_input!" equ "%%i" (
					echo !hash_input!:!pass!>> "found.txt"
					echo !pass!> "temp2"
				)
			)
		)
	)

	if exist "temp2" (
		<nul set /p =%fg`black%     -^> %fg`white-%
		for /f %%i in (temp2) do (
			if not "%%i" equ "" set "pwd=%%i"
		)
		echo !pwd! %fg`red%[%fg`black%saved to 'found.txt'%fg`red%]%`r%
		del /f /q temp2 >nul
	) else (
		echo %fg`black%     -^> %fg`red%Not found :/%`r%
	)
	del /f /q temp1 >nul

	echo.
	goto :main

:getlen %1
	set n=%~1#
	set l=0
	for %%i in (2048 1024 512 256 128 64 32 16 8 4 2 1) do if not "!n:~%%i!" equ "" set /a "l+=%%i" & set "n=!n:~%%i!"
	exit /b