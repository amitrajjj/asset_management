@echo off
echo ========================================
echo   AssetFlow Pro - Complete Fix
echo ========================================
echo.

echo Stopping existing servers...
taskkill /F /IM node.exe 2>nul
taskkill /F /IM python.exe 2>nul
timeout /t 2 /nobreak > nul

echo Starting XAMPP MySQL...
if exist "C:\xampp\mysql\bin\mysqld.exe" (
    net start mysql 2>nul
    if %errorlevel% neq 0 (
        start /min "MySQL" "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" --standalone --console
        timeout /t 5 /nobreak > nul
    )
    echo MySQL service started
) else (
    echo XAMPP not found. Please start MySQL from XAMPP Control Panel.
    pause
)

echo Testing MySQL connection...
timeout /t 3 /nobreak > nul
netstat -an | findstr :3306 > nul
if %errorlevel% neq 0 (
    echo WARNING: MySQL not detected. Please start XAMPP MySQL.
    pause
)

echo Creating database...
cd backend
node -e "const mysql=require('mysql2/promise');(async()=>{try{const c=await mysql.createConnection({host:'localhost',user:'root',password:''});await c.execute('CREATE DATABASE IF NOT EXISTS asset_db');console.log('DB ready');await c.end();}catch(e){console.log('DB error:',e.message);}})();" 2>nul
cd ..

echo Starting backend server...
cd backend
start "AssetFlow Backend - Keep Open" cmd /k "node src/server.js"
cd ..

echo Waiting for backend...
timeout /t 12 /nobreak > nul

echo Testing backend...
curl -s http://localhost:4000/health > nul
if %errorlevel% neq 0 (
    echo ERROR: Backend not responding. Check the backend window.
    pause
    exit /b 1
)

echo Starting frontend server...
cd frontend
start "AssetFlow Frontend - Keep Open" cmd /k "python -m http.server 5174"
cd ..

timeout /t 3 /nobreak > nul

echo.
echo ========================================
echo         ALL SYSTEMS READY!
echo ========================================
echo Backend:  http://localhost:4000
echo Frontend: http://localhost:5174
echo Main App: http://localhost:5174/index.html
echo ========================================

echo Opening application...
start http://localhost:5174/index.html

echo.
echo SUCCESS! Keep both CMD windows open.
echo Press any key to exit...
pause > nul
