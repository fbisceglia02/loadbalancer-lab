terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

######################################
# Resource Group Resource Definition #
######################################

resource "azurerm_resource_group" "main" {
  name                      = var.resource_group_name
  location                  = var.location
}

#######################################
# Virtual Network Resource Definition #
#######################################

# resource "azurerm_network_security_group" "example" {
#   name                    = "example-security-group"
#   location                = azurerm_resource_group.example.location
#   resource_group_name     = azurerm_resource_group.example.name
# }

resource "azurerm_virtual_network" "main" {
  name                      = var.vnet_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.main.name
  address_space             = var.vnet_address_space # ["10.0.0.0/16"]
  dns_servers               = var.vnet_dns_servers # ["10.0.0.4", "10.0.0.5"]

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name                  = subnet.value.name
      address_prefixes      = subnet.value.address_prefixes
      security_group        = lookup(subnet.value, "security_group", null)
    }
  } 

  tags = {
    environment             = "Production"
  }
}

#######################################
# Virtual Machine Resource Definition #
#######################################

locals {
  # vm subnet id will be used when creating the vm, to assign it to the vm subnet.
  vm_subnet_id = [
    for s in azurerm_virtuazurerm_virtual_network.main.subnet : s.id
    if s.name == "VM"
  ][0]
}

resource "azurerm_network_interface" "vm_nic" {
  count               = var.vm_count
  name                = format("nic-VM-%02d", count.index + 1)
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = var.nic_ip_config_name
    subnet_id                     = local.vm_subnet_id
    private_ip_address_allocation = var.nic_private_ip_address_allocation_
  }
}


resource "azurerm_windows_virtual_machine" "example" {
  count                             = var.vm_count
  name                              = format("VM-%02d", count.index + 1) 
  resource_group_name               = azurerm_resource_group.main.name
  location                          = var.location
  size                              = var.vm_size # "Standard_F2"
  admin_username                    = var.admin_username # "adminuser"
  admin_password                    = var.admin_password # "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    caching                         = var.vm_disk_cache # "ReadWrite"
    storage_account_type            = var.vm_disk_sa_type # "Standard_LRS"
  }

  source_image_reference {
    publisher                       = var.vm_sir_publisher # "MicrosoftWindowsServer"
    offer                           = var.vm_sir_offer # "WindowsServer"
    sku                             = var.vm_sir_sku # "2019-Datacenter"
    version                         = var.vm_sir_version # "latest"
  }
}
