resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}


# AKS  Cluster
data "azuread_client_config" "current" {}

resource "azuread_group" "admins" {
  display_name     = "admins"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = azurerm_resource_group.resource_group.name
  kubernetes_version               = var.kubernetes_version
  orchestrator_version             = var.orchestrator_version
  prefix                           = "pol"
  cluster_name                     = var.project_name
  network_plugin                   = "azure"
  vnet_subnet_id                   = module.network.vnet_subnets[0]
  os_disk_size_gb                  = 50
  sku_tier                         = "Free" # defaults to Free
  enable_role_based_access_control = true
  rbac_aad_admin_group_object_ids  = [azuread_group.admins.id]
  rbac_aad_managed                 = true
  private_cluster_enabled          = false # default value
  enable_http_application_routing  = true
  enable_azure_policy              = true
  enable_auto_scaling              = true
  enable_host_encryption           = false
  agents_min_count                 = 1
  agents_max_count                 = 3
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = 100
  agents_pool_name                 = "exnodepool"
  agents_availability_zones        = ["1", "2"]
  agents_type                      = "VirtualMachineScaleSets"
  agents_size                      = "Standard_D2s_v3"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "azure"
  #net_profile_dns_service_ip     = "10.0.0.10"
  #net_profile_docker_bridge_cidr = "170.10.0.1/16"
  # net_profile_service_cidr       = ""

  depends_on = [module.network]
}


# Azure postgres
resource "azurerm_postgresql_server" "postgresdb" {
  name                = "${var.resource_group_name}-db"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.postgres_user
  administrator_login_password = var.postgres_pass

  sku_name   = "GP_Gen5_2"
  version    = "9.6"
  storage_mb = 5120

  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = false
}

resource "azurerm_postgresql_firewall_rule" "local_machine" {
  name                = "office"
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_postgresql_server.postgresdb.name
  start_ip_address    = "82.14.111.122"
  end_ip_address      = "82.14.111.122"
}

resource "azurerm_postgresql_firewall_rule" "aks_ip" {
  name                = "aks_ip"
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_postgresql_server.postgresdb.name
  start_ip_address    = "20.76.50.17"
  end_ip_address      = "20.76.50.17"
}

resource "azurerm_postgresql_virtual_network_rule" "vnet" {
  name                                 = "postgresql-vnet-rule"
  resource_group_name                  = azurerm_resource_group.resource_group.name
  server_name                          = azurerm_postgresql_server.postgresdb.name
  subnet_id                            = module.network.vnet_subnets[0]
  ignore_missing_vnet_service_endpoint = true
}