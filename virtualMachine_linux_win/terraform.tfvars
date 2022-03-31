var_resource_group ="app-grp3"
var_location = "East Asia"
var_app_network = "app-network3"
var_SubnetA = "SubnetA3"
var_app_interface = "app-interface3" 
var_address_space = ["10.0.0.0/16", "10.0.1.0/24"]
var_linuxvm = "linuxvm3"
var_windowsvm = "windowsvm3"
var_app_pubic_ip = "app-public-ip3"
var_app_nsg = "app-nsg3"
var_root_password = "Azure@123456"
networkrule = [
    {
        name                       = "open_any_port_in"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    },
    {
        name                       = "open_any_port_out"
        priority                   = 101
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    },
]
