# =============================================================================
# Knowledge Wiki — Auto Git Sync (FileSystemWatcher)
# =============================================================================
# 이 스크립트는 Obsidian 볼트의 파일 변경을 감지하여
# 자동으로 git add → commit → push 를 수행합니다.
#
# 사용법:
#   powershell -ExecutionPolicy Bypass -File "D:\Obsidan\Knowledge_01\.scripts\auto-sync.ps1"
#
# 중지: Ctrl+C 또는 터미널 닫기
# =============================================================================

$VaultPath = "D:\Obsidan\Knowledge_01"
$DebounceSeconds = 30  # 변경 후 이 시간만큼 대기 후 커밋 (연속 편집 대응)

# --- 색상 로그 함수 ---
function Write-Log {
    param([string]$Message, [string]$Color = "Cyan")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] $Message" -ForegroundColor $Color
}

Write-Log "🚀 Knowledge Wiki Auto-Sync 시작" "Green"
Write-Log "📂 감시 경로: $VaultPath"
Write-Log "⏱  디바운스: ${DebounceSeconds}초"
Write-Log "중지하려면 Ctrl+C를 누르세요." "Yellow"
Write-Log "---"

# --- FileSystemWatcher 설정 ---
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $VaultPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $false
$watcher.NotifyFilter = [System.IO.NotifyFilters]::FileName -bor
                         [System.IO.NotifyFilters]::DirectoryName -bor
                         [System.IO.NotifyFilters]::LastWrite

# .git 과 .obsidian/workspace 변경은 무시
$ignorePatterns = @("\.git\\", "\.git/", "workspace.json", "workspace-mobile.json", "graph.json")

function Should-Ignore {
    param([string]$FilePath)
    foreach ($pattern in $ignorePatterns) {
        if ($FilePath -match [regex]::Escape($pattern).Replace("\\\*", ".*")) {
            return $true
        }
    }
    # .git 디렉토리 내부 변경 무시
    if ($FilePath -match "[\\/]\.git[\\/]") {
        return $true
    }
    return $false
}

function Do-GitSync {
    Push-Location $VaultPath
    try {
        # 변경사항 확인
        $status = git status --porcelain 2>&1
        if ([string]::IsNullOrWhiteSpace($status)) {
            Write-Log "변경사항 없음, 스킵" "DarkGray"
            return
        }

        # 변경 파일 수 계산
        $changedFiles = ($status -split "`n") | Where-Object { $_ -match '\S' }
        $fileCount = $changedFiles.Count

        # 커밋 메시지 생성
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
        $commitMsg = "wiki: auto-sync $fileCount file(s) at $timestamp"

        Write-Log "📦 변경 감지: $fileCount 파일" "Yellow"

        # git add, commit, push
        git add -A 2>&1 | Out-Null
        $commitResult = git commit -m $commitMsg 2>&1
        Write-Log "✅ 커밋: $commitMsg" "Green"

        $pushResult = git push origin main 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Log "🌐 GitHub 푸시 완료!" "Green"
        } else {
            Write-Log "⚠️  푸시 실패: $pushResult" "Red"
        }
    }
    catch {
        Write-Log "❌ 오류: $_" "Red"
    }
    finally {
        Pop-Location
    }
}

# --- 메인 루프 ---
$lastChangeTime = [DateTime]::MinValue
$pendingSync = $false

try {
    while ($true) {
        # 변경 감지 (500ms 대기)
        $result = $watcher.WaitForChanged(
            [System.IO.WatcherChangeTypes]::All, 500
        )

        if (-not $result.TimedOut) {
            $changedPath = $result.Name
            if (-not (Should-Ignore $changedPath)) {
                $lastChangeTime = Get-Date
                if (-not $pendingSync) {
                    Write-Log "📝 변경 감지: $changedPath" "DarkCyan"
                    $pendingSync = $true
                }
            }
        }

        # 디바운스: 마지막 변경 이후 N초 경과하면 동기화
        if ($pendingSync) {
            $elapsed = ((Get-Date) - $lastChangeTime).TotalSeconds
            if ($elapsed -ge $DebounceSeconds) {
                Do-GitSync
                $pendingSync = $false
            }
        }
    }
}
finally {
    $watcher.Dispose()
    Write-Log "🛑 Auto-Sync 종료" "Yellow"
}
