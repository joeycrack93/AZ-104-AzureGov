# These cli commands are not complete but can be used as a starter/example
az group create --name rg-az104-cap-usgaz-hub -l usgovarizona
az network vnet create -g rg-az104-cap-usgaz-hub -n vnet-az104-cap-usgaz-hub --address-prefix 10.52.0.0/16
az network vnet subnet create --address-prefixes 10.52.0.0/24 --name Subnet-Jumpbox --resource-group rg-az104-cap-usgaz-hub --vnet-name vnet-az104-cap-usgaz-hub
az network vnet subnet create --address-prefixes 10.52.255.0/24 --name AzureBastionSubnet --resource-group rg-az104-cap-usgaz-hub --vnet-name vnet-az104-cap-usgaz-hub

az network nsg create -g rg-az104-cap-usgaz-hub -n NSG-Jumpbox  
az network vnet subnet update --resource-group rg-az104-cap-usgaz-hub --vnet-name vnet-az104-cap-usgaz-hub --name Subnet-Jumpbox --network-security-group NSG-Jumpbox

az group create --name rg-az104-cap-usgaz-storage -l usgovarizona
az storage account create -n az104capusgazdiag --kind StorageV2 -g rg-az104-cap-usgaz-storage -l usgovarizona --sku Standard_LRS  

JUMPBOXSUBNET=$(az network vnet subnet list --resource-group rg-az104-cap-usgaz-hub --vnet-name vnet-prd-usgva-IRIS --query "[?name=='Subnet-IRIS-Jumpbox'].id" --output tsv)

az group create --name rg-az104-cap-usgaz-jumpbox -l usgovarizona
az vm create -n dsvm-jump-01 -g rg-az104-cap-usgaz-jumpbox --subnet $JUMPBOXSUBNET --public-ip-address "" --nsg "" --location usgovarizona --license-type "Windows_Server" --admin-username azureadmin --admin-password "$vm_secrets" --size Standard_D4s_v3 --image "microsoft-dsvm:dsvm-win-2019:winserver-2019:latest" --no-wait

#Build Virginia Region Hub
        
az group create --name rg-az104-cap-usgva-hub -l usgovvirginia
az network vnet create -g rg-az104-cap-usgva-hub -n vnet-az104-cap-usgva-hub --address-prefix 10.50.0.0/16
az network vnet subnet create --address-prefixes 10.50.0.0/24 --name Subnet-Jumpbox --resource-group rg-az104-cap-usgva-hub --vnet-name vnet-az104-cap-usgva-hub
az network vnet subnet create --address-prefixes 10.50.255.0/24 --name AzureBastionSubnet --resource-group rg-az104-cap-usgva-hub --vnet-name vnet-az104-cap-usgva-hub

az network nsg create -g rg-az104-cap-usgva-hub -n NSG-usgva-Jumpbox  
az network vnet subnet update --resource-group rg-az104-cap-usgva-hub --vnet-name vnet-az104-cap-usgva-hub --name Subnet-Jumpbox --network-security-group NSG-usgva-Jumpbox

JUMPBOXSUBNET=$(az network vnet subnet list --resource-group rg-az104-cap-usgaz-hub --vnet-name vnet-prd-usgva-IRIS --query "[?name=='Subnet-IRIS-Jumpbox'].id" --output tsv)

az group create --name rg-az104-cap-usgva-jumpbox -l usgovvirginia
az vm create -n dsvm-jump-01 -g rg-az104-cap-usgva-jumpbox --subnet $JUMPBOXSUBNET --public-ip-address "" --nsg "" --location usgovvirginia --license-type "Windows_Server" --admin-username azureadmin --admin-password "$vm_secrets" --size Standard_D4s_v3 --image "microsoft-dsvm:dsvm-win-2019:winserver-2019:latest" --no-wait

#Build Virginia Region Identity Spoke
        
az group create --name rg-az104-cap-usgva-identity -l usgovvirginia
az network vnet create -g rg-az104-cap-usgva-hub -n vnet-az104-cap-usgva-identity --address-prefix 10.0.0.0/16
az network vnet subnet create --address-prefixes 10.0.0.0/24 --name Subnet-Keycloak --resource-group rg-az104-cap-usgva-identity --vnet-name vnet-az104-cap-usgva-identity
az network vnet subnet create --address-prefixes 10.0.255.0/24 --name Subnet-Kion --resource-group rg-az104-cap-usgva-identity --vnet-name vnet-az104-cap-usgva-identity

az network nsg create -g rg-az104-cap-usgva-identity -n NSG-USGVA-Keycloak  
az network vnet subnet update --resource-group rg-az104-cap-usgva-identity --vnet-name vnet-az104-cap-usgva-identity --name Subnet-Keycloak --network-security-group NSG-USGVA-Keycloak