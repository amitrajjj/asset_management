@echo off
echo ========================================
echo    AssetFlow Pro - Quick Start
echo ========================================
echo.

echo Stopping any existing servers...
taskkill /F /IM node.exe 2>nul
taskkill /F /IM python.exe 2>nul
timeout /t 2 /nobreak > nul

echo Starting Backend Server...
cd backend
start "AssetFlow Backend - Keep This Open" cmd /k "echo Backend Server Starting... && node src/server.js"
cd ..

echo Waiting for backend to initialize...
timeout /t 8 /nobreak > nul

echo Starting Frontend Server...
cd frontend
start "AssetFlow Frontend - Keep This Open" cmd /k "echo Frontend Server Starting... && python -m http.server 5174"
cd ..

echo Waiting for frontend to initialize...
timeout /t 3 /nobreak > nul

echo.
echo ========================================
echo         SERVERS ARE READY!
echo ========================================
echo Backend:  http://localhost:4000
echo Frontend: http://localhost:5174
echo Admin:    http://localhost:5174/admin-dashboard.html
echo ========================================
echo.

echo Opening admin dashboard...
timeout /t 2 /nobreak > nul
start http://localhost:5174/admin-dashboard.html

echo.
echo SUCCESS! Both servers are running.
echo Keep both CMD windows open.
echo.
echo Login with: admin@example.com / adminpass
echo.
echo Press any key to exit this window...
pause > nul
