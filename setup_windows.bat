@echo off
setlocal
cd /d %~dp0
echo [1/6] Creating virtual environment...
if not exist .venv\Scripts\python.exe py -m venv .venv
if not exist .venv\Scripts\python.exe python -m venv .venv
if not exist .venv\Scripts\python.exe (echo ERROR: Python virtual environment could not be created.& pause & exit /b 1)
echo [2/6] Installing requirements...
.venv\Scripts\python.exe -m pip install --upgrade pip
.venv\Scripts\python.exe -m pip install -r requirements.txt
if errorlevel 1 (echo ERROR: Package installation failed.& pause & exit /b 1)
echo [3/6] Creating Django migration...
.venv\Scripts\python.exe manage.py makemigrations portal --noinput
if errorlevel 1 (echo ERROR: makemigrations failed.& pause & exit /b 1)
echo [4/6] Creating/updating database...
.venv\Scripts\python.exe manage.py migrate --noinput
if errorlevel 1 (echo ERROR: migrate failed.& pause & exit /b 1)
echo [5/6] Loading initial website content...
.venv\Scripts\python.exe manage.py seed_defaults
echo [6/6] Django system check...
.venv\Scripts\python.exe manage.py check
if errorlevel 1 (echo ERROR: Django check failed.& pause & exit /b 1)
echo.
echo SETUP COMPLETED SUCCESSFULLY.
echo Create administrator now:
.venv\Scripts\python.exe manage.py createsuperuser
echo.
echo Use run_windows.bat to start the website.
pause
