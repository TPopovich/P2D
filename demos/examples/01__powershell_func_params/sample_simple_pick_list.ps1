echo "We defined a powershell function Get-EmpPickList"

function Get-EmpPickList
{
<#
  .SYNOPSIS
     Get-EmpPickList in a Short description shows "PickList" being mandatory, flat -ID being optional
  .DESCRIPTION
     Detailed: goal is to define this syntax:
    _____________________
     Get-EmpPickList  [[-ID] <int>] -Position <'PM','Manager','Software','QA'>]
    _____________________


     Get-EmpPickList in short description shows a sample "PickList" being mandatory,
     and has another optional argument called -ID
     
     
  .EXAMPLE
     First example w/o options will prompt for the mandatory ones:
     Get-EmpPickList

     PS C:\> Get-EmpPickList 
	cmdlet Get-EmpPickList at command pipeline position 1
	Supply values for the following parameters:
	Position: QA

    As seen, above, powershell prompted for only the "-Position" flag
    since that param was Mandatory.

  .EXAMPLE
     Second example gives -Position as a lead flag and when run we get a pick-list
     Get-EmpPickList -Position (control space here shows all pick list)
  #>

  [CmdletBinding()]
  param
  (
    # Parameter -ID is OPTIONAL gives employee id , if known
    # NOTE this is a whole-number integer type like 101
    [Parameter(Position=0, Mandatory=$false)]
    [int] $ID,

    # Parameter -Position in selects a pick-list set of job titles
    # and we validate that the user enters just values in the pick-list
    [Parameter(Mandatory=$true)]
    [ValidateSet('PM','Manager','Software','QA')]
    [string] $Position
  )


  # TODO: you can place the real custom function code here to run,
  #       we just echo back the value of -Position that was selected.

  echo $Position


}
