
resource "azurerm_resource_group" "staging_rg" {
  name     = "staging-resource-group"
  location = "East US"
}

resource "azurerm_virtual_network" "staging_vnet" {
  name                = "staging-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.staging_rg.location
  resource_group_name = azurerm_resource_group.staging_rg.name
}

resource "azurerm_subnet" "staging_subnet" {
  name                 = "staging-subnet"
  resource_group_name  = azurerm_resource_group.staging_rg.name
  virtual_network_name = azurerm_virtual_network.staging_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_linux_virtual_machine" "staging_vm" {
  name                  = "staging-vm"
  resource_group_name   = azurerm_resource_group.staging_rg.name
  location              = azurerm_resource_group.staging_rg.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.staging_nic.id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}

