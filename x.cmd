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
echo 5. Tat Windows Update
echo 6. Don dep may tinh
echo 0. Thoat
echo ===============================
set /p choice=Nhap lua chon (1-6, 0 de thoat): 

if "%choice%"=="1" goto get
if "%choice%"=="2" goto checkinfo
if "%choice%"=="3" goto checkwin7
if "%choice%"=="4" goto winutil
if "%choice%"=="5" goto update
if "%choice%"=="6" goto clean
if "%choice%"=="0" goto exit

:: Loai bo cac khoang trang trong input
set "choice=%choice: =%"

:: Kiem tra tung lua chon
echo.
if not "%choice%"=="" (
    echo Dang xu ly lua chon...

    echo %choice% | find "1" >nul && call :get
    echo %choice% | find "2" >nul && call :checkinfo
    echo %choice% | find "3" >nul && call :checkwin7
    echo %choice% | find "4" >nul && call :winutil
    echo %choice% | find "5" >nul && call :update
    echo %choice% | find "6" >nul && call :clean
    echo %choice% | find "0" >nul && goto exit
)

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
echo ==== Kiem tra thong so Windows 10/11 ====
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
echo ==== Kiem tra thong so Windows 7 ====
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
echo ==== Tuy chinh Windows ====
echo Dang chay script...
powershell -Command "irm https://drhoangzp.github.io/winutil.ps1 | iex"
echo ---------------------------------------
echo Nhan 0 de quay lai menu chinh
:wait0a
set /p back=Nhap 0 de quay lai: 
if "%back%"=="0" goto menu
goto wait0a

:clean
cls
echo ==== Don dep may tinh ====
echo Dang chay script...
@echo off
:: Kiểm tra quyền Admin bằng cách ghi vào thư mục system
>nul 2>&1 net session
if %errorLevel% NEQ 0 (
    echo Dang yeu cau quyen Administrator...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)
del /q /f /s %TEMP%\* 
del /q /f %LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db 
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*" 
del /q /f /s C:\Windows\Prefetch\*
echo ---------------------------------------
echo Da tat Windows Update xong
echo Nhan 1 de don dep may tinh
echo Nhan 0 de quay lai menu chinh
:wait0a
set /p choice=Nhap lua chon: 
if "%choice%"=="1" goto update
if "%choice%"=="0" goto menu
goto wait0a

:update
cls
echo ==== Tat Windows Update ====
echo Dang chay script...
@echo off
:: Kiểm tra quyền Admin bằng cách ghi vào thư mục system
>nul 2>&1 net session
if %errorLevel% NEQ 0 (
    echo Dang yeu cau quyen Administrator...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)
net stop wuauserv
net stop bits
sc config wuauserv start= disabled
sc config bits start= disabled
echo ---------------------------------------
echo Da don dep xong
echo Nhan 1 de tat Window Update
echo Nhan 0 de quay lai menu chinh
:wait0a
set /p choice=Nhap lua chon: 
if "%choice%"=="1" goto update
if "%choice%"=="0" goto menu
goto wait0a

:exit
exit




