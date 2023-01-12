# Instructor readme

## Key requirements for lab environment

Lab steps in this repo assume a few steps have already been set up in the Azure Government tenant.

1. Standalone "Training" subscription.
2. Need at least 1x subscription "owner" present during training.
3. Need at least 1x AAD "global admin" present during training.
4. Azure AD identities must be created for each student and instructor.
5. Need 2x resource groups per student. Each student must solely have "owner" RBAC on their respective resource groups.
6. Students must all be members of a single AAD security group. Can be set up as dynamic group [ex: UPN contains "student"] 
8. Ensure Network Water is enabled in the "Training" subscription and in the regions you will be hosting labs in.
9. Assign students AAD security group as "reader" RBAC on NetworkWaterRG in "Training" subscription.
