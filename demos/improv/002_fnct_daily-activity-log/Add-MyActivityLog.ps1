# Add-MyActivityLog.ps1  --  develop a tool to append to a .csv file our activities for apprasial, status, etc

# Step 1 - stub out the function and validate logic of if the optional arguments is given
function Add-MyActivityLog($FilenameCsv) {
    <# Add-MyActivityLog will add activity to a log file, csv assumed,
       Optional -FilenameCsv is the file to append to. If not present assume ~/Documents/activity.csv
    #>

    # use logic to test if $FilenameCsv was given
    #
    # -practice-    if (-not (Test-Path actions.csv)) { echo 4; }
    #               ^-- run the following in the powershell terminal to see what it does.
    
    if (-not (Test-Path $FilenameCsv)) {
        echo "NOTE: creating a new file $FilenameCsv to hold the log...";
        ni $FilenameCsv
    }

    ## rest of logic to be continued.... lets test this first with a present/missing filename.

}

## Step 2 - add in data for date

#  Get-Date -Format "MM/dd/yyyy"
#   ^-  that is the proper date format we want


## Step 3 - figure out a PSCustomObject to hold a record for data

#  We want formated data and need a "bucket to hold key/value pairs
#  and such a object exists in powershell called pscustomobject,
#  this is similar to a struct/class in other langs.

# $data = [pscustomobject]@{
#  Date = $(Get-Date -Format "MM/dd/yyyy");
#  Group = 'SysAdmin';
#  Activity = "Created 2 new users"; }

# ^-- test out the above and look at how it prints.
#     NOTICE how powershell nicely plays with pscustomobject streams to make a "report"
<#

PS C:\>  $data = [pscustomobject]@{Date = $(Get-Date -Format "MM/dd/yyyy");  Group = 'SysAdmin' ; Activity = "Created 2 new users"; }

PS C:\>  @( $data, $data, $data)

Date       Group    Activity
----       -----    --------
04/07/2026 SysAdmin Created 2 new users
04/07/2026 SysAdmin Created 2 new users
04/07/2026 SysAdmin Created 2 new users

PS C:\>  $data | Export-Csv -Path "C:\Users\$( $env:USERNAME )\Documents\activity.csv" -Append
PS C:\>  type "C:\Users\$( $env:USERNAME )\Documents\activity.csv"
"Date","Group","Activity"
"04/07/2026","SysAdmin","Created 2 new users"
#>

# Try the shorthand as well : PS C:\>  type "~\Documents\activity.csv"


## Step 4 - lets bundle what we have, including fake data, into the function,
##          but also introduce a "default value of the .csv file to simplify"

function Add-MyActivityLog {
    <# Add-MyActivityLog will add activity to a log file, csv assumed,
       Optional -FilenameCsv is the file to append to. If not present assume ~/Documents/activity.csv
    #>

    param(
        [Parameter()]
        [string]$FilenameCsv = "~/Documents/activity.csv"
        )

    # use logic to test if $FilenameCsv was given
    #
    # -practice-    if (-not (Test-Path actions.csv)) { echo 4; }
    #               ^-- run the following in the powershell terminal to see what it does.
    
    if (-not (Test-Path $FilenameCsv)) {
        echo "NOTE: creating a new file $FilenameCsv to hold the log...";
        ni $FilenameCsv
    }

    $data = [pscustomobject]@{
    Date = $(Get-Date -Format "MM/dd/yyyy");
    Group = 'SysAdmin';
    Activity = "Created 2 new users"; }

    ## rest of logic to be continued later to prompt....
    ## lets test this first with a present/missing filename.
    ## for now just print out the record we created in the csv file...

    $data | Export-Csv -Path $FilenameCsv -Append

    echo "__ current CSV file __"
    type $FilenameCsv
}

## Step 5 - play with Read-Host to look at how to prompt users, later we will also
##          look at maybe making a mandatory parameter so pwrsh will prompt automatically

#   Read-Host -Prompt "Enter Group, e.g. SysAdmin"


## Step 6 - lets bundle what we have learned with READ-HOST into our soln

