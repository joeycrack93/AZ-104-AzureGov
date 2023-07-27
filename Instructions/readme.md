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
#!/bin/bash

# Variables
subscriptionId="<subscription-id>"
trainingSubscriptionName="Training"
studentCount=30
instructorCount=2
studentGroupName="studentGroup"
networkWatcherRG="NetworkWaterRG"

# Set the Azure Government environment
az cloud set --name AzureUSGovernment

# Login to your Azure Government account
# az login

# Set the subscription
az account set --subscription $subscriptionId

# Register all resource providers
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.Network
# Add other providers as needed

# Create Azure AD identities for students and instructors
for ((i=1; i<=$studentCount; i++))
do
  az ad user create --display-name "Student$i" --password "Student$i@123" --user-principal-name "student$i@domain.com" --force-change-password-next-login true
done

for ((i=1; i<=$instructorCount; i++))
do
  az ad user create --display-name "Instructor$i" --password "Instructor$i@123" --user-principal-name "instructor$i@domain.com" --force-change-password-next-login true
done

# Create AAD security group for students
az ad group create --display-name $studentGroupName --mail-nickname $studentGroupName

# Add students to the group
for ((i=1; i<=$studentCount; i++))
do
  az ad group member add --group $studentGroupName --member-id $(az ad user show --id "student$i@domain.com" --query objectId --output tsv)
done

# Create resource groups for students in usgovvirginia region
for ((i=1; i<=$studentCount; i++))
do
  az group create --name "Student${i}RG1" --location "usgovvirginia"
  az group create --name "Student${i}RG2" --location "usgovvirginia"

  # Assign owner role to the student
  az role assignment create --assignee "student$i@domain.com" --role Owner --resource-group "Student${i}RG1"
  az role assignment create --assignee "student$i@domain.com" --role Owner --resource-group "Student${i}RG2"
done

# Assign students AAD security group as "reader" RBAC on NetworkWaterRG
az role assignment create --assignee $studentGroupName --role Reader --resource-group $networkWatcherRG

# Create custom RBAC role and assign to students AAD security group
customRoleId=$(az role definition create --role-definition '{
    "Name": "CustomRole",
    "Description": "Allows running commands on VMs",
    "Actions": [
        "Microsoft.Compute/locations/runCommands/read",
        "Microsoft.Compute/virtualMachines/runCommand/action"
    ],
    "AssignableScopes": ["/subscriptions/'$subscriptionId'"]
}' --query id --output tsv)

az role assignment create --assignee $studentGroupName --role $customRoleId
