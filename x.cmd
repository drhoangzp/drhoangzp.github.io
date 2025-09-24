@echo off
:menu
cls
echo ===============================
echo         MENU LUA CHON
echo ===============================
echo 1. Kich hoat Windows - Office
echo 2. Kiem tra Windows 10/11
echo 3. Kiem tra Windows 7
echo 4. Tuy chinh Windows
echo 0. Thoat
echo ===============================
set /p choice=Nhap lua chon (1-4, 0 de thoat): 

if "%choice%"=="1" goto get
if "%choice%"=="2" goto checkinfo
if "%choice%"=="3" goto checkwin7
if "%choice%"=="4" goto winutil
if "%choice%"=="0" goto exit

echo Lua chon khong hop le. Vui long nhap lai.
pause
goto menu

:get
cls
echo ==== Microsoft Activation Scripts ====
echo Dang chay script...
powershell -Command "irm https://get.activated.win | iex"
echo ---------------------------------------
echo Nhan 0 de quay lai menu chinh
:wait0a
set /p back=Nhap 0 de quay lai: 
if "%back%"=="0" goto menu
goto wait0a

:checkinfo
cls
echo ==== Kiem tra thong tin (Moi nhat) ====
echo Dang chay script...
powershell -Command "irm https://drhoangzp.github.io/checkinfo.ps1 | iex"
echo ---------------------------------------
echo Nhan 0 de quay lai menu chinh
:wait0a
set /p back=Nhap 0 de quay lai: 
if "%back%"=="0" goto menu
goto wait0a

:checkwin7
cls
echo ==== Kiem tra tren Windows 7 ====
echo Dang chay script...
powershell -Command "iex (Invoke-WebRequest -UseBasicParsing https://drhoangzp.github.io/win7.ps1).Content"
echo ---------------------------------------
echo Nhan 0 de quay lai menu chinh
:wait0b
set /p back=Nhap 0 de quay lai: 
if "%back%"=="0" goto menu
goto wait0b

:winutil
cls
echo ==== Tuy chinh Windows====
echo Dang chay script...
powershell -Command "irm https://drhoangzp.github.io/winutil.ps1 | iex"
echo ---------------------------------------
echo Nhan 0 de quay lai menu chinh
:wait0a
set /p back=Nhap 0 de quay lai: 
if "%back%"=="0" goto menu
goto wait0a

:exit
exit
