@echo off
setlocal
cd /d %~dp0
set DJANGO_ALLOWED_HOSTS=127.0.0.1,localhost,.trycloudflare.com
.venv\Scripts\python.exe manage.py migrate --noinput
.venv\Scripts\python.exe manage.py runserver 0.0.0.0:8000
