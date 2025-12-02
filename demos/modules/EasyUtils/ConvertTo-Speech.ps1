function ConvertTo-Speech
{
  <#
      .SYNOPSIS
      TTS Convert some text to Sound/Speech, like MacOSX say
      .DESCRIPTION
      TTS Convert some text to Sound/Speech, like MacOSX say
      .EXAMPLE
      ConvertTo-Speech 'hi there'
  #>
  [CmdletBinding()]
  [Alias("say")]
  param
  (
    [Parameter(Mandatory=$false, Position=1)]  # optional so position 1
    [System.Int32] $Rate = 1,
    
    [Parameter(Mandatory=$true, Position=0)]
    [System.String] $TextToSpeak
  )
  
  $sapiObject = New-Object -ComObject Sapi.SPVoice
  $sapiObject.Rate = $Rate
  
  $sapiObject.Speak($TextToSpeak)  | Out-Null
}