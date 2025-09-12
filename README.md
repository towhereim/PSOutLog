# PSOutLog

PSOutLog is a PowerShell logging module designed to provide streamlined logging functionality for your scripts. It offers functions such as Out-Log, Out-WarnLog, Out-ErrLog, and Out-LogBlock to generate log files with various log levels and styles.

- Sample.ps1
![poster](./PSOutLog_Sample.png)

## Overview

- **Module Version**: 1.3 
- **Author**: Steve Im  
- **Company**: towhereim  
- **Description**: A logging module for PowerShell. PSOutLog creates a log file (e.g., <scriptname>.log) in the 'logs' folder and highlights key events using keywords like `START`, `END`, and `STEP`. It also supports log date format customization via environment variables.
- **Compatible Editions**: Core, Desktop

## Features

- Simple logging mechanism with multiple log levels.
- Out-Log for standard log messages.
- Out-WarnLog for warning messages.
- Out-ErrLog for error messages.
- Out-LogBlock for logging blocks of messages.
- Automatic log file creation.
- Keyword highlighting (`START`, `END`, `STEP`).

## Installation

1. This module is registered in the PowerShell Gallery. You can install it using:
   ```powershell
   Install-Module PSOutLog -RequiredVersion 1.3
   ```
2. Import the module in your PowerShell session using:
   ```powershell
   Import-Module PSOutLog
   ```

## Usage

```powershell
Import-Module PSOutLog

# Log a standard message
Out-Log 'Script execution started'

# Log a warning message with an indent
Out-WarnLog 'This is a warning message' -Indent 1

# Log an error message with a deeper indent
Out-ErrLog 'An error occurred' -Indent 2

# Log a block of messages for a specific step
Out-LogBlock 'STEP 1: Initialization' -Type 'start'
Out-Log 'Initializing variables...' -Indent 1
Out-Log 'Connecting to database...' -Indent 1
Out-LogBlock 'STEP 1: Initialization' -Type 'end'
```

## Environment Variable
![env](./PSOutLog_EnvVars.png)
- **PSOUTLOG_FILE_DATE_FORMAT**
  - Use this to rotate log files daily, hourly, or on any other schedule. The format you provide will be appended to the log filename (e.g., `script_yyyy-MM-dd.log`).
- **PSOUTLOG_LOG_DATE_FORMAT**
  - Use this to customize the timestamp format within the log entries. The default is `yyyy-MM-dd HH:mm:ss.fff`.

## Additional Information

- **License**: [MIT License](https://github.com/towhereim/PSOutLog/LICENSE)
- **Project Repository**: [PSOutLog on GitHub](https://github.com/towhereim/PSOutLog)
- **Release Notes**:
  - **v1.1**
    - Added `Out-LogBlock` function.
    - Implemented keyword highlighting for `START`, `END`, and `STEP`.
  - **v1.2**
    - Added indent support for all logging functions to improve readability.
  - **v1.3**
    - Fixed a bug preventing log file creation when `Out-LogBlock` was called.
    - Corrected an issue with the keyword highlighting logic.
    - Introduced environment variables for date format customization.