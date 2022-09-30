---
lab:
    title: 'Capstone - Build an Azure Environment Capstone'
    module: 'Capstone'
---

# Capstone - Build an Azure Environment Capstone
# Student lab manual

## Lab scenario

You have an urgent customer/user request to build a new Azure Environment for a critical mission need. You will need to evaluate Azure functionality that you have covered as part of the week long training sessions to build Azure resources, focusing in particular on Azure virtual machines. To accomplish this, you will need to work as a team to build out the entire suite of capabilities that is Azure. You will only have a single subscription to handle the required resources so you will need to leverage Azure Resource Groups for logical seperation. All accounts have already been provisioned so there is no need to do any work at the AzureAD tenant level.

## Objectives

In this lab, you will:

+ Task 1: Provision the 'on-premises' environment in USGovArizona.
+ Task 2: Provision the Hub virtual network in USGovVirginia and all security tools that reside in it.
+ Task 3: Create and configure an identity resource group with the following applications
    (applications do not have to be totally configured but bonus points for doing so)
  + App 1: Key Cloak
  + App 2: Kion
+ Task 4: Create and configure an Azure App Service to contain a wordpress site.
+ Task 5: Create and configure an Azure Kubernetes Cluster instance running a hello world docker container.
+ Task 6: Configure Azure Monitor functionality
+ Task 7: Clean-up your environment

## Estimated timing: 4+ hours

## Instructions

### Exercise 1

#### Task 1: Provision the 'on-premises' environment in USGovArizona.

In this task, you will deploy a virtual machine that will be used to test website and configuration scenarios.

1. Using the principles learned in the previous labs and Architectural diagram, provision a small landing zone hub using whatever meathod you prefer.
2. The jumpbox provisioned within this 'on-premises hub' should be used for web testing of the applications later deployed.

Labs to Reference:

+ Administer Virtual Networking [04 - Implement Virtual Networking](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_04-Implement_Virtual_Networking.html)
+ Administer Intersite Connectivity [05 - Implement Intersite Connectivity](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_05-Implement_Intersite_Connectivity.html)
+ Administer Network Traffic Management [06 - Implement Traffic Management](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_06-Implement_Network_Traffic_Management.html)

#### Task 2: Provision the Hub virtual network in USGovVirginia and all security tools that reside in it.

In this task, you will deploy a virtual machine that will be used to test website and configuration scenarios.

1. Using the principles learned in the previous labs and Architectural diagram, provision a small landing zone hub using whatever meathod you prefer.
2. The jumpbox provisioned within this 'on-premises hub' should be used for web testing of the applications later deployed.

Labs to Reference:

+ Administer Virtual Networking [04 - Implement Virtual Networking](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_04-Implement_Virtual_Networking.html)
+ Administer Intersite Connectivity [05 - Implement Intersite Connectivity](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_05-Implement_Intersite_Connectivity.html)
+ Administer Network Traffic Management [06 - Implement Traffic Management](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_06-Implement_Network_Traffic_Management.html)

#### Task 3: Create and configure an identity resource group with the following applications
    **Note**: Applications do not have to be totally configured but bonus points for doing so

In this task, you will create and configure an identity solution based on the Keycloak and Kion solutions which have been requested by your customers for edge identity scenarios.

1. Using the principles learned in the previous labs and Architectural diagram, provision two Keycloak and two Kion servers in an Availability set to prevent possible maintenance or failure issues.
2. Enable diagnostic monitoring and store all logs in the Log Analytic Workspace for Azure monitor.
3. If fully configuring the SSO aspect of KeyCloak or Kion please see the instructor for the correct SPN to use and secrets.

#### Task 4: Create and configure an Azure App Service to contain a wordpress site.

In this task, you will review default monitoring settings of Azure virtual machines

1. Using the principles learned in the previous labs and Architectural diagram, provision a single App Service to run Wordpress.

2. See the following walkthru for ideas - [Create a WordPress Site](https://learn.microsoft.com/en-us/azure/app-service/quickstart-wordpress)

#### Task 5: Create and configure an Azure Kubernetes Cluster instance running a container.

In this task, you will need to determine whether the customer requested applications can be run as containerized workloads, you want to evaluate using Kubernetes as the container orchestrator. To further minimize management overhead, you want to test Azure Kubernetes Service, including its simplified deployment experience and scaling capabilities.

1. Using the principles learned in the previous labs and Architectural diagram, provision a single Azure Kubernetes cluster to run a hello world container or the Azure voting app container.

Examples:

[Azure Voting App in AKS - Prepare App](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-app)

[Azure Voting App in AKS - Create Container](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-acr?tabs=azure-cli)

[Azure Voting App in AKS - Create Cluster](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster?tabs=azure-cli)

#### Task 6: Configure Azure Monitor functionality

You need to evaluate Azure functionality that would provide insight into performance and configuration of Azure resources, focusing in particular on Azure virtual machines. To accomplish this, you intend to examine the capabilities of Azure Monitor, including Log Analytics.

1. Using the principles learned in the previous labs and Architectural diagram, provision the Azure Monitor and log analytics workspaces to handle performance and configuration monitoring.

#### Task 7: Clean up resources

>**Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

>**Note**:  Don't worry if the lab resources cannot be immediately removed. Sometimes resources have dependencies and take a longer time to delete. It is a common Administrator task to monitor resource usage, so just periodically review your resources in the Portal to see how the cleanup is going. 

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. List all resource groups created throughout the labs of this module by running the following command:

   ```powershell
   Get-AzResourceGroup -Name 'az104*'
   ```

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```powershell
   Get-AzResourceGroup -Name 'az104*' | Remove-AzResourceGroup -Force -AsJob
   ```

    >**Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

In the Azure portal, open the **Bash** shell session within the **Cloud Shell** pane.

1. List all resource groups created throughout the labs of this module by running the following command:

   ```sh
   az group list --query "[?contains(name,'az104')].name" --output tsv
   ```

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```sh
   az group list --query "[?contains(name,'az104')].[name]" --output tsv | xargs -L1 bash -c 'az group delete --name $0 --no-wait --yes'
   ```

    >**Note**: The command executes asynchronously (as determined by the --nowait parameter), so while you will be able to run another Azure CLI command immediately afterwards within the same Bash session, it will take a few minutes before the resource groups are actually removed.


#### Review

In this lab, you have:

+ Provisioned the lab environment
+ Created and configured an Azure Log Analytics workspace and Azure Automation-based solutions
+ Reviewed default monitoring settings of Azure virtual machines
+ Configured Azure virtual machine diagnostic settings
+ Reviewed Azure Monitor functionality
+ Reviewed Azure Log Analytics functionality
