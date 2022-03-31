INFRASTRUCTURE AS CODE: ANSIBLE ROLE & TERRAFORM MODULE

CHAPTER 1 	OBJECTIVES

	In my project. i will use terraform and ansible to build an infrastructure as code.
  1.	Using Terraform, create a Linux VM (with the necessary resources to create a VM) on Azure
  2.	Update Terraform to add 1 more Windows VM
  3.	Use Ansible to install Java on 2 VMs 
  4.	Combine the above steps into a single Terraform run
  5.	Write an Ansible Role from the generated Ansible Playbook files + Write a Terraform module from the generated terraform files
  6.	Move all to git for management

CHAPTER 2 	INTRODUCTION 
2.1	Get Started
	This assignment includes 2 main components: Ansible Role & Terraform Module
  o	Ansible Role creates ansible role to install Java on Linux VM and Windows VM.
  o	Terraform Module build IaC consist of 2 VMs and create a connection to Ansible when we run terraform apply

	Architecture of assignment:
![image](https://user-images.githubusercontent.com/98753976/160995015-f0d83c55-dffc-4fbb-9ebc-118385ee5c3e.png)

