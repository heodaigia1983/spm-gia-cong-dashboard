@echo off
REM Push dashboard len GitHub Pages (dung login GitHub da luu trong Windows).
REM Chi push - viec chuan hoa + gop JSON + commit da lam san trong chat.
cd /d D:\SPM\dashboard
echo ==== %date% %time% ==== > push.log
git push origin main >> push.log 2>&1
echo exit=%errorlevel% >> push.log
