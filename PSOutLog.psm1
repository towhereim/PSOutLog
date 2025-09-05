$color=@{
    "[INFO]"="Green"
    "[WARN]"="Yellow"
    "[ERR]"="Red"
    "Purple"=$PSStyle.Foreground.FromRgb(0xa020f0)
    "Orange"=$PSStyle.Foreground.FromRgb(0xffb618)
    "DeepYellow"=$PSStyle.Foreground.FromRgb(0xfff640)
}
$keyword=@("START","END", "STEP")
function Add-Logging ([string]$str, [string]$lvl){
    $psPath = (Get-PSCallStack)[2].ScriptName
    $slash = ($IsWindows) ? "\" : "/"
    $path = ($psPath -and $psPath -notcontains ".psm1") ? $psPath.Replace($slash+$psPath.Split($slash)[-1],"") : "."
    $logPath="$path/logs/$($psPath ? $psPath.Split($slash)[-1].Split('.ps1')[0] : '')$($env:PSOUTLOG_DATE_FORMAT ? "_" + $(Get-Date -Format $env:PSOUTLOG_DATE_FORMAT) : '').log"
    if(!(Test-Path $logPath)){New-Item $logPath -Force}
    $logStr="$(Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff")`t$lvl $str"
    foreach($item in $keyword){ if($logStr -cmatch $item){$writeStr=$logStr -replace $item,"$($color.Orange)$item$($PSStyle.Reset)"} }
    $boldStr=$logStr -match " : " ? $logStr -split " : " : $null
    if($boldStr -and $boldStr[1]){ $writeStr=($writeStr ? $writeStr : $logStr) -replace $boldStr[-1],"$($color.Purple)$($boldStr[-1])" }
    $writeStr = $writeStr ? $writeStr : $logStr
    Write-Host $writeStr -ForegroundColor:$color[$lvl]
    Add-Content -Path $logPath -Value $logStr
}
<#
.SYNOPSIS
   Writes an informational/warning/error log message and creates a log file if it doesn't exist.
.DESCRIPTION
   Out-Log writes the given message with informational log level.
.PARAMETER str
   The log message to write.
.EXAMPLE
   Out-Log "This is an info message"
   Out-WarnLog "This is a warning message"
   Out-ErrLog "This is an error message"
#>
function Out-Log ([string]$str){Add-Logging $str "[INFO]"}
<#
.SYNOPSIS
   Writes a warning log message.
.DESCRIPTION
   Out-WarnLog writes the given message with warning log level.
.PARAMETER str
   The log message to write.
.EXAMPLE
   Out-WarnLog "This is a warning message"
#>
function Out-WarnLog ([string]$str){Add-Logging $str "[WARN]"}
<#
.SYNOPSIS
   Writes an error log message and terminates execution.
.DESCRIPTION
   Out-ErrLog writes the given message with error log level and then exits the process.
.PARAMETER str
   The log message to write.
.EXAMPLE
   Out-ErrLog "This is an error message"
#>
function Out-ErrLog ([string]$str){Add-Logging $str "[ERR]";exit; }

<#
.SYNOPSIS
   Writes a block of log messages.
.DESCRIPTION
   Out-LogBlock writes a formatted block of log messages with a title and optional formatting based on a start or end marker.
.PARAMETER title
   The title or message identifier for the log block.
.PARAMETER startORend
   A flag indicating if this is the start or end of the log block. Acceptable values are "start" or "end".
.PARAMETER indent
   The indentation level to apply to the log block.
.EXAMPLE
   Out-LogBlock "$($MyInvocation.MyCommand.Name)" -startORend "start" -indent 0
   Out-LogBlock "$($MyInvocation.MyCommand.Name)" -startORend "end" -indent 0
   Out-LogBlock "$($MyInvocation.MyCommand.Name)" "start" 2
   Out-LogBlock "$($MyInvocation.MyCommand.Name)" "end" 2
#>
function Out-LogBlock ($title, [string][ValidateSet("start", "end")]$startORend = "start", [int]$indent = 1) {
    $charStep = @("≫", "—", "✧", "•", "∘", "･")
    $strLine = ""
    1..(79 - ($indent * 2)) | ForEach-Object { $strLine += $charStep[$indent] }
    $strIndent = ""
    0..($indent * 2) | ForEach-Object { if ($_ -gt 0) { $strIndent += " " } }

    Out-Log $strIndent$strLine
    Out-Log "$($strIndent)$($startORend.ToUpper()) : $title"
}