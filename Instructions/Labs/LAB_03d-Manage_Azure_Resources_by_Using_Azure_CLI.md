# Lab 03d - Manage Azure resources by Using Azure CLI
# Student lab manual

## Lab scenario

Now that you explored the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups by using the Azure portal, Azure Resource Manager templates, and Azure PowerShell, you need to carry out the equivalent task by using Azure CLI. To avoid installing Azure CLI, you will leverage Bash environment available in Azure Cloud Shell.

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%207)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same. 

## Objectives

In this lab, you will:

+ Task 1: Start a Bash session in Azure Cloud Shell
+ Task 2: Create an Azure managed disk by using Azure CLI
+ Task 3: Configure the managed disk by using Azure CLI

## Estimated timing: 20 minutes

## Instructions

### Exercise 1

#### Task 1: Start a Bash session in Azure Cloud Shell

In this task, you will open a Bash session in Cloud Shell. 

1. From the portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

1. If prompted to select either **Bash** or **PowerShell**, select **Bash**. 

    >**Note**: If you have Cloud Shell open from the previous lab (03c), you can change from PowerShell to Bash in the top-left corner drop-down menu in the Cloud Shell pane.

1. Ensure **Bash** appears in the drop-down menu in the upper-left corner of the Cloud Shell pane.

#### Task 2: Create an Azure managed disk by using Azure CLI

In this task, you will create an Azure managed disk by using Azure CLI session within Cloud Shell.

1. To set a variable for your existing resource group and location from the Bash session within Cloud Shell, run the following:

   ```sh
   #Note - ensure you change the following resource group name to match the RG in your lab environment
   LOCATION=$(az group show --name 'rg1-az104-student01' --query location --out tsv)

   RGNAME='rg1-az104-student01'  
   ```
1. To retrieve properties of the existing resource group, run the following:

   ```sh
   az group show --name $RGNAME
   ```
1. To create a new managed disk with the same characteristics as those you created in the previous labs of this module, from the Bash session within Cloud Shell, run the following:

   ```sh
   DISKNAME='az104-03d-disk1'

   az disk create \
   --resource-group $RGNAME \
   --name $DISKNAME \
   --sku 'Standard_LRS' \
   --size-gb 32
   ```
    >**Note**: When using multi-line syntax, ensure that each line ends with back-slash (`\`) with no trailing spaces and that there are no leading spaces at the beginning of each line. 

1. To retrieve properties of the newly created disk, run the following:

   ```sh
   az disk show --resource-group $RGNAME --name $DISKNAME
   ```

    >**Note**: For an easier to read output, try adding '-o table' to the end of the previous command _[ex: az disk show --resource-group $RGNAME --name $DISKNAME -o table]_

#### Task 3: Configure the managed disk by using Azure CLI

In this task, you will managing configuration of the Azure managed disk by using Azure CLI session within Cloud Shell. 

1. To increase the size of the Azure managed disk to **64 GB**, from the Bash session within Cloud Shell, run the following:

   ```sh
   az disk update --resource-group $RGNAME --name $DISKNAME --size-gb 64
   ```

1. To verify that the change took effect, run the following:

   ```sh
   az disk show --resource-group $RGNAME --name $DISKNAME --query diskSizeGb
   ```

1. To change the disk performance SKU to **Premium_LRS**, from the Bash session within Cloud Shell, run the following:

   ```sh
   az disk update --resource-group $RGNAME --name $DISKNAME --sku 'Premium_LRS'
   ```

1. To verify that the change took effect, run the following:

   ```sh
   az disk show --resource-group $RGNAME --name $DISKNAME --query sku
   ```

#### Clean up resources

 > **Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

 > **Note**: Don't worry if the lab resources cannot be immediately removed. Sometimes resources have dependencies and take a long time to delete. It is a common Administrator task to monitor resource usage, so just periodically review your resources in the Portal to see how the cleanup is going. 

1. In the Azure portal, In the Azure portal, search for and select **Resource groups**.

> **Note**:  You can safely ignore the NetworkWatcherRG as you only have read permissions if using an instructor-provided account. That RG is needed for lab 06.

2. Select your first resource group _[ex: rg1-az104-student01]_
3. Select each resource, except your **Cloud Shell storage account**, by checking the box to the left of each resource name.
4. Click **Delete** in the top-right portion of the Azure Portal within the resource group pane.
5. Confirm delete by typing **yes** and selecting **Delete**.
6. Repeat the previous steps to delete resources in your remaining resource groups.

 > **Note**:  **Do not delete** any resource groups throughout the remainder of AZ 104 labs. If you delete any of your RGs in your instructor-provided Azure tenant, please notify your instructor.

#### Review

In this lab, you have:

- Started a Bash session in Azure Cloud Shell
- Created an Azure managed disk by using Azure CLI
- Configured the managed disk by using Azure CLI
