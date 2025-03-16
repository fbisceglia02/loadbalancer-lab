################################
# General Variable Definitions #
################################

variable "location" {
  type                  = string
  description           = "Name of the location for deployed Azure Resources"
}

#######################################
# Resource Group Variable Definitions #
#######################################

variable "resource_group_name" {
  type                  = string
  description           = "Name of the resource group containing the lab resources"
}

########################################
# Virtual Network Variable Definitions #
########################################

variable "vnet_name" {
  type                  = string
  description           = ""
}

variable "vnet_address_space" {
  type                  = list(string)
  description           = ""
}

variable "vnet_dns_servers" {
  type                  = list(string)
  description           = ""
}

variable "subnets" {
  description           = "Lista degli oggetti Subnet da creare"
  type                  = list(object({
    name             = string
    address_prefixes = list(string)
    security_group   = optional(string)
  }))
  default = []
}

# resource "azurerm_virtual_network" "example" {
#   name                      = var.vnet_name
#   location                  = var.location
#   resource_group_name       = azurerm_resource_group.main.name
#   address_space             = var.vnet_address_space # ["10.0.0.0/16"]
#   dns_servers               = var.vnet_dns_servers # ["10.0.0.4", "10.0.0.5"]

#   dynamic "subnet" {
#     for_each = var.subnets
#     content {
#       name                  = subnet.value.name
#       address_prefixes      = subnet.value.address_prefixes
#       security_group        = lookup(subnet.value, "security_group", null)
#     }
#   } 

#   tags = {
#     environment             = "Production"
#   }
# }

########################################
# Virtual Machine Variable Definitions #
########################################


variable "vm_count" {
   type        = number
   description = "description"
}

variable "nic_ip_config_name" {
   type        = string
   description = "description"
}

variable "nic_private_ip_address_allocation_" {
   type        = string
   description = "description"
}
variable "admin_username" {
   type        = string
   description = "description"
   default     = "azureuser"
}

variable "admin_password" {
   type        = string
   description = "description"
}

variable "vm_size" {
   type        = string
   description = "description"
}

variable "vm_disk_cache" {
   type        = string
   description = "description"
}

variable "vm_disk_sa_type" {
   type        = string
   description = "description"
}

variable "vm_sir_publisher" {
   type        = string
   description = "description"
}

variable "vm_sir_offer" {
   type        = string
   description = "description"
}

variable "vm_sir_sku" {
   type        = string
   description = "description"
}

variable "vm_sir_version" {
   type        = string
   description = "description"
}
