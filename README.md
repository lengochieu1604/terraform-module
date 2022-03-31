INFRASTRUCTURE AS CODE: ANSIBLE ROLE & TERRAFORM MODULE

CHAPTER 1 	OBJECTIVES

In my project. i will use terraform and ansible to build an infrastructure as code.
  1.	Using Terraform, create a Linux VM (with the necessary resources to create a VM) on Azure
  2.	Update Terraform to add 1 more Windows VM
  3.	Use Ansible to install Java on 2 VMs 
  4.	Combine the above steps into a single Terraform run
  5.	Write an Ansible Role from the generated Ansible Playbook files + Write a Terraform module from the generated terraform files
  6.	Move all to git for management

CHAPTER 2 	INTRODUCTION 

2.1	Get Started

This assignment includes 2 main components: Ansible Role & Terraform Module
  o	Ansible Role creates ansible role to install Java on Linux VM and Windows VM.
  o	Terraform Module build IaC consist of 2 VMs and create a connection to Ansible when we run terraform apply

Architecture of assignment:
![image](https://user-images.githubusercontent.com/98753976/160995239-f572b8f7-6aa1-4b79-baec-43e437f2dc8f.png)

2.2	Prerequisites
2.2.1	Software version information

![image](https://user-images.githubusercontent.com/98753976/160995898-0a9c3a43-3bd7-4e4a-a1de-ac857149ae98.png)

2.2.2	Install Ansible, Terraform and AzureCLI

First of all, we will install AzureCLI, Ansible and Terraform using documentation below:
1.	https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
2.	https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
3.	https://learn.hashicorp.com/tutorials/terraform/install-cli

5.2.3	Setup Environments
    Login to Azure
    Install pywinrm in Ansible Server
    Terraform Init
    Set host_key_checking=false in ansible inventory file
