:: MIT License
:: Copyright (c) 2024 Liam Francis Olarte
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

:: _____________________________________________________________________________
::                    This is a script to reset windows update.
:: 
::                                 Version info:
::                   Version 3.1.4 - Last Updated: ReleaseDate
::
::          You can find comments like this (ex. :: comment) so you can see
::                               what that code does.
::        
::            If you still have questions about this code, feedback,
::                        and suggestions, email me on:
::                       liamfrancisolarte502@gmail.com
::
::                 Thank you for choosing windows update reset!
::
::                    Copyright (c) 2024 Liam Francis Olarte          
:: _____________________________________________________________________________

:: Starts the loading process 
@echo off
goto :startload

:: Displays a loading message
:startload
cls
Title Windows Update Reset - Loading
echo:                              ____________________________________________________
echo:                                       Please wait while Windows Update Reset
echo:                                                      loads.    
echo:                              ____________________________________________________

:: Sets the name variable. This is used when showing the credits.
set "name=Liam Francis Olarte" 

:: Checks if PowerShell exists
where /q powershell
if %ERRORLEVEL% neq 0 (
  goto :startloadnoupdatecheck
)

:: Checks for administrator previlages
net session >nul 2>&1
if %errorLevel% == 0 (
    cd /d C:\Windows\System32
) else (
    
    goto :ADMINCHECKFAILED
)


:: Checks the windows version for compatibility issues
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.3" goto :incompatibleos
if "%version%" == "6.2" goto :incompatibleos
if "%version%" == "6.1" goto :incompatibleos
if "%version%" == "6.0" goto :incompatibleos

:: Checks if an older version of Windows Update Reset exists in your "Downloads" folder.
IF EXIST "%userprofile%\downloads\windows.update.reset.version.3.1.3" (
  goto :olderversiondetected
) ELSE (
  goto :updatecheck
)

:: Displays a message informing you that Windows Update Reset detected an older version of Windows Update Reset and asks you if you want to delete it.
:olderversiondetected
Title Windows Update Reset - Older version detected
cls
echo: _________________________________________________________
echo:         An older version of Windows Update Reset
echo:     has been detected in your downloads directory.
echo.
echo:               Do you want to delete it?
echo:    [1] Yes                                    [2] No
echo: _________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :updatecheck
if %_erl%==1 goto :delete
goto :olderversiondetected

:: This deletes your older version of Windows Update Reset and checks if it failed to delete it.
:delete
cls
echo:                              ______________________________________________________
echo:                               Deleting your older version of Windows Update Reset.
echo:                                                   Please wait.
echo:                              ______________________________________________________
cd %userprofile%\downloads\
rd Windows.Update.Reset.version.3.1.3 /s /q
if %errorlevel% 5 goto :deleteerror
if %errorlevel% 2 goto :deleteerror
if %errorlevel% 1 goto :deleteerror
if %errorlevel% 0 goto :deleteerror
) else (
    
    goto :updatecheck
)

:: This shows an error if Windows Update Reset fails to delete your older version of Windows Update Reset. 
:DeleteError
cls
Title Windows Update Reset - Failed to check for updates
echo: ________________________________________________________________
echo:                            Error:
echo:         Windows Update Reset failed to delete your older
echo:               version of Windows Update Reset.
echo:                  What would you like to do?
echo.
echo:     [1] Retry                               [2] Continue
echo: ________________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%
if %_erl%==2 goto :updatecheck
if %_erl%==1 goto :delete


:: Shows a message while checking for updates
:updatecheck
Title Windows Update Reset - Checking for updates
cls
echo:                              ____________________________________________________
echo:                                              Checking for updates.
echo:                                                  Please wait.
echo:                              ____________________________________________________


:: Sets the current version of this batch file
set current_version=3.01.04

:: Downloads the latest version number
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Liam358/Windows-Update-Reset/main/version.txt -OutFile version.txt"

:: Checks if the download was successful
if %ERRORLEVEL% neq 0 (
  echo Download failed
  goto :error
) else (
  echo Download successful
)

:: Reads the latest version number
set /p latest_version= < version.txt

:: Compares the current version with the latest version
if %latest_version% gtr %current_version% (
    goto :newversion
) else (
    goto :start
)

:: This is responsible for loading this script without powershell (it loads without checking for updates)
:startloadnoupdatecheck
cls
Title Windows Update Reset - Loading
echo:                              ____________________________________________________
echo:                                       Please wait while Windows Update Reset
echo:                                                      loads.    
echo:                              ____________________________________________________

:: Checks for administrator previlages
net session >nul 2>&1
if %errorLevel% == 0 (
    cd /d C:\Windows\System32
) else (
    
    goto :ADMINCHECKFAILED
)

:: Checks the windows version for compatibility issues
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.3" goto :incompatibleos
if "%version%" == "6.2" goto :incompatibleos
if "%version%" == "6.1" goto :incompatibleos
if "%version%" == "6.0" goto :incompatibleos
endlocal

:: Goes to the part where the main menu displays.
goto :start

:: This displays an error message when the script fails to check for updates
:error
cls
Title Windows Update Reset - Failed to check for updates
echo: ________________________________________________________________
echo:                          Error:
echo:      Windows Update Reset failed to check for updates.
echo:   Please check your internet connection and select option 1.
echo:   If you don't have access to the internet, select option 2.
echo.
echo:     [1] Retry                               [2] Continue
echo: ________________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%
if %_erl%==2 goto :start
if %_erl%==1 goto :startload


:newversion
cls
Title Windows Update Reset - New version detected
echo: ________________________________________________________________
echo:              A newer version of Windows Update Reset
echo:                       has been detected.
echo:        Do you want to go to the download page to download
echo:                       the latest version?
echo.
echo:   [1] Yes                                             [2] No
echo: ________________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%
if %_erl%==2 goto :start
if %_erl%==1 goto :downloadversion

:: Displays a message when the user chooses to download the latest version.
:downloadversion
cls
start https://github.com/Liam358/Windows-Update-Reset/releases
echo: _________________________________________________________________________________________
echo:                                  You have been redirected to
echo:                                     the download page.
echo:
echo:             Once you've finished downloading the latest version, press any key 
echo:                                       to exit this
echo:                                         version.
echo: _________________________________________________________________________________________
pause >nul
exit

