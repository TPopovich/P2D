function Rabbit {
      param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Type,

        [Parameter(Mandatory=$true, Position=1)]
        [string]$Value
    
  )
}

function Rabbit {
<#
 Rabbit jump to a directory  or  jump to a url

 Example usage:
   Rabbit DIR DIR_onedrive
   Rabbit URL URL_accountability
#>
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet("DIR", "URL")]
        [string]$Type,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateSet("DIR_onedrive", "DIR_work", "URL_citrix", "URL_sharepoint_home", "URL_google_videos", "URL_azure_sp_trn")]
        [string]$Value
    )

    # Your function logic here
    Write-Output "Type: $Type"
    Write-Output "Value: $Value"

    
    $URL_citrix = 'https://citrix.acme.com/logon/LogonPoint/index.html'
    $URL_sharepoint_home = 'https://sample-my.sharepoint.us'
    $URL_google_videos = "https://www.google.com/videohp"

    switch ($Value) {
      # For citrix it is best to use Firefox, this is how to do it:
      "URL_citrix" { & "C:\Program Files\Mozilla Firefox\firefox.exe" "$( $URL_citrix )"; }
      "URL_sharepoint_home"         { start $URL_sharepoint_home; }
      "URL_google_videos"           { start $URL_google_videos; }

    }
}


function RabbitUrl {
<#
 Rabbit jump to a url, which will be given in a pick list.
 
 Example usage:
   RabbitUrl  google_videos
#>
    [Alias("ru")]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet( "citrix", "sharepoint_home", "google_videos")]
        [string]$Value
    )

    # Your function logic here
    Write-Output "Launching browser..."
    Write-Output "Site: $Value"

    
    $URL_citrix = 'https://citrix.acme.com/logon/LogonPoint/index.html'
    $URL_sharepoint_home = 'https://sample-my.sharepoint.us'
    $URL_google_videos = "https://www.google.com/videohp"

    switch ($Value) {
      # For citrix it is best to use Firefox, this is how to do it:
      "citrix" { & "C:\Program Files\Mozilla Firefox\firefox.exe" "$( $URL_citrix )"; }
      "sharepoint_home"         { start $URL_sharepoint_home; }
      "google_videos"           { start $URL_google_videos; }

    }
}




