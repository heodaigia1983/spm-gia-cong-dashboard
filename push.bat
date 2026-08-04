@echo off
REM Push dashboard len GitHub Pages (dung login GitHub da luu trong Windows).
REM Chi push - viec chuan hoa + gop JSON + commit da lam san trong chat.
cd /d D:\SPM\dashboard
echo ==== %date% %time% ==== > push.log
REM phanbo.json: nguon chan ly la ban tren GitHub (nhap tay tren dashboard HTML).
REM Bo ban tren dia truoc khi pull, de khong bao gio de ban cu len ban moi.
git checkout -- phanbo.json >> push.log 2>&1
REM Keo ve commit phan bo do dashboard ghi thang len GitHub, tranh push bi reject.
git pull --rebase --autostash origin main >> push.log 2>&1
if errorlevel 1 (
  echo LOI pull --rebase - huy rebase de repo khong bi ket. >> push.log
  git rebase --abort >> push.log 2>&1
  echo exit=2 >> push.log
  exit /b 2
)
git push origin main >> push.log 2>&1
echo exit=%errorlevel% >> push.log
