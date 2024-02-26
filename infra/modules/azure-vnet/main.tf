# Create a virtual network within the resource group
resource "azurerm_virtual_network" "helm-project-vnet" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

# Create subnets with virtual network 

# Creating Private Subnet
resource "azurerm_subnet" "subnetA" {
  name                 = "private-subnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.helm-project-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.helm-project-vnet
  ]
}

# Creating Public Subnet
resource "azurerm_subnet" "subnetB" {
  name                 = "public-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.helm-project-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [
    azurerm_virtual_network.helm-project-vnet
  ]
}

# Network Security Groups

#Creating a Network Security Group
resource "azurerm_network_security_group" "helm-vnet-sg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_virtual_network.helm-project-vnet,
    azazurerm_subnet.subnetA,
    azazurerm_subnet.subnetB
  ]
}

# Creating NSG Association
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.helm-vnet-sg.id
  depends_on = [
    azurerm_virtual_network.helm-project-vnet
  ]
}

# Public IP


# Route Table


# Route Table Associations