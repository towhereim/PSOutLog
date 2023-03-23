$logColor=@{"[INFO]"="Green";"[WARN]"="Yellow";"[ERR]"="Red"}
function Add-Logging ([string]$str, [string]$lvl){
    $psPath = (Get-PSCallStack)[2].ScriptName
    $slash = ($IsWindows) ? "\" : "/"
    $path = $psPath ? $psPath.Replace($slash+$psPath.Split($slash)[-1],"") : "."
    $logPath="$path/logs/$($psPath.Split($slash)[-1].Split('.ps1')[0]).log"
    if(!(Test-Path $logPath)){New-Item $logPath -Force}
    $logStr="$(Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff")`t$lvl $str"
    Write-Host $logStr -ForegroundColor:$logColor[$lvl]
    Add-Content -Path $logPath -Value $logStr
}
function Out-Log ([string]$str){Add-Logging $str "[INFO]"}
function Out-WarnLog ([string]$str){Add-Logging $str "[WARN]"}
function Out-ErrLog ([string]$str){Add-Logging $str "[ERR]";exit; }