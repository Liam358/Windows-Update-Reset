@echo off

Echo Windows Update Reset (WUR) Version 0.0.3 Build 7 Codename: WUR V3

net session >nul 2>&1
if %errorLevel% == 0 (
    cd /d C:\Windows\System32
) else (
     

    Echo An Error Has Occurred. Error Code: ADMIN_CHECK_FAILED
    echo Reason: You are not running this program as an administrator.
    echo Solution: Please run this as an administrator.
    echo This program has closed.
    echo To close this window, Press any key.
    pause
    exit
)

Echo Please wait...
Echo Please do not tamper with the code.
Echo This is a Pre-release, so, It can be incomplete and unstable
Echo Instructions :
Echo Type "Yes" If you want to or type "No" If you don't want to.


:choice
set /P c=Do you want to continue "Yes" Or "No"?
if /I "%c%" EQU "Yes" goto :choice2
if /I "%c%" EQU "No" goto :No
goto :choice

:choice2
set /P c=Would you like to enable echo? (You can see what commands are being executed) "Yes" or "No"?
if /I "%c%" EQU "Yes" goto :enable echo
if /I "%c%" EQU "No" goto :choice3
goto :choice2

:choice3
set /P c=Do you want to see the thing that's currently running? Example: "Starting windows update services..." "Yes" Or "No"?
if /I "%c%" EQU "Yes" goto :see_the_thing
if /I "%c%" EQU "No" goto :not_see_the_thing
goto :choice3

:enable echo

echo on
goto :stage1

:disable echo

goto :stage1

:Yes

Goto :stage1


:not_see_the_thing
Echo _______________________________________________
Echo If it continues to ask something type "Y" and press Enter.
Echo _______________________________________________                                           
net stop bits
net stop wuauserv
net stop appidsvc
net stop cryptsvc
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*"
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
net start cryptsvc
Echo Done!
Echo To close this windows, Press any key.
pause
exit


:see_the_thing
goto :stage1

:No

cls
echo This program has closed.
echo To close this window, Press any key.
pause
exit

:stage1

Echo _______________________________________________
Echo If it continues to ask something type "Y" and press Enter.
Echo _______________________________________________
Echo _______________________________________________  
Echo Stopping Windows Update Services...
Echo _______________________________________________                                            
net stop bits
net stop wuauserv
net stop appidsvc
net stop cryptsvc
Echo _______________________________________________  
Echo Deleting qmgr.dat files...
Echo _______________________________________________  
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*"
Echo _______________________________________________  
Echo Clearing Windows Update Cache...
Echo _______________________________________________  
rmdir %systemroot%\SoftwareDistribution /S /Q
rmdir %systemroot%\system32\catroot2 /S /Q
Echo _______________________________________________  
Echo Reseting the BITS and Windows Update Services...
Echo _______________________________________________  
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
cd /d %windir%\system32
Echo _______________________________________________  
Echo Re-registering the critical DLL files...
Echo _______________________________________________  
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

Echo _______________________________________________  
Echo Reseting network settings...
Echo _______________________________________________  
netsh winsock reset
netsh winsock reset proxy
Echo _______________________________________________  
Echo Starting Windows Update Services...
Echo _______________________________________________  
net start bits
net start wuauserv
net start appidsvc
net start cryptsvc
Echo Done!
Echo To close this window, Press any key
pause







