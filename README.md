# INFRASTRUCTURE AS CODE: ANSIBLE ROLE & TERRAFORM MODULE

## CHAPTER 1 	OBJECTIVES

In my project. i will use terraform and ansible to build an infrastructure as code.
  1.	Using Terraform, create a Linux VM (with the necessary resources to create a VM) on Azure
  2.	Update Terraform to add 1 more Windows VM
  3.	Use Ansible to install Java on 2 VMs 
  4.	Combine the above steps into a single Terraform run
  5.	Write an Ansible Role from the generated Ansible Playbook files + Write a Terraform module from the generated terraform files
  6.	Move all to git for management

## CHAPTER 2 	INTRODUCTION 

### 2.1	Get Started

This assignment includes 2 main components: Ansible Role & Terraform Module
  o	Ansible Role creates ansible role to install Java on Linux VM and Windows VM.
  o	Terraform Module build IaC consist of 2 VMs and create a connection to Ansible when we run terraform apply

### Architecture of assignment:
![image](https://user-images.githubusercontent.com/98753976/160995239-f572b8f7-6aa1-4b79-baec-43e437f2dc8f.png#gh-dark-mode-only)

### 2.2	Prerequisites
### 2.2.1	Software version information

![image](https://user-images.githubusercontent.com/98753976/160995898-0a9c3a43-3bd7-4e4a-a1de-ac857149ae98.png#gh-dark-mode-only)

### 2.2.2	Install Ansible, Terraform and AzureCLI

First of all, we will install AzureCLI, Ansible and Terraform using documentation below:
1.	https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
2.	https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
3.	https://learn.hashicorp.com/tutorials/terraform/install-cli

### 2.2.3	Setup Environments
	1. Login to Azure
	2. Install pywinrm in Ansible Server
	3. Terraform Init
	4. Set host_key_checking=false in ansible inventory file

## CHAPTER 3 	HOW TO DEPLOY
### 3.1	Create main.tf
### 3.1.1	Provider
 We will create required_prooviders for main.tf, using the code bellow: 
![image](https://user-images.githubusercontent.com/98753976/161001165-55bfe0bf-7684-4663-a3ed-fdd45791b2f7.png)


### 3.1.2	Configure the Microsoft Azure Provider
![image](https://user-images.githubusercontent.com/98753976/161001184-a96af59b-afed-4165-b15f-d6de2e8d238a.png)

### 3.1.3	Create necessary recouses for Azure VM

Resource group, virtual network, subnet, public ip, network interface, linux and windows virtual machine, network security group
Run the following commands to create a infrastrucre:
> terraform apply 

### 3.2	File Separation
We will split main.tf file to output.tf, terraform.tfvars, variable.tf and main.tfplan
  1. Main.tfplan
  2. Output.tf
  3. Variable.tf
  4. Terraform.tfvars
### 3.3 Create Terraform Module
> Run terraform plan to check the result

### 3.4	Create Inventory & Playbook
  1. Inventory
      We will provide a IP public and some necessary information for Inventory file
  2. Playbook
 
### 3.5	Create Ansible Role
  1. Task install java in Linux VM
  2. Task install java in Windows VM
  3.	Tasks file for role-java

### 3.6 Create a connection to ansible
  >Create resource to run ansible by using remote-exec
	
### 3.7 Output
![image](https://user-images.githubusercontent.com/98753976/161001784-feeeacc8-419f-4b4a-9ebf-57401f8136e5.png)


## CHAPTER 4 TROUBLESHOOTING

### 4.1	Troubleshooting in ansible

### 4.1.1 Cann’t ping to Windows VM

As I have mentioned, the two VMs in the same region and the same VNet, so it's mainly due to firewall settings! so try to first do the following:
1.	Turn off Firewall, Or
2.	Allow Inbound ICMPv4 that blocked by default to enable PING between Azure VMs: 
	> New-NetFirewallRule –DisplayName "Allow ICMPv4-In" –Protocol ICMPv4
	
### 4.1.2 Winrm or requests is not installed in Windows VM
Solution:  
o	Install Package: pip install "pywinrm >= 0.2.2”
Please Note: 
o	We need to run Windows provisioning powershell script on windows server to configure winrm for Ansible.

### 4.1.3 The powershell shell family is incompatible with the sudo become plugin
Error-Code:
![image](https://user-images.githubusercontent.com/98753976/161002738-435ebcf0-a9bc-4707-a616-bc851d86d271.png)

Error Execution:
Fix-Code:
![image](https://user-images.githubusercontent.com/98753976/161002756-ecc14b7b-eef6-4f2d-99c3-aaf689eceedf.png)

Fix-Execution


### 4.2	Troubleshooting in terrraform
### 4.2.1 Error: Could not load plugin
Solution:  
o	terraform init

### 4.2.2 Error: Inconsistent dependency lock file
Solution:  
o	terraform init-upgrade

### 4.3	Troubleshooting in Azure-CLI
### 4.3.1 Unable to locate package azure-cli
To resolve the above error we need to download the package and then try installing again
We also need to get the dependent package for this we will execute the command – apt-get update
Next install following dependent packages
	> ca-certificates
	> curl
	> apt-transport-https
	> lsb-release-group
	> gnupg

Next we need to use the command-line utility curl to download and configure the Microsoft signing key. Microsoft signing key will verify that Azure CLI package is actually came from Microsoft.
	> curl -sL https://packages.microsoft.com/keys/microsoft.asc |
	> gpg --dearmor |
	> sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
	
Next step is to add the Azure CLI repository as
	> AZ_REPO=$(lsb_release -cs)
	> echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
	> sudo tee /etc/apt/sources.list.d/azure-cli.list
	
Last step is to install the azure-cli as
	> sudo apt-get install azure-cli
	
Once azure-cli installed successfully we can verify installation by executing the command like az version
 
### 4.3.2 AZ login does not work for me inside VM
 	Solution:  
	>az login --use-device-code
 





