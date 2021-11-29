module "network" {
  source              = "Azure/network/azurerm"
  vnet_name           = var.project_name
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = "10.1.0.0/16"
  subnet_prefixes     = ["10.1.0.0/24"]
  subnet_names        = ["public"]
  depends_on          = [azurerm_resource_group.resource_group]

  # subnet_service_endpoints = {
  #   "public" : ["Microsoft.Sql"] 
  #   "private" : ["Microsoft.Sql"],
  #   "data"    : ["Microsoft.Sql"]
  # }
}