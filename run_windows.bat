@echo off
setlocal
cd /d %~dp0
if not exist .venv\Scripts\python.exe (echo Virtual environment missing. Run setup_windows.bat first.& pause & exit /b 1)
.venv\Scripts\python.exe manage.py makemigrations portal --noinput >nul
.venv\Scripts\python.exe manage.py migrate --noinput
if errorlevel 1 (echo Database migration failed.& pause & exit /b 1)
.venv\Scripts\python.exe manage.py check
if errorlevel 1 (echo Django check failed.& pause & exit /b 1)
.venv\Scripts\python.exe manage.py runserver 127.0.0.1:8000
