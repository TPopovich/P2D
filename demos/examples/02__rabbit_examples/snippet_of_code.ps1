# In powershell

[bool]$UseSimplePrompt = $false # set to $true to use  c:\ prompt?
if ($UseSimplePrompt) {
  function prompt () {
   return "C:\ "
  } 

  # here is a more "fancy" prompt that also chops the length to at most 30 chars
  function prompt () {
   $current_PWD = $PWD
   
   [string] $the_prompt = "PS $($current_PWD.path) > "
   if ($the_prompt -gt 30) {
     $the_prompt = $the_prompt.Substring($the_prompt.Length - 30)
   }
   return $the_prompt
   }

}  

# Call "dos" version of "dir" as that is way easier than the equal powershell to get a date
# sort and select the newest 30...
function lth {
 cmd /C "dir /OD" | select -Last 10
}


 
 function get-newestfilenamethatmatchesFilterpattern ([string]$Filter) {
  # e.g. (Get-ChildItem -Filter '*.docx' | Sort-Object LastWriteTime -Descending | Select-Object -First 1).Name
  return (Get-ChildItem -Filter "$( $Filter )" | Sort-Object LastWriteTime -Descending | Select-Object -First 1).Name
 }

 # The above function is very long!  This will set "lthf" to be a shortcut
 Set-Alias lthf  get-newestfilenamethatmatchesFilterpattern 
 
 function nd4 {
       [string]$nm="$(get-newestfilenamethatmatchesFilterpattern 'lun*mp4')";
       $c = ($idx + 1)
       $lead = "{0:D3}" -f $c;
       # NOTE: this also works, and uses the Object Oriented String object function/methods:
       # $lead = "$( $c )".PadLeft(3, "0")
       [string]$canonical_new_filename = "$($lead)_$($nm)"
       
       ## ECHO HERE IS JUST PRINT and not do the move
       echo mv "$nm" "b:$($canonical_new_filename)" | Out-Null
       return $canonical_new_filename
  }

  function ndp ([string]$Filename_OF_MP4_file) {
       [string]$nm="$(get-newestfilenamethatmatchesFilterpattern 'lun*docx')";
       $fn = "$($Filename_OF_MP4_file)"
       $fn = $fn.Replace("mp4", "docx")
       echo mv "$nm" "b:$($fn)";     ## ECHO HERE IS JUST PRINT and not do the move
  }


<#  

PS H:\Downloads > $fn_mp4_canonical = $(nd4)

PS H:\Downloads > ndp $fn_mp4_canonical

mv
Lunch On Linux - Intro to Linux-ClassA.docx
b:001_001_Lunch On Linux - Intro to Linux-ClassA-20250506_111020-Meeting Recording.docx

PS H:\Downloads > 


logic


  # process the next file rename and move to b: drive
  $idx = $idx +1
  $fn_mp4_canonical = $(nd4)
  ndp $fn_mp4_canonical

#>

function doit () {
  $global:idx = $global:idx +1
  $fn_mp4_canonical = $(nd4)
  ndp $fn_mp4_canonical
  }





 $FILENAME_FNAMES_OF_MP4 = 'O:\c\tmp\csv__filename_of_mp4_files.csv'

# this csv looks like:
# filename
# Lunch On Linux - Intro to Linux-ClassA-20250506_111020-Meeting Recording.mp4
# 
 $csv_mp4_filenames = Import-Csv $FILENAME_FNAMES_OF_MP4


  function append-toOurCSVObjectNewMp4Filename ([string]$filename_mp4) {

    $newEntry = [PSCustomObject]@{
     filename = $filename_mp4
    }

    # Append the new object to the CSV data
    $csv_mp4_filenames += $newEntry
  }