:: Deletes the temporary startup files, remove and set variables, then, display the main menu.
:start
cls
echo:                              ____________________________________________________
echo:                                               Finalizing startup.
echo:                                                  Please wait.
echo:                              ____________________________________________________
del version.txt
endlocal
set version=3.1.4
Title Windows Update Reset
cls
echo:       ______________________________________________________________________________________
echo:                                 Welcome to Windows Update Reset!         Version %version%        
echo:                                                                                                   
echo:                                          Instructions:             
echo:                        Enter a menu option in the Keyboard [1,2,3,4,5,6,7,8,9]                         
echo:       ______________________________________________________________________________________
echo:                                                
echo:             Option                                  Description    
echo:
echo:             [1] Reset windows update                Resets windows update then restarts
echo:                 then restart the computer           the computer.       
echo:        
echo:             [2] Reset without showing               Resets windows update without
echo:                 messages                            showing what its doing.      
echo:                       
echo:             [3] Reset windows update                Resets windows update while  
echo:                 with echo on                        showing the command its                  
echo:                                                     executing.
echo:                                                     (Example: net stop bits)
echo:
echo:             [4] Reset windows update                Resets windows update
echo:                 without restarting                  without restarting the   
echo:                 the computer                        computer.             
echo:                 
echo:             [5] Reset windows update                Resets windows update
echo:                 with a more                         while showing a more
echo:                 graphical interface                 graphical interface.
echo:                                                     This is not a great
echo:                                                     option if you want
echo:                                                     to see what's
echo:                                                     happening in the
echo:                                                     background.
echo:
echo:             [6] Reset windows update                This will Reset
echo:                 without showing                     windows update
echo:                 the output of                       without showing
echo:                 the commands                        most of the output
echo:                                                     but will still
echo:                                                     show the messages.   
echo:
echo:             [7] Help                                Opens the readme file.  
echo:             
echo:             [8] Extras                              Shows extras that
echo:                                                     are not really
echo:                                                     the purpose of
echo:                                                     this batch script.
echo:
echo:             [9] Next page                           This will show the
echo:                                                     next part of the main menu. 	 
echo:       ______________________________________________________________________________________
echo:

choice /C:123456789 /N
set _erl=%errorlevel%

if %_erl%==9 goto :MainMenuPage2
if %_erl%==8 goto :Extras
if %_erl%==7 goto :openreadmefile
if %_erl%==6 goto :no_output
if %_erl%==5 goto :newresetmenu
if %_erl%==4 goto :see_the_thing
if %_erl%==3 goto :enable_echo
if %_erl%==2 goto :not_see_the_thing
if %_erl%==1 goto :stage1

:: Displays Page 2 of the main menu.
:MainMenuPage2
cls
echo:       ______________________________________________________________________________________
echo:                                 Welcome to Windows Update Reset!         Version %version%        
echo:                                                                                                   
echo:                                          Instructions:             
echo:                        Enter a menu option in the Keyboard [1,2,3,4,5,6,7]                         
echo:       ______________________________________________________________________________________
echo:                                                
echo:             Option                                  Description    
echo:
echo:             [1] Open Random Stuff                   Some very random stuff that are
echo:                                                     less useful from the ones in the extras.
echo:                                                     This is here because I don't know
echo:                                                     what features to add anymore.       
echo:
echo:             [2] Reset Windows Update                This resets windows update using the way                                   
echo:                 using the way that                  that the wureset tool does.
echo:                 the wureset tool                    This gives you a more reliable way of
echo:                 does                                resetting windows update.
echo:
echo:             [3] Create a restore point              This creates a restore point with the
echo:                                                     name of "Windows Update Reset User made
echo:                                                     restore point". THIS MAY NOT WORK!
echo:
echo:             [4] Sign up for Windows                 Opens a servey. This is needed so
echo:                 Update Reset beta                   we can see if you are a good beta
echo:                 versions                            tester. We will send you an email
echo:                                                     that notifies you if you are now
echo:                                                     a beta tester.
echo:  
echo:             [5] Credits                             Shows the credits.
echo:
echo:             [6] Previous page                       This will show the
echo:                                                     last shown part of the main menu.
echo:
echo:             [7] Exit                                Exits this batch script.	 
echo:       ______________________________________________________________________________________
echo:

choice /C:1234567 /N
set _erl=%errorlevel%

if %_erl%==7 goto :exitnow
if %_erl%==6 goto :start
if %_erl%==5 goto :credits
if %_erl%==4 goto :betatesting
if %_erl%==3 goto :createrestorepoint
if %_erl%==2 goto :getValues
if %_erl%==1 goto :randomstuff

:betatesting
start https://forms.gle/UKewwtjEAwty5pnJ6
goto :MainMenuPage2

:createrestorepoint
cls
Echo.
Echo Creating a restore point
Echo.
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Windows Update Reset User made restore point", 100, 7 >nul
echo Done!
goto :MainMenuPage2

:getValues
cls
echo: _______________________________________________________
echo:                     Please wait...
echo: _______________________________________________________
echo.

:: The following code is licensed under the MIT License
:: Copyright (c) 2023 Manuel Gil
:: 
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:
:: 
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
:: 
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

	for /f "tokens=4 delims=[] " %%a in ('ver') do set version=%%a

	if %version% EQU 6.0.6000 (
		:: Name: "Microsoft Windows Vista"
		set name=Microsoft Windows Vista
		:: Family: Windows 6
		set family=6
		:: Compatibility: No
		set allow=No
	) else if %version% EQU 6.0.6001 (
		:: Name: "Microsoft Windows Vista SP1"
		set name=Microsoft Windows Vista SP1
		:: Family: Windows 6
		set family=6
		:: Compatibility: No
		set allow=No
	) else if %version% EQU 6.0.6002 (
		:: Name: "Microsoft Windows Vista SP2"
		set name=Microsoft Windows Vista SP2
		:: Family: Windows 6
		set family=6
		:: Compatibility: No
		set allow=No
	) else if %version% EQU 6.1.7600 (
		:: Name: "Microsoft Windows 7"
		set name=Microsoft Windows 7
		:: Family: Windows 7
		set family=7
		:: Compatibility: No
		set allow=No
	) else if %version% EQU 6.1.7601 (
		:: Name: "Microsoft Windows 7 SP1"
		set name=Microsoft Windows 7 SP1
		:: Family: Windows 7
		set family=7
		:: Compatibility: No
		set allow=No
	) else if %version% EQU 6.2.9200 (
		:: Name: "Microsoft Windows 8"
		set name=Microsoft Windows 8
		:: Family: Windows 8
		set family=8
		:: Compatibility: Yes
		set allow=Yes
	) else if %version% EQU 6.3.9200 (
		:: Name: "Microsoft Windows 8.1"
		set name=Microsoft Windows 8.1
		:: Family: Windows 8
		set family=8
		:: Compatibility: Yes
		set allow=Yes
	) else if %version% EQU 6.3.9600 (
		:: Name: "Microsoft Windows 8.1 Update 1"
		set name=Microsoft Windows 8.1 Update 1
		:: Family: Windows 8
		set family=8
		:: Compatibility: Yes
		set allow=Yes
	) else (
		ver | find "10.0." > nul
		if %errorlevel% EQU 0 (
			:: Name: "Microsoft Windows 10"
			set name=Microsoft Windows 10
			:: Family: Windows 10
			set family=10
			:: Compatibility: Yes
			set allow=Yes
		) else (
			:: Name: "Unknown"
			set name=Unknown
			:: Compatibility: No
			set allow=No
		)
	)

	echo Done! Executing the reset.
        goto :components 


:components
cls
	:: ----- Stopping the Windows Update services -----
	echo Stopping the Windows Update services.
	net stop bits

	echo Stopping the Windows Update services.
	net stop wuauserv

	echo Stopping the Windows Update services.
	net stop appidsvc

	echo Stopping the Windows Update services.
	net stop cryptsvc

	echo Canceling the Windows Update process.
	taskkill /im wuauclt.exe /f

	:: ----- Checking the services status -----
	echo Checking the services status.

	sc query bits | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo.    Failed to stop the BITS service.
		echo.
		echo.Press any key to continue . . .
		pause>nul
		goto :MainMenuPage2
	)

	echo Checking the services status.

	sc query wuauserv | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo.    Failed to stop the Windows Update service.
		echo.
		echo.Press any key to continue . . .
		pause>nul
		goto :MainMenuPage2
	)

	echo Checking the services status.

	sc query appidsvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		sc query appidsvc | findstr /I /C:"OpenService FAILED 1060"
		if %errorlevel% NEQ 0 (
			echo.    Failed to stop the Application Identity service.
			echo.
			echo.Press any key to continue . . .
			pause>nul
			if %family% NEQ 6 goto :eof
		)
	)

	echo Checking the services status.

	sc query cryptsvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo.    Failed to stop the Cryptographic Services service.
		echo.
		echo.Press any key to continue . . .
		pause>nul
		goto :MainMenuPage2
	)

	:: ----- Delete the qmgr*.dat files -----
	echo Deleting the qmgr*.dat files.

	del /s /q /f "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"
	del /s /q /f "%ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat"

	:: ----- Renaming the softare distribution folders backup copies -----
	echo Deleting the old software distribution backup copies.

	cd /d %SYSTEMROOT%

	if exist "%SYSTEMROOT%\winsxs\pending.xml.bak" (
		del /s /q /f "%SYSTEMROOT%\winsxs\pending.xml.bak"
	)
	if exist "%SYSTEMROOT%\SoftwareDistribution.bak" (
		rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution.bak"
	)
	if exist "%SYSTEMROOT%\system32\Catroot2.bak" (
		rmdir /s /q "%SYSTEMROOT%\system32\Catroot2.bak"
	)
	if exist "%SYSTEMROOT%\WindowsUpdate.log.bak" (
		del /s /q /f "%SYSTEMROOT%\WindowsUpdate.log.bak"
	)

	echo Renaming the software distribution folders.

	if exist "%SYSTEMROOT%\winsxs\pending.xml" (
		takeown /f "%SYSTEMROOT%\winsxs\pending.xml"
		attrib -r -s -h /s /d "%SYSTEMROOT%\winsxs\pending.xml"
		ren "%SYSTEMROOT%\winsxs\pending.xml" pending.xml.bak
	)
	if exist "%SYSTEMROOT%\SoftwareDistribution" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\SoftwareDistribution"
		ren "%SYSTEMROOT%\SoftwareDistribution" SoftwareDistribution.bak
		if exist "%SYSTEMROOT%\SoftwareDistribution" (
			echo.
			echo.    Failed to rename the SoftwareDistribution folder.
			echo.
			echo.Press any key to continue . . .
			pause>nul
			goto :MainMenuPage2
		)
	)
	if exist "%SYSTEMROOT%\system32\Catroot2" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\system32\Catroot2"
		ren "%SYSTEMROOT%\system32\Catroot2" Catroot2.bak
	)
	if exist "%SYSTEMROOT%\WindowsUpdate.log" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\WindowsUpdate.log"
		ren "%SYSTEMROOT%\WindowsUpdate.log" WindowsUpdate.log.bak
	)

	:: ----- Reset the BITS service and the Windows Update service to the default security descriptor -----
	echo Reset the BITS service and the Windows Update service to the default security descriptor.

	sc.exe sdset wuauserv D:(A;CI;CCLCSWRPLORC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)S:(AU;FA;CCDCLCSWRPWPDTLOSDRCWDWO;;;WD)
	sc.exe sdset bits D:(A;CI;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)S:(AU;SAFA;WDWO;;;BA)
	sc.exe sdset cryptsvc D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)(A;;CCLCSWRPWPDTLOCRRC;;;SO)(A;;CCLCSWLORC;;;AC)(A;;CCLCSWLORC;;;S-1-15-3-1024-3203351429-2120443784-2872670797-1918958302-2829055647-4275794519-765664414-2751773334)
	sc.exe sdset trustedinstaller D:(A;CI;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLOCRRC;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)S:(AU;SAFA;WDWO;;;BA)

	:: ----- Reregister the BITS files and the Windows Update files -----
	echo Reregister the BITS files and the Windows Update files.

	cd /d %SYSTEMROOT%\system32
	regsvr32.exe /s atl.dll
	regsvr32.exe /s urlmon.dll
	regsvr32.exe /s mshtml.dll
	regsvr32.exe /s shdocvw.dll
	regsvr32.exe /s browseui.dll
	regsvr32.exe /s jscript.dll
	regsvr32.exe /s vbscript.dll
	regsvr32.exe /s scrrun.dll
	regsvr32.exe /s msxml.dll
	regsvr32.exe /s msxml3.dll
	regsvr32.exe /s msxml6.dll
	regsvr32.exe /s actxprxy.dll
	regsvr32.exe /s softpub.dll
	regsvr32.exe /s wintrust.dll
	regsvr32.exe /s dssenh.dll
	regsvr32.exe /s rsaenh.dll
	regsvr32.exe /s gpkcsp.dll
	regsvr32.exe /s sccbase.dll
	regsvr32.exe /s slbcsp.dll
	regsvr32.exe /s cryptdlg.dll
	regsvr32.exe /s oleaut32.dll
	regsvr32.exe /s ole32.dll
	regsvr32.exe /s shell32.dll
	regsvr32.exe /s initpki.dll
	regsvr32.exe /s wuapi.dll
	regsvr32.exe /s wuaueng.dll
	regsvr32.exe /s wuaueng1.dll
	regsvr32.exe /s wucltui.dll
	regsvr32.exe /s wups.dll
	regsvr32.exe /s wups2.dll
	regsvr32.exe /s wuweb.dll
	regsvr32.exe /s qmgr.dll
	regsvr32.exe /s qmgrprxy.dll
	regsvr32.exe /s wucltux.dll
	regsvr32.exe /s muweb.dll
	regsvr32.exe /s wuwebv.dll

	:: ----- Resetting Winsock -----
	echo Resetting Winsock.
	netsh winsock reset

	:: ----- Resetting WinHTTP Proxy -----
	echo Resetting WinHTTP Proxy.

	if %family% EQU 5 (
		proxycfg.exe -d
	) else (
		netsh winhttp reset proxy
	)

	:: ----- Set the startup type as automatic -----
	echo Resetting the services as automatics.
	sc.exe config wuauserv start= auto
	sc.exe config bits start= delayed-auto
	sc.exe config cryptsvc start= auto
	sc.exe config TrustedInstaller start= demand
	sc.exe config DcomLaunch start= auto

	:: ----- Starting the Windows Update services -----
	echo Starting the Windows Update services.
	net start bits

	echo Starting the Windows Update services.
	net start wuauserv

	echo Starting the Windows Update services.
	net start appidsvc

	echo Starting the Windows Update services.
	net start cryptsvc

	echo Starting the Windows Update services.
	net start DcomLaunch

        set "name=Liam Francis Olarte"
	goto :exitmenu


