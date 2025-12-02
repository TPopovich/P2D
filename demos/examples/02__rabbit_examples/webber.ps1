

function webber($csvPath = "h:\tjp\LoL-a-classes.csv") {
    <# webber is used to go to each url given in a CSV file,
       that are Teams Recordings.
       
       $csvPath: the path to the CSV file
    #>

    # Import the CSV file
    $csvData = Import-Csv -Path $csvPath -Header Date, URL

    # Loop through each row in the CSV
    foreach ($row in $csvData) {
        # Prompt the user to continue
        echo $row.url
        $userInput = Read-Host "Ok to continue? (Press Enter to continue or type 'exit' to quit 's' to skip)"
        
        # Check if the user wants to exit
        if ($userInput -eq 'exit') {
            Write-Host "Exiting the script."
            break
        }
        if ($userInput -eq 's') {
            continue
        }
        
        # Launch the URL in Microsoft Edge
        Start-Process "msedge.exe" -ArgumentList $row.URL
    }
}