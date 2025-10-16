# 一键打包、安装、运行 HarmonyOS ArkTS 应用并查看日志
# 使用方法：在项目根目录执行：
#   powershell -ExecutionPolicy Bypass -File .\build.ps1

# 应用包名和入口 Ability 名称（请根据实际修改）
$pkgName = "com.rinca.copilot"
$abilityName = "EntryAbility"
#无线调试
$ip = "192.168.43.1"
$port = "35557"
Write-Host ">>> ohpm installing..."
ohpm install
if ($LASTEXITCODE -ne 0) {
    Write-Error "ohpm install Failed"
    exit 1
}

Write-Host ">>> Building Debug package..."
hvigorw assembleHap
if ($LASTEXITCODE -ne 0) {
    Write-Error "Build Failed"
    exit 1
}

Write-Host ">>> Searching hap files..."
$hapFile = Get-ChildItem -Path "entry/build/default/outputs/default" -Recurse -Filter "*signed.hap" | Select-Object -First 1

if (-not $hapFile) {
    Write-Error "hap file not found"
    exit 1
}

Write-Host ">>> Found hap file: $($hapFile.FullName)"

Write-Host ">>> Installing hap to device..."
hdc tconn $ip`:$port
hdc install -r $hapFile.FullName
if ($LASTEXITCODE -ne 0) {
    Write-Error "Installation Failed"
    exit 1
}

Write-Host ">>> Starting application..."
hdc shell aa start -a $abilityName -b $pkgName
if ($LASTEXITCODE -ne 0) {
    Write-Error "Starting Failed"
    exit 1
}

Write-Host "Application started successfully!"
Write-Host "--------------------------------------"
Write-Host "Press Ctrl+C to stop log output"
Write-Host "--------------------------------------"
$line = hdc shell ps -ef | Select-String "$pkgName"
if ($line) {
    # ps -ef 输出一般是多列，第二列通常是 PID
    $columns = $line.ToString().Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)
    $xpid = $columns[1]
    Write-Host "application PID: $xpid"
}
hdc shell hilog -t app -P $xpid

# Real-time log viewing