:randomstuff
cls
echo:       ______________________________________________________________________________________
echo:                                    Welcome to the random world!         Version %version%       
echo:                                                                                                   
echo:                                          Instructions:             
echo:                          Enter a menu option in the Keyboard [1,2,3,4,5]                         
echo:       ______________________________________________________________________________________
echo:                                                
echo:             Option                                  Description    
echo:
echo:             [1] Destroy your computer               Please don't select this option.
echo:                                                     Bad things will happen.
echo:                                                     Only run this in a VM.
echo:                                                     This will destroy your windows
echo:                                                     install. 
echo:
echo:             [2] Ryanair Diaster                     This will non-stop open ryanair
echo:                                                     landing memes on your computer.
echo:                                                     Please save your work because
echo:                                                     this could cause a system crash.
echo:
echo:             [3] Gibberish                           You know what gibberish is.
echo:                                                     Google it if you don't know.
echo:
echo:             [4] Show the date and time              Shows the date and time. I don't know
echo:                                                     why would anyone need this in a batch
echo:                                                     script.
echo:  
echo:             [5] Go back to Page 2                   Goes back to the previous menu.	 
echo:       ______________________________________________________________________________________
echo:

choice /C:12345 /N
set _erl=%errorlevel%

if %_erl%==5 goto :MainMenuPage2
if %_erl%==4 goto :DateAndTime
if %_erl%==3 goto :Gibberish
if %_erl%==2 goto :RyanairDiaster
if %_erl%==1 goto :destroywindows

:DateAndTime
cls
echo: _________________________________________________________
echo:                       Date and Time:
echo: _________________________________________________________
echo:                          Date:
echo:                     %date%
echo:
echo:                         Time:
echo:                       %time%
echo: _________________________________________________________
echo:      To go back to the random world, press any key.
echo: _________________________________________________________         
pause >nul
goto :randomstuff

