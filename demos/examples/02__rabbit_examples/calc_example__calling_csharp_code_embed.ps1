# Define the C# source code for the custom class, to Add/Subtract to show how to call
# C# from powershell
$Source = @'
public class Calculator
{
    public static int Add(int a, int b)
    {
        return a + b;
    }

    public static int Subtract(int a, int b)
    {
        return a - b;
    }
}
'@

# Add the custom type to the current PowerShell session
Add-Type -TypeDefinition $Source

# Call the static 'Add' method (static method is like a standaone function) of the Calculator class
$sum = [Calculator]::Add(10, 5)
Write-Host "The sum is: $sum"

# Call the static 'Subtract' method (static method is like a standaone function) of the Calculator class
$difference = [Calculator]::Subtract(20, 7)
Write-Host "The difference is: $difference"