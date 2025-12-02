function RabbitUrl
 {
    <#
      .SYNOPSIS
      Rabbit jump to a url, which will be given in a pick list.
      .DESCRIPTION
      Rabbit jump to a url, which will be given in a pick list.
      .EXAMPLE
      RabbitUrl  google_videos
      # Note powershell will offer completion via TAB and Cntrl-Space
  #>
    [Alias("ru")]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet( "citrix", "sharepoint_home", "google_videos")]
        [string]$UrlValue
    )

    # Simple sample function logic here, just give the user the UrlValue they gave first.
    Write-Output "Launching browser..."
    Write-Output "Site: $UrlValue"

    # Next look at some "urls" we want quick access to...
    
    $URL_citrix = 'https://citrix.acme.com/logon/LogonPoint/index.html'
    $URL_sharepoint_home = 'https://sample-my.sharepoint.us'
    $URL_google_videos = "https://www.google.com/videohp"

    switch ($UrlValue) {
      # For citrix it is best to use Firefox, this is how to do it:
      "citrix" { & "C:\Program Files\Mozilla Firefox\firefox.exe" "$( $URL_citrix )"; }

      # These will use the default browser
      "sharepoint_home"         { start $URL_sharepoint_home; }
      "google_videos"           { start $URL_google_videos; }

    }
}
