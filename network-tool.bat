@echo off
setlocal enabledelayedexpansion
:loop
cls
set ssid=
set Description=
set State=
set Signal=
color 0A
for /f "tokens=2 delims=: " %%a in ('netsh wlan show interface ^| find "SSID" ^| findstr /v "BSSID"') do set ssid=%%a
for /f "tokens=2* delims=: " %%a in ('netsh wlan show interface ^| find "Description"') do set Description=%%b
for /f "tokens=2 delims=: " %%a in ('netsh wlan show interface ^| find "State"') do set State=%%a
for /f "tokens=2 delims=: " %%a in ('netsh wlan show interface ^| find "Signal"') do set Signal=%%a
for /f "tokens=4 delims==: " %%a in ('ping -n 2 8.8.8.8 ^| find "Average"') do set ping=%%a
for /f "tokens=2 delims=: " %%a in ('netsh wlan show interface ^| find "Signal"') do set Signal=%%a
for /f "tokens=2 delims==: " %%a in ('ping -n 2 8.8.8.8 ^| find "Average"') do set ping=%%a
for /f "tokens=2 delims= " %%a in ('netstat -e ^| find "Bytes"') do set rbytes=%%a
for /f "tokens=3 delims= " %%a in ('netstat -e ^| find "Bytes"') do set  sbytes=%%a



echo NETWORK
echo --------
echo  SSID: !ssid!
echo  NIC: !Description!
echo  State: !State!
echo  Signal: !Signal!
echo.
echo PING
echo _______
echo  Average:  !ping!
echo  Received: !rbytes!
echo  Sent: !sbytes!
timeout /t 5 /nobreak >nul
goto loop