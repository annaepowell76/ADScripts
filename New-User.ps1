 [CmdletBinding()]

 #Parameters set for New-ADUser

param( 


            [Parameter (
        Mandatory=$False,
        ValueFromPipeline=$False
        )]
          [string] $pPrefix = "HW10_"

            ,[Parameter (
        Mandatory=$False,
        ValueFromPipeline=$False
        )]
          [string] $pPath = "OU=HW10OU_PoweAn,OU=CIS620_2018_1,DC=CIS620,DC=TurkDom,DC=Net”

            ,[Parameter (
        Mandatory=$False,
        ValueFromPipeline=$False
        )]
          [string] $pServer = "10.6.20.48"


     ,[Parameter (
        Mandatory=$True,
        ValueFromPipeline=$False
        )]
          [PSCredential] $pCredential

        ,[Parameter (
        Mandatory=$True,
        ValueFromPipeline=$False
        )]
           [System.Security.SecureString] $pPassword= (Read-Host -Prompt "Password: " -AsSecureString)

 ,[Parameter (
        Mandatory=$True
        , ValueFromPipeline=$True
        )]
    [string[]] $pFullName
         
         
   
) #param 


#Begin block. This runs once. Verbose keeps track of how script is processed

BEGIN {
Write-Verbose "BEGIN"



} #Begin

#Process can run multiple times. This makes sure that parameters are filled properly and runs New-ADUser

PROCESS{
Write-Verbose "PROCESS"



try {

foreach ($name in $pFullName) {
$pExitValue = 0 
 #Get the name seperated out and make account and sam account name
 $nameParts =$name.split(" ");

    $firstName=$nameParts[0];
    $lastName=$nameParts[$nameParts.Length-1];
     $accountname = $nameParts[$nameParts.Length-1].substring(0,4)+$nameParts[0].substring(0,2);

   
        $samAccountName = $pPrefix + $accountname


New-ADUser -Path $pPath -Server $pServer -Credential $pCredential -Enable:$True -AccountPassword $pPassword -PasswordNeverExpires:$False `
-ChangePasswordAtLogon:$True -Name $name -DisplayName $samAccontName -GivenName $firstName -Surname $lastName -SamAccountName $samAccountName
     
    Write-Output $samAccountName          
   
   
   
   exit $pExitValue       

  }# for each

} #try 

catch {

Write-Error "Something went wrong, please check your inputs"

$pExitValue = 1

exit $pExitValue

}







} #Process

#End block. Script is finished.

END{
Write-Verbose "End!!"
} #End