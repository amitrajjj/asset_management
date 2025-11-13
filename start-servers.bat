@echo off
echo ========================================
echo    AssetFlow Pro - Clean Startup
echo ========================================
echo.

REM Kill any existing servers
echo Stopping existing servers...
taskkill /F /IM node.exe 2>nul
taskkill /F /IM python.exe 2>nul
timeout /t 2 /nobreak > nul

REM Check MySQL
echo Checking MySQL status...
netstat -an | findstr :3306 > nul
if %errorlevel% neq 0 (
    echo WARNING: MySQL not detected on port 3306
    echo Please start XAMPP MySQL service first
    echo Press any key when MySQL is running...
    pause > nul
)

echo Starting Backend Server...
cd backend
start "AssetFlow Backend - Keep Open" cmd /k "node src/server.js"
cd ..

echo Waiting for backend initialization...
timeout /t 10 /nobreak > nul

echo Testing backend connection...
curl -s http://localhost:4000/health > nul
if %errorlevel% neq 0 (
    echo ERROR: Backend not responding
    echo Check the Backend CMD window for errors
    pause
    exit /b 1
)

echo Starting Frontend Server...
cd frontend
start "AssetFlow Frontend - Keep Open" cmd /k "python -m http.server 5174"
cd ..

timeout /t 3 /nobreak > nul

echo.
echo ========================================
echo         SERVERS READY!
echo ========================================
echo Backend:  http://localhost:4000
echo Frontend: http://localhost:5174
echo Main App: http://localhost:5174/index.html
echo Admin:    http://localhost:5174/admin-dashboard.html
echo ========================================
echo.

echo Opening application...
start http://localhost:5174/index.html

echo.
echo SUCCESS: AssetFlow Pro is running!
echo Keep both CMD windows open.
echo.
echo Press any key to exit...
pause > nul
