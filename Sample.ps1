
# Script start log output
Out-LogBlock "$($MyInvocation.MyCommand)" "start" 0

# Example of output using all log functions from the module
Out-Log "This is a standard log message." 1
Out-WarnLog "This is a warning log message." 1
# Out-ErrLog "This is an error log message."

# Define a function using log functions
function Invoke-SampleLog {
    # Function start log output
    Out-LogBlock "$($MyInvocation.MyCommand)" "start"

    Out-LogBlock "STEP 1 : Call Out-LogBlock with indent level 2." "start" 2
    Out-WarnLog "Warning message inside the function." 3
    Out-LogBlock "STEP 1-A : Call Out-LogBlock with indent level 3." "start" 3
    Out-Log "Out-Log with indent level 4." 4
    Out-LogBlock "STEP 1-A-a : Call Out-LogBlock with indent level 4." "start" 4
    Out-Log "Out-Log with indent level 4." 5
    Out-LogBlock "STEP 1-A-a1 : Call Out-LogBlock with indent level 5." "start" 5
    Out-Log "Out-Log with indent level 4." 6
    Out-LogBlock "STEP 1-A-a1 : Call Out-LogBlock with indent level 5." "end" 5
    Out-LogBlock "STEP 1-A-a : Call Out-LogBlock with indent level 4." "end" 4
    Out-LogBlock "STEP 1-A : Call Out-LogBlock with indent level 3." "end" 3
    Out-LogBlock "STEP 1 : Call Out-LogBlock with indent level 2." "end" 2
    # Out-ErrLog "This is an error log message."

    # Function end log output
    Out-LogBlock "$($MyInvocation.MyCommand)" "end"
}

# Call the function
Invoke-SampleLog

# Additional log output after function call
Out-Log "Additional standard log message after function call." 1

# Script end log output
Out-LogBlock "$($MyInvocation.MyCommand)" "end" 0

Out-ErrLog "Out-ErrLog ends the process so I leave a message here."