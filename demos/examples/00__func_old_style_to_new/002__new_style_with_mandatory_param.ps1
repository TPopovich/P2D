
function dl_01
{
  <#
      .SYNOPSIS
      dl_01  does not have a POSITION so it will need a user to use -FolderName flag
      .DESCRIPTION
      dl_01  does not have a POSITION so it will need a user to use -FolderName flag
      .EXAMPLE
      First example will prompt user on terminal as it is Mandatory
      dl_01
      .EXAMPLE
      Second example, will use -FolderName
      dl_01 -FolderName  foo
  #>

  [CmdletBinding()]
  param
  (
    # Parameter description
    [Parameter(Mandatory=$true)]
    [string] $FolderName
  )

  robocopy "$($FolderName )"  "O:\c\$($FolderName  )" /E /NP /R:2 /W:2   /L
}

function dl_02
{
  <#
      .SYNOPSIS
      dl_02  has a POSITION so it will NOT need a user to use -FolderName flag
      .DESCRIPTION
      dl_02  has a POSITION so it will NOT need a user to use -FolderName flag
      .EXAMPLE
      First example will prompt user on terminal as it is Mandatory
      dl_02
      .EXAMPLE
      Second example, will dont need to use -FolderName flag but can simply type the foldername
      dl_02 foo
  #>

  [CmdletBinding()]
  [Alias("dl2")]
  param
  (
    # Parameter description
    [Parameter(Position=0, Mandatory=$true)]
    [string] $FolderName
  )

  robocopy "$($FolderName )"  "O:\c\$($FolderName  )" /E /NP /R:2 /W:2   /L
}
