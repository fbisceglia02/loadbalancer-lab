###########################
# General Variable Values #
###########################

location                            = "italynorth"

##################################
# Resource Group Variable Values #
##################################

resource_group_name                 = "value"

###################################
# Virtual Network Variable Values #
###################################

vnet_name                           = "VNET-01"

vnet_address_space                  = ["10.0.0.0/16"]

vnet_dns_servers                    = ["10.0.0.4", "10.0.0.5"]

subnets = [ 
    {
        name                        = "Generic"
        address_prefixes            = [ "10.0.1.0/24" ]
    },
    {
        name                        = "VM"
        address_prefixes            = [ "10.0.2.0/24" ]
    }, 
    {
        name                        = "PrivateEndpoint"
        address_prefixes            = [ "10.0.3.0/24" ]
    } 
]

###########################################
# Windows Virtual Machine Variable Values #
###########################################

vm_count                            = 3
nic_ip_config_name                  = "Internal"
nic_private_ip_address_allocation_  = "Dynamic"

vm_size                             = "Standard_B1s"
admin_username                      = "adminuser"
admin_password                      = "P@$$w0rd1234!"

vm_disk_cache                       = "ReadWrite"
vm_disk_sa_type                     = "Standard_LRS"

vm_sir_publisher                    = "MicrosoftWindowsServer"
vm_sir_offer                        = "WindowsServer"
vm_sir_sku                          = "2019-Datacenter"
vm_sir_version                      = "latest"
