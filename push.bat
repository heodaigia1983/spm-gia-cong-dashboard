@echo off
REM Push dashboard len GitHub Pages.
REM CANH BAO: file nay chi con la duong du phong. Viec thuong ngay dung D:\SPM\CHAY.bat.
REM Tu 06/08/2026 co chot chan: du lieu khong du nguon thi TU CHOI push.
REM KHONG duoc dat 'pause' trong file nay - Power Automate goi no khong nguoi truc,
REM pause se treo ca day chuyen dem va may khong bao gio tat.
cd /d D:\SPM\dashboard
echo ==== %date% %time% ==== > push.log

set PY=python
if exist "D:\SPM\.venv\Scripts\python.exe" set PY=D:\SPM\.venv\Scripts\python.exe
"%PY%" -u D:\SPM\chay.py --chi-kiem-tra >> push.log 2>&1
if errorlevel 1 (
  echo TU CHOI PUSH - du lieu khong du. Doc D:\SPM\chay.log roi chay D:\SPM\CHAY.bat. >> push.log
  echo exit=1 >> push.log
  exit /b 1
)

REM Tu 29/08/2026 phanbo.json khong con trong repo (phan bo nam o Firestore).
REM Da bo dong 'git checkout -- phanbo.json' vi file khong con duoc track -> bao loi moi dem.
git pull --rebase --autostash origin main >> push.log 2>&1
if errorlevel 1 (
  echo LOI pull --rebase - huy rebase de repo khong bi ket. >> push.log
  git rebase --abort >> push.log 2>&1
  echo exit=2 >> push.log
  exit /b 2
)
git push origin main >> push.log 2>&1
echo exit=%errorlevel% >> push.log