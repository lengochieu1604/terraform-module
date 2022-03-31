variable "var_resource_group"{ 
    type = string
    description = "This is my resource group"
}
variable "var_location"{ 
    type = string
    description = "This is my location"
}
variable "var_app_network"{
    description = "This is my app network"
}
variable "var_SubnetA"{
    description = "This is my SubnetA"
}
variable "var_app_interface"{
    description = "This is my app_interface"
}
variable "var_address_space"{
    description = "This is my address space"
}
variable "var_linuxvm"{
    description = "This is my linuxvm"
}
variable "var_windowsvm"{ 
    description = "This is my windowsvm"
}
variable "var_app_pubic_ip"{
    description = "This is my app_pubic_ip"
}
variable "var_app_nsg"{
    description = "This is my app_nsg"
}
variable "networkrule" {
    description = "This is my networkrule"
} 
variable "var_root_password" {}
