# Notes:  '$PSScriptRoot' below will point to the "folder that has this code".

# Load any global variables in the "init" file
. $PSScriptRoot\init.ps1


# NEXT, We LOAD ALL function definitions:

. $PSScriptRoot\ConvertTo-Speech.ps1
. $PSScriptRoot\RabbitUrl.ps1