function Add-MyActivityLog {
    <# Add-MyActivityLog will add activity to a log file, csv assumed,
       Optional -FilenameCsv is the file to append to. If not present assume ~/Documents/activity.csv
    #>

    param(
        [Parameter()]
        [string]$FilenameCsv = "~/Documents/activity.csv"
        )

    # use logic to test if $FilenameCsv was given
    #
    # -practice-    if (-not (Test-Path actions.csv)) { echo 4; }
    #               ^-- run the following in the powershell terminal to see what it does.
    
    if (-not (Test-Path $FilenameCsv)) {
        echo "NOTE: creating a new file $FilenameCsv to hold the log...";
        ni $FilenameCsv
    }

    $data = [pscustomobject]@{
    Date = $(Get-Date -Format "MM/dd/yyyy");
    Group = "$(  Read-Host -Prompt "Enter Group, e.g. SysAdmin"  )";
    Activity = "$(  Read-Host -Prompt "Enter Activity, e.g. Added 2 users"  )"; }
    #         NOTE:                   ^-- pwsh is weird in that inner double quotes does not mess up

    ## Append record, and also print out the record we created in the csv file...
    ## next version will have a "flag" to do the print as that might not be wanted always.

    $data | Export-Csv -Path $FilenameCsv -Append

    echo "__ current CSV file __"
    type $FilenameCsv
}



## Step 7 - add OPTIONAL flag to print the csv after we add a line, default = false

function Add-MyActivityLog {
    <# Add-MyActivityLog will add activity to a log file, csv assumed,
       Optional -FilenameCsv is the file to append to. If not present assume ~/Documents/activity.csv
    #>

    param(
        [Parameter()]
        [string]$FilenameCsv = "~/Documents/activity.csv",
        [switch]$PrintResultingCsv
        )

    # use logic to test if $FilenameCsv was given
    #
    # -practice-    if (-not (Test-Path actions.csv)) { echo 4; }
    #               ^-- run the following in the powershell terminal to see what it does.
    
    if (-not (Test-Path $FilenameCsv)) {
        echo "NOTE: creating a new file $FilenameCsv to hold the log...";
        ni $FilenameCsv
    }

    $data = [pscustomobject]@{
    Date = $(Get-Date -Format "MM/dd/yyyy");
    Group = "$(  Read-Host -Prompt "Enter Group, e.g. SysAdmin"  )";
    Activity = "$(  Read-Host -Prompt "Enter Activity, e.g. Added 2 users"  )"; }
    #         NOTE:                   ^-- pwsh is weird in that inner double quotes does not mess up

    ## Append record to the csv file.
    
    $data | Export-Csv -Path $FilenameCsv -Append
    
    ## The final version has a "flag" to do the print as that might not be wanted always.
    if ($PrintResultingCsv) {
        echo "__ current CSV file __"
        type $FilenameCsv
    }
}


## Step 8 - make the arguments we prompt for be mandatory and have pwsh prompt for it.

function Add-MyActivityLog {
    <# Add-MyActivityLog will add activity to a log file, csv assumed,
       Optional -FilenameCsv is the file to append to. If not present assume ~/Documents/activity.csv
    #>

    param(
        [Parameter()]
        [string]$FilenameCsv = "~/Documents/activity.csv",
        [switch]$PrintResultingCsv,

        [Parameter(Mandatory)]
        [string]$Group = "$(  Read-Host -Prompt "Enter Group, e.g. SysAdmin"  )",
        [Parameter(Mandatory)]
        [string]$Activity = "$(  Read-Host -Prompt "Enter Activity, e.g. Added 2 users"  )"

        )

    # use logic to test if $FilenameCsv was given
    #
    # -practice-    if (-not (Test-Path actions.csv)) { echo 4; }
    #               ^-- run the following in the powershell terminal to see what it does.
    
    if (-not (Test-Path $FilenameCsv)) {
        echo "NOTE: creating a new file $FilenameCsv to hold the log...";
        ni $FilenameCsv
    }

    $data = [pscustomobject]@{
      Date = $(Get-Date -Format "MM/dd/yyyy");
      Group = "$( $Group.Trim() )";
      Activity = "$( $Activity.Trim() )";
    }

    ## Append record to the csv file.
    
    $data | Export-Csv -Path $FilenameCsv -Append
    
    ## The final version has a "flag" to do the print as that might not be wanted always.
    if ($PrintResultingCsv) {
        echo "__ current CSV file __"
        type $FilenameCsv
    }
}
