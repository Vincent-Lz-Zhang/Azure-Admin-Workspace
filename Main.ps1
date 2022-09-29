# Run a script to load handy functions
. .\modules\AzureManagementFunctions.ps1

# Log into Azure
Connect-AzAccount

# By default, the current subscription is <cus-sub-name>
# Switch to the subscription we need to work with
Switch-<cus-sub-name>
#Switch-<cus-sub-name>
#Switch-<cus-sub-name>

Grant-VzAllPermissionsOnKeyVault -VaultName '<kv-name>'
#Grant-VzAllPermissionsOnKeyVault -VaultName '<kv-name>'

Get-KeyVaultSecretsAsPlainText -VaultName '<kv-name>'

Add-VzAddressToServerIpFirewallRules `
        -ResourceGroupName "<resGroup-name>" `
        -ServerName "<AzSql-name>" `
        -StartIpAddress "122.58.118.0" `
        -EndIpAddress "122.58.118.255"

Get-AzFunctionAppSetting `
        -Name "<AzFunc-name>" `
        -ResourceGroupName "<resGroup-name>"

# not working in DevOps pipeline, use Azure CLI equvalent
#az functionapp config appsettings list --name "<AzFunc-name>" --resource-group "<resGroup-name>"

Import-AzAksCredential `
        -ResourceGroupName "<resGroup-name>" `
        -Name "<Az-K8s-clst-name>"


# Kubernetes commands
kubectl config set-context --current --namespace=<namespace-name>

kubectl get pods -n <namespace-name>

#kubectl get pods --selector app.kubernetes.io/name=standard-cronjob
kubectl get pods -l app.kubernetes.io/name=standard-cronjob

kubectl get pods -o wide

kubectl describe pods <pod-name>

kubectl logs <pod-name>
kubectl logs --tail=20 <pod-name>

kubectl logs --tail=5 --follow <pod-name>

kubectl get pod <pod-name>6 -o json        #https://kubernetes.io/docs/reference/kubectl/cheatsheet/

kubectl get pod <pod-name> -o=jsonpath='{.metadata.labels}'

kubectl get pods -o=jsonpath='{.items[0].metadata.labels}'

kubectl get pods --field-selector=metadata.name=<pod-name> -o=jsonpath='{.items[0].metadata.labels}'

#kubectl get pods | grep ^jk8xj6
#grep: The term 'grep' is not recognized as a name of a cmdlet, function, script file, or executable program.
#Check the spelling of the name, or if a path was included, verify that the path is correct and try again.