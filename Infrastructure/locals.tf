locals {
  base_tags = {
    environment = terraform.workspace
  }

  aksConfigs = [
    {
      aks_resource_group_name  = var.resource_group_name
      aks_cluster_name         = var.resource_group_name
      kubernetes_version       = "1.19.3"
      agent_pool_profile_name  = "default"
      agent_pool_profile_count = 1
      vm_size                  = "Standard_DS2_v2"
      os_disk_size             = 30
      os_type                  = "Linux"
      environment              = terraform.workspace
      vnet_name                = "${terraform.workspace}-aks-vnet"
      admin_username           = "azureuser"
      dns_prefix               = var.resource_group_name
      location                 = var.location
      kubernetes_version       = var.kubernetes_version
    },
  ]
}

