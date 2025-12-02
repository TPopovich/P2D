robocopy . O:\c\tmp\tmp\. /E /NP /R:2 /W:2 /L
robocopy . O:\c\tmp\tmp\. /E /NP /R:2 /W:2 


<#
function dl ( [string]$FolderName ) {
  robocopy “$( $FolderName )”  “O:\c\$( $FolderName  )” /E /NP /R:2 /W:2   /L
}

function dc ( [string]$FolderName ) {
 robocopy “$( $FolderName )”  “O:\c\$( $FolderName  )” /E /NP /R:2 /W:2
}
#>
