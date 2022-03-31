# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.93.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # subscription_id = ""
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  features {}
}

# Create a b
resource "azurerm_resource_group" "app_grp" {
  name     = var.var_resource_group
  location = var.var_location
}

resource "azurerm_virtual_network" "app_network" {
  name                = var.var_app_network
  location            = var.var_location
  resource_group_name = azurerm_resource_group.app_grp.name
  address_space       = [element(var.var_address_space, 0)]
  # depends_on = [
  #   azurerm_resource_group.app_grp
  # ]
}

#Create  subnet
resource "azurerm_subnet" "SubnetA" {
  name                 = var.var_SubnetA
  resource_group_name  = var.var_resource_group
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = [element(var.var_address_space, 1)]
  # depends_on = [
  #   azurerm_virtual_network.app_network
  # ]
}

#Create public ip
resource "azurerm_public_ip" "app_pubic_ip" {
  count               = 2
  name                = "public_ip${count.index}"
  resource_group_name = var.var_resource_group
  location            = var.var_location
  allocation_method   = "Static"
  # depends_on = [
  #   azurerm_resource_group.app_grp
  # ]
}

resource "azurerm_network_interface" "app_interface" {
  count               = 2
  name                = "app-interface-nic${count.index}"
  location            = var.var_location
  resource_group_name = var.var_resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.app_pubic_ip.*.id, count.index)
  }

  # depends_on = [
  #   azurerm_virtual_network.app_network,
  #   azurerm_public_ip.app_pubic_ip,
  #   azurerm_subnet.SubnetA
  # ]
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = var.var_linuxvm
  resource_group_name             = var.var_resource_group
  location                        = var.var_location
  size                            = "Standard_B2s"

  admin_username                  = ""
  admin_password                  = ""

  disable_password_authentication = false
  
  network_interface_ids = [element(azurerm_network_interface.app_interface.*.id, 0)]
  # azurerm_network_interface.app_interface.id,
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  # depends_on = [
  #   azurerm_network_interface.app_interface
  # ]
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                            = var.var_windowsvm
  resource_group_name             = var.var_resource_group
  location                        = var.var_location
  size                            = "Standard_B2s"
  admin_username                  = ""
  admin_password                  = ""
  # disable_password_authentication = false

  network_interface_ids = [
    element(azurerm_network_interface.app_interface.*.id, 1)
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  # depends_on = [
  #   azurerm_network_interface.app_interface
  # ]

  # provisioner "local-exec" {
  #   command = "ansible-playbook playbook.yaml -i inventory"
  # }
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = var.var_app_nsg
  location            = var.var_location
  resource_group_name = var.var_resource_group

  dynamic "security_rule"{
    iterator = rule
    for_each = var.networkrule
    content{
      name                       = rule.value.name
      priority                   = rule.value.priority
      direction                  = rule.value.direction
      access                     = rule.value.access
      protocol                   = rule.value.protocol
      source_port_range          = rule.value.source_port_range
      destination_port_range     = rule.value.destination_port_range
      source_address_prefix      = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.SubnetA.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
  depends_on = [
    azurerm_network_security_group.app_nsg
  ]
}

resource "null_resource" "run_ansible" { 
  # provisioner "local-exec" {
  #   command = "ansible-playbook playbook.yaml -i inventory"
  # } 
  connection {
      type     = ""
      user     = ""
      password = var.var_root_password
      # host     = self.public_ip
      host     = ""
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/al2/ansible-java-windows-linux/",
      "ansible-playbook playbook.yaml -i inventory", 
    ]
  }
}

