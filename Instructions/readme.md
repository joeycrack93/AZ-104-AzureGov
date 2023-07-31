# Instructor readme

## Key requirements for lab environment

Lab steps in this repo assume a few steps have already been set up in the Azure Government tenant.

- Standalone "Training" subscription.
- Register all resource providers in "Training" subscription.
- Need at least 1x subscription "owner" present during training.
- Need at least 1x AAD "global admin" present during training.
- Azure AD identities must be created for each student and instructor.
- Need 2x resource groups per student. Each student must solely have "owner" RBAC on their respective resource groups.
- Students must all be members of a single AAD security group. Can be set up as dynamic group [ex: UPN contains "student"] 
- Ensure Network Water is enabled in the "Training" subscription and in the regions you will be hosting labs in.
- Assign students AAD security group as "reader" RBAC on NetworkWaterRG in "Training" subscription.
- Create custom RBAC role on Training subscription and assign to students AAD security group with the following permissions:
   >- Microsoft.Compute/locations/runCommands/read
   >- Microsoft.Compute/virtualMachines/runCommand/action

## AZ CLI script to accomplish requirements:
### Replace `<subscription-id>` with your actual subscription ID. Also, remember to uncomment the `az login` line and login to your Azure Government account when you're ready to run the script.
```bash

#!/bin/bash

# Variables
subscriptionId="your subscription ID here"
# Adjust student & instructor count as necessary.
studentCount=30
instructorCount=2
studentGroupName="az104studentGroup"
# Ensure RG name matches in your environment. Default is NetworkWatcherRG.
networkWatcherRG="NetworkWatcherRG"

# Set the Azure Government environment
az cloud set --name AzureUSGovernment

# Login to your Azure Government account
az login

# Set the subscription
az account set --subscription $subscriptionId

# Register all resource providers
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.Network
# Add other providers as needed

# Create Azure AD identities for students and instructors
for ((i=1; i<=$studentCount; i++))
do
  az ad user create --display-name "az104student$i" --password "SecureP@ssword" --user-principal-name "az104student$i@domain.us" --force-change-password-next-sign-in true
done

for ((i=1; i<=$instructorCount; i++))
do
  az ad user create --display-name "az104instructor$i" --password "SecureP@ssword" --user-principal-name "instructor$i@domain.us" --force-change-password-next-sign-in true
done

# Create AAD security group for students
az ad group create --display-name $studentGroupName --mail-nickname $studentGroupName

# Add students to the group
# If you encounter issues at this point, try manually adding student & instructor users to the group.
for ((i=1; i<=$studentCount; i++))
do
  memberId=$(az ad user show --id "az104student$i@domain.us" --query objectId --output tsv)
  if [ -z "$memberId" ]; then
    echo "Error: Could not find object ID for az104student$i@domain.us"
  else
    az ad group member add --group $studentGroupName --member-id $memberId
  fi
done

# Create resource groups for students in usgovvirginia region
for ((i=1; i<=$studentCount; i++))
do
  az group create --name "az104student${i}RG1" --location "usgovvirginia"
  az group create --name "az104student${i}RG2" --location "usgovvirginia"

  # Assign owner role to the student
  az role assignment create --assignee "az104student$i@domain.us" --role Owner --resource-group "az104student${i}RG1"
  az role assignment create --assignee "az104student$i@domain.us" --role Owner --resource-group "az104student${i}RG2"
done

# Assign students AAD security group as "reader" RBAC on NetworkWaterRG
# might need to change --assignee to --assignee-object-id and manually input obj ID.
az role assignment create --assignee $studentGroupName --role Reader --resource-group $networkWatcherRG

# Create custom RBAC role and assign to students AAD security group
# might need to change --assignee to --assignee-object-id and manually input obj ID.
customRoleId=$(az role definition create --role-definition '{
    "Name": "AZ104runVMcommands",
    "Description": "Allows running commands on VMs",
    "Actions": [
        "Microsoft.Compute/locations/runCommands/read",
        "Microsoft.Compute/virtualMachines/runCommand/action"
    ],
    "AssignableScopes": ["/subscriptions/'$subscriptionId'"]
}' --query id --output tsv)

az role assignment create --assignee $studentGroupName --role $customRoleId
```

