# first try:  has issue when file already exists, will give error "already exists."

function start-excel($Filename) {
    ni $Filename
    start $Filename
}

# e.g. start-excel actions.csv

## Try 2 - ignore ni (new item) if file already exists
function start-excel($Filename) {
    # use logic to test if $Filename is present
    #
    # -practice-    if (-not (Test-Path actions.csv)) { echo 4; }
    #               ^-- run the following in the powershell terminal to see what it does.

    if (-not (Test-Path $Filename)) { 
        ni $Filename
    }
    start $Filename
}

## Try 3 - ignore ni (new item) error by doing -EA (-ErrorAction) option
#         -EA can be given various flags, one is the silently ignore errors
function start-excel($Filename) {
    ni $Filename  -ErrorAction SilentlyContinue  # ignore file already exists
    start $Filename
}


## Try 4 - use better param() style with attributes for parameters.
function start-excel {
    param(
        [Parameter(Mandatory)]
        [string] $Filename
    )
    ni $Filename  -ErrorAction SilentlyContinue  # ignore file already exists
    start $Filename
}

## Try 5 - Remove the output from "new item/ ni" when we create a file. We show 3 ways.
function start-excel {
    param(
        [Parameter(Mandatory)]
        [string] $Filename
    )
    # -- any of the following will work
    # [void](ni $Filename  -ErrorAction SilentlyContinue)  # ignore file already exists
    # $void = (ni $Filename  -ErrorAction SilentlyContinue)  # ignore file already exists
    (ni $Filename  -ErrorAction SilentlyContinue) | Out-Null  # ignore file already exists

    start $Filename
}
