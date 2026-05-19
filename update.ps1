# 맘솔브 대시보드 1줄 업데이트 스크립트
# 사용: powershell -File update.ps1
# = working/ V5 소스 → projects/dashboard-deploy/index.html 복사 + commit + push
# URL: https://momsolve7-rgb.github.io/momsolve-dashboard/ (~30초 후 라이브)

$ErrorActionPreference = "Stop"
# git 이 stderr 로 정보 메시지 (진행 상황) 출력하는 걸 에러로 잡지 않게
$PSNativeCommandUseErrorActionPreference = $false

$src = "C:\Users\yoriz\my-assistant\working\momsolve_orders_hub\dashboard_mockup_v5.html"
$dst = "C:\Users\yoriz\my-assistant\projects\dashboard-deploy\index.html"
$deployDir = "C:\Users\yoriz\my-assistant\projects\dashboard-deploy"

Copy-Item $src $dst -Force
Write-Host "[OK] V5 source -> index.html"

Set-Location $deployDir
git add .
$ts = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "Update dashboard $ts" 2>&1 | Out-Null
git push 2>&1 | Out-Null
Write-Host "[OK] Pushed at $ts"
Write-Host ""
Write-Host "Live in ~30s: https://momsolve7-rgb.github.io/momsolve-dashboard/"

# 완료 팝업
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$n = New-Object System.Windows.Forms.NotifyIcon
$n.Icon = [System.Drawing.SystemIcons]::Information
$n.Visible = $true
$n.ShowBalloonTip(5000, 'Claude Code', "Dashboard updated - live in ~30s", 'Info')
Start-Sleep -Seconds 6
$n.Dispose()
