<#
Function Definitions
Functions in advanced form, are a bit 'verbose' as they inherit the [Attribute] Syntax from C#.
Advanced Powershell functions are as powerful and featured as CmdLets made from C#.
Lets convert one of our DL and DC functions.


# Prototype of an action for ROBOCOPY  "/L" means just show me what you would copy
subst o:  "\Users\$( $env:USERNAME )\OneDrive"
robocopy . O:\c\tmp\tmp\. /E /NP /R:2 /W:2   /L
robocopy . O:\c\tmp\tmp\. /E /NP /R:2 /W:2

Using the above we will build 2 functions, and iterate on adding a param for the directory name as well
#>

# FolderName param to tell what folder to copy to our one drive  |   "dl" means just list  |  "dc" means copy
function dl ( [string]$FolderName ) {
  robocopy "$($FolderName )"  "O:\c\$($FolderName  )" /E /NP /R:2 /W:2   /L
}

function dc ( [string]$FolderName ) {
 robocopy "$($FolderName )"  "O:\c\$($FolderName  )" /E /NP /R:2 /W:2
}

