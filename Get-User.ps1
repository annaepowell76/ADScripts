 [CmdletBinding()]

 #Parameters set for Get-ADUser

param( 

    [Parameter (
        Mandatory=$False,
        ValueFromPipeline=$False
        )]
          [string] $pServer

     ,[Parameter (
        Mandatory=$True,
        ValueFromPipeline=$False
        )]
          [PSCredential] $pCredential

             ,[Parameter (
        Mandatory=$False,
        ValueFromPipeline=$False
        )]
          [string] $pFilter
         
         
   
) #param 


#Begin block. This runs once. Verbose keeps track of how script is processed

BEGIN {
Write-Verbose "BEGIN"



} #Begin

#Process can run multiple times. This makes sure that parameters are filled properly and runs Get-ADUser

PROCESS{

Write-Verbose "PROCESS"

 if(!($pFilter))
 {
    $pFilter = '*'
 }

 if(!($pServer))
 {
    $pServer = "10.6.20.48"
 }

 if(!($pCredential))
 {
    $pCredential = Get-Credential
 }

Write-Verbose $pFilter


Get-AdUser -Filter $pFilter -Server $pServer -Credential $pCredential



$pExitValue =0 

exit $pExitValue


} #Process

#End block. Script is finished.

END{
Write-Verbose "End!!"
} #End