# =============================================================================
# Knowledge Wiki — Task Scheduler 등록 스크립트
# =============================================================================
# 이 스크립트는 Windows 작업 스케줄러에 auto-sync를 등록합니다.
# 로그인 시 자동으로 백그라운드에서 auto-sync가 실행됩니다.
#
# 사용법 (관리자 권한으로 실행):
#   powershell -ExecutionPolicy Bypass -File "D:\Obsidan\Knowledge_01\.scripts\register-task.ps1"
#
# 삭제:
#   Unregister-ScheduledTask -TaskName "KnowledgeWikiAutoSync" -Confirm:$false
# =============================================================================

$TaskName = "KnowledgeWikiAutoSync"
$ScriptPath = "D:\Obsidan\Knowledge_01\.scripts\auto-sync.ps1"

# 기존 작업이 있으면 삭제
$existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($existingTask) {
    Write-Host "기존 작업 '$TaskName' 삭제 중..." -ForegroundColor Yellow
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# 작업 액션: PowerShell로 auto-sync.ps1 실행 (숨김 창)
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ScriptPath`""

# 트리거: 사용자 로그인 시 (CIM 방식 — 호환성 높음)
$trigger = New-CimInstance -CimClass (Get-CimClass -ClassName MSFT_TaskLogonTrigger -Namespace Root/Microsoft/Windows/TaskScheduler) -ClientOnly
$trigger.Enabled = $true

# 설정: 무기한 실행, 배터리에서도 실행
$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -ExecutionTimeLimit ([TimeSpan]::Zero) `
    -RestartCount 3 `
    -RestartInterval (New-TimeSpan -Minutes 1)

# 등록
Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Description "Obsidian Knowledge Wiki를 GitHub에 자동 동기화합니다." `
    -RunLevel Limited

Write-Host ""
Write-Host "✅ 작업 스케줄러 등록 완료!" -ForegroundColor Green
Write-Host "   작업 이름: $TaskName" -ForegroundColor Cyan
Write-Host "   트리거: 로그인 시 자동 실행" -ForegroundColor Cyan
Write-Host "   스크립트: $ScriptPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "수동 시작: Start-ScheduledTask -TaskName '$TaskName'" -ForegroundColor Yellow
Write-Host "삭제: Unregister-ScheduledTask -TaskName '$TaskName' -Confirm:`$false" -ForegroundColor Yellow
