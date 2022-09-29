<#-----------------------------------------------------------------------------
  Functions to perform mostly repeated tasks with Azure PowerShell

  Author: Vincent Zhang
  Date  : 3/Mar/2022

 -----------------------------------------------------------------------------#>

#region Subscription Management

<#---------------------------------------------------------------------------#>
<# Switch-<sub-name>                                             #>
<#---------------------------------------------------------------------------#>
function Switch-<cus-sub-name> {
<#
  .SYNOPSIS
  Switch to subscription <sub-name>

  .DESCRIPTION
  Switch to subscription <sub-name>.

  .INPUTS
  N/A

  .OUTPUTS
  N/A

  .EXAMPLE
  Switch-<cus-sub-name>

  .NOTES

  .LINK
  http://
#>
    [CmdletBinding()]
    param ()

    Get-AzContext -Name '<sub-name> (<sub-id>) - <account-id> - <account-email>' | Select-AzContext
}

function Switch-<cus-sub-name> {
    [CmdletBinding()]
    param ()

    Get-AzContext -Name '<sub-name> (<sub-id>) - <account-id> - <account-email>' | Select-AzContext
}

function Switch-<cus-sub-name> {
    [CmdletBinding()]
    param ()

    Get-AzContext -Name '<sub-name> (<sub-id>) - <account-id> - <account-email>' | Select-AzContext
}
#endregion Subscription Management




#region Key Vault Management
<#---------------------------------------------------------------------------#>
<# Grant-VzAllPermissionsOnKeyVault                                          #>
<#---------------------------------------------------------------------------#>
function Grant-VzAllPermissionsOnKeyVault {
<#
  .SYNOPSIS
  Grant all the permissions on KV to Vincent

  .DESCRIPTION
  Grant all the permissions on KV to Vincent.

  .PARAMETER VaultName
  The name of the KV resource, it needs to be in the current Subscription.

  .INPUTS
  System.String

  .OUTPUTS
  N/A

  .EXAMPLE
  Grant-VzAllPermissionsOnKeyVault -VaultName '<kv-name>'
  Grant-VzAllPermissionsOnKeyVault -VaultName '<kv-name>'
  Grant-VzAllPermissionsOnKeyVault -VaultName '<kv-name>'
  Grant-VzAllPermissionsOnKeyVault -VaultName '<kv-name>'

  .NOTES

  .LINK
  http://
#>
    [CmdletBinding()]
    param (
        [Parameter( Mandatory=$true, HelpMessage='The name of the KV resource, it needs to be in the current Subscription.')]
        [string]$VaultName
        )
    Set-AzKeyVaultAccessPolicy `
    -VaultName $VaultName `
    -UserPrincipalName '<account-email>' `
    -PermissionsToSecrets all `
    -PassThru
}

<#---------------------------------------------------------------------------#>
<# Get-KeyVaultSecretsAsPlainText                                            #>
<#---------------------------------------------------------------------------#>
function Get-KeyVaultSecretsAsPlainText {
    <#
      .SYNOPSIS
      Grant all the permissions on KV to Vincent

      .DESCRIPTION
      Grant all the permissions on KV to Vincent.

      .PARAMETER VaultName
      The name of the KV resource, it needs to be in the current Subscription.

      .INPUTS
      System.String

      .OUTPUTS
      N/A

      .EXAMPLE
      Get-KeyVaultSecretsAsPlainText -VaultName '<kv-name>'
      Get-KeyVaultSecretsAsPlainText -VaultName '<kv-name>'
      Get-KeyVaultSecretsAsPlainText -VaultName '<kv-name>'
      Get-KeyVaultSecretsAsPlainText -VaultName '<kv-name>'

      .NOTES

      .LINK
      http://
    #>
    [CmdletBinding()]
    param (
        [Parameter( Mandatory=$true, HelpMessage='The name of the KV resource, it needs to be in the current Subscription.')]
        [string]$VaultName
        )
    Get-AzKeyVaultSecret -VaultName $VaultName | ForEach-Object {
        $secretText = Get-AzKeyVaultSecret -VaultName $_.VaultName -Name $_.Name -AsPlainText
        Write-Host (-join($_.Name, ": ", $secretText))
    }
}
#endregion Key Vault Management




#region SQL Server Management
<#---------------------------------------------------------------------------#>
<# Add-VzAddressToServerIpFirewallRules                                      #>
<#---------------------------------------------------------------------------#>
function Add-VzAddressToServerIpFirewallRules {
    <#
      .SYNOPSIS
      Add Vincent's IP address to the SQL Server's IP firewall rules

      .DESCRIPTION
      Add Vincent's IP address to the SQL Server's IP firewall rules.

      .PARAMETER ResourceGroupName
      The name of the resource group containing the SQL Server.

      .PARAMETER ServerName
      The name of the SQL Server.

      .PARAMETER StartIpAddress
      The start address of the IP range.

      .PARAMETER EndIpAddress
      The end address of the IP range.

      .INPUTS
      System.String

      .OUTPUTS
      N/A

      .EXAMPLE
      Add-VzAddressToServerIpFirewallRules `
        -ResourceGroupName "" `
        -ServerName "" `
        -StartIpAddress "" `
        -EndIpAddress ""

      .NOTES

      .LINK
      http://
    #>
    [CmdletBinding()]
    param (
        [Parameter( Mandatory=$true, HelpMessage='The name of the resource group containing the SQL Server.')]
        [string]$ResourceGroupName
      , [Parameter( Mandatory=$true, HelpMessage='The name of the SQL Server.')]
        [string]$ServerName
      , [Parameter( Mandatory=$true, HelpMessage='The start address of the IP range.')]
        [string]$StartIpAddress
      , [Parameter( Mandatory=$true, HelpMessage='The end address of the IP range.')]
        [string]$EndIpAddress
        )
    New-AzSqlServerFirewallRule `
    -ResourceGroupName $ResourceGroupName `
    -ServerName $ServerName `
    -FirewallRuleName "TempRuleForDevTroubleshooting" `
    -StartIpAddress $StartIpAddress `
    -EndIpAddress $EndIpAddress
 # -FirewallRuleName cannot exceed 80 chars
}
#endregion SQL Server Management



