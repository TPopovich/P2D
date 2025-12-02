echo "We defined a powershell function MySample-Parameterset"

function MySample-Parameterset
{
<#
  .SYNOPSIS
     Short example to show "ParameterSets" that powershell supports, here -cd |vs| -url
     
  .DESCRIPTION
     Detailed, powershell will pick the flags/options based on mysample-parameterset is given a switch
     a user gives a -cd |vs| -url.  As powershell needs some "distinct-ness" to select which ParameterSet to use...

    It Will define SYNTAX:
    _____________________

    mysample-parameterset [-url] [-Jump] <String> [<CommonParameters>]
    ... -JUMP will pick a jump from several FIXED choices

    mysample-parameterset [-cd] -Dir <String> [-Pushd] [<CommonParameters>]
    _____________________

  .EXAMPLE
     First example, uses -url then it will offer the other flags appropriate for -cd ParameterSet
     mysample-parameterset -url ...
  .EXAMPLE
     Second example, uses -cd then it will offer the other flags appropriate for -cd ParameterSet
     mysample-parameterset -cd ...
  #>

  [CmdletBinding(DefaultParameterSetName='ParameterSetURL')]
  param
  (
    # Parameter -url is a lead flag to select ParameterSetURL
      [Parameter(ParameterSetName='ParameterSetURL', Mandatory=$false)]
      [switch] $url,
    
    # Parameter -url will use -Jump to pick a jump from several FIXED choices
      [Parameter(ParameterSetName='ParameterSetURL', Position=0, Mandatory=$true)]
      [ValidateSet('accountability','benefits')]
      [string] $Jump,
  
    # Parameter description
      [Parameter(ParameterSetName='ParameterSetPushdDir', Mandatory=$false)]
      [switch]
      $cd,
  
    # Parameter -Dir [in ParameterSetPushdDir] selects a pick-list set of directories
      [Parameter(ParameterSetName='ParameterSetPushdDir', Mandatory=$true)]
      [ValidateSet('one_drive','home','project_1')]
      [string] $Dir,
  
    # Parameter -Pushd, if specified means we need to "pushd" and not "cd" to the directory
      [Parameter(ParameterSetName='ParameterSetPushdDir', Mandatory=$false)]
      [switch] $Pushd
  )

  # This is to map the pick-list Parameter value to some sample folder
  # also note how we use env variables in double quote strings, and assume
  # you userid is "fred" there are env variables on windows of:
  # USERNAME                       fred                                                                                
  # USERPROFILE                    C:\Users\fred
  $DIRS = @{
    'one_drive' = "$( $env:USERPROFILE  )\onedrive"
    'home' = "$( $env:USERPROFILE  )"
    'project_1' = "/tmp/project_1"
  }

  # This following sample code gets executed when the function is called with -cd or -url
  # and we simply use parameters to cd/pushd to sample folders and for -url do nothing special
  $chosenParameterSet = $PSCmdlet.ParameterSetName
  switch($chosenParameterSet)
  {
    'ParameterSetURL'    {
                echo 'User has chosen ParameterSetURL' 
                
              } 
    'ParameterSetPushdDir'    { 
                echo 'User has chosen ParameterSetPushdDir, has optional switch -Pushd'
                
                [string]$the_dir = $DIRS[$Dir]

                echo "... going to dir: $the_dir"
                if ($Pushd) {
                  pushd $the_dir  ## user wants to "pushd" rather than just "cd"
                } else {
                  cd $the_dir
                }
           } 
  }



}
