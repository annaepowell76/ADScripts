 [CmdletBinding(
    DefaultParameterSetName="One"
    )]
 #Parameters set for Remove-User

 param(

  [Parameter (
        ParameterSetName="One",
        Mandatory=$False
        , ValueFromPipeline=$False
        )]
        [Parameter (
        ParameterSetName="Two",
        Mandatory=$False
        , ValueFromPipeline=$False
        )]
    [string] $pServer = "10.6.20.48"


    ,[Parameter (
        ParameterSetName="One",
        Mandatory=$True
        , ValueFromPipeline=$True
        )]
    [String[]] $pAccountName

    ,[Parameter (
        ParameterSetName="Two",
        Mandatory=$True
        , ValueFromPipeline=$False
        )]
    [string] $pFilter = ''

    ,[Parameter (
        ParameterSetName="One",
        Mandatory=$False
        , ValueFromPipeline=$False
        )]
        [Parameter (
        ParameterSetName="Two",
        Mandatory=$False
        , ValueFromPipeline=$False
        )]
    [PSCredential] $pCredential = (Get-Credential)

    ,[Parameter (
        ParameterSetName="One",
        Mandatory=$False
        , ValueFromPipeline=$False
        )]
     [Parameter (
        ParameterSetName="Two",
        Mandatory=$False
        , ValueFromPipeline=$False
        )]
    [System.Management.Automation.SwitchParameter] $pConfirm = $True

     
     )#param
      
     #Begin block. This runs once. Verbose keeps track of how script is processed

BEGIN {
Write-Verbose "BEGIN"


} #Begin

#Process can run multiple times. This makes sure that parameters are filled properly and runs Removes-ADUser

PROCESS {

$EXIT_ERROR = 0

$EXIT_NoERROR = 1


    Write-Verbose "PROCESS running."

    switch ($PSCmdlet.ParameterSetName) {

    "One" {


        foreach ($user in $pAccountName) {
             

         try {
        
        Get-ADUser $user -Server $pServer -Credential $pCredential | `Remove-ADUser -Confirm:$pConfirm -ErrorAction Continue
           
          Write-Output $username.samaccountname

          exit $EXIT_ERROR
           
           }#try

          catch {
        
            
               
               Write-Error "Something went wrong check your parameters."
               
               exit $EXIT_NoERROR

            continue
          }#catch


         }#foreach statement
      
      }#One switch

      "Two" {
            
            if($pFilter.CompareTo('*') -eq 0 ) {
                Write-Warning "The filter: '$($pFilter)' could get rid of all users."
                exit $EXIT_ERROR
            }#if statement

      if($pFilter.ToLower().Contains('name -like "*"')) {
                Write-Warning "The filter: '$($pFilter)' could get rid of all users."
                exit $EXIT_ERROR
            }#if statement
           
            
            
            
       try {
           
              Get-ADUser -Filter $pFilter  -Server $pServer -Credential $pCredential | `
              Remove-ADUser -Confirm:$pConfirm -ErrorAction Continue

              Write-Output $username.samaccountname

              exit $EXIT_NoERROR

              }#try

              catch {
              
              Write-Error "Something went wrong check parameters" 

              exit $EXIT_ERROR

              }#catch


         }#Two

    }#Switch   
    
   
    
    
    Write-Verbose "PROCESS finished."

  

} #Process

#End of script
END{

}#End