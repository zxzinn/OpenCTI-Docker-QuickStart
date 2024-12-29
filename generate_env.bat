@echo off
echo 正在生成新的 .env 文件...

REM 檢查Python是否安裝
python --version >nul 2>&1
if errorlevel 1 (
    echo 錯誤：需要安裝Python才能繼續
    pause
    exit /b 1
)

REM 檢查OpenSSL是否安裝
openssl version >nul 2>&1
if errorlevel 1 (
    echo 錯誤：需要安裝OpenSSL才能繼續
    pause
    exit /b 1
)

REM 檢查.env.example是否存在
if not exist .env.example (
    echo 錯誤：找不到 .env.example 文件
    pause
    exit /b 1
)

REM 如果.env存在，創建備份
if exist .env (
    for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
        set mydate=%%c%%a%%b
    )
    for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (
        set mytime=%%a%%b
    )
    copy .env ".env.backup.%mydate%_%mytime%"
)

REM 創建臨時Python腳本
echo import uuid > generate_env.py
echo import secrets >> generate_env.py
echo import string >> generate_env.py
echo import os >> generate_env.py
echo. >> generate_env.py
echo def generate_password(): >> generate_env.py
echo     alphabet = string.ascii_letters + string.digits + "@#$%%^&*" >> generate_env.py
echo     return ''.join(secrets.choice(alphabet) for _ in range(16)) >> generate_env.py
echo. >> generate_env.py
echo def generate_uuid(): >> generate_env.py
echo     return str(uuid.uuid4()) >> generate_env.py
echo. >> generate_env.py
echo def generate_api_key(length=64): >> generate_env.py
echo     return secrets.token_hex(length // 2) >> generate_env.py
echo. >> generate_env.py
echo with open('.env.example', 'r') as f: >> generate_env.py
echo     lines = f.readlines() >> generate_env.py
echo. >> generate_env.py
echo with open('.env', 'w') as f: >> generate_env.py
echo     for line in lines: >> generate_env.py
echo         if line.strip() and not line.startswith('#'): >> generate_env.py
echo             name = line.split('=')[0].strip() >> generate_env.py
echo             if 'ChangeMe' in line: >> generate_env.py
echo                 if '_TOKEN' in name or '_ID' in name: >> generate_env.py
echo                     value = generate_uuid() >> generate_env.py
echo                 elif 'API_KEY' in name: >> generate_env.py
echo                     value = generate_api_key() >> generate_env.py
echo                 elif name == 'IPINFO_TOKEN': >> generate_env.py
echo                     value = generate_api_key(16) >> generate_env.py
echo                 else: >> generate_env.py
echo                     value = generate_password() >> generate_env.py
echo                 f.write(f"{name}={value}\n") >> generate_env.py
echo             else: >> generate_env.py
echo                 f.write(line) >> generate_env.py
echo         else: >> generate_env.py
echo             f.write(line) >> generate_env.py

REM 執行Python腳本
python generate_env.py

REM 刪除臨時Python腳本
del generate_env.py

echo 新的 .env 文件已生成完成！
pause
