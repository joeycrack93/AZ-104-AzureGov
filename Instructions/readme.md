# Instructor readme

## Key requirements for lab environment

Lab steps in this repo assume a few steps have already been set up in the Azure Government tenant.

[]Standalone "Training" subscription.
[]Register all resource providers in "Training" subscription.
- [] Need at least 1x subscription "owner" present during training.
- [] Need at least 1x AAD "global admin" present during training.
- []Azure AD identities must be created for each student and instructor.
- []Need 2x resource groups per student. Each student must solely have "owner" RBAC on their respective resource groups.
- Students must all be members of a single AAD security group. Can be set up as dynamic group [ex: UPN contains "student"] 
- Ensure Network Water is enabled in the "Training" subscription and in the regions you will be hosting labs in.
- Assign students AAD security group as "reader" RBAC on NetworkWaterRG in "Training" subscription.
- Create custom RBAC role on Training subscription and assign to students AAD security group with the following permissions:
   >- Microsoft.Compute/locations/runCommands/read
   >- Microsoft.Compute/virtualMachines/runCommand/action