:Gibberish
cls
echo eyyyyyyyhfuhdiujeiufyieyfk8reyfuiy8rfywe87fyrfjyurfnyvgrhfgdfjerhfjeuyheruvburevbhubfvjheriu384uhiofk;34kpfl3p[fllr4fprelfwo;f[ew;ro[rof-0[o;4-3-2;f=0;f4-p;3-=24;f-=;3-f3-4;fo-;034fo;43f-ql3[fi;0[erp9f;o34[-;of3p4[f034;p[fp04;p-034pf[-;3[pef=['ef'pfe'prf[r3pef-[p1p3-;[1-3[13f][	=]';f1p[3;q'/;f3p-[=12'[;r13gf`[;p1f;.
echo Press any key to return to the random world.
pause >nul
goto :randomstuff


:RyanairDiaster
start https://www.youtube.com/shorts/u51XJtam6O8
goto :RyanairDiaster

:destroywindowswarning1
cls
Title Windows Update Reset - Warning
echo:
echo: ____________________________________________________________________
echo:                               Warning:
echo:                  This "Feature" will actually destroy
echo:                            your computer.
echo.                   Do you want to continue anyway?
echo.
echo:    [1] No                               [2] Yes (NOT RECOMMENDED)
echo: ____________________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :destroywindowswarning2
if %_erl%==1 goto :randomstuff

:destroywindowswarning2
cls
Title Windows Update Reset - Warning
echo:
echo: ____________________________________________________________________
echo:                               Warning:
echo:                  This "Feature" will actually destroy
echo:                            your computer.
echo.                   Do you want to continue anyway?
echo.
echo:    [1] No                               [2] Yes (NOT RECOMMENDED)
echo: ____________________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :destroywindowswarning3
if %_erl%==1 goto :randomstuff

:destroywindowswarning3
ls
Title Windows Update Reset - Warning
echo:
echo: ____________________________________________________________________
echo:                               Warning:
echo:                  This "Feature" will actually destroy
echo:                            your computer.
echo:                      THIS IS YOUR LAST WARNING.
echo.                   Do you want to continue anyway?
echo.
echo:    [1] No                               [2] Yes (NOT RECOMMENDED)
echo: ____________________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :destroy1
if %_erl%==1 goto :randomstuff


:destroy1
cls
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
cd..
takeown -f C:\ /r /d Y
rd C: /s /q
goto :computerdead

:computerdead
cls
Echo:
Echo: ___________________________________________
Echo:                   Done!
Echo:         Your computer is done for.
Echo:    To close this program, Press any key.
Echo: ___________________________________________
pause >nul
exit

:no_output
cls
Echo.
Echo Creating a restore point
Echo.
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Windows Update Reset", 100, 7 >nul
Echo. 
Echo Stopping Windows Update Services
Echo.                                          
net stop bits >nul 2>nul
net stop wuauserv >nul 2>nul
net stop applockerfltr >nul 2>nul
net stop appidsvc >nul 2>nul
net stop cryptsvc >nul 2>nul
Echo.
Echo Deleting qmgr files
Echo.
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*" /q >nul
Echo. 
Echo Clearing Windows Update Cache
Echo. 
rmdir %systemroot%\SoftwareDistribution /S /Q >nul 2>nul
rmdir %systemroot%\system32\catroot2 /S /Q >nul 2>nul
Echo.
Echo Reseting the Windows Update Services
Echo.
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU) >nul
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU) >nul
cd /d %windir%\system32
Echo.
Echo Re-registering the critical DLL files
Echo.
regsvr32.exe /s atl.dll >nul
regsvr32.exe /s urlmon.dll >nul
regsvr32.exe /s mshtml.dll >nul
regsvr32.exe /s shdocvw.dll >nul
regsvr32.exe /s browseui.dll >nul
regsvr32.exe /s jscript.dll >nul
regsvr32.exe /s vbscript.dll >nul
regsvr32.exe /s scrrun.dll >nul
regsvr32.exe /s msxml.dll >nul
regsvr32.exe /s msxml3.dll >nul
regsvr32.exe /s msxml6.dll >nul
regsvr32.exe /s actxprxy.dll >nul
regsvr32.exe /s softpub.dll >nul
regsvr32.exe /s wintrust.dll >nul
regsvr32.exe /s dssenh.dll >nul
regsvr32.exe /s rsaenh.dll >nul
regsvr32.exe /s gpkcsp.dll >nul
regsvr32.exe /s sccbase.dll >nul
regsvr32.exe /s slbcsp.dll >nul
regsvr32.exe /s cryptdlg.dll >nul
regsvr32.exe /s oleaut32.dll >nul
regsvr32.exe /s ole32.dll >nul
regsvr32.exe /s shell32.dll >nul
regsvr32.exe /s initpki.dll >nul
regsvr32.exe /s wuapi.dll >nul
regsvr32.exe /s wuaueng.dll >nul
regsvr32.exe /s wuaueng1.dll >nul
regsvr32.exe /s wucltui.dll >nul
regsvr32.exe /s wups.dll >nul
regsvr32.exe /s wups2.dll >nul
regsvr32.exe /s wuweb.dll >nul
regsvr32.exe /s qmgr.dll >nul
regsvr32.exe /s qmgrprxy.dll >nul
regsvr32.exe /s wucltux.dll >nul
regsvr32.exe /s muweb.dll >nul
regsvr32.exe /s wuwebv.dll >nul
Echo.
Echo Reseting network settings
Echo.  
netsh winsock reset >nul
netsh winsock reset proxy >nul
Echo.
Echo Starting Windows Update Services
Echo. 
net start bits >nul 2>nul
net start wuauserv >nul 2>nul
net start appidsvc >nul 2>nul
net start applockerfltr >nul 2>nul
net start cryptsvc >nul 2>nul
Echo.
goto :exitmenu

:incompatibleos
Title Windows Update Reset - Incompatible OS Error
cls
echo:
echo: __________________________________________________________________
echo:                              Error:
echo:                 Your computer is running an older
echo:                  version of Microsoft Windows.
echo.                  
echo:                   This program cannot continue.
echo:                To close this program, Press any key
echo: __________________________________________________________________
pause >nul
exit                      


:openreadmefile
cls
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
start /wait readme.txt
cls
goto :start

:openreadmefile2
cls
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
start /wait readme.txt
cls
goto :ADMINCHECKFAILED

:openreadmefile3
cls
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
start /wait readme.txt
cls
goto :limitmode


:Extras
cls
Title Windows Update Reset - Extras
echo:     _______________________________________________________________________________________
echo:                                     Welcome to Extras!                  Version %version%
echo:
echo:                                       Instructions:
echo:                     Enter a menu option in the Keyboard [1,2,3,4,5,6,7,8]
echo:     _______________________________________________________________________________________
echo.
echo:           Option                                  Description
echo.
echo:           [1] Open Repair Tools                   Provides tools to fix windows.
echo.
echo:           [2] Open the changelog file             Opens the changelog file
echo:                                                   that only list's changes
echo:                                                   from Version 3.0.9 and later.
echo:
echo:           [3] Open the changelog file             Does the same thing as option 2
echo:               (For weak computers)                but does not use Notepad.
echo:
echo:           [4] Restart Explorer                    Restarts file explorer.
echo.    
echo:           [5] Open Command Prompt                 Opens the command prompt.
echo:
echo:           [6] Restart Program                     Restarts the program.
echo.
echo:           [7] File organizer                      This is a file organizer that
echo:                                                   organizes your documents, images,
echo:                                                   and text files. Under development.
echo:                     
echo:           [8] Back to Main Menu                   Goes back to the main menu.
echo:     _______________________________________________________________________________________

choice /C:12345678  /N
set _erl=%errorlevel%

if %_erl%==8 goto :start
if %_erl%==7 goto :fileorganizer
if %_erl%==6 goto :startload
if %_erl%==5 goto :startcmd
if %_erl%==4 goto :restartexplorer
if %_erl%==3 goto :weakchangelogfile
if %_erl%==2 goto :changelogfile
if %_erl%==1 goto :toolstofixwindows
goto :Extras

:fileorganizer
Title Windows Update Reset - File organizer
cls
echo: _____________________________________________________
echo:                     Instructions:
echo:          Enter the folder you want to organize.
echo:             Be sure to enter the whole path!
echo.
echo:                        Note:
echo:             This wll only organize your 
echo:          Documents, Images, and Text Files
echo: _____________________________________________________
echo.

set /P folder=What folder would you like to organize? 
cd %folder%
if %errorLevel% == 1 (
    goto :errororganize
) else (
    
    goto :organize
)

:organize
md "Documents"
move "*.docx" "%folder%\Documents"
move "*.pdf"  "%folder%\Documents"
move "*.pptx" "%folder%\Documents"
goto :organize2

:organize2
md "Images"
move "*.jpg" "%folder%\Images"
move "*.jpeg"  "%folder%\Images"
move "*.png" "%folder%\Images"
move "*.gif" "%folder%\Images"
move "*.tiff"  "%folder%\Images"
move "*.tif" "%folder%\Images"
move "*.bmp" "%folder%\Images"
move "*.webp"  "%folder%\Images"
move "*.nef" "%folder%\Images"
move "*.cr2" "%folder%\Images"
move "*.arw"  "%folder%\Images"
move "*.dng" "%folder%\Images"
move "*.svg" "%folder%\Images"
move "*.ai"  "%folder%\Images"
move "*.eps" "%folder%\Images"
goto :organize3

:organize3
md "Text Files"
move "*.txt" "%folder%\Text Files"
goto :doneorganize

:doneorganize
cls
echo: ________________________________________________
echo:                    Done!
echo:        Your files have been organized.
echo:           Please select an option.
echo.
echo:  [1] Organize another folder       [2] Extras
echo: ________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :extras
if %_erl%==1 goto :fileorganizer


:errororganize
cls
echo: _____________________________________________________
echo:  Whoops! You entered an invalid or inaccesable path.
echo:               Do you want to try again?
echo.
echo:  [1] Yes                                    [2] No
echo: _____________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :extras
if %_erl%==1 goto :fileorganizer

:weakchangelogfile
cls
type "%userprofile%"\downloads\Windows.Update.Reset.Version.3.1.4\"Application files"\changelog.txt
echo.
echo.
echo To return to the extras menu, press any key.
pause >nul
goto :extras


:weakchangelogfile2
cls
type "%userprofile%"\downloads\Windows.Update.Reset.Version.3.1.4\"Application files"\changelog.txt
echo.
echo.
echo To return to the extras menu, press any key.
pause >nul
goto :extraslimited


:toolstofixwindows
cls            
echo:     __________________________________________________________________________________________
echo:                                     Welcome to Repair Tools!                Version %version%
echo:                               
echo:                                         Instructions:                       
echo:                           Enter a menu option in the Keyboard [1,2,3,4]
echo:     __________________________________________________________________________________________
echo.
echo:          Option                                       Description                                                        
echo. 
echo:          [1] Restart to UEFI                          Restarts the computer to
echo:                                                       the UEFI interface.
echo.
echo:          [2] Run sfc /scannow                         Runs sfc /scannow
echo.
echo:          [3] Run the DISM repair tool                 Runs DISM
echo.
echo:          [4] Back to Extras menu.                     Goes back to the Extras
echo:                                                       menu
echo:     __________________________________________________________________________________________

choice /C:1234 /N
set _erl=%errorlevel%

if %_erl%==4 goto :Extras
if %_erl%==3 goto :dismrepair
if %_erl%==2 goto :sfcrepair
if %_erl%==1 goto :UEFIBoot

:UEFIBoot
cls
shutdown -fw -r -t 30
echo.
echo: _________________________________________________________________
echo:      Your computer will restart to the UEFI interface soon.
echo: _________________________________________________________________
echo.
echo To exit this program, Press any key
pause >nul
exit

:dismrepair
cls
echo.
echo: ___________________________________________________
echo:          Running the dism repair tool
echo:                  Please wait.
echo: ___________________________________________________
echo.
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
dism /online /cleanup-image /restorehealth >nul 2>nul
goto :exit3

:sfcrepair
cls
echo.
echo: ___________________________________________________
echo:             Running sfc /scannow...
echo:                  Please wait.
echo: ___________________________________________________
echo.
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
sfc /scannow >nul 2>nul
goto :exit4

:changelogfile
cls
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
start /wait changelog.txt
goto :Extras

:changelogfile2
cls
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
start /wait changelog.txt
goto :extraslimited

:: Starts the command prompt
:startcmd
cls
echo:                                     Instructions:
echo:                         Type help to view the avelible commands.
echo:                      You can also type "exit" to go back to extras,
echo:                              you can also type "help" for
echo:                                        help.
echo.
Title Windows Update Reset - Command Prompt
cmd
goto :Extras

:: Starts the command prompt in limited mode
:startcmd2
cls
echo:                                     Instructions:
echo:                         Type help to view the avelible commands.
echo:                      You can also type "exit" to go back to extras,
echo:                              you can also type "help" for
echo:                                        help.
echo.
Title Windows Update Reset - Command Prompt
cmd
goto :extraslimited


:restartexplorer
cls
Title Windows Update Reset - Restarting explorer
echo: __________________________________________
echo:        Please wait while Explorer
echo:                restarts.
echo: __________________________________________
taskkill /f /im explorer.exe >nul 2>nul
explorer.exe
goto :Extras

:restartexplorer2
cls
Title Windows Update Reset - Restarting explorer
echo: __________________________________________
echo:        Please wait while Explorer
echo:               restarts.
echo: __________________________________________
taskkill /f /im explorer.exe >nul 2>nul
explorer.exe
goto :extraslimited

:: This is responsible for showing the credit's
:credits
cls
echo: _____________________________________________________________
echo:                          Credits: 
echo: _____________________________________________________________                  
echo.
echo:                         Made by:
echo:                    %Name%
echo.
echo:            Some code has been used from the MAS
echo:  (Microsoft-Activation-Scripts) (Since Version 3.0.3) and the  
echo:         wureset script (Since Version 3.1.4) to help
echo:                  make this script better.
echo.
echo:         Portions of this batch script are made by
echo:         Manuel Gil, Copyright (c) 2023 Manuel Gil.
echo.
echo:        Thank you for choosing Windows Update Reset!
echo.
echo:          Copyright (c) 2024 Liam Francis Olarte
echo.
Echo:    To return to page 2 of the main menu, press any key.
echo: _____________________________________________________________
pause >nul
goto :MainMenuPage2

:: This is responsible for showing the credit's in limited mode
:credits2
cls
echo: _____________________________________________________________
echo:                          Credits: 
echo: _____________________________________________________________                  
echo.
echo:                         Made by:
echo:                    %Name%
echo.
echo:            Some code has been used from the MAS
echo:  (Microsoft-Activation-Scripts) (Since Version 3.0.3) and the  
echo:         wureset script (Since Version 3.1.4) to help
echo:                  make this script better.
echo.
echo:         Portions of this batch script are made by
echo:         Manuel Gil, Copyright (c) 2023 Manuel Gil.
echo.
echo:        Thank you for choosing Windows Update Reset!
echo.
echo:          Copyright (c) 2024 Liam Francis Olarte
echo.
Echo:         To return to the main menu, press any key.
echo: _____________________________________________________________
pause >nul
goto :limitmode

:: This is responsible for showing the warning when this script is running without administrator previlages
:ADMINCHECKFAILED
Cls
Title Windows Update Reset - Warning
Echo:
Echo: _______________________________________________________________________
Echo:                            Warning:     
Echo:    This script requires administrator privileges to run properly.
echo:       You can still choose to run this script in limited mode.
Echo:           Please refer to the readme file for more info.
Echo:                    What would you like to do?
Echo:
Echo:   [1] Run in limited mode      [2] Open readme file.     [3] Exit
Echo: _______________________________________________________________________

choice /C:123 /N
set _erl=%errorlevel%

if %_erl%==3 exit
if %_erl%==2 goto :openreadmefile2
if %_erl%==1 goto :limitmode

:: This is responsible for displaying the main menu in limited mode
:limitmode
cls
set version=3.1.4
Title Windows Update Reset - Limited Mode
echo:       ______________________________________________________________________________________
echo:                                 Welcome to Windows Update Reset!         Version %version%        
echo:                                                                          Limited Mode                        
echo:                                          Instructions:             
echo:                           Enter a menu option in the Keyboard [1,2,3,4]                         
echo:       ______________________________________________________________________________________
echo:                                                
echo:             Option                                  Description    
echo:
echo:             [1] Help                                Opens the readme file.
echo:             
echo:             [2] Extras                              Shows extras that
echo:                                                     are not really
echo:                                                     the purpose of
echo:                                                     this program.
echo:
echo:             [3] Credits                             Shows the credits.
echo:
echo:             [4] Exit                                Quits the program. 	 
echo:       ______________________________________________________________________________________
echo:

choice /C:1234 /N
set _erl=%errorlevel%

if %_erl%==4 goto :exitnow
if %_erl%==3 goto :credits2
if %_erl%==2 goto :extraslimited
if %_erl%==1 goto :openreadmefile3

:: This is responsible for showing the extra's in limited mode
:extraslimited
cls
Title Windows Update Reset - Limited Mode
echo:     _______________________________________________________________________________________
echo:                                     Welcome to Extras!                   Version %version%
echo:                                                                          Limited Mode
echo:                                       Instructions:
echo:                      Enter a menu option in the Keyboard [1,2,3,4,5,6]
echo:     _______________________________________________________________________________________
echo.
echo:           Option                                  Description
echo.
echo:           [1] Open the changelog file             Opens the changelog file
echo:                                                   that only list's changes
echo:                                                   from Version 3.0.9 and later.
echo:
echo:           [2] Open the changelog file             Does the same thing as option 1
echo:               (For weak computers)                but does not use Notepad.
echo.
echo:           [3] Restart Explorer                    Restarts file explorer.
echo.    
echo:           [4] Open Command Prompt                 Opens the command prompt
echo:                                                   (Some commands may not work in
echo:                                                   limited mode).
echo:
echo:           [5] Restart Program                     Restarts the program.   
echo:                     
echo:           [6] Back to Main Menu                   Goes back to the main menu.
echo:     _______________________________________________________________________________________

choice /C:123456 /N
set _erl=%errorlevel%

if %_erl%==6 goto :limitmode
if %_erl%==5 goto :startload
if %_erl%==4 goto :startcmd2
if %_erl%==3 goto :restartexplorer2
if %_erl%==2 goto :weakchangelogfile2
if %_erl%==1 goto :changelogfile2

:: Reset's windows update
:enable_echo
cls
Echo .
Echo:                                Note:
Echo: You might see some errors during reset although most of the errors are okay.
Echo.
Echo.
Echo Creating a restore point
Echo.
@Echo on
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Windows Update Reset", 100, 7
@Echo off
Echo.
Echo Stopping Windows Update Services
Echo.
@Echo on
net stop bits
net stop wuauserv
net stop applockerfltr
net stop appidsvc
net stop cryptsvc
@Echo off
Echo.
Echo Deleting qmgr files
Echo.
@Echo on
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*" /q
Echo off
Echo.
Echo Clearing Windows Update Cache
Echo.
@Echo on
rmdir %systemroot%\SoftwareDistribution /S /Q
rmdir %systemroot%\system32\catroot2 /S /Q 
@Echo off
Echo.
Echo Reseting the Windows Update Services
Echo.
@Echo on
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
cd /d %windir%\system32
@Echo off
Echo.
Echo Re-registering the critical DLL files
Echo.
@Echo on  
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
Echo off
Echo.
Echo Reseting network settings
Echo.
@Echo on  
netsh winsock reset
netsh winsock reset proxy
@Echo off
Echo.
Echo Starting Windows Update Services
Echo.
@Echo on  
net start bits
net start wuauserv
net start appidsvc
net start applockerfltr
net start cryptsvc
Echo.
@echo off
goto :exitmenu


:: Reset's windows update
:not_see_the_thing
cls
Echo.
Echo:                                Note:
Echo: You might see some errors during reset although most of the errors are okay.
Echo. 
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Windows Update Reset", 100, 7                                     
net stop bits
net stop wuauserv
net stop applockerfltr
net stop appidsvc
net stop cryptsvc
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*" /q
rmdir %systemroot%\SoftwareDistribution /S /Q
rmdir %systemroot%\system32\catroot2 /S /Q 
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
cd /d %windir%\system32  
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll  
netsh winsock reset
netsh winsock reset proxy  
net start bits
net start wuauserv
net start appidsvc
net start applockerfltr
net start cryptsvc
Echo.
goto :exitmenu

:: Responsible for showing the done menu after reseting windows update
:exitmenu
Echo: ______________________________________________________________
Echo:                          Done! 
Echo:             Do you want to exit this program?
Echo:
Echo:    [1] Exit                             [2] Main Menu
Echo: ______________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :start
if %_erl%==1 goto :exitnow

:: Responsible for showing the done menu after reseting windows update with the new menu
:exit2
cls
Echo: ______________________________________________________________
Echo:                          Done! 
Echo:             Do you want to exit this program?
Echo:
Echo:    [1] Exit                             [2] Main Menu
Echo: ______________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :start
if %_erl%==1 goto :exitnow

:: Responsible for showing the done menu after running DISM
:exit3
cls
Echo: ______________________________________________________________
Echo:                          Done! 
Echo:             Do you want to open the log file?
Echo:
Echo:    [1] Repair Tools                      [2] Open log file
Echo: ______________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :dismlogfile
if %_erl%==1 goto :toolstofixwindows

:dismlogfile
notepad %systemroot%\Logs\DISM\dism.log
goto :exit3

:: Responsible for showing the done menu after running sfc
:exit4
cls
Echo: ______________________________________________________________
Echo:                          Done! 
Echo:             Do you want to open the log file?
Echo:
Echo:    [1] Repair Tools                      [2] Open log file
Echo: ______________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :sfcscannowlogfile
if %_erl%==1 goto :toolstofixwindows

:sfcscannowlogfile
notepad %windir%\logs\cbs\cbs.log
goto :exit4

:: Displays a message while exiting
:exitnow
cls
echo: ______________________________________________________
echo:                       Exiting.
echo:                     Please wait.
echo: ______________________________________________________
endlocal
exit

:: Reset's windows update with the new menu
:newresetmenu
cls
echo: ______________________________________________________
echo:              Resetting windows update.
echo:                     Please wait.
echo: ______________________________________________________
cd /d %userprofile%\downloads\Windows.Update.Reset.Version.3.1.4\Application Files
start /wait /min Reset.bat
goto :exit2

:: Reset's windows update
:see_the_thing
cls
Echo.
Echo:                                Note:
Echo: You might see some errors during reset although most of the errors are okay.
Echo.
Echo.
Echo Creating a restore point
Echo.
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Windows Update Reset", 100, 7
Echo. 
Echo Stopping Windows Update Services
Echo.                                          
net stop bits
net stop wuauserv
net stop applockerfltr
net stop appidsvc
net stop cryptsvc
Echo.
Echo Deleting qmgr files
Echo.
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*" /q
Echo. 
Echo Clearing Windows Update Cache
Echo. 
rmdir %systemroot%\SoftwareDistribution /S /Q
rmdir %systemroot%\system32\catroot2 /S /Q
Echo.
Echo Reseting the Windows Update Services
Echo.
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
cd /d %windir%\system32
Echo.
Echo Re-registering the critical DLL files
Echo.
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
Echo.
Echo Reseting network settings
Echo.  
netsh winsock reset
netsh winsock reset proxy
Echo.
Echo Starting Windows Update Services
Echo. 
net start bits
net start wuauserv
net start appidsvc
net start applockerfltr
net start cryptsvc
Echo.
goto :exitmenu

:: Reset's windows update
:stage1
cls
Echo.
Echo:                                Note:
Echo: You might see some errors during reset although most of the errors are okay.
Echo.
Echo.
Echo Creating a restore point
Echo.
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Windows Update Reset>", 100, 7
Echo. 
Echo Stopping Windows Update Services
Echo.                                          
net stop bits
net stop wuauserv
net stop applockerfltr
net stop appidsvc
net stop cryptsvc
Echo.
Echo Deleting qmgr files
Echo.
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*" /q
Echo. 
Echo Clearing Windows Update Cache
Echo. 
rmdir %systemroot%\SoftwareDistribution /S /Q
rmdir %systemroot%\system32\catroot2 /S /Q
Echo.
Echo Reseting the Windows Update Services
Echo.
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
cd /d %windir%\system32
Echo.
Echo Re-registering the critical DLL files
Echo.
goto :stage2

:stage2

regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
goto :stage3

:stage3

Echo.
Echo Reseting network settings
Echo.  
netsh winsock reset
netsh winsock reset proxy
Echo.
Echo Starting Windows Update Services
Echo. 
net start bits
net start wuauserv
net start appidsvc
net start applockerfltr
net start cryptsvc
Echo.
shutdown /r /t 20
Echo.
goto :restartmenu


:: This is responsible for displaying the restart menu
:restartmenu
Echo: ____________________________________________________________
Echo:                          Done!
Echo:             Your computer will restart soon.
Echo:            Do you want to cancel the restart?
Echo:
Echo:        [1] Yes                              [2] No
Echo: ____________________________________________________________      

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :halt
if %_erl%==1 goto :abort_restart


:: This is responsible for showing the following message if you don't select to cancel the restart
:halt
cls
Echo: ______________________________________________________________________
Echo:                    Your computer will restart soon.           
Echo:                   Press any key to exit this script.
Echo: ______________________________________________________________________
pause >nul
exit

:: This is responsible for showing the following message if you select to cancel the restart
:abort_restart
cls
shutdown /a
Echo: _______________________________________________________________
Echo:              Your computer will not restart soon.
Echo:               Do you want to exit this program?
Echo:
Echo:    [1] Exit                                [2] Main Menu
Echo: ______________________________________________________________

choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 goto :start
if %_erl%==1 goto :exitnow